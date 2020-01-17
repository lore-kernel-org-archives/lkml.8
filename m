Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9F6C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D6F214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ju3I1Jfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgAQQyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:54:16 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35498 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgAQQyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:54:14 -0500
Received: by mail-io1-f65.google.com with SMTP id h8so26751267iob.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 08:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uFIUVKsz4aPMvzp5H7zdGJcmUXpH7dHc5gmMJqmLGlg=;
        b=Ju3I1Jfs9dGT84Iy5fhqRFLUVMNJ2DaIdE+XAgBGJVq2WI7cBhYBPlKCVOfqs4VjMZ
         5ICq/oE45Eg7QmU2ztU/ugOzLpOvQ2sTLgH4W6CEG5igTtgl1kKoVhX3J3f1sfZ7fO+I
         JlYaxN8NlIaKixzCZBXnSUCbPBdtD6QReoBvllPp/KtRlRs4nS+7Hm4udEoIrUm8C0m7
         Bv5BGlkrns50GvcaB7Bf+XmCIptl1fNUe3m5b7HoaXRW5F86S/8vnDbb3AuiE2juhPi+
         5AJL6a9LVL5rapntmvKmiWEqM1aM55VyhUm/u1S9BHEP0VaaVuXAx4M5wkLazCr15Z/M
         67ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uFIUVKsz4aPMvzp5H7zdGJcmUXpH7dHc5gmMJqmLGlg=;
        b=PImLmAKfeFuihsnK6AKQLgbBgq7mPNEyg1WSO6pbHxb/ZZs1Vvh1q41qrqzNJ7tBDU
         wle/eoMMssX0r6UACGnRfeZp7YdHMbRbQL2ySN+mwfQ4WUEaSV6beGAdhzo0/ubY4yhy
         L8snOBdprZjD3LocvZdCtN6k21D2swoJ/Tm6mBfDx/pWxSPvBiqe5hpU7UMjUQ4BQUq/
         uzYu3bxLL6DMttusckrz/RDpxxPgT0nAIkwYax0y8BwJwXxtiZR9Pb6hw2ypHim2dYH9
         Py1Nj4CDahrFf4+jo2xKJdbMwSeXRmOZazdQ4suLJvtzHjPlTXgHI6wMyulIoAXyeCsc
         R0dw==
X-Gm-Message-State: APjAAAUx+6yNoBLvjL5877yCQaKSNhqzIr0LwHWN9KhbzV+s62I8KyR8
        gAdA5nUK2HYlGDwdvssAfl2PGg==
X-Google-Smtp-Source: APXvYqyb7lB/rV1ivpPHirD+5CsQ4f/jRvFS49kUJduVxa9UCt1nkgGP/tUwxXBNpRlOKcvyPaLpjg==
X-Received: by 2002:a5e:9748:: with SMTP id h8mr23496836ioq.121.1579280053465;
        Fri, 17 Jan 2020 08:54:13 -0800 (PST)
Received: from alago.cortijodelrio.net (CableLink-189-219-74-147.Hosts.InterCable.net. [189.219.74.147])
        by smtp.googlemail.com with ESMTPSA id f16sm8120662ilq.16.2020.01.17.08.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 08:54:12 -0800 (PST)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     shuah@kernel.org
Cc:     =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        netdev@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
        bpf@vger.kernel.org (open list:BPF (Safe dynamic programs and tools)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] selftests/bpf: Build urandom_read with LDFLAGS and LDLIBS
Date:   Fri, 17 Jan 2020 10:53:28 -0600
Message-Id: <20200117165330.17015-3-daniel.diaz@linaro.org>
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

During cross-compilation, it was discovered that LDFLAGS and
LDLIBS were not being used while building binaries, leading
to defaults which were not necessarily correct.

OpenEmbedded reported this kind of problem:
  ERROR: QA Issue: No GNU_HASH in the ELF binary [...], didn't pass LDFLAGS?

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e2fd6f8d579c..f1740113d5dc 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -88,7 +88,7 @@ $(notdir $(TEST_GEN_PROGS)						\
 	 $(TEST_CUSTOM_PROGS)): %: $(OUTPUT)/% ;
 
 $(OUTPUT)/urandom_read: urandom_read.c
-	$(CC) -o $@ $< -Wl,--build-id
+	$(CC) $(LDFLAGS) -o $@ $< $(LDLIBS) -Wl,--build-id
 
 $(OUTPUT)/test_stub.o: test_stub.c
 	$(CC) -c $(CFLAGS) -o $@ $<
-- 
2.20.1

