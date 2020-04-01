Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA1FC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B42920658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759336;
	bh=6bU7rDiBb1wJCZS4711Koslbcjtgda7A2njGprrWFgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uosxy53d9Z4ZBLk0SgN3JbCjsdM6k0tMFeLxCAB2GweqxQH+bvmZENhMNCwYxNvxk
	 WVTOUrp25T1alTSnnie8ajmVHEl0KzIHCTjrJuw6lL8K1UAJeYfOIEucwPb3P3vMr3
	 VBr2ig/dEWpHunv8/20rRPKkYsRMPufeFGtESWF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389516AbgDAQmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389502AbgDAQmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:42:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E68D62063A;
        Wed,  1 Apr 2020 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759332;
        bh=6bU7rDiBb1wJCZS4711Koslbcjtgda7A2njGprrWFgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wNTkZjz8IZpF1cV0vk073fRD7K//gKKCAfIO4cjT5JHfHvo0wNMMGuv4oJaY9OS50
         mnrjxH1TRdyv6qMPOLHBjRemTQO0/REns4k5fDoS09+VfJNvglJNC067fscMkcHMVm
         /6u8KvYNo5FnCgZQ9FjKJaHaHVSCmz97idWVOEVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 049/148] ALSA: hda/realtek: Fix pop noise on ALC225
Date:   Wed,  1 Apr 2020 18:17:21 +0200
Message-Id: <20200401161557.700566400@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 3b36b13d5e69d6f51ff1c55d1b404a74646c9757 upstream.

Commit 317d9313925c ("ALSA: hda/realtek - Set default power save node to
0") makes the ALC225 have pop noise on S3 resume and cold boot.

So partially revert this commit for ALC225 to fix the regression.

Fixes: 317d9313925c ("ALSA: hda/realtek - Set default power save node to 0")
BugLink: https://bugs.launchpad.net/bugs/1866357
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://lore.kernel.org/r/20200311061328.17614-1-kai.heng.feng@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4687,6 +4687,8 @@ static void alc_determine_headset_type(s
 		is_ctia = (val & 0x1c02) == 0x1c02;
 		break;
 	case 0x10ec0225:
+		codec->power_save_node = 1;
+		/* fall through */
 	case 0x10ec0295:
 	case 0x10ec0299:
 		alc_process_coef_fw(codec, alc225_pre_hsmode);


