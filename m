Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE76FC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D3B24695
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTvvE365"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgCBE1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:27:48 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44600 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCBE1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 23:27:48 -0500
Received: by mail-io1-f65.google.com with SMTP id u17so5077562iog.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 20:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vv2Sc8B0glSYUp6Nh8UGuuTgg56SY/hjW95AaxE5lns=;
        b=uTvvE365zQuj38jHbwLu0+rP/cUnO+g/w0tYXKG59kdzHgeGB/KG7SmTdfMZs/6N6L
         TEyG0X2ZE5GdBNldoM9zjem5tBkG1AQ93RSi6Cd5F5NCt6gnZTDSlNweL98VxlFDwaNP
         1+U2Wqr/bCGQLydBpVWXpZw8eBKRwAmdKkGNvrBp/7Rt+mn6/QCcHMlAWxbyTdallaRA
         OfM2ElHFETEjeZcyr9iCUEDvVVopcoha/z1vnDzvqCWqp4EfbIzfcGVVg+yeuojo0Nwc
         sN7zZPA6emUwrXXo7MVigSaud12NF6FZ55m6iJ4vodMA5XCcnoaVoEfQ1AXmEkFGgdmD
         omXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vv2Sc8B0glSYUp6Nh8UGuuTgg56SY/hjW95AaxE5lns=;
        b=D0d/iBCXu0ISIRlFDdbgbbkkRXB4nFURpBwdprO8MspxSlR8WyCO5+O2ME5v9fl9He
         Avw/XArKeozY8CuJD5xOuxbkDH+Qptux7k71eMj3JLtkH7H3tgbjO9pfL6sTIX7tpOL7
         kWbg/+n8bgucUo2mr3cXq1DivQzIwddDzOA5LDPa24xPu+QBD9OuEuIkD1hVAyA/18i9
         iobJEVhOKzIGjS30NGfVSq6r8qdgpkh7ENVPKg7vIifAkTVeIh/Oy1NgutGi4eJlGKjv
         U+xrYnL9UAQPC7fHCMsKY10fmieUb60728vbseWRcr6KqHNu5QwncfvfuI/4uCeRKRu5
         sX1g==
X-Gm-Message-State: APjAAAWdeUEEK99Hlap/4FA72ibUVKMYSkfpaYDebtrfJUgWufmdbGf8
        TrdXYXimun6N2nZhowdVJofJOJyu
X-Google-Smtp-Source: APXvYqwLnaMnmXSuqzpJsNvD1QVnviEDyLvidsXNHnMDeYayJDpNvvM6KbU8p8v+oaelrenwubUwQw==
X-Received: by 2002:a05:6638:3:: with SMTP id z3mr12778084jao.65.1583123267649;
        Sun, 01 Mar 2020 20:27:47 -0800 (PST)
Received: from bifrost (c-71-196-210-244.hsd1.co.comcast.net. [71.196.210.244])
        by smtp.gmail.com with ESMTPSA id d17sm6138440ild.11.2020.03.01.20.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 20:27:47 -0800 (PST)
Date:   Sun, 1 Mar 2020 21:27:42 -0700
From:   Cody Planteen <planteen@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de
Subject: [PATCH 1/2] rslib: Minimum symbol size for a Reed-Solomon code is 2
 bits not 1 bit
Message-ID: <a8a449e6acf1c4e09bd8e7d3b8310cbc315e05a8.1583122776.git.planteen@gmail.com>
References: <cover.1583122776.git.planteen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1583122776.git.planteen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The minimum field for a R-S code is GF(2**2). A code in GF(2**1) would
only be 1 symbol long including data and parity which does not make sense.

Signed-off-by: Cody Planteen <planteen@gmail.com>
---
 include/linux/rslib.h           | 4 ++--
 lib/reed_solomon/reed_solomon.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index 5974cedd008c..3e48d4302908 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -57,7 +57,7 @@ struct rs_control {
 	uint16_t	buffers[0];
 };
 
-/* General purpose RS codec, 8-bit data width, symbol width 1-15 bit  */
+/* General purpose RS codec, 8-bit data width, symbol width 2-15 bit  */
 #ifdef CONFIG_REED_SOLOMON_ENC8
 int encode_rs8(struct rs_control *rs, uint8_t *data, int len, uint16_t *par,
 	       uint16_t invmsk);
@@ -68,7 +68,7 @@ int decode_rs8(struct rs_control *rs, uint8_t *data, uint16_t *par, int len,
 	       uint16_t *corr);
 #endif
 
-/* General purpose RS codec, 16-bit data width, symbol width 1-15 bit  */
+/* General purpose RS codec, 16-bit data width, symbol width 2-15 bit  */
 #ifdef CONFIG_REED_SOLOMON_ENC16
 int encode_rs16(struct rs_control *rs, uint16_t *data, int len, uint16_t *par,
 		uint16_t invmsk);
diff --git a/lib/reed_solomon/reed_solomon.c b/lib/reed_solomon/reed_solomon.c
index bbc01bad3053..357723ac252f 100644
--- a/lib/reed_solomon/reed_solomon.c
+++ b/lib/reed_solomon/reed_solomon.c
@@ -219,7 +219,7 @@ static struct rs_control *init_rs_internal(int symsize, int gfpoly,
 	unsigned int bsize;
 
 	/* Sanity checks */
-	if (symsize < 1)
+	if (symsize < 2)
 		return NULL;
 	if (fcr < 0 || fcr >= (1<<symsize))
 		return NULL;
-- 
2.20.1

