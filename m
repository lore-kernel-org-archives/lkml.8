Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA66C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62265206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZkTKO+iu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgG3TFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:05:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42510 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgG3TFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:05:22 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06UJ4f4W052710;
        Thu, 30 Jul 2020 14:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596135881;
        bh=7R9JaaDyYHy6j1wPGdULOAzlHcWaIwOq1zScyFP4fpA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZkTKO+iuingK+4RBn9kVZitYeGcnuiyBwnt+USE8cHTR3YxVI4nAatlD1WwT/Uh8I
         2LgY0U15xRwnv1ZZjjOWAl21h0jrvZqDLGKENCOsrth3nDZLTxSeaENsLachXE5sTU
         VC1ouMEDFgIAKyhmD99zw580oMpEiZm8/sHome1k=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06UJ4f4X025816
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 14:04:41 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Jul 2020 14:04:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Jul 2020 14:04:40 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06UJ4ZfB013220;
        Thu, 30 Jul 2020 14:04:35 -0500
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
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <7b0c0f44-f56d-5e71-cf86-dbdea190267a@ti.com>
Date:   Thu, 30 Jul 2020 22:04:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whn8OB-QbxpffK=Lhh6Mhj+Y2ALFZ1asCgtnQOnmQgWUw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/07/2020 21:56, Linus Torvalds wrote:
> On Thu, Jul 30, 2020 at 11:47 AM Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>>
>>
>> I'd like to note that below set of patches:
>> 1c9df907da83 random: fix circular include dependency on arm64 after addition of percpu.h
>> 83bdc7275e62 random32: remove net_rand_state from the latent entropy gcc plugin
>> f227e3ec3b5c random32: update the net random state on interrupt and activity
>>
>> also break ARM build for the case:
>> #if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)
> 
> Lovely.
> 
> I think I'll have to revert 1c9df907da83 after all, and  use Marc
> Zyngier's patch to just remove that troublesome <asm/pointer_auth.h>
> include in arm64 instead.
> 
> This turned out to be much messier than it should have been.

FYI. Below diff seems fixes build:

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
Best regards,
grygorii
