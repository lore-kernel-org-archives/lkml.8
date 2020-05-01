Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE39C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44F0216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339772;
	bh=9brijW7GuhDSeY1AtCRbki20nRFuzUWvoIMQLuBG7Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fzm71ia4A9NWk3JkW7IzmSVLc44lKlDJZLmyvcVDdEPmX2JZ1Ls3WdzPPnWPnuwoA
	 hQUz7Th93CzMFHVD3a9/zOWXzCf+zj0y5dlDifmvGGVu/Av83GvGcaA8YaAHpvSu4A
	 +Eoguug4yPvVLoNoI114pF+gGB3inWjnzK5cXCQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgEAN3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbgEAN32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:29:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEED0208D6;
        Fri,  1 May 2020 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339768;
        bh=9brijW7GuhDSeY1AtCRbki20nRFuzUWvoIMQLuBG7Rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0S4pNUGmsRr/aVvgYFGOzo2wPXud3AkztnAmcx66WTdDiLfF98AxY+FRkSNTTOJVU
         WghEKZsktFXLwBr+S56hhN29SR4OuB8ugZukVMjwahXKJAmnwm39qI95+1jb2d9XST
         +9ulYQi4UtFP4BIhoTyN4rjqOOq5pri1NVAzjRCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lin Yi <teroincn@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 40/80] ALSA: usx2y: Fix potential NULL dereference
Date:   Fri,  1 May 2020 15:21:34 +0200
Message-Id: <20200501131526.254332322@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.810761598@linuxfoundation.org>
References: <20200501131513.810761598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 7686e3485253635c529cdd5f416fc640abaf076f upstream.

The error handling code in usX2Y_rate_set() may hit a potential NULL
dereference when an error occurs before allocating all us->urb[].
Add a proper NULL check for fixing the corner case.

Reported-by: Lin Yi <teroincn@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200420075529.27203-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/usx2y/usbusx2yaudio.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -691,6 +691,8 @@ static int usX2Y_rate_set(struct usX2Yde
 			us->submitted =	2*NOOF_SETRATE_URBS;
 			for (i = 0; i < NOOF_SETRATE_URBS; ++i) {
 				struct urb *urb = us->urb[i];
+				if (!urb)
+					continue;
 				if (urb->status) {
 					if (!err)
 						err = -ENODEV;


