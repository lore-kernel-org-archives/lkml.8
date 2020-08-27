Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0007C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7AB420737
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jz0jrysR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgH0RD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgH0RDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:03:55 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3FBC06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:03:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so3810864pgf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=VdlKRWAYiWH7aKzpIghVWZrmLNU8AEzG/Co4MAt2Y8A=;
        b=jz0jrysRrFtf/raS4GKGdoe89ArXeoPqY37vy/lf9q7hC1dPzYrXzA7FQg1GxNoSx9
         45sI9wAD+tgmlr+4TRjRy7KymBhpuGnQhdOezR7Iji0nDV4LHV6FZa9XYTwyqI7K5ywo
         wZW4a8krMN8wUAFvWxBTRuvn0QzrMmbFzyALo6zd9iPiVjYXO08aHo24023L8s2S2miN
         fSBNMgoX7M1YmR4ki4uaKST0hES5XubV5AUI379ZwuQSy+yn34/KVq80YDGHALdqwTC4
         D5bltMawbgbptzmTJG/fA7IDtDYZ5aBE5bZGX+w8WcIZl7cfNsgcjR3BVcPdMri/bQlR
         CI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=VdlKRWAYiWH7aKzpIghVWZrmLNU8AEzG/Co4MAt2Y8A=;
        b=e3hPh4xML7idtRr6JL9Vo31olEfwoNKL77aW0vYZKJ1Vg5lZ6yCJEQgO72qrsiGsVE
         ZaRALecCr7pvYj0TAaO9Ij+ms3w9qLLyYampJPOjSeqROGTLK1gSxLsuf8+BLHx2lOGS
         Zdyg0KAPAGxF+00CCTzWaWRiv6q3eSau7tF9x8TG1v5Xinmd3yowzC1oEwmAA6poZyLd
         +CgkGH4p6EHaVy+N9cOb6VPD+xxk2pzLbEvubaL3QHg64LjNM5orZtrCMZQUZRfWcE6F
         sWR8Uqc4RK5t+K6edPNx5ENWpsM/z0jTqNKk6NHjnAtuPl30ZhMyaH5DKqApgH8De1ZO
         4GVA==
X-Gm-Message-State: AOAM5337k3B72uCbJ587bR4H0RgEGjQPXeD1e28ycvOBbQL0OGw10XvU
        oAdum7s5E7Q24olJQHgbxJp6Ng==
X-Google-Smtp-Source: ABdhPJzh87b1e1c3qz49gLw9m5Qn9DxARjR19PlbS5t4MeaJtCJCaCf1OukqFVW6zxLubVLXUWN6HA==
X-Received: by 2002:a63:a53:: with SMTP id z19mr14876176pgk.67.1598547834087;
        Thu, 27 Aug 2020 10:03:54 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v10sm3402662pff.192.2020.08.27.10.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 10:03:53 -0700 (PDT)
Date:   Thu, 27 Aug 2020 10:03:53 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Aug 2020 10:03:52 PDT (-0700)
Subject:     Re: linux-next: Tree for Aug 27
In-Reply-To: <fa8a133517704eff9b0f2369c1b7b5bbc8517916.camel@wdc.com>
CC:     anders.roxell@linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        anup@brainfault.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-16126c08-fe1d-43bf-bd48-9f1cdcdb5a57@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 10:02:57 PDT (-0700), Atish Patra wrote:
> On Thu, 2020-08-27 at 10:37 +0200, Anders Roxell wrote:
>> On Thu, 27 Aug 2020 at 07:11, Stephen Rothwell <sfr@canb.auug.org.au>
>> wrote:
>> > Hi all,
>> > 
>> > News:  There will be no linux-next releases next Monday or Tuesday.
>> > 
>> > Changes since 20200826:
>> > 
>> > The net-next tree gained a conflict against the net tree.
>> > 
>> > Non-merge commits (relative to Linus' tree): 2901
>> >  3429 files changed, 100496 insertions(+), 37081 deletions(-)
>> > 
>> 
>> I built riscv on todays tag and I see this error:
>> ../arch/riscv/kernel/setup.c: In function ‘setup_arch’:
>> ../arch/riscv/kernel/setup.c:74:2: error: implicit declaration of
>> function ‘early_ioremap_setup’; did you mean ‘early_memtest’?
>> [-Werror=implicit-function-declaration]
>>   early_ioremap_setup();
>>   ^~~~~~~~~~~~~~~~~~~
>>   early_memtest
>> cc1: some warnings being treated as errors
>> 
>> I think its due to commit 3d109b0e0949 ("RISC-V: Add early ioremap
>> support")
>> 
> 
> Yes. For some reason, I never get this with the UEFI support series
> applied on top 5.9-rc2 in my tree. But I get this error with linux-next 
> tree.
> 
>> It builds with this fix:
>> 
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index 5ab185130cae..41ef96d0d97a 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/smp.h>
>> 
>>  #include <asm/cpu_ops.h>
>> +#include <asm/early_ioremap.h>
>>  #include <asm/setup.h>
>>  #include <asm/sections.h>
>>  #include <asm/sbi.h>
>> 
>> 
> 
> This fix solves the problem. Thanks.
> @palmer: Do you want me to update the patch and send v7 ?

That'd be great, thanks!

> 
> 
>> Cheers,
>> Anders
> 
> -- 
> Regards,
> Atish
