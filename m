Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35FFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0EB420708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgETHus convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:50:48 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:37109 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726403AbgETHur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:50:47 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.03739544|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.00791156-0.00127422-0.990814;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07447;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.Hb479ug_1589961042;
Received: from 192.168.43.81(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Hb479ug_1589961042)
          by smtp.aliyun-inc.com(10.147.44.145);
          Wed, 20 May 2020 15:50:43 +0800
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] csky: Fixup calltrace panic
From:   Guo Ren <ren_guo@c-sky.com>
In-Reply-To: <20200517175220.GA48379@roeck-us.net>
Date:   Wed, 20 May 2020 15:50:42 +0800
Cc:     Guo Ren <guoren@linux.alibaba.com>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D93AFA5B-3BF1-4E11-B278-22E980C3EE36@c-sky.com>
References: <20200517175220.GA48379@roeck-us.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        =?gb2312?B?9sTPye21?= <xianmiao_qu@c-sky.com>,
        =?gb2312?B?ydDUxrqj?= <yunhai_shang@c-sky.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

> 在 2020年5月18日，上午1:52，Guenter Roeck <linux@roeck-us.net> 写道：
> 
> Hi,
> 
> On Wed, May 13, 2020 at 03:15:25PM +0800, Guo Ren wrote:
>> The implementation of show_stack will panic with wrong fp:
>> 
>> addr    = *fp++;
>> 
>> because the fp isn't checked properly.
>> 
>> The current implementations of show_stack, wchan and stack_trace
>> haven't been designed properly, so just deprecate them.
>> 
>> This patch is a reference to riscv's way, all codes are modified from
>> arm's. The patch is passed with:
>> 
>> - cat /proc/<pid>/stack
>> - cat /proc/<pid>/wchan
>> - echo c > /proc/sysrq-trigger
>> 
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> 
> This patch results in:
> 
> gcc version: csky-linux-gcc (GCC) 9.3.0
> 
> Building csky:defconfig ... failed
> --------------
> Error log:
> csky-linux-gcc: error: unrecognized command line option '-mbacktrace'; did you mean '-fbacktrace'?
> csky-linux-gcc: error: unrecognized command line option '-mbacktrace'; did you mean '-fbacktrace'?
> make[2]: *** [scripts/mod/devicetable-offsets.s] Error 1
> make[2]: *** Waiting for unfinished jobs....
> csky-linux-gcc: error: unrecognized command line option '-mbacktrace'; did you mean '-fbacktrace'?
> make[2]: *** [scripts/mod/empty.o] Error 1
> make[1]: *** [prepare0] Error 2
> make: *** [sub-make] Error 2
> 
> when trying to build csky images with upstream gcc 9.3.0.
> 
> What version of gcc is needed to build csky images ? Also, would it be
> possible to support the upstream version of gcc ?
> 

We tested it with https://github.com/c-sky/gcc (gcc-6.3)

You can fast test with:


 wget -nc https://gitlab.com/c-sky/buildroot/-/jobs/557072746/artifacts/raw/output/images/toolchain_thead_860_compat_next_glibc_br_defconfig_8f1b5cd7d85509fbafea935ec65c48add73bba07.tar.xz

 mkdir -p host
 tar -Jxf toolchain_thead_860_compat_next_glibc_br_defconfig_8f1b5cd7d85509fbafea935ec65c48add73bba07.tar.xz -C host

 cd linux-xxx

 LD_LIBRARY_PATH=../host/lib make ARCH=csky CROSS_COMPILE=../host/bin/csky-linux- Image


We will upstream -mbacktrace to gcc.org

> Thanks,
> Guenter

