Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE9CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E4D2072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oCplm4YJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgG3Srj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:47:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40162 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgG3Srg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:47:36 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06UIkqiD047674;
        Thu, 30 Jul 2020 13:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596134812;
        bh=H97hSMtUi6Ldll477vreOznYuaxJYnCs6xCyk6sD7Yw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oCplm4YJYcRRf5fEC+1+IK3OfieoZpU6D+38ioxFbhnhm9BULIugn4rNd1DvH4Biu
         WjdmPzzWIFsrN4Taq9Gp1+NBVd0cY2JcFlBkPggRyhseqp8GC5TNs2+8xAQ8goenr+
         s8qifO8vG3xlNkAjeEQA/Tjkixd4In9gZiJEJpEM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06UIkqHO056432;
        Thu, 30 Jul 2020 13:46:52 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Jul 2020 13:46:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Jul 2020 13:46:52 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06UIklXf119658;
        Thu, 30 Jul 2020 13:46:48 -0500
Subject: =?UTF-8?B?UmU6IGFybTY0OiBwb2ludGVyX2F1dGguaDo0MDozOiBlcnJvcjogaW1w?=
 =?UTF-8?Q?licit_declaration_of_function_=e2=80=98get=5frandom=5fbytes?=
 =?UTF-8?B?4oCZOyBkaWQgeW91IG1lYW4g4oCYZ2V0X3JhbmRvbV9vbmNl4oCZPw==?=
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        <richard.henderson@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <re.emese@gmail.com>, <hsinyi@chromium.org>,
        Will Deacon <will@kernel.org>, <w@1wt.eu>,
        <linux-arm-kernel@lists.infradead.org>
References: <CA+G9fYvSyXnfGmK1FLRtraWWre7QjUoGE_qiwM8XPUBXjnudWA@mail.gmail.com>
 <20200730211522.1ea3561f@canb.auug.org.au>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <d23eba90-ee2c-efe0-0cb6-88e99fb22e54@ti.com>
Date:   Thu, 30 Jul 2020 21:46:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200730211522.1ea3561f@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/07/2020 14:15, Stephen Rothwell wrote:
> Hi Naresh,
> 
> On Thu, 30 Jul 2020 16:25:49 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> Linus master branch failed to build the arm64 architecture due to
>> below error and warnings.
> 
> Thanks for the report.
> 
> Please see https://lore.kernel.org/lkml/202007292007.D87DBD34B@keescook/

I'd like to note that below set of patches:
1c9df907da83 random: fix circular include dependency on arm64 after addition of percpu.h
83bdc7275e62 random32: remove net_rand_state from the latent entropy gcc plugin
f227e3ec3b5c random32: update the net random state on interrupt and activity

also break ARM build for the case:
#if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)

config: keystone_defconfig

   CC      arch/arm/kernel/signal.o
In file included from ../include/linux/random.h:14,
                  from ../arch/arm/kernel/signal.c:8:
../arch/arm/include/asm/percpu.h: In function ‘__my_cpu_offset’:
../arch/arm/include/asm/percpu.h:29:34: error: ‘current_stack_pointer’ undeclared (first use in this function); did you mean ‘user_stack_pointer’?
    : "Q" (*(const unsigned long *)current_stack_pointer));
                                   ^~~~~~~~~~~~~~~~~~~~~
                                   user_stack_pointer
../arch/arm/include/asm/percpu.h:29:34: note: each undeclared identifier is reported only once for each function it appears in
../scripts/Makefile.build:280: recipe for target 'arch/arm/kernel/signal.o' failed
make[2]: *** [arch/arm/kernel/signal.o] Error 1
/home/grygorii/kernel.org/linux-master/linux/Makefile:1756: recipe for target 'arch/arm/kernel' failed
make[1]: *** [arch/arm/kernel] Error 2



-- 
Best regards,
grygorii
