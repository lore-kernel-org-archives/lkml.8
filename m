Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9DCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C4520663
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eeWUgxRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgGFSbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbgGFSbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:31:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213BAC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 11:31:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e4so46688597ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 11:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=p5Lmi+n2aCPuO3HRqROvjZ77CiNJumYrCfcDWyCoeRo=;
        b=eeWUgxRo45PzzLMOYfNqM0fJG3eM7NhB0LGTmtY80A7HRBb96PXbpmm2eQ7cWidh/B
         TuMBksb61mp7mBvwy6xMYVeWjgnZW0XCH3OQxXUoDvh5pjiVoak0SmUzC4Ppmwnt1EOX
         djbiIXAdo7K0uMgMf7QT6ZkuKLl3EXY2WqHvR/g0lFwC5fwnIogO2p7f2mjjkzSodbAv
         opbO1ipwB03vwqWkP+GjYO2dKy/mRRGzSLTUiOJ9IalzRfYDGdYf9UmMpOWUoP09XcT8
         o9QAISDvnbmvuYYDSu5sgEJUCpkrVcpBwXTU3yfABGF2AAv4F67VsZBkA1w9RLpfAXqv
         Sprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=p5Lmi+n2aCPuO3HRqROvjZ77CiNJumYrCfcDWyCoeRo=;
        b=gXfcdbyeeUyt2lGIbir+OvQfWOYokqELLWiVw1jLpnVbceLqc7k0F76lFpZoAGMqBB
         kO0OxzhE4AKJLzcegdWG+G1hpkSy3o0rZci6TvhA8TNKhNRCvvhJCtFhHn6zwRybwCJe
         twjTvfratJrffAdb4lsPhtvqB15TNJsR/uySkImlQ6kNT0Rw2Ojf6eQZlmJ+2GsueB5M
         gzpNLg6NzUVO/8amEYtXreqQZDPGy7MUFiWpTPuZup5bAk0ihFZ+fLZkPNyCm9qxTZNC
         uip3rl3XlfHsWoCVQp095r11jd3hvaai0R7kyAVJhc8Jh9050QRtQ1fe4/hrXUVs8dBa
         LRVA==
X-Gm-Message-State: AOAM531lt0B81vhRiV78905Ff+n0u2J19XboObUg8NY75M11lduElhpx
        SxGoFkh6PfvSFuK596Q9T3jIeNfFFjqS6sObUnioMg==
X-Google-Smtp-Source: ABdhPJwS18nLQq/ktvdWl0S9gHYIEpELe1rh6z+qD6ClkdZU5mPQNRNLXiDBb3yDb/T6RZ6tXPh/BrUG0n7zFuAuJJ8=
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr27484571ljj.102.1594060277199;
 Mon, 06 Jul 2020 11:31:17 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Jul 2020 00:01:05 +0530
Message-ID: <CA+G9fYuiK95tkP1e2VogtbzGex4qJdpfCZ6bfM5S5sA_o+iRQw@mail.gmail.com>
Subject: clone302.c:88: FAIL: invalid parenttid: clone3() should fail with
 EFAULT: EINVAL (22)
To:     LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Cyril Hrubis <chrubis@suse.cz>,
        Jan Stancek <jstancek@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTP clone302 test case failed on linux next 20200706 tag.
This is a regression on arm64, arm, x86_64, and i386.

The expected error code is EFAULT but got EINVAL.
This is already addressed here in this email thread by Christian Brauner
https://lore.kernel.org/linux-m68k/20200627122332.ki2otaiw3v7wndbl@wittgenstein/T/#u


Test output log.
clone302.c:92: PASS: invalid args: clone3() failed as expected: EFAULT (14)
clone302.c:92: PASS: zero size: clone3() failed as expected: EINVAL (22)
clone302.c:92: PASS: short size: clone3() failed as expected: EINVAL (22)
clone302.c:92: PASS: extra size: clone3() failed as expected: EFAULT (14)
clone302.c:92: PASS: sighand-no-VM: clone3() failed as expected: EINVAL (22)
clone302.c:92: PASS: thread-no-sighand: clone3() failed as expected: EINVAL (22)
clone302.c:92: PASS: fs-newns: clone3() failed as expected: EINVAL (22)
clone302.c:92: PASS: invalid pidfd: clone3() failed as expected: EFAULT (14)
clone302.c:92: PASS: invalid childtid: clone3() failed as expected: EFAULT (14)
clone302.c:88: FAIL: invalid parenttid: clone3() should fail with
EFAULT: EINVAL (22)
clone302.c:92: PASS: invalid signal: clone3() failed as expected: EINVAL (22)
clone302.c:92: PASS: zero-stack-size: clone3() failed as expected: EINVAL (22)
clone302.c:92: PASS: invalid-stack: clone3() failed as expected: EINVAL (22)

strace output:
[pid   519] getpid()                    = 519
[pid   519] wait4(-1, 0x7fff504b02ec, 0, NULL) = -1 ECHILD (No child processes)
[pid   519] syscall_435(0x7fcc0478bfc0, 0x40, 0x7fcc04278031, 0,
0x7fff504afb26, 0x360) = -1 (errno 22)
[pid   519] write(2, "clone302.c:88: FAIL: "..., 97clone302.c:88:
FAIL: invalid parenttid: clone3() should fail with EFAULT: EINVAL (22)

Test code:
{"invalid parenttid", &valid_args, sizeof(*valid_args),
CLONE_PARENT_SETTID | CLONE_CHILD_SETTID | CLONE_PIDFD, NULL, NULL,
&invalid_address, SIGCHLD, 0, 0, 0, EFAULT},

Test case link,
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/clone3/clone302.c#L41

ref:
https://lkft.validation.linaro.org/scheduler/job/1542127#L3243
https://lkft.validation.linaro.org/scheduler/job/1542828#L1412

--
Linaro LKFT
https://lkft.linaro.org
