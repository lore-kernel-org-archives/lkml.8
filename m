Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EBBC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113A72072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SZtwdh2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgAQQyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:54:06 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33547 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgAQQyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:54:05 -0500
Received: by mail-il1-f193.google.com with SMTP id v15so21830271iln.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 08:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=brzZaUJh7FW1ka56Adtf/85XWoAeQqVQT/Er0invsYs=;
        b=SZtwdh2oqjI+UBiZ9BSi5WKvwkiUFyfwGoVa2E3NdmvReO0bKyMmTi7Ubdbzdm1zYx
         j/dvlz0YjLN6po1K1VfcfjAdHKCvHItvP3Fh0gJV3ri9ioJU/CfhoGK21WXnfbbiT9Ji
         VousTxLZB3mEZQk6cxudxSPYWMu4CwYT2N1RfGnbN5M51Qg1EEcVToajht0YCvQ0kEfi
         aFDZVWqMkJNUKyTuLZY22D6P6bg1mg5zo/PuTI9B2KNZ9AMzwyoslvWMmqdQS7Se9uAT
         caEUvK8/k9nEXVFSzcrVcZBzcRGDYYGKFiV5c/iPuhhat3MwI0pN5oV/tk6ytlYWaiwu
         EiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=brzZaUJh7FW1ka56Adtf/85XWoAeQqVQT/Er0invsYs=;
        b=Y6Mu4yMNtCXS2y0yH1oZygDijRwRSADiHkOG/47ZJcyQRN53yANrAO3a9cjyNupQM1
         WE6h27zKY69LnLinWod7XIODiLsY62KC425tjAjXo5+pB2w4Z7MtufmcPfWOTspGZ/fW
         feupIUq/vCWO97UbcanKJJk0+nqLIzWRLY2wpGHD0EjGuYv8ngjm4aKIBfuguHMSMQrr
         DZof2yQZmRyJWxKSevrA1XJff9+4yRWQqNAgbbmylPdQqhwWmk7KygCLD2OgjxY9eoA3
         rRVPu5J7RFlyewhiNQiCaW1MttFIPykCEyLlKizMdm/KUDVAuGNgUzRKNCNrcgRj76LC
         67jQ==
X-Gm-Message-State: APjAAAXGizsC7okc4k6aUzORCnnYn8cbiH//A46SNy8OsKezJ/bIDDZk
        TcoPxcB3OnJj/FL1XFxMZetTvA==
X-Google-Smtp-Source: APXvYqwYn6A64W6RYQdcSAW8Dx+vuADYJTH0IldHuTPwJSaUgo9yYVECtHmkSACxkdEpECMiMT5HEw==
X-Received: by 2002:a92:4013:: with SMTP id n19mr3718111ila.279.1579280044000;
        Fri, 17 Jan 2020 08:54:04 -0800 (PST)
Received: from alago.cortijodelrio.net (CableLink-189-219-74-147.Hosts.InterCable.net. [189.219.74.147])
        by smtp.googlemail.com with ESMTPSA id f16sm8120662ilq.16.2020.01.17.08.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 08:54:03 -0800 (PST)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     shuah@kernel.org
Cc:     =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org (open list:RESTARTABLE SEQUENCES SUPPORT),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH 2/3] selftests/rseq: Build with LDFLAGS
Date:   Fri, 17 Jan 2020 10:53:27 -0600
Message-Id: <20200117165330.17015-2-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117165330.17015-1-daniel.diaz@linaro.org>
References: <20200117165330.17015-1-daniel.diaz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During cross-compilation, it was discovered that LDFLAGS were
not being used while building binaries, leading to defaults
which were not necessarily correct.

OpenEmbedded reported this kind of problem:
  ERROR: QA Issue: No GNU_HASH in the ELF binary [...], didn't pass LDFLAGS?

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/rseq/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index d6469535630a..2d2d0c283de1 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -22,15 +22,15 @@ TEST_PROGS = run_param_test.sh
 include ../lib.mk
 
 $(OUTPUT)/librseq.so: rseq.c rseq.h rseq-*.h
-	$(CC) $(CFLAGS) -shared -fPIC $< $(LDLIBS) -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -fPIC $< $(LDLIBS) -o $@
 
 $(OUTPUT)/%: %.c $(TEST_GEN_PROGS_EXTENDED) rseq.h rseq-*.h
-	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) $< $(LDLIBS) -lrseq -o $@
 
 $(OUTPUT)/param_test_benchmark: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
 					rseq.h rseq-*.h
-	$(CC) $(CFLAGS) -DBENCHMARK $< $(LDLIBS) -lrseq -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -DBENCHMARK $< $(LDLIBS) -lrseq -o $@
 
 $(OUTPUT)/param_test_compare_twice: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
 					rseq.h rseq-*.h
-	$(CC) $(CFLAGS) -DRSEQ_COMPARE_TWICE $< $(LDLIBS) -lrseq -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -DRSEQ_COMPARE_TWICE $< $(LDLIBS) -lrseq -o $@
-- 
2.20.1

