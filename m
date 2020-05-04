Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B4AC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A79FD205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615812;
	bh=+lCzk60t6D3AqqDcbuo5xmrcjuWvczNzUemVjNaWeRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qEh/XxZRS42xaC7t7/Ju1x+9kfzDOx1F7w8QCQU8UvRYfzv3BFPCu70xXo0sVoEVZ
	 PUlvOZV7AQyV1pKZtNVpfFsHik6Cf6qqW4idCYFyWb2z0Ru0XFpkdq43V08XK7pgd0
	 +HeykrLUgtD3f8RneKiQCVPxyXzkY5pxeOGMgRTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbgEDSKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731303AbgEDSFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:05:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 318F1206B8;
        Mon,  4 May 2020 18:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615545;
        bh=+lCzk60t6D3AqqDcbuo5xmrcjuWvczNzUemVjNaWeRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=al6y9OGW5bHXgEkwXAeXwXURTdNVCWno/Q5RoiWOyG5IxzQj5GtQnADTMAhaDn7pm
         e1eeJICe4Wz96reuH2360P4dpalXffkB8FQiE+AKhpJ6cYL3BB7eKWql3R12zXlkyF
         p+dbOHeoPyIkEVFSvlPDJzNFQxJzooONakvib97c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.6 24/73] ALSA: usb-audio: Correct a typo of NuPrime DAC-10 USB ID
Date:   Mon,  4 May 2020 19:57:27 +0200
Message-Id: <20200504165506.634960965@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165501.781878940@linuxfoundation.org>
References: <20200504165501.781878940@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 547d2c9cf4f1f72adfecacbd5b093681fb0e8b3e upstream.

The USB vendor ID of NuPrime DAC-10 is not 16b0 but 16d0.

Fixes: f656891c6619 ("ALSA: usb-audio: add more quirks for DSD interfaces")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200430124755.15940-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1643,7 +1643,7 @@ u64 snd_usb_interface_dsd_format_quirks(
 
 	case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
 	case USB_ID(0x10cb, 0x0103): /* The Bit Opus #3; with fp->dsd_raw */
-	case USB_ID(0x16b0, 0x06b2): /* NuPrime DAC-10 */
+	case USB_ID(0x16d0, 0x06b2): /* NuPrime DAC-10 */
 	case USB_ID(0x16d0, 0x09dd): /* Encore mDSD */
 	case USB_ID(0x16d0, 0x0733): /* Furutech ADL Stratos */
 	case USB_ID(0x16d0, 0x09db): /* NuPrime Audio DAC-9 */


