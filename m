Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2E9C433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D02920734
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262973;
	bh=GhzcNzMLzU+k4u2UopzNtwBLZ0GHtloGVkpykWWg/X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GhwoWYDsEVWQcdQvr1rpv8WIImk2meA/sQ+NmEkh9QLTrWpjNCSYzcPoKZ1L9LxTE
	 vk8u5Tc7oNpMYalX9wgsP5YP+jz4GPyLHtaJld948TZ1OrYDyueTimtT9aLvBlltGQ
	 yMCZgnj/XOahcW6mDwrAl6vnkSZOKnWh99U7N4b4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732238AbgGTQgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730125AbgGTPxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:53:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9AE622CAF;
        Mon, 20 Jul 2020 15:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260402;
        bh=GhzcNzMLzU+k4u2UopzNtwBLZ0GHtloGVkpykWWg/X4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ywWXZpS8QqHWT7mkf/DAYsL5WDEvDKRik7zG1jTsufn+vUGyfw50hMlB8UvzIWGOn
         MpppOHWhRbg17enUzwdyGULlHbaQmvOboejNa3MJPMd8G+WoZaHgVPaL+jHJNnL5eP
         Q70URO/aSeSSZKppyEKrjnbYI36+PYAk3rQV0VlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 089/133] ALSA: hda/realtek - Enable Speaker for ASUS UX533 and UX534
Date:   Mon, 20 Jul 2020 17:37:16 +0200
Message-Id: <20200720152808.020155337@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit 473fbe13fd6f9082e413aea37e624ecbce5463cc upstream.

ASUS UX533 and UX534 speaker still can't output.
End User feedback speaker didn't have output.
Add this COEF value will enable it.

Fixes: 4e051106730d ("ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/r/80334402a93b48e385f8f4841b59ae09@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6718,6 +6718,8 @@ static const struct hda_fixup alc269_fix
 			/* Set EAPD high */
 			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x40 },
 			{ 0x20, AC_VERB_SET_PROC_COEF, 0x8800 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x0f },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x7774 },
 			{ }
 		},
 		.chained = true,


