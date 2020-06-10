Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66307C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478D2206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgFJOSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:18:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36342 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727913AbgFJOSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:18:01 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7821D2A478008854BE00;
        Wed, 10 Jun 2020 22:17:55 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 10 Jun 2020
 22:17:49 +0800
Subject: Re: [PATCH] sysctl: Delete the code of sys_sysctl
To:     Kees Cook <keescook@chromium.org>
CC:     <ebiederm@xmission.com>, <ak@linux.intel.com>,
        <alex.huangjianhui@huawei.com>, <linzichang@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <1591683605-8585-1-git-send-email-nixiaoming@huawei.com>
 <202006090839.6EDB4BA@keescook>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <21a9d711-af31-f7bd-1143-af2ca5b77ba9@huawei.com>
Date:   Wed, 10 Jun 2020 22:17:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <202006090839.6EDB4BA@keescook>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/9 23:40, Kees Cook wrote:
> On Tue, Jun 09, 2020 at 02:20:05PM +0800, Xiaoming Ni wrote:
>> Since the commit 61a47c1ad3a4dc ("sysctl: Remove the sysctl system call"),
>> sys_sysctl has lost its actual role: any input can only return an error.
>>
>> Delete the code and return -ENOSYS directly at the function entry
>>
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> 
> Looks right to me.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Should this be taken a step further and just remove the syscall entirely
> and update the per-arch tables with the ENOSYS hole?
> 
> -Kees
> 
Searching for git log, I found a commit record that deleted syscall:
commit f5b94099739722 ("All Arch: remove linkage for sys_nfsservctl 
system call"). Could I use sys_ni_syscall to implement the hole as in 
the example here?
E.g:
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 7b3832d..f36fda6 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -162,7 +162,7 @@
  146    common  writev                  sys_writev
  147    common  getsid                  sys_getsid
  148    common  fdatasync               sys_fdatasync
-149        common  _sysctl                 sys_sysctl
+149  common  _sysctl                 sys_ni_syscall
  150    common  mlock                   sys_mlock
  151    common  munlock                 sys_munlock
  152    common  mlockall                sys_mlockall
diff --git a/arch/arm64/include/asm/unistd32.h 
b/arch/arm64/include/asm/unistd32.h
index f8dafe9..ca41bb7 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -308,8 +308,8 @@
  __SYSCALL(__NR_getsid, sys_getsid)
  #define __NR_fdatasync 148
  __SYSCALL(__NR_fdatasync, sys_fdatasync)
-#define __NR__sysctl 149
-__SYSCALL(__NR__sysctl, compat_sys_sysctl)
+                 /* 149 was sys_sysctl */
+__SYSCALL(149, sys_ni_syscall)
  #define __NR_mlock 150
  __SYSCALL(__NR_mlock, sys_mlock)
  #define __NR_munlock 151


In this case, I need to modify a lot of code in v2. Can I add 
"Reviewed-by: Kees Cook <keescook@chromium.org>" to the v2 patch?

Thanks
Xiaoming Ni

