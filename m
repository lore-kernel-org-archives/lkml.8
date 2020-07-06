Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E425C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9AD0206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGFXk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:40:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35665 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGFXk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:40:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so42337570wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 16:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8f1d2vneWPYG6cNHDIYxhbTZtuTn4U5ltxye0jZNYhY=;
        b=l8tPDeT/4KU2AlxyobfTn24M1RG92kMFXHwejD0hpJjrMFzXekku6ozq6QM7e5XGp1
         5/7xFejJBCiEf3g0NcojjHLO3DqrYECpx8eggZ3IyOJZfoay4w2euDU4sZVG1yH/CaDj
         wN32+gNFKt7EXzvxRVfEEJpZP+3Ia+oBwTQ26VILDplxXRY/nuV1z8lKEA/giD8F+mhp
         67TsBXukx1ZbzICUn3baM9IRw3tGb0G1y/m+kF2htb3BH3jT187Qdtmx1xwFLtIGhDbi
         XMrunEdVlfug/nvje3Pw5HjBXMO3G2zQ7oexqmn/e0cy+5HG+ZxaBB5aQSe4hreNN4T8
         E9lQ==
X-Gm-Message-State: AOAM5334LJrK8dpEkYF96vHmmNI4NI5/SP3VS6jtLwtQ3vVUyVkcL46u
        5DkGX/b9d9uKh5MwBsv1FJ0=
X-Google-Smtp-Source: ABdhPJwNJf56q8o6pxHITt3B3DjKyWyHc7q/3uEAooDIQh77MI6A/hBSGihn61cqeLFIwtCUzZXEnw==
X-Received: by 2002:a7b:c007:: with SMTP id c7mr1417009wmb.165.1594078854626;
        Mon, 06 Jul 2020 16:40:54 -0700 (PDT)
Received: from msft-t490s.lan ([2001:b07:5d26:7f46:d7c1:f090:1563:f81f])
        by smtp.gmail.com with ESMTPSA id 138sm1827541wmb.1.2020.07.06.16.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 16:40:53 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] pstore/platform: build fix when crypto API are disabled
Date:   Tue,  7 Jul 2020 01:40:45 +0200
Message-Id: <20200706234045.9516-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

When building a kernel with CONFIG_PSTORE=y and CONFIG_CRYPTO not set,
a build error happens:

    ld: fs/pstore/platform.o: in function `pstore_dump':
    platform.c:(.text+0x3f9): undefined reference to `crypto_comp_compress'
    ld: fs/pstore/platform.o: in function `pstore_get_backend_records':
    platform.c:(.text+0x784): undefined reference to `crypto_comp_decompress'

This because some pstore code uses crypto_comp_(de)compress
regardless of the CONFIG_CRYPTO status.
Fix it by wrapping the (de)compress usage by IS_ENABLED(CONFIG_PSTORE_COMPRESS)

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 fs/pstore/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index a9e297eefdff..6022d8359f96 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -436,7 +436,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 					  dst_size, &dump_size))
 			break;
 
-		if (big_oops_buf) {
+		if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && big_oops_buf) {
 			zipped_len = pstore_compress(dst, psinfo->buf,
 						header_size + dump_size,
 						psinfo->bufsize);
@@ -668,7 +668,7 @@ static void decompress_record(struct pstore_record *record)
 	int unzipped_len;
 	char *unzipped, *workspace;
 
-	if (!record->compressed)
+	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !record->compressed)
 		return;
 
 	/* Only PSTORE_TYPE_DMESG support compression. */
-- 
2.26.2

