Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5264C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829DE2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599592343;
	bh=jgMn294zgifUDPim3+TDSPhGDGrgYEBA0kW53bEw85A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IXGXMZB6EkD2o0RkxH3uA98mfNIVHfUauwc2Z3czd2Jf2j3BNSg4PYMDSO70HvW78
	 p0sm/GSdqWgTgI3N/HaYZLOBzgZjIdYdFaM/7ySy8bjveoElvlqGs9gnqLPwGFHyw+
	 +00cROWEt4lfgufmBd3PAB9LxOZ4yB/Fzn1TRims=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbgIHTMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730927AbgIHQFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:05:22 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1627F2192A;
        Tue,  8 Sep 2020 15:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579934;
        bh=jgMn294zgifUDPim3+TDSPhGDGrgYEBA0kW53bEw85A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DTs0tpfMGOYkswp5jHLKs1V/YJExHPBzVoG7TYTHnOoHemKFJnFKOZBiG+f8/Ed9w
         BS+eC3CALezC5wSiKmmqGghzpc7Ispo/pboFBGeOusMJRK49WS7vBXnzsj+PMRorNt
         CGEyzqgrGfjbgmCR8Te9l6Ds0lMH9P0qzEkbMtzI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 093/129] ALSA: hda/hdmi: always check pin power status in i915 pin fixup
Date:   Tue,  8 Sep 2020 17:25:34 +0200
Message-Id: <20200908152234.388623847@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

commit 858e0ad9301d1270c02b5aca97537d2d6ee9dd68 upstream.

When system is suspended with active audio playback to HDMI/DP, two
alternative sequences can happen at resume:
  a) monitor is detected first and ALSA prepare follows normal
     stream setup sequence, or
  b) ALSA prepare is called first, but monitor is not yet detected,
     so PCM is restarted without a pin,

In case of (b), on i915 systems, haswell_verify_D0() is not called at
resume and the pin power state may be incorrect. Result is lack of audio
after resume with no error reported back to user-space.

Fix the problem by always verifying converter and pin state in the
i915_pin_cvt_fixup().

BugLink: https://github.com/thesofproject/linux/issues/2388
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200826170306.701566-1-kai.vehmanen@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_hdmi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2798,6 +2798,7 @@ static void i915_pin_cvt_fixup(struct hd
 			       hda_nid_t cvt_nid)
 {
 	if (per_pin) {
+		haswell_verify_D0(codec, per_pin->cvt_nid, per_pin->pin_nid);
 		snd_hda_set_dev_select(codec, per_pin->pin_nid,
 			       per_pin->dev_id);
 		intel_verify_pin_cvt_connect(codec, per_pin);


