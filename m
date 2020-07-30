Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E283C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563EA2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jMB6xbY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbgG3Toa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:44:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46936 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG3To3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:44:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06UJhnu1062283;
        Thu, 30 Jul 2020 14:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596138229;
        bh=z+5GPowId3gZU8tjl7B+lOU9DcG/hQmnbMLkZY6+rOk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jMB6xbY0hDtmKI75YlExWCbXxkOWbgQSNFV1RxjyXUsDPzj5BxYU1pUMomFkS70OM
         0jgfZ50d5LkpJuxlaF3qpFFX3ZiHNcyQPVJWwoh9Bl8v3d9PYkY0PemVslZuD7LJ8M
         dk8220LxvVazqmdlWbAUzGfX2tEWbhhSXH6UTPfk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06UJhn4x020159
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 14:43:49 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Jul 2020 14:43:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Jul 2020 14:43:49 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06UJhgKh042768;
        Thu, 30 Jul 2020 14:43:44 -0500
Subject: =?UTF-8?B?UmU6IGFybTY0OiBwb2ludGVyX2F1dGguaDo0MDozOiBlcnJvcjogaW1w?=
 =?UTF-8?Q?licit_declaration_of_function_=e2=80=98get=5frandom=5fbytes?=
 =?UTF-8?B?4oCZOyBkaWQgeW91IG1lYW4g4oCYZ2V0X3JhbmRvbV9vbmNl4oCZPw==?=
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>, Emese Revfy <re.emese@gmail.com>,
        <hsinyi@chromium.org>, Will Deacon <will@kernel.org>,
        Willy Tarreau <w@1wt.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <CA+G9fYvSyXnfGmK1FLRtraWWre7QjUoGE_qiwM8XPUBXjnudWA@mail.gmail.com>
 <20200730211522.1ea3561f@canb.auug.org.au>
 <d23eba90-ee2c-efe0-0cb6-88e99fb22e54@ti.com>
 <CAHk-=whn8OB-QbxpffK=Lhh6Mhj+Y2ALFZ1asCgtnQOnmQgWUw@mail.gmail.com>
 <7b0c0f44-f56d-5e71-cf86-dbdea190267a@ti.com>
 <CAHk-=whX7gPBn+jthX8bbfz9kU+0CbYwTxbASwPRCZ1bhVqrOw@mail.gmail.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <f6cd5c6a-8779-e17d-2827-cbf531c969e2@ti.com>
Date:   Thu, 30 Jul 2020 22:43:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whX7gPBn+jthX8bbfz9kU+0CbYwTxbASwPRCZ1bhVqrOw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/07/2020 22:40, Linus Torvalds wrote:
> On Thu, Jul 30, 2020 at 12:05 PM Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>>
>> FYI. Below diff seems fixes build:
> 
> Thanks, I'll do that instead, it looks like the right thing to do regardless.
> 
> Mind sending me a sign-off for it (and commit message would be lovely
> too, but I can make something up)? Yeah, it's just a one-liner, but
> let's do this right.

I've also boot-tested it on Keystone 2 platforms.

Best regards,
grygorii

---
 From fa1238a8e4b7c603fcc0fb5f6169c212035aef4f Mon Sep 17 00:00:00 2001
From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Thu, 30 Jul 2020 22:05:01 +0300
Subject: [PATCH] ARM: percpu.h: fix build error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix build error for the case:
  defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)

config: keystone_defconfig

CC      arch/arm/kernel/signal.o
In file included from ../include/linux/random.h:14,
                  from ../arch/arm/kernel/signal.c:8:
../arch/arm/include/asm/percpu.h: In function ‘__my_cpu_offset’:
../arch/arm/include/asm/percpu.h:29:34: error: ‘current_stack_pointer’ undeclared (first use in this function); did you mean ‘user_stack_pointer’?
    : "Q" (*(const unsigned long *)current_stack_pointer));
                                   ^~~~~~~~~~~~~~~~~~~~~
                                   user_stack_pointer

Fixes: f227e3ec3b5c ("random32: update the net random state on interrupt and activity")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
  arch/arm/include/asm/percpu.h | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
index f44f448537f2..1a3eedbac4a2 100644
--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -5,6 +5,8 @@
  #ifndef _ASM_ARM_PERCPU_H_
  #define _ASM_ARM_PERCPU_H_
  
+#include <asm/thread_info.h>
+
  /*
   * Same as asm-generic/percpu.h, except that we store the per cpu offset
   * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
-- 
2.17.1

