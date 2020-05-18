Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713ADC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D6B20674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824614;
	bh=eQdZ91CzWNv7UCeJd+a5ATQUeTgkuElb4uubROWyJM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mN/RsBQXANI0uGEjxCykunqEcGTHKb4SU3uV36BUA4r9wUKMpIfq8znXUOSjxqKl3
	 TN8Rv6YYXHxAYXmvhW/MB7mVaQxPanbABnyt5VZEs7IGfJY2FNKA+8Q8zz3bDN0PQg
	 rr+Al/XXF9KXekryQuXkONksj+z3KidmtMTB+NYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbgERR4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731693AbgERR4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:56:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51FB8207C4;
        Mon, 18 May 2020 17:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824609;
        bh=eQdZ91CzWNv7UCeJd+a5ATQUeTgkuElb4uubROWyJM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6gUSnZ1uhNVkxoYpm0iWzn2t18S2rmsa4UtVLc93a2YvYHF11WbNTGZWyNZobrXj
         BKISIGFxP+7QCubM+SHCSA8pwbDv4SCZVv/XOl5Jv5BpCxSUnuH/Zp5ThsMoC2INgg
         ybr9anjIRrNoxjCNGV66vkg1t7Fqc5J15Ad82pkM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 043/147] ALSA: hda/hdmi: fix race in monitor detection during probe
Date:   Mon, 18 May 2020 19:36:06 +0200
Message-Id: <20200518173519.406942250@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit ca76282b6faffc83601c25bd2a95f635c03503ef ]

A race exists between build_pcms() and build_controls() phases of codec
setup. Build_pcms() sets up notifier for jack events. If a monitor event
is received before build_controls() is run, the initial jack state is
lost and never reported via mixer controls.

The problem can be hit at least with SOF as the controller driver. SOF
calls snd_hda_codec_build_controls() in its workqueue-based probe and
this can be delayed enough to hit the race condition.

Fix the issue by invalidating the per-pin ELD information when
build_controls() is called. The existing call to hdmi_present_sense()
will update the ELD contents. This ensures initial monitor state is
correctly reflected via mixer controls.

BugLink: https://github.com/thesofproject/linux/issues/1687
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20200428123836.24512-1-kai.vehmanen@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 663168ddce722..d48263d1f6a24 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2234,7 +2234,9 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
 		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
+		struct hdmi_eld *pin_eld = &per_pin->sink_eld;
 
+		pin_eld->eld_valid = false;
 		hdmi_present_sense(per_pin, 0);
 	}
 
-- 
2.20.1



