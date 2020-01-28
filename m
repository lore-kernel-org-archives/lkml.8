Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6379C33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8052467C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 02:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rnj6yTlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgA1COw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 21:14:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38580 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgA1COu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 21:14:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so6148275pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 18:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to:in-reply-to:references;
        bh=B26eSG9gMaHSxZUV5pLyS5i7Lt3Ya0fKdNJyMPYapJg=;
        b=rnj6yTltwKWYN3+9NJAw5sCB/fR2AAcye4lYI+VlXhtsAeDA2BY21GJ8k8CnQf7aQY
         VdJ1qPrTM3EARaQkNVyPlmwk3OR0FZ1qhmjPYmqj747Fi6+MIUvvEt3r/xG932neiZRZ
         G3MOKgdSY//mdAPafDURRAFv84ghi6Xg6+OIs6B82gN1iNzgi4TCJIbiKMAjvWHnWsI8
         LfD/uSlWuMSGAOZ40hPJMvwD5XkCAeqbt+356MQtEucaALw0rbVlR+5ifj9W6OqwPggu
         K+WgKDD0Sf0RDg9+u3AIFA8wMp9WAsRV6SFb5qwxtu0Spb25cBn4ycpFAc+FS2vQBAxJ
         dq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to:in-reply-to:references;
        bh=B26eSG9gMaHSxZUV5pLyS5i7Lt3Ya0fKdNJyMPYapJg=;
        b=i3r9J1ehubZ/a131ZBhbdC8Pyqny6dya0qxARn06gxUsL/29nCeTZbO9mw51+YxDyM
         eCHR46NI7cEEsOwxRwp0KFT1L+P25N1cuKutjNnJ+1vAJt9DCfVzwAI/ASSHvrxMlIse
         khHLcWPsUPpVFb9OlF/Q8tSwAn/CZAGaAyVgCKFnR3FGqJ5hJQuZbCA9yL1XvdHdahsu
         7bQw7d3cUaxlyIkMBs3dbDDnd3iGorZjwH0t7fAk+Dqijmgpz0B0DmJOznD5u2AHBqio
         LIqqpVSwPQSkgt3EyRoZZr7i9Nep8VHYvTAjliOJqPRhI/R8Y5K15Pxv46M6kvGEJD/t
         TVDQ==
X-Gm-Message-State: APjAAAUuloSV85aj15X5s7A9za1apfxDKRReiVvUxs5EAK+0eE3Mu7wJ
        sLqdw5yKqlFAN5D2DxD+LuieLg==
X-Google-Smtp-Source: APXvYqxWbxJsMQEFqUcP7zhlWCZa48n0RUY+fa4pHyARk3jQS+HZxuwfqCKurzNjpNa6tqaE0J+XAw==
X-Received: by 2002:a62:2b8a:: with SMTP id r132mr1588482pfr.56.1580177689517;
        Mon, 27 Jan 2020 18:14:49 -0800 (PST)
Received: from localhost ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id x21sm10370389pfq.76.2020.01.27.18.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 18:14:48 -0800 (PST)
Subject: [PATCH 1/4] selftests/bpf: Elide a check for LLVM versions that can't compile it
Date:   Mon, 27 Jan 2020 18:11:42 -0800
Message-Id: <20200128021145.36774-2-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     daniel@iogearbox.net, ast@kernel.org, zlim.lnx@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        shuah@kernel.org, Palmer Dabbelt <palmerdabbelt@google.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, kernel-team@android.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Bjorn Topel <bjorn.topel@gmail.com>
In-Reply-To: <20200128021145.36774-1-palmerdabbelt@google.com>
References: <20200128021145.36774-1-palmerdabbelt@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current stable LLVM BPF backend fails to compile the BPF selftests
due to a compiler bug.  The bug has been fixed in trunk, but that fix
hasn't landed in the binary packages I'm using yet (Fedora arm64).
Without this workaround the tests don't compile for me.

This patch triggers a preprocessor warning on LLVM versions that
definitely have the bug.  The test may be conservative (ie, I'm not sure
if 9.1 will have the fix), but it should at least make the current set
of stable releases work together.

See https://reviews.llvm.org/D69438 for more information on the fix.  I
obtained the workaround from
https://lore.kernel.org/linux-kselftest/aed8eda7-df20-069b-ea14-f06628984566@gmail.com/T/

Fixes: 20a9ad2e7136 ("selftests/bpf: add CO-RE relocs array tests")
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 .../testing/selftests/bpf/progs/test_core_reloc_arrays.c  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c b/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
index bf67f0fdf743..c9a3e0585a84 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
@@ -40,15 +40,23 @@ int test_core_arrays(void *ctx)
 	/* in->a[2] */
 	if (BPF_CORE_READ(&out->a2, &in->a[2]))
 		return 1;
+#if defined(__clang__) && (__clang_major__ < 10) && (__clang_minor__ < 1)
+# warning "clang 9.0 SEGVs on multidimensional arrays, see https://reviews.llvm.org/D69438"
+#else
 	/* in->b[1][2][3] */
 	if (BPF_CORE_READ(&out->b123, &in->b[1][2][3]))
 		return 1;
+#endif
 	/* in->c[1].c */
 	if (BPF_CORE_READ(&out->c1c, &in->c[1].c))
 		return 1;
+#if defined(__clang__) && (__clang_major__ < 10) && (__clang_minor__ < 1)
+# warning "clang 9.0 SEGVs on multidimensional arrays, see https://reviews.llvm.org/D69438"
+#else
 	/* in->d[0][0].d */
 	if (BPF_CORE_READ(&out->d00d, &in->d[0][0].d))
 		return 1;
+#endif
 
 	return 0;
 }
-- 
2.25.0.341.g760bfbb309-goog

