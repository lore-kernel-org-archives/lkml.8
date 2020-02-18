Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3858EC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A31322B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056373;
	bh=889FUsw8ToFo6ZuKe4T1rsGGm3hUcVkaCHLutHExmao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m9TLTyifWM5vqdq1l/bTBrI97QcDdUzee17RIOLDYXXymEr2ILhvt1LzKUAeRUu0H
	 MPhJa2EfCSgCRW8HGb2YULkO/KFp7kBg4dRAC/Q25BSKOW3SJ/mxOKQz9Hajrr0vDv
	 PgwwRwCycCDvcW5KrZVOsW6wA7X+Q3O/0Q/YNZnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgBRUAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:00:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbgBRUAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:00:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12212464E;
        Tue, 18 Feb 2020 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056037;
        bh=889FUsw8ToFo6ZuKe4T1rsGGm3hUcVkaCHLutHExmao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4jEHiMYBxIMPuM4x8YS5fuUjKhTr1XO+QdEEhMOC8eU/UzzClHH4j6p0L1g5cJuF
         A7ILLLgei+5yP8dCMJohytitTdI2WQwnEViI0K7IrVqK6K9hVhLsQDS5xfT/6A8heP
         veJZDH9S2xATMqXs0reoZr5qUAHqj+HI+l7S9u6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.5 11/80] ALSA: usb-audio: Apply sample rate quirk for Audioengine D1
Date:   Tue, 18 Feb 2020 20:54:32 +0100
Message-Id: <20200218190433.163362498@linuxfoundation.org>
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

From: Arvind Sankar <nivedita@alum.mit.edu>

commit 93f9d1a4ac5930654c17412e3911b46ece73755a upstream.

The Audioengine D1 (0x2912:0x30c8) does support reading the sample rate,
but it returns the rate in byte-reversed order.

When setting sampling rate, the driver produces these warning messages:
[168840.944226] usb 3-2.2: current rate 4500480 is different from the runtime rate 44100
[168854.930414] usb 3-2.2: current rate 8436480 is different from the runtime rate 48000
[168905.185825] usb 3-2.1.2: current rate 30465 is different from the runtime rate 96000

As can be seen from the hexadecimal conversion, the current rate read
back is byte-reversed from the rate that was set.

44100 == 0x00ac44, 4500480 == 0x44ac00
48000 == 0x00bb80, 8436480 == 0x80bb00
96000 == 0x017700,   30465 == 0x007701

Rather than implementing a new quirk to reverse the order, just skip
checking the rate to avoid spamming the log.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200211162235.1639889-1-nivedita@alum.mit.edu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1402,6 +1402,7 @@ bool snd_usb_get_sample_rate_quirk(struc
 	case USB_ID(0x1395, 0x740a): /* Sennheiser DECT */
 	case USB_ID(0x1901, 0x0191): /* GE B850V3 CP2114 audio interface */
 	case USB_ID(0x21B4, 0x0081): /* AudioQuest DragonFly */
+	case USB_ID(0x2912, 0x30c8): /* Audioengine D1 */
 		return true;
 	}
 


