Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26989C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0F224683
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ds0PkzXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404570AbgAPRcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:32:21 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:38259 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404551AbgAPRcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:32:19 -0500
Received: by mail-lj1-f181.google.com with SMTP id w1so23613591ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 09:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZRs7Xp0qs3qSGzHPRqTIAxDUBByj6hXad2iqRxuy3uU=;
        b=Ds0PkzXYKwfH5VMIQ2HwynIM8jIAXa3kQWMalAJeoiV9OgHxutgG8PSQtMDBHYShy0
         lqkPu35misOXAyD5IPvFaKfZaws3OZmCwdCejEDoEeMdZU8ZuplgXfD3/ChnIgEUF0wq
         54Mf8TfzdyjhPdkQDZ5wQxXj79Gss85UmIyb65ogaRhcmVAJzf2C2QCCmbJ9eCAGkI2H
         lj/BkkgMqhxklh0dpDCMqAOjYrUNVVy5JtFqssgsVehwpSCO+hzJQRCwE7R3tjiP8e1X
         JW7KcFDwgM5dscKbR5eXgyumflHxLbPnE0x7uprXD7ZeUZtUfF/THRu3TbKfH/T0G4Kf
         w7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZRs7Xp0qs3qSGzHPRqTIAxDUBByj6hXad2iqRxuy3uU=;
        b=p0LxE+1XI7qBbPXjxsEe77zTxX/bGI9q+f+9hdLpoftvT3uzATAjf+VPgiirliXNiT
         da4Tvwh+bIVfDnDDDhSjJ1vwgbhE63riDqjYJhQ8F+Al4c1Zdb0Aew37wIoFjDCx4iqy
         +qJ1uBsUyzJJQv0CvRlS0FcY75ywweb1d35SucPITDsWFLPH1slPb2q5gCuvpRhXhGRf
         idcfDpYvrIR0utRNNDoHeVSVEdyGsUaWT8Ec3GdulvJogddx16SsegC20vx4LhsakoBz
         fE9TYwYVAFdqbqlR7R6daEc8YUJchJlf7dh3ZRa+B9GO9k1FUFWYKDzQyrzsiANEGK6Z
         2sMQ==
X-Gm-Message-State: APjAAAViKraE0c7cxy4zNdHxVF7JWb7ZEY4hGby/MCIRgSeeFEgSYk2+
        Hah2US87iObrhTL2qQUkjHxfibbJlljcKaoqTbc0+UvTuwU=
X-Google-Smtp-Source: APXvYqw22NAxskOmVG4g/0VbfThQV7pva1b0M4/v5OzJ6zLzfCSGpwdpRcbI9f3lbdNKyDsJ5uhJ3O9hLgJLDeEH3DI=
X-Received: by 2002:a2e:965a:: with SMTP id z26mr521409ljh.104.1579195937348;
 Thu, 16 Jan 2020 09:32:17 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Jan 2020 23:02:06 +0530
Message-ID: <CA+G9fYuBdcZvE6VPm9i2=F0mK5u3j6Z+RHbFBQ1zh9qbN_4kaw@mail.gmail.com>
Subject: LTP: statx06: FAIL: Birth time < before time
To:     LTP List <ltp@lists.linux.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Jan Stancek <jstancek@redhat.com>,
        chrubis <chrubis@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTP syscalls statx06 test case getting failed from linux next 20200115
tag onwards on all x86_64, i386, arm and arm64 devices

Test output:
statx06.c:152: FAIL: Birth time < before time
statx06.c:156: PASS: Modified time Passed
statx06.c:156: PASS: Access time Passed
statx06.c:156: PASS: Change time Passed

strace output snippet:
[pid   498] clock_getres(CLOCK_REALTIME_COARSE, {tv_sec=0, tv_nsec=1000000}) = 0
[pid   498] nanosleep({tv_sec=0, tv_nsec=1000000}, NULL) = 0
[pid   498] openat(AT_FDCWD, \"mount_ext/test_file.txt\",
O_RDWR|O_CREAT, 0666) = 3
[pid   498] clock_getres(CLOCK_REALTIME_COARSE, {tv_sec=0, tv_nsec=1000000}) = 0
[pid   498] nanosleep({tv_sec=0, tv_nsec=1000000}, NULL) = 0
[pid   498] statx(AT_FDCWD, \"mount_ext/test_file.txt\",
AT_STATX_SYNC_AS_STAT, STATX_ALL, {stx_mask=STATX_BASIC_STATS,
stx_attributes=0, stx_mode=S_IFREG|0644, stx_size=0, ...}) = 0
[pid   498] write(2, \"statx06.c:152: \33[1;31mFAIL: \33[0m\"...,
57statx06.c:152: [1;31mFAIL: [0mBirth time < before time
) = 57

Full test log link,
https://lkft.validation.linaro.org/scheduler/job/1107634#L2276

Test results comparison link,
https://qa-reports.linaro.org/lkft/linux-next-oe/tests/ltp-syscalls-tests/statx06

Test case link,
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/statx/statx06.c

--
Linaro LKFT
https://lkft.linaro.org
