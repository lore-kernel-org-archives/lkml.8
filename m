Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7C7C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0807B20770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgIDPe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:34:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44768 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726111AbgIDPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:34:51 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-mw9RuvctPhCiT8gwiGfWPQ-1; Fri, 04 Sep 2020 11:34:49 -0400
X-MC-Unique: mw9RuvctPhCiT8gwiGfWPQ-1
Received: by mail-ed1-f71.google.com with SMTP id m88so2883417ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WtSQORr6+6yYCkCLTXJ5IatuumCAr49mZj4nyHMqJcM=;
        b=SvS3yywOHqGeS06xV7R2ay8g22UXyjoN5nm5OgD3bxS0vs1nVUINFf9xvtleyWZe69
         N8VIEJdjZmU++VFICSA1ludNzqrgvZRRN4Vb0OwNfDafFOd7jeY4P8RDESipb4dIhTpo
         yTa544E5HEa5pJPpNwAf/G7444uVYsokTUZ7N3fRRiqhlsV5z/n0wA6+N1Gp3WkTZPdI
         x3JkhHKe98FUOdzAqgOXKYX4VNE1Yin4tF8FtAkcfxRuH4LVhpQSbLK6p60GeO0D/8k4
         LfC6B8BBsJxS9NrRt33zi93qATLmHU/Xeec0mlN395ug25T7dluMPSOrQo4PDNi9qcMD
         +Qkg==
X-Gm-Message-State: AOAM533mQtxYNEu+Wl8Kf3GFTo8J9OO4gQ9V2fJ4Ra5WbfUZHhdN3iq0
        pPV+hXqkn9LyDZVfMwHocfvsfNBcMj8dKeR/k13JWdLgjjknaEErNSaOyOGEXItPKultM0uYv8s
        gSLhgqu2HUTJ2Iy+uXQ2Olv+j
X-Received: by 2002:a17:906:7746:: with SMTP id o6mr7801729ejn.113.1599233687737;
        Fri, 04 Sep 2020 08:34:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUn0pYFiGC9IZPcFaUNOfLKZi7Fn+UKLTxwq178dkbzQ/9wtaONXkA8fnUdBFhPVH2ISnePg==
X-Received: by 2002:a17:906:7746:: with SMTP id o6mr7801706ejn.113.1599233687562;
        Fri, 04 Sep 2020 08:34:47 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id e11sm6159055edu.23.2020.09.04.08.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:34:47 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 08/10] objtool: Only include valid definitions depending on source file type
Date:   Fri,  4 Sep 2020 16:30:26 +0100
Message-Id: <20200904153028.32676-9-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200904153028.32676-1-jthierry@redhat.com>
References: <20200904153028.32676-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Header include/linux/objtool.h contains both C and assembly definition that
are visible regardless of the file including them.

Place definition under conditional __ASSEMBLY__.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 include/linux/objtool.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 358175c9c2b5..15e9997a9fb4 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -3,6 +3,8 @@
 #define _LINUX_OBJTOOL_H
 
 #ifdef CONFIG_STACK_VALIDATION
+
+#ifndef __ASSEMBLY__
 /*
  * This macro marks the given function's stack frame as "non-standard", which
  * tells objtool to ignore the function when doing stack metadata validation.
@@ -15,6 +17,8 @@
 	static void __used __section(.discard.func_stack_frame_non_standard) \
 		*__func_stack_frame_non_standard_##func = func
 
+#else /* __ASSEMBLY__ */
+
 /*
  * This macro indicates that the following intra-function call is valid.
  * Any non-annotated intra-function call will cause objtool to issue a warning.
@@ -25,6 +29,8 @@
 	.long 999b;						\
 	.popsection;
 
+#endif /* __ASSEMBLY__ */
+
 #else /* !CONFIG_STACK_VALIDATION */
 
 #define STACK_FRAME_NON_STANDARD(func)
-- 
2.21.3

