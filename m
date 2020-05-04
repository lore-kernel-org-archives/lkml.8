Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C21CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E5B20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615997;
	bh=PyIQ4kK76SdPKTkL4N7bmlzScORWQ5LQBKoJEDlI3Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wT3lRYD7tqbq0FsGZkc1l+9tm4VyxdWwznyMa2IDeYH/pE8j89JEQWvx1pnvLoK6+
	 Hqk+XLts6rVWdHutieYBQUQFy7fMZqkrNHumU22lMOSNjjCejXScYpusdPaLa7MdEA
	 Se3rQnWt72XBewVydaNKkWvvsx8FIKp0xgOfJxGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgEDSNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731193AbgEDSBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:01:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF2BA206B8;
        Mon,  4 May 2020 18:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615299;
        bh=PyIQ4kK76SdPKTkL4N7bmlzScORWQ5LQBKoJEDlI3Rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=erIAyu8CC901XdRictSRhuAAQcSVdbkdsoR7f1T3Xt6j65O1FQOrB4VY/WlGGtnZf
         LjxtL4By+cAhoMhx3ekk8DHZl1X2s3MDCBagl0tosiQub6p5lhv6YB+D+Plf99tZ4R
         tAUWWosg5RlFjqemKQVC+fVgBsPnhQ2CWEaCLcn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 07/37] ALSA: usb-audio: Correct a typo of NuPrime DAC-10 USB ID
Date:   Mon,  4 May 2020 19:57:20 +0200
Message-Id: <20200504165449.465263927@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165448.264746645@linuxfoundation.org>
References: <20200504165448.264746645@linuxfoundation.org>
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
@@ -1385,7 +1385,7 @@ u64 snd_usb_interface_dsd_format_quirks(
 
 	case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
 	case USB_ID(0x10cb, 0x0103): /* The Bit Opus #3; with fp->dsd_raw */
-	case USB_ID(0x16b0, 0x06b2): /* NuPrime DAC-10 */
+	case USB_ID(0x16d0, 0x06b2): /* NuPrime DAC-10 */
 	case USB_ID(0x16d0, 0x09dd): /* Encore mDSD */
 	case USB_ID(0x16d0, 0x0733): /* Furutech ADL Stratos */
 	case USB_ID(0x16d0, 0x09db): /* NuPrime Audio DAC-9 */


