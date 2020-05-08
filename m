Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452E1C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B39620735
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LSasER3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgEHGkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgEHGj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:39:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F29C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 23:39:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z11so991063ybk.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 23:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JqKocGa5cimql1fp4DS+xPXwrVZ2Z2hJEVO/fiKh20k=;
        b=LSasER3WBqtfBg/bGE3PeVOf3C1Dim6JBLIEgeU3rioM9+MNBKorVZ4wLEoKOWeVEB
         WVpX2iRLeOoAaTH5FU79u0hIMkOIFUHESFKAB1oxCjCgjRvmMdaxTMqaBOwQHVR2u8SD
         YZHIpK0wPVJW+tg5pO++cjzhWrun5K+JyrZzWt5wXl2Y8cto4/QGzWXb3Z/TQ/PXtNRg
         qgUSdqGjHPbW9fg5ueq6bMEwFbpewcbkDB66XY25g0+h47IYWDzeNld91gofqSW4vQkh
         JGmHEsw+wh2w1youzj1UIYZYEk5FplV54amOTaCJkWNEEuH/6+HkYRwNtBmntewVUL2F
         WsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JqKocGa5cimql1fp4DS+xPXwrVZ2Z2hJEVO/fiKh20k=;
        b=sp89BUCDpK2wAXZoXq+ke7j9wBDiJoGyxgvNfljfcF7aIOubz2hrSYydXmqcBYm4bi
         qK1bj6THhqV5YTadpDGTqts/9crXrqjGlCSDQBXU0/N/YIz+NtlhXymuZ8xM1wM3p+UN
         kuGJH1SxjiOPR8w3IF8QwqfCTQ+mfc37js06uBV9qxqy/7pftJFJIH87ZcAROhqrLkpv
         O2PW3PLmvjbioU5QwoxBFKDxt1M9vDowVfBhPAKT6oSBMdn1vYlEVII0bF2G7NRyy10o
         gbz64VCvDPgMteCbAmTqlDg6D4G1X3dyllP21EqlnlAldnE6USVeR0tOVRr33o+65yH9
         BoFQ==
X-Gm-Message-State: AGi0PubIw/wDqigNWSUrNhyAGqKGePzBqn1ZmCjZG77GJpGMUhI7QWB0
        6GVguQ+n+d4JaWOPI9Sdo2JtuT8QHjYj
X-Google-Smtp-Source: APiQypIzG335LQcvib+amwZBO3RBTIJWyEl0ag5FnTDtNK3nU2gmInNWeH2R0b+Fk2aSWTZl0MrQJhBzEET6
X-Received: by 2002:a25:dbd2:: with SMTP id g201mr2328607ybf.17.1588919997600;
 Thu, 07 May 2020 23:39:57 -0700 (PDT)
Date:   Thu,  7 May 2020 23:39:54 -0700
Message-Id: <20200508063954.256593-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH] libbpf hashmap: fix undefined behavior in hash_bits
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bits is 0, the case when the map is empty, then the >> is the size of
the register which is undefined behavior - on x86 it is the same as a
shift by 0. Fix by handling the 0 case explicitly.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index d5ef212a55ba..781db653d16c 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -19,6 +19,8 @@
 static inline size_t hash_bits(size_t h, int bits)
 {
 	/* shuffle bits and return requested number of upper bits */
+	if (bits == 0)
+		return 0;
 	return (h * 11400714819323198485llu) >> (__WORDSIZE - bits);
 }
 
-- 
2.26.2.645.ge9eca65c58-goog

