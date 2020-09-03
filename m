Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C6EC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB29820716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jg0PYIL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgICWdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgICWdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 18:33:36 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F1BC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 15:33:36 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 139so2474744qkl.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=fTZ15syT0j93m0JsqPQnX1nkgQUuupGOrvog1ui3uCg=;
        b=jg0PYIL8/uxMLhBlBcANr9ZodHPKPSPhUdh/T7gtdwPYtHZdEBIqw++C06tS8hxt7K
         FQyODpWmDbyei1fD7rLkUD5zFFclZ0s8B9BFtTRjSVxAaF6DQovV4Tjag5YScRBg3rkr
         pz/qPj2xm0HVcn8B8Iug60bEEaZkRnD6g3sQRlc+Vo+zmID1DkdotqvR8FtOUdizKqvc
         3AZBfgYuZCtK8DfaBtPFmUcNC8RoC5gAUxZe6ZBg+vFjnvwS/sFbWMb0dJQr1LxwBeMy
         bMDihACraTfSF8FFU0JmiMN/uuQRlyc1F25wtC9BTlvZuCn4DvWUsLnVZIYwezb9zoHh
         BGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=fTZ15syT0j93m0JsqPQnX1nkgQUuupGOrvog1ui3uCg=;
        b=GUSvR7kburJrpuCFQBFqvLsYc2zOrKBQmlPFkiN4PmWubSftTwZlSUiVWrLov3eQMT
         yjPfIwFq8aiR42jVO0q4E4qqr/D1HFkaVg3gWa+vWxsyRLrcFFGXVr8As9VhilxZfUAK
         VINRkoV8x0+B+NjeKIr+CX3SmRNon261t58DYl6MLA8b2tvwxNJevd3jx2d2IdlnQZqq
         g5nZoTJltiJ8Tx8T6EFFsyX5oNIwlpdwBNFjd0JSFhZP8B2Occv1ZOJANcKUbd7KZArp
         XCADse8oNZiregUC+qqTgLR0UgrDvZCPGNfHqBMnCB9CfSqycEf2UPjNC2T5XvvTaCgC
         t6Qw==
X-Gm-Message-State: AOAM5307hl7QzHBJFK0P30VubiLlck8ozpUeQrrawBHC2a4OC6+bBKxG
        NlvwVi/dPaA8Mo8C+FizYmAp+tZM5NQ=
X-Google-Smtp-Source: ABdhPJwfdmRl7fQrs6iAGmzxMo4s6aY3ueBPiwa8QHmB+91ldNEpNzmWD5pOtS17ypkemV/n1Ula7lNNngU=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:a0c:f48e:: with SMTP id i14mr4176950qvm.9.1599172415472;
 Thu, 03 Sep 2020 15:33:35 -0700 (PDT)
Date:   Thu,  3 Sep 2020 15:33:26 -0700
Message-Id: <20200903223332.881541-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH bpf-next v2 0/6] bpf: BTF support for ksyms
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Andrey Ignatov <rdna@fb.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
 - Move check_pseudo_btf_id from check_ld_imm() to
   replace_map_fd_with_map_ptr() and rename the latter.
 - Add bpf_this_cpu_ptr().
 - Use bpf_core_types_are_compat() in libbpf.c for checking type
   compatibility.
 - Rewrite typed ksym extern type in BTF with int to save space.
 - Minor revision of bpf_per_cpu_ptr()'s comments.
 - Avoid using long in tests that use skeleton.
 - Refactored test_ksyms.c by moving kallsyms_find() to trace_helpers.c
 - Fold the patches that sync include/linux/uapi and
   tools/include/linux/uapi.

rfc -> v1:
 - Encode VAR's btf_id for PSEUDO_BTF_ID.
 - More checks in verifier. Checking the btf_id passed as
   PSEUDO_BTF_ID is valid VAR, its name and type.
 - Checks in libbpf on type compatibility of ksyms.
 - Add bpf_per_cpu_ptr() to access kernel percpu vars. Introduced
   new ARG and RET types for this helper.

This patch series extends the previously added __ksym externs with
btf support.

Right now the __ksym externs are treated as pure 64-bit scalar value.
Libbpf replaces ld_imm64 insn of __ksym by its kernel address at load
time. This patch series extend those externs with their btf info. Note
that btf support for __ksym must come with the kernel btf that has
VARs encoded to work properly. The corresponding chagnes in pahole
is available at [1] (with a fix at [2] for gcc 4.9+).

The first 3 patches in this series add support for general kernel
global variables, which include verifier checking (01/06), libpf
support (02/06) and selftests for getting typed ksym extern's kernel
address (03/06).

The next 3 patches extends that capability further by introducing
helpers bpf_per_cpu_ptr() and bpf_this_cpu_ptr(), which allows accessing
kernel percpu variables correctly (04/06 and 05/06).

The tests of this feature were performed against pahole that is extended
with [1] and [2]. For kernel BTF that does not have VARs encoded, the
selftests will be skipped.

[1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=f3d9054ba8ff1df0fc44e507e3a01c0964cabd42
[2] https://www.spinics.net/lists/dwarves/msg00451.html

Hao Luo (6):
  bpf: Introduce pseudo_btf_id
  bpf/libbpf: BTF support for typed ksyms
  bpf/selftests: ksyms_btf to test typed ksyms
  bpf: Introduce bpf_per_cpu_ptr()
  bpf: Introduce bpf_this_cpu_ptr()
  bpf/selftests: Test for bpf_per_cpu_ptr() and bpf_this_cpu_ptr()

 include/linux/bpf.h                           |   4 +
 include/linux/bpf_verifier.h                  |   4 +
 include/linux/btf.h                           |  26 +++
 include/uapi/linux/bpf.h                      |  69 ++++++-
 kernel/bpf/btf.c                              |  25 ---
 kernel/bpf/verifier.c                         | 176 +++++++++++++++++-
 kernel/trace/bpf_trace.c                      |  32 ++++
 tools/include/uapi/linux/bpf.h                |  69 ++++++-
 tools/lib/bpf/libbpf.c                        | 116 ++++++++++--
 .../testing/selftests/bpf/prog_tests/ksyms.c  |  31 +--
 .../selftests/bpf/prog_tests/ksyms_btf.c      |  73 ++++++++
 .../selftests/bpf/progs/test_ksyms_btf.c      |  49 +++++
 tools/testing/selftests/bpf/trace_helpers.c   |  26 +++
 tools/testing/selftests/bpf/trace_helpers.h   |   4 +
 14 files changed, 615 insertions(+), 89 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf.c

-- 
2.28.0.526.ge36021eeef-goog

