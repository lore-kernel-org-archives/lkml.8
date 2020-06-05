Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5558FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270C32074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxkKKMyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgFEPpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgFEPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:45:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B716BC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 08:45:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so10218493wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BetZ+wYF1iiWHnIZJ0zwu4SRy9AotvXrrNHCrobpfBA=;
        b=nxkKKMyy4FDVn9Z3erPWnQd1uF1jyI+aXihMySRJa/m+2RuKvsQvhfAAG3LedtWZVX
         zmKf5ZBq1h8scS8tPtPSMSCzRZCkzbZ1NI4OMoKqxfZStA0r8HLzG4L984rw69PlxJyy
         XHw5mo+y88km16pcp7XrSzz5iCK+Vg6KTWvP4ixKUEEmwNp6RadK5yOFFj/8QX9i4Bju
         dJOHgCQ/n9JFHU3wXN7htzh6j9C9giprGL8jYngznpG95TTvatkT/VOrTeuYQkiDdS6L
         0WSJ/jsoz8u/6r5oNInz2ttFYLfKjupcw754znqBvBd1rYk/foE0LFMtfyO3baM38/Fj
         MHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BetZ+wYF1iiWHnIZJ0zwu4SRy9AotvXrrNHCrobpfBA=;
        b=Ta0ooc1Dcxd/Et7/5FPLxP2qP2x9km0MkZzREEODLQikIXNo5FJR2I9DYs9qoxRtZ9
         bOSutjGt4mmVwwndHUl8nSUZiiwq8rYqIT0LeyOLZmaHfcrmte5lEZ6xoM7ViBpOLYB4
         QM8/OhbwVNqGw6ioJQz+jPSzn2mSdYt8tAO8Hk37VKQrjPmNSQWz9mhE3ExrtW9UVFHN
         E2eL9WDFMJuMLZ6EK6H6A+i7MqcxnXji891ktDBPOcSAyqUHPM3mI13o9HvMGyBPIpsQ
         H5SseEzD9DIzSmbomxBqAMSaaFSW4thiyj0nC9pjNMJC9jIoi31Yl+AoGbpnCAI/djnb
         hmiw==
X-Gm-Message-State: AOAM532ypkWxvRP4bUMCUK4XuRWlMCUgJXEJQsFlLWf8GweMB04Grm7C
        N8dlPFU6TSp7q021XIOUAnc=
X-Google-Smtp-Source: ABdhPJz+hGZHyw8F9K+Ai8h6JZcQYwxxpSrKCcd8SjXCdA8ddUeBWbLp+YZvvNZ0hGpb1CJSCXsElg==
X-Received: by 2002:adf:8b47:: with SMTP id v7mr9739687wra.238.1591371948442;
        Fri, 05 Jun 2020 08:45:48 -0700 (PDT)
Received: from localhost.localdomain (go-46.stud.uni-potsdam.de. [141.89.103.46])
        by smtp.googlemail.com with ESMTPSA id g187sm12105848wma.17.2020.06.05.08.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 08:45:47 -0700 (PDT)
From:   Joan Bruguera <joanbrugueram@gmail.com>
Cc:     Joan Bruguera <joanbrugueram@gmail.com>,
        Haren Myneni <haren@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Add missing bound checks for software 842 decompressor
Date:   Fri,  5 Jun 2020 17:44:15 +0200
Message-Id: <20200605154416.5022-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The software 842 decompressor receives, through the initial value of the
'olen' parameter, the capacity of the buffer pointed to by 'out'. If this
capacity is insufficient to decode the compressed bitstream, -ENOSPC
should be returned.

However, the bounds checks are missing for index references (for those
ops. where decomp_ops includes a I2, I4 or I8 subop.), and also for
OP_SHORT_DATA. Due to this, sw842_decompress can write past the capacity
of the 'out' buffer.

The case for index references can be triggered by compressing data that
follows a 16-byte periodic pattern (excluding special cases which are
better encoded by OP_ZEROS) and passing a 'olen' somewhat smaller than the
original length.
The case for OP_SHORT_DATA can be triggered by compressing an amount of
data that is not a multiple of 8, and then a slightly smaller 'olen' that
can't fit those last <8 bytes.

Following is a small test module to demonstrate the issue.

-

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/sw842.h>

static unsigned char workspace[1000000] = { 0 }; // Hacky

static void test_bound(const char *name, unsigned ibound, unsigned dbound)
{
	uint8_t in[ibound], out[ibound * 4], decomp[ibound /* Overallocated */];
	unsigned clen = ibound * 4, dlen = dbound, i;
	int ret;

	for (i = 0; i < ibound; i ++)
		in[i] = i % 16; // 0, 1, 2, ..., 14, 15, 0, 1, 2, ...
	for (i = dbound; i < ibound; i++)
		decomp[i] = 0xFF; // Place guard bytes

	ret = sw842_compress(in, ibound, out, &clen, workspace);
	BUG_ON(ret != 0);

	ret = sw842_decompress(out, clen, decomp, &dlen);
	if (ret != -ENOSPC) {
		printk(KERN_ERR "%s: Expected ENOSPC to be returned\n", name);
	}
	for (i = dbound; i < ibound; i++) {
		if (decomp[i] != 0xFF) {
			printk(KERN_ERR "%s: Guard overwritten\n", name);
			break;
		}
	}
}

int init_module(void)
{
	test_bound("Index reference test", 256, 64);
	test_bound("Short data test", 12, 8);
	return -ECANCELED; // Do not leave this test module hanging around
}

void cleanup_module(void)
{
}

MODULE_LICENSE("GPL");
MODULE_SOFTDEP("pre: 842");

Signed-off-by: Joan Bruguera <joanbrugueram@gmail.com>
---
 lib/842/842_decompress.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/842/842_decompress.c b/lib/842/842_decompress.c
index 582085ef8b4..c29fbfc9d08 100644
--- a/lib/842/842_decompress.c
+++ b/lib/842/842_decompress.c
@@ -202,6 +202,9 @@ static int __do_index(struct sw842_param *p, u8 size, u8 bits, u64 fsize)
 			 (unsigned long)total,
 			 (unsigned long)beN_to_cpu(&p->ostart[offset], size));
 
+	if (size > p->olen)
+		return -ENOSPC;
+
 	memcpy(p->out, &p->ostart[offset], size);
 	p->out += size;
 	p->olen -= size;
@@ -345,6 +348,9 @@ int sw842_decompress(const u8 *in, unsigned int ilen,
 			if (!bytes || bytes > SHORT_DATA_BITS_MAX)
 				return -EINVAL;
 
+			if (bytes > p.olen)
+				return -ENOSPC;
+
 			while (bytes-- > 0) {
 				ret = next_bits(&p, &tmp, 8);
 				if (ret)
-- 
2.27.0

