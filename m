Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81520C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 683192068E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgHaMsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:48:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53512 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbgHaMsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:48:18 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B55BBE54C02C1B2B22FA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 20:48:14 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.16) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 31 Aug 2020
 20:48:06 +0800
To:     <yury.norov@gmail.com>
CC:     <bobo.shaobowang@huawei.com>, <wangxiongfeng2@huawei.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: [Question] About SECCOMP issue for ILP32
Message-ID: <30b491ad-a7e1-f7b5-26b8-2cfffc81a080@huawei.com>
Date:   Mon, 31 Aug 2020 20:48:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

We were testing the ILP32 feature and came accross a problem. Very apperaciate
it if you could give us some help !

We compile the LTP testsuite with '-mabi=ilp32' and run it on a machine with
kernel and glibc applied with ILP32 patches. But we failed on one testcase,
prctl04. It print the following error info.
'prctl04.c:199: FAIL: SECCOMP_MODE_STRICT doesn't permit read(2) write(2) and
_exit(2)'

The testcase is like below, syscall 'prctl' followed by a syscall 'write'.
prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT);
SAFE_WRITE(1, fd, "a", 1);

When we execute syscall 'write', we receive a SIGKILL. It's not as expected.
We track the kernel and found out it is because we failed the syscall_whitelist
check in '__secure_computing_strict'. Because flag 'TIF_32BIT_AARCH64' is set,
we falls into the 'in_compat_syscall()' branch. We compare the parameter
'this_syscall' with return value of 'get_compat_model_syscalls()'
The syscall number of '__NR_write' for ilp32 application is 64, but it is 4 for
'model_syscalls_32' returned from 'get_compat_model_syscalls()'
So '__secure_computing_strict' retuned with 'do_exit(SIGKILL)'. We have a
modification like below, but I am not sure if it correct or not.

--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -618,7 +618,7 @@ static void __secure_computing_strict(int this_syscall)
 {
        const int *syscall_whitelist = mode1_syscalls;
 #ifdef CONFIG_COMPAT
-       if (in_compat_syscall())
+       if (is_a32_compat_task())
                syscall_whitelist = get_compat_mode1_syscalls();
 #endif
        do {


Thanks,
Xiongfeng

