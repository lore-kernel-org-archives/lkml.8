Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F55AC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E640424655
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582055871;
	bh=UaHQsd0lbeb/d/qEnZXRs/3aNWzkj9aSTZcTiZmiilg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LfWAojfaj+JBH9IoW8/SwtBMaIVW4nMQBGT1CRGpZpcZQ0sIp02z33YJCCJJAEzUK
	 stffy4Gks/Ot2lNGwXNH0mdk1O4PJZhAGQNh5GMLe5EeiuLLBXJFaWFNea3quKkkSp
	 t32gCxrIibmyHB5dXWPADES0RbOFSa+H1vjRhiLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgBRT5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:57:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgBRT5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:57:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D564B24655;
        Tue, 18 Feb 2020 19:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582055866;
        bh=UaHQsd0lbeb/d/qEnZXRs/3aNWzkj9aSTZcTiZmiilg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otksbcQx/Ry8PhZvgpU+3pAR9r2y0iLn+3gtrxCDqflafOSWKEsww/geb3xevkICM
         BnCzouEywOCafwHQFRCM/65A25TIFgKz0Rr6VuO46i6STy8gFzJ5TbM5blIYRMamwk
         62vcvfSJFgctd5N/Mxi2jjBOgx6EJRDGGjMtELSY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 05/66] ALSA: hda/realtek - Add more codec supported Headset Button
Date:   Tue, 18 Feb 2020 20:54:32 +0100
Message-Id: <20200218190428.622094301@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190428.035153861@linuxfoundation.org>
References: <20200218190428.035153861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit 2b3b6497c38d123934de68ea82a247b557d95290 upstream.

Add supported Headset Button for ALC215/ALC285/ALC289.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/948f70b4488f4cc2b629a39ce4e4be33@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5701,8 +5701,11 @@ static void alc_fixup_headset_jack(struc
 		break;
 	case HDA_FIXUP_ACT_INIT:
 		switch (codec->core.vendor_id) {
+		case 0x10ec0215:
 		case 0x10ec0225:
+		case 0x10ec0285:
 		case 0x10ec0295:
+		case 0x10ec0289:
 		case 0x10ec0299:
 			alc_write_coef_idx(codec, 0x48, 0xd011);
 			alc_update_coef_idx(codec, 0x49, 0x007f, 0x0045);


