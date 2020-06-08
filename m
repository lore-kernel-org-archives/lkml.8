Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CF3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8C32072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fnarfbargle.com header.i=@fnarfbargle.com header.b="kInQoV/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgFHNV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 09:21:26 -0400
Received: from ns3.fnarfbargle.com ([103.4.19.87]:53890 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgFHNV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:21:26 -0400
Received: from srv.home ([10.8.0.1] ident=heh12225)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1jiHgh-0005if-Nj; Mon, 08 Jun 2020 21:19:39 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=4Kn47SvgWtzJvGdAHtrl4GrkBFzAMzAPDG0yfcYoJ1k=;
        b=kInQoV/PZVWBADyl/OvkPVHIeU6xGQmm2wlLxoxIVPKXyXoATsVzYIqfQ+DGOC87kN9QHFLGsXO55oCGYNxx8Yu/9q0f6m8XchyRrrvgbTkqSkeof1pu2WS6ZFzVPG3F62sbwxsNKNMhJwklahRAngYRoFtMHwcbKKLHvMw16C4=;
Subject: Re: [PATCH] x86/cpu: Reinitialize IA32_FEAT_CTL MSR on BSP during
 wakeup
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        kernel test robot <lkp@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, kbuild-all@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20200605200728.10145-1-sean.j.christopherson@intel.com>
 <202006060421.fTpTXYbe%lkp@intel.com>
 <20200607163428.GB24576@linux.intel.com>
From:   Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <2c420161-2f1c-9d7b-47fb-c270c4b1645a@fnarfbargle.com>
Date:   Mon, 8 Jun 2020 21:20:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200607163428.GB24576@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G'day Sean,

With the addition of this patch on a vanilla v5.7 :
Tested-by: Brad Campbell <lists2009@fnarfbargle.com>

On 8/6/20 12:34 am, Sean Christopherson wrote:
> On Sat, Jun 06, 2020 at 05:08:38AM +0800, kernel test robot wrote:
>   arch/x86/kernel/cpu/centaur.c: In function 'init_centaur':
>>>> arch/x86/kernel/cpu/centaur.c:219:2: error: implicit declaration of function 'init_ia32_feat_ctl' [-Werror=implicit-function-declaration]
>> 219 |  init_ia32_feat_ctl(c);
>> |  ^~~~~~~~~~~~~~~~~~
>> cc1: some warnings being treated as errors
>> --
>> arch/x86/kernel/cpu/zhaoxin.c: In function 'init_zhaoxin':
>>>> arch/x86/kernel/cpu/zhaoxin.c:110:2: error: implicit declaration of function 'init_ia32_feat_ctl' [-Werror=implicit-function-declaration]
>> 110 |  init_ia32_feat_ctl(c);
>> |  ^~~~~~~~~~~~~~~~~~
>> cc1: some warnings being treated as errors
> 
> Blech, zhaoxin.c an centaur.c don't include asm/cpu.h, and I (obviously)
> don't have them enabled in my configs.  I'll wait a day or two more before
> sending v2.
> diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
> index 426792565d86..c5cf336e5077 100644
> --- a/arch/x86/kernel/cpu/centaur.c
> +++ b/arch/x86/kernel/cpu/centaur.c
> @@ -3,6 +3,7 @@
>   #include <linux/sched.h>
>   #include <linux/sched/clock.h>
> 
> +#include <asm/cpu.h>
>   #include <asm/cpufeature.h>
>   #include <asm/e820/api.h>
>   #include <asm/mtrr.h>
> diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
> index df1358ba622b..05fa4ef63490 100644
> --- a/arch/x86/kernel/cpu/zhaoxin.c
> +++ b/arch/x86/kernel/cpu/zhaoxin.c
> @@ -2,6 +2,7 @@
>   #include <linux/sched.h>
>   #include <linux/sched/clock.h>
> 
> +#include <asm/cpu.h>
>   #include <asm/cpufeature.h>
> 
>   #include "cpu.h"
> 
> 

