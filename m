Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B0AC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11D72335A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="A6A+hw2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgDFOUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:20:37 -0400
Received: from smtp79.iad3a.emailsrvr.com ([173.203.187.79]:37382 "EHLO
        smtp79.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728200AbgDFOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1586182835;
        bh=IXqX3F/z+CAt7tsmt1NR5FY1/oDvfyAWhQLCbYCHVr8=;
        h=From:To:Subject:Date:From;
        b=A6A+hw2vkrBzg4VtAq8MUCYjl5YHOT9OmHkXkyo45WVyAk4dg+oMtJGHJaOfOmCZr
         BElPApt7r7jjrqcjfcaoZJP9jHxJ3j9u4yB2VajrBba98m+Cqle8mBU70XZWkqZgUm
         3ZXqmANE5fYLib01xV99OWG7H5jzkH5eN4Up44IU=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp26.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id ACAC354E7;
        Mon,  6 Apr 2020 10:20:34 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from ian-deb.inside.mev.co.uk (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 06 Apr 2020 10:20:35 -0400
From:   Ian Abbott <abbotti@mev.co.uk>
To:     devel@driverdev.osuosl.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: dt2815: fix writing hi byte of analog output
Date:   Mon,  6 Apr 2020 15:20:15 +0100
Message-Id: <20200406142015.126982-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: dee1a059-f926-4030-9b69-c7ea7a34e1a6-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT2815 analog output command is 16 bits wide, consisting of the
12-bit sample value in bits 15 to 4, the channel number in bits 3 to 1,
and a voltage or current selector in bit 0.  Both bytes of the 16-bit
command need to be written in turn to a single 8-bit data register.
However, the driver currently only writes the low 8-bits.  It is broken
and appears to have always been broken.

Electronic copies of the DT2815 User's Manual seem impossible to find
online, but looking at the source code, a best guess for the sequence
the driver intended to use to write the analog output command is as
follows:

1. Wait for the status register to read 0x00.
2. Write the low byte of the command to the data register.
3. Wait for the status register to read 0x80.
4. Write the high byte of the command to the data register.

Step 4 is missing from the driver.  Add step 4 to (hopefully) fix the
driver.

Also add a "FIXME" comment about setting bit 0 of the low byte of the
command.  Supposedly, it is used to choose between voltage output and
current output, but the current driver always sets it to 1.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/staging/comedi/drivers/dt2815.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/comedi/drivers/dt2815.c b/drivers/staging/comedi/drivers/dt2815.c
index 83026ba63d1c..78a7c1b3448a 100644
--- a/drivers/staging/comedi/drivers/dt2815.c
+++ b/drivers/staging/comedi/drivers/dt2815.c
@@ -92,6 +92,7 @@ static int dt2815_ao_insn(struct comedi_device *dev, struct comedi_subdevice *s,
 	int ret;
 
 	for (i = 0; i < insn->n; i++) {
+		/* FIXME: lo bit 0 chooses voltage output or current output */
 		lo = ((data[i] & 0x0f) << 4) | (chan << 1) | 0x01;
 		hi = (data[i] & 0xff0) >> 4;
 
@@ -105,6 +106,8 @@ static int dt2815_ao_insn(struct comedi_device *dev, struct comedi_subdevice *s,
 		if (ret)
 			return ret;
 
+		outb(hi, dev->iobase + DT2815_DATA);
+
 		devpriv->ao_readback[chan] = data[i];
 	}
 	return i;
-- 
2.25.1

