Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ADEC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D202073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="QrJVXlru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgATHny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:43:54 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35450 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:43:53 -0500
Received: by mail-pj1-f66.google.com with SMTP id s7so6761789pjc.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 23:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGzxV+LL88B+fATt6abbCjZqtOsySmjlch7DJWcKIik=;
        b=QrJVXlruig0d5ecXvvbWcbKMcaX9f7bSq3DARYQAlfFXIYLoHZhe0LbKsZiw+/Pkhb
         Kqwn/mlr4ATbaCYDIVX2mYktnHVp6zNt5h0WTR1eNoomrO8vtOC5bN9V61quVFzBdmns
         X1eaQxmScrIri3kpRg8MH1wtaFeo3eYnH+fA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGzxV+LL88B+fATt6abbCjZqtOsySmjlch7DJWcKIik=;
        b=jvxiGNEfkBX5AM4+T9fFdHnefD4MmOD4UeGvId0a0ysCCxdU0ZG0/7HDptGHk0uB5l
         oor9iwnGma1l3gf1ixpsVqWu5osaar30NTe0Q5YkCl14YJDJlrvBs4h0zCt/dfRy1Iap
         5zoIFzlONp5PfxH43qsLMrOPdgYFHjn/YwYM0MGp6dpgqbKHYRf7BVMyPZayVBw+zLJf
         71mWHftWC3nLdljpb+8x5z0oEgaZlrtVMH75UBnF46n575yqOX3HHqhMpt/TdHg48lqT
         gk72whXsxKLCo7tAAXa8etN7vwQr3yB2TvIBaKzdanRGXaGnnvAv/xJuOznIzftOBozk
         yy4Q==
X-Gm-Message-State: APjAAAWCv7fR/+HynbOtrx+sGkFF07SE7qQA+NjnHd6F8VrJgeLd+OPv
        /r93G4GuY+6rxKvJpQUQapgFVDyxt3c=
X-Google-Smtp-Source: APXvYqxRl1/EQDPVjdeMlWwspz86l1VCWkYGZLCYqdRqVMW2QddfAJWpVwh0yCdA65+wQtpZK0Lc5g==
X-Received: by 2002:a17:90a:c385:: with SMTP id h5mr21966359pjt.122.1579506233119;
        Sun, 19 Jan 2020 23:43:53 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-4064-d910-a710-f29a.static.ipv6.internode.on.net. [2001:44b8:1113:6700:4064:d910:a710:f29a])
        by smtp.gmail.com with ESMTPSA id a23sm39832941pfg.82.2020.01.19.23.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 23:43:52 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Daniel Axtens <dja@axtens.net>,
        "Igor M. Liplianin" <liplianin@netup.ru>
Subject: [PATCH 1/5] altera-stapl: altera_get_note: prevent write beyond end of 'key'
Date:   Mon, 20 Jan 2020 18:43:40 +1100
Message-Id: <20200120074344.504-2-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120074344.504-1-dja@axtens.net>
References: <20200120074344.504-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

altera_get_note is called from altera_init, where key is kzalloc(33).

When the allocation functions are annotated to allow the compiler to see
the sizes of objects, and with FORTIFY_SOURCE, we see:

In file included from drivers/misc/altera-stapl/altera.c:14:0:
In function ‘strlcpy’,
    inlined from ‘altera_init’ at drivers/misc/altera-stapl/altera.c:2189:5:
include/linux/string.h:378:4: error: call to ‘__write_overflow’ declared with attribute error: detected write beyond size of object passed as 1st parameter
    __write_overflow();
    ^~~~~~~~~~~~~~~~~~

That refers to this code in altera_get_note:

    if (key != NULL)
            strlcpy(key, &p[note_strings +
                            get_unaligned_be32(
                            &p[note_table + (8 * i)])],
                    length);

The error triggers because the length of 'key' is 33, but the copy
uses length supplied as the 'length' parameter, which is always
256. Split the size parameter into key_len and val_len, and use the
appropriate length depending on what is being copied.

Detected by compiler error, only compile-tested.

Cc: "Igor M. Liplianin" <liplianin@netup.ru>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/altera-stapl/altera.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/altera-stapl/altera.c b/drivers/misc/altera-stapl/altera.c
index 25e5f24b3fec..5bdf57472314 100644
--- a/drivers/misc/altera-stapl/altera.c
+++ b/drivers/misc/altera-stapl/altera.c
@@ -2112,8 +2112,8 @@ static int altera_execute(struct altera_state *astate,
 	return status;
 }
 
-static int altera_get_note(u8 *p, s32 program_size,
-			s32 *offset, char *key, char *value, int length)
+static int altera_get_note(u8 *p, s32 program_size, s32 *offset,
+			   char *key, char *value, int keylen, int vallen)
 /*
  * Gets key and value of NOTE fields in the JBC file.
  * Can be called in two modes:  if offset pointer is NULL,
@@ -2170,7 +2170,7 @@ static int altera_get_note(u8 *p, s32 program_size,
 						&p[note_table + (8 * i) + 4])];
 
 				if (value != NULL)
-					strlcpy(value, value_ptr, length);
+					strlcpy(value, value_ptr, vallen);
 
 			}
 		}
@@ -2189,13 +2189,13 @@ static int altera_get_note(u8 *p, s32 program_size,
 				strlcpy(key, &p[note_strings +
 						get_unaligned_be32(
 						&p[note_table + (8 * i)])],
-					length);
+					keylen);
 
 			if (value != NULL)
 				strlcpy(value, &p[note_strings +
 						get_unaligned_be32(
 						&p[note_table + (8 * i) + 4])],
-					length);
+					vallen);
 
 			*offset = i + 1;
 		}
@@ -2449,7 +2449,7 @@ int altera_init(struct altera_config *config, const struct firmware *fw)
 			__func__, (format_version == 2) ? "Jam STAPL" :
 						"pre-standardized Jam 1.1");
 		while (altera_get_note((u8 *)fw->data, fw->size,
-					&offset, key, value, 256) == 0)
+					&offset, key, value, 32, 256) == 0)
 			printk(KERN_INFO "%s: NOTE \"%s\" = \"%s\"\n",
 					__func__, key, value);
 	}
-- 
2.20.1

