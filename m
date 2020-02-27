Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48871C3F369
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B75E2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811554;
	bh=j5gtom/5IeYiStN19TQ9vC/vOdafBVAjH6Eh3hoKgVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kMzFK5JxvlAijeM0brvhNQEWm9SxYVqtpMHSyc/DXZjNJZ5YVlHKdk9ZPme/cEQz/
	 oM63Q/90lj79cDq1XniJJv2fj8oO9Ok7dx7DYcvv9ad8Trv/ZkGqe5nVad4KPa7pJ8
	 dFJq/mZNOcqPoK/NqtJfzwtRIIRnq8nFxb8rA93s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbgB0Nwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:52:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730455AbgB0Nw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:52:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E570E20578;
        Thu, 27 Feb 2020 13:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811548;
        bh=j5gtom/5IeYiStN19TQ9vC/vOdafBVAjH6Eh3hoKgVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sM5e+CIkqbSFe4V51K947wWAYz/XwNwg0uCf0gh2aJJ50JqrdGn4FS+y+3w9Q/Uzu
         iUkSqcaDoW6crsf4d/RroAvWyJY4Dh9SPVI2gBpKABNzxz+J5kD0/PsPwnwebN/lR3
         M0gWEaRUYH6DyNc4LBrc7vEtR/hJIikNI6568Oh4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 010/237] ALSA: usb-audio: Apply sample rate quirk for Audioengine D1
Date:   Thu, 27 Feb 2020 14:33:44 +0100
Message-Id: <20200227132256.677883462@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
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
@@ -1151,6 +1151,7 @@ bool snd_usb_get_sample_rate_quirk(struc
 	case USB_ID(0x1de7, 0x0014): /* Phoenix Audio TMX320 */
 	case USB_ID(0x1de7, 0x0114): /* Phoenix Audio MT202pcs */
 	case USB_ID(0x21B4, 0x0081): /* AudioQuest DragonFly */
+	case USB_ID(0x2912, 0x30c8): /* Audioengine D1 */
 		return true;
 	}
 	return false;


