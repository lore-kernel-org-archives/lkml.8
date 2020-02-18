Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF17C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A90F21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056329;
	bh=UaHQsd0lbeb/d/qEnZXRs/3aNWzkj9aSTZcTiZmiilg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uPL98du/lSdV5eTI7YJqW/bz2UR/VN+xKrF3SFaq/8Y1pUuWrX+CFklUY19neI9TB
	 bO4xWIIXHZ0dvZNwHTG8Vh6Vvy0J9JbQcG/W9dOSktDqcxGTCscnaYtFtZqgTDJ545
	 EgMWtBcJw9hT1Z1zqsxs47wZkIwWwqmSlM0E7lBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgBRUF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:05:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728610AbgBRUBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:01:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A10F82465D;
        Tue, 18 Feb 2020 20:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056110;
        bh=UaHQsd0lbeb/d/qEnZXRs/3aNWzkj9aSTZcTiZmiilg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=prHR9dPiEjEhX4J++VQSa3515/zxWCVAb3mv7Ax/LiOpUwtj/g4Ttrdr1yvtr1ruQ
         JV+jLZExQoSWaZecl/E/aXjQIGwQFCDqk54ffHwFFBEcIDWkOX0xv1tGRaUENM4qLy
         yG4/QfMW2zuA6VM1orkAVW5FGauvytV8rweIxtaE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.5 09/80] ALSA: hda/realtek - Add more codec supported Headset Button
Date:   Tue, 18 Feb 2020 20:54:30 +0100
Message-Id: <20200218190432.972127246@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
References: <20200218190432.043414522@linuxfoundation.org>
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


