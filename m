Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A563C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3CB2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gDKmgaxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgF3Sta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbgF3St1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:49:27 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1EFC03E97B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:49:27 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id m7so15791542pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LEHppYXCQPcRgd0zlbLe7CmHbNbqX0AwBnt1nKT8kmo=;
        b=gDKmgaxn/Cl6wcc1lPhuw4d+qqZAEQfqpIWDlxkB2OP7eOtiDx3WCaV9AFMCtBGcEW
         6y4r4V13gqh1xMTARtmFL7ye+2ccgbPwchESgvOexvYAy6hhtgrGLCKG6QC3Vkrev2y+
         IcxsPM4HEFx4vUl3Trmszcq2jN0HtzaH7vyAMM+/hVR7gCA6JLkndlLF4fRw/mi2fYa/
         rqJwYliZI3TiCxV3OBUl6aFdha/b4dwy17RorxyAwRczDrSXGLV+oykGuVWj1ZNTPbvv
         I1GjO7O7ckRnbMSSppCivAiy/2XvKnfWVijFknFlTXq65JbU2aUhnsfHnxvk6sQUTHLf
         fWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LEHppYXCQPcRgd0zlbLe7CmHbNbqX0AwBnt1nKT8kmo=;
        b=m31xZ18NJgEvT3/yAa5fU4uvFNPDxfjDwvbeXjk9522dgAw4UbwAkXqDKw2Mpinamm
         MejTPkNv3r7XPlApU36nKMJS9IDq9seWj6hpw9f7mu483nxINjU6hpxXoDQihz1ZXMEZ
         Ru8fbXvzMmD7Vg4UJ1QlgF476ZqtGXyTpdTm4x7TVTZjkrAGjrfsk+IJG9GMViqf/PZp
         umZqYnZZJowzwI/uxCz67r5rowovAmFhwvGyUOACtu1v7j9Ijqc68krv04relPe0reSw
         rt/Ku+btR0oHFhiCbpHlHeyceBKeviyhZjel4l5+TPoeMI+nNbupu788zwXgg9bcaTxd
         wcoQ==
X-Gm-Message-State: AOAM533jRgUMOeR70/uXjQ79XmIIcAXTtRU3DZLgWOcboKhlMyrXMBcc
        SNVl1j/U4s9PEIB2CXnDSsQPDmqUBbA=
X-Google-Smtp-Source: ABdhPJwRys7ufIj6Wc7BHqYbfXPqG7SI1+88BKjiZMcxuVaaHmLS3yYhRz/blmSR7Scygm3uV5jRzePkDzQ=
X-Received: by 2002:ad4:4105:: with SMTP id i5mr11143826qvp.170.1593542965986;
 Tue, 30 Jun 2020 11:49:25 -0700 (PDT)
Date:   Tue, 30 Jun 2020 11:49:22 -0700
Message-Id: <20200630184922.455439-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH bpf-next] selftests/bpf: Switch test_vmlinux to use hrtimer_range_start_ns.
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kselftest@vger.kernel.org
Cc:     sdf@google.com, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test_vmlinux test uses hrtimer_nanosleep as hook to test tracing
programs. But it seems Clang may have done an aggressive optimization,
causing fentry and kprobe to not hook on this function properly on a
Clang build kernel.

A possible fix is switching to use a more reliable function, e.g. the
ones exported to kernel modules such as hrtimer_range_start_ns. After
we switch to using hrtimer_range_start_ns, the test passes again even
on a clang build kernel.

Tested:
 In a clang build kernel, the test fail even when the flags
 {fentry, kprobe}_called are set unconditionally in handle__kprobe()
 and handle__fentry(), which implies the programs do not hook on
 hrtimer_nanosleep() properly. This could be because clang's code
 transformation is too aggressive.

 test_vmlinux:PASS:skel_open 0 nsec
 test_vmlinux:PASS:skel_attach 0 nsec
 test_vmlinux:PASS:tp 0 nsec
 test_vmlinux:PASS:raw_tp 0 nsec
 test_vmlinux:PASS:tp_btf 0 nsec
 test_vmlinux:FAIL:kprobe not called
 test_vmlinux:FAIL:fentry not called

 After we switch to hrtimer_range_start_ns, the test passes.

 test_vmlinux:PASS:skel_open 0 nsec
 test_vmlinux:PASS:skel_attach 0 nsec
 test_vmlinux:PASS:tp 0 nsec
 test_vmlinux:PASS:raw_tp 0 nsec
 test_vmlinux:PASS:tp_btf 0 nsec
 test_vmlinux:PASS:kprobe 0 nsec
 test_vmlinux:PASS:fentry 0 nsec

Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/testing/selftests/bpf/progs/test_vmlinux.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_vmlinux.c b/tools/testing/selftests/bpf/progs/test_vmlinux.c
index 5611b564d3b1..29fa09d6a6c6 100644
--- a/tools/testing/selftests/bpf/progs/test_vmlinux.c
+++ b/tools/testing/selftests/bpf/progs/test_vmlinux.c
@@ -63,20 +63,20 @@ int BPF_PROG(handle__tp_btf, struct pt_regs *regs, long id)
 	return 0;
 }
 
-SEC("kprobe/hrtimer_nanosleep")
-int BPF_KPROBE(handle__kprobe,
-	       ktime_t rqtp, enum hrtimer_mode mode, clockid_t clockid)
+SEC("kprobe/hrtimer_start_range_ns")
+int BPF_KPROBE(handle__kprobe, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
+	       const enum hrtimer_mode mode)
 {
-	if (rqtp == MY_TV_NSEC)
+	if (tim == MY_TV_NSEC)
 		kprobe_called = true;
 	return 0;
 }
 
-SEC("fentry/hrtimer_nanosleep")
-int BPF_PROG(handle__fentry,
-	     ktime_t rqtp, enum hrtimer_mode mode, clockid_t clockid)
+SEC("fentry/hrtimer_start_range_ns")
+int BPF_PROG(handle__fentry, struct hrtimer *timer, ktime_t tim, u64 delta_ns,
+	     const enum hrtimer_mode mode)
 {
-	if (rqtp == MY_TV_NSEC)
+	if (tim == MY_TV_NSEC)
 		fentry_called = true;
 	return 0;
 }
-- 
2.27.0.212.ge8ba1cc988-goog

