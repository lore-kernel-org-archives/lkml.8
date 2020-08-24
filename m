Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B580C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7D6207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHXLyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:54:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55548 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726075AbgHXLyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:54:21 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6905211FDBEEEEE5F66E;
        Mon, 24 Aug 2020 19:54:16 +0800 (CST)
Received: from DESKTOP-8N3QUD5.china.huawei.com (10.67.102.173) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 24 Aug 2020 19:54:09 +0800
From:   Guohua Zhong <zhongguohua1@huawei.com>
To:     <segher@kernel.crashing.org>
CC:     <christophe.leroy@csgroup.eu>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <nixiaoming@huawei.com>, <paulus@samba.org>,
        <stable@vger.kernel.org>, <wangle6@huawei.com>,
        <zhongguohua1@huawei.com>
Subject: =?UTF-8?q?Re=3A=20Re=EF=BC=9ARe=3A=20=5BPATCH=5D=20powerpc=3A=20Fix=20a=20bug=20in=20=5F=5Fdiv64=5F32=20if=20divisor=20is=20zero?=
Date:   Mon, 24 Aug 2020 19:54:07 +0800
Message-ID: <20200824115407.55896-1-zhongguohua1@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200823001101.GO28786@gate.crashing.org>
References: <20200823001101.GO28786@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.173]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Yet, I have noticed that there is no checking of 'base' in these functions.
>> But I am not sure how to check is better.As we know that the result is 
>> undefined when divisor is zero. It maybe good to print error and dump stack.
>>  Let the process to know that the divisor is zero by sending SIGFPE. 

> That is now what the PowerPC integer divide insns do: they just leave
> the result undefined (and they can set the overflow flag then, but no
> one uses that).

OK ,So just keep the patch as below. If this patch looks good for you, please
help to review. I will send the new patch later.

Thanks for your reply.

diff --git a/arch/powerpc/boot/div64.S b/arch/powerpc/boot/div64.S
index 4354928ed62e..1d3561cf16fa 100644
--- a/arch/powerpc/boot/div64.S
+++ b/arch/powerpc/boot/div64.S
@@ -13,8 +13,10 @@

        .globl __div64_32
        .globl __div64_32
 __div64_32:
+ cmplwi      r4,0    # check if divisor r4 is zero
        lwz     r5,0(r3)        # get the dividend into r5/r6
        lwz     r6,4(r3)
+ beq 5f                      # jump to label 5 if r4(divisor) is zero
        cmplw   r5,r4
        li      r7,0
        li      r8,0
@@ -52,7 +54,7 @@ __div64_32:
 4:     stw     r7,0(r3)        # return the quotient in *r3
        stw     r8,4(r3)
        mr      r3,r6           # return the remainder in r3
-   blr
+5:   blr                             # return if divisor r4 is zero

 /*
  * Extended precision shifts.
diff --git a/arch/powerpc/lib/div64.S b/arch/powerpc/lib/div64.S
index 3d5426e7dcc4..570774d9782d 100644
--- a/arch/powerpc/lib/div64.S
+++ b/arch/powerpc/lib/div64.S
@@ -13,8 +13,10 @@
 #include <asm/processor.h>

 _GLOBAL(__div64_32)
+ cmplwi      r4,0    # check if divisor r4 is zero
        lwz     r5,0(r3)        # get the dividend into r5/r6
        lwz     r6,4(r3)
+ beq 5f                      # jump to label 5 if r4(divisor) is zero
        cmplw   r5,r4
        li      r7,0
        li      r8,0
@@ -52,4 +54,4 @@ _GLOBAL(__div64_32)
 4:     stw     r7,0(r3)        # return the quotient in *r3
        stw     r8,4(r3)
        mr      r3,r6           # return the remainder in r3
-   blr
+5:   blr                             # return if divisor r4 is zero

Guohua

