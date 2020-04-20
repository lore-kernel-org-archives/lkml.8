Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B03EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA94B2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="RCtJAKGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgDTSdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgDTSdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:33:07 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E80C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:33:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so5341327pfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gen1M+qmXAJMJ8ttcb3/H4xStTkszQo6DIR2GPpGFxw=;
        b=RCtJAKGblQLL+e4wkUbNuQFul/A/dXUoDg6yQk1o/4X9s+YZmF9wuHMAv6OByfLo/x
         SG422GKuiYQeARlGpR4+qWPgY8jI03n+4M/P8v7rNzTqZEbUQhw3EfRGEmmH5n8Q8yUA
         h75q9+rP1TDxrxpLgiMNmSbplnGPmbPRjZP9BvVlVwG7hT1A0iJWuvg/nNMEla/rTqM8
         OeHC8M6gfdK8JW5NEpArpQK81Rnc0xj4ULhKgYwgVs9scdFI6DjMnUPGf9JVlCC8SHaB
         8aTamiSSFbtQ50kyMdNT7LIR4GJOqMvguXUcSZ5AS0immHALKi06agJEx/Sbcgtd11rr
         0rKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gen1M+qmXAJMJ8ttcb3/H4xStTkszQo6DIR2GPpGFxw=;
        b=BWVfNsg6nUMJa2NebVez5ZqqyRIJFfuSfwrURynaNv1bp2ZgKo5TGMUa3F/m/bb+0T
         su55wOoJnnXqTwaRBURdgEVIkkTz3OzUh/2fGMfD9PMrFshz2w7yRCcDtjRfnnt+hwv0
         c//0V6qRYRpMqE+Ehg1UOgNasIAExZF/0gaeFKWIC4k6q6t0Morf2wYrntzeILjhj79j
         bf7Y3CGNZ5VxzJxalovpcicqCls8tvbWexiTghHNozl6H6Qqh8ccZUZKyslkllk14zZi
         U+ddfaO/5IsIN9E0ldX26rPr+z+vRmc6iNg+PG5WShFY5r58+zdEsc1rL9QhA2+B8zvE
         k+JQ==
X-Gm-Message-State: AGi0PualCTWEI81SKqvK2dPXpqPdqPAS+TSurzK9QcarGqRqrsOtfukN
        ouf1T6Vn6tXgd8PVNCM39UNPnZqd+eihWg==
X-Google-Smtp-Source: APiQypJNWMn/7pvPs/nSvHePEQtldRDCRs999tTtsV6kWSextz2pcNoQoEch533PPnSP0kxuV5q8Tw==
X-Received: by 2002:a63:1566:: with SMTP id 38mr18556582pgv.355.1587407586218;
        Mon, 20 Apr 2020 11:33:06 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l185sm172536pfl.104.2020.04.20.11.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:33:04 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        Andrei Vagin <avagin@openvz.org>
Subject: [PATCH 1/3] x86/vdso2c: Correct err messages on file opening
Date:   Mon, 20 Apr 2020 19:32:53 +0100
Message-Id: <20200420183256.660371-2-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420183256.660371-1-dima@arista.com>
References: <20200420183256.660371-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

err() message in main() is misleading: it should print `outfilename`,
which is argv[3], not argv[2].

Correct error messages to be more precise about what failed and for
which file.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 3842873b3ae3..7380908045c7 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -187,7 +187,7 @@ static void map_input(const char *name, void **addr, size_t *len, int prot)
 
 	int fd = open(name, O_RDONLY);
 	if (fd == -1)
-		err(1, "%s", name);
+		err(1, "open(%s)", name);
 
 	tmp_len = lseek(fd, 0, SEEK_END);
 	if (tmp_len == (off_t)-1)
@@ -240,7 +240,7 @@ int main(int argc, char **argv)
 	outfilename = argv[3];
 	outfile = fopen(outfilename, "w");
 	if (!outfile)
-		err(1, "%s", argv[2]);
+		err(1, "fopen(%s)", outfilename);
 
 	go(raw_addr, raw_len, stripped_addr, stripped_len, outfile, name);
 
-- 
2.26.0

