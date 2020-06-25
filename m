Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A001C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695C020899
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593072968;
	bh=MPqzxqlkLelCCKm2NSBBivueFsMTrj5zghx/JYvmDos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=n/o3oZH4y+8Koy0kw9HQYclx2Rk43wAH3oapOVJxQ0oeSYbHuvNJWaVQmPD5BPDyS
	 cJJaf4Gre/dciy1HNQ5R0/flyQghHRWe7uZKIaKuSXzko6LHzE4gkIa+xT96gtIn/J
	 WybYBlh4Plq3hFnJIe9GstYB6iLKwrUxTGlNLKWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390576AbgFYIQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390548AbgFYIQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:16:06 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65BF6207FC;
        Thu, 25 Jun 2020 08:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593072965;
        bh=MPqzxqlkLelCCKm2NSBBivueFsMTrj5zghx/JYvmDos=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iL2oGQgxl7cBdkY9GmZCHCXDsYU7SyMCIRn/zVaiJclsOjqSG0cvWh8OH/4Etip+T
         ysc31KkZoevPkSZHEf1wCj90WehZeMFWM5bLpoFc46CDHeCtYgskvJGZqzlulxmiUo
         nDbHMuvsM8e7K6B9QsrHQf/2m0ZzO8Gc+WZ89v7E=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1joN3D-006HU5-Ud; Thu, 25 Jun 2020 09:16:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Jun 2020 09:16:03 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     David Brazdil <dbrazdil@google.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com
Subject: Re: [PATCH v3 08/15] arm64: kvm: Split hyp/switch.c to VHE/nVHE
In-Reply-To: <202006251244.YDWclRrq%lkp@intel.com>
References: <20200618122537.9625-9-dbrazdil@google.com>
 <202006251244.YDWclRrq%lkp@intel.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <d807e83db1f1052378b6998f683e4617@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lkp@intel.com, dbrazdil@google.com, will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kbuild-all@lists.01.org, clang-built-linux@googlegroups.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-25 06:03, kernel test robot wrote:
> Hi David,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.8-rc2 next-20200624]
> [cannot apply to kvmarm/next arm64/for-next/core 
> arm-perf/for-next/perf]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use  as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:
> https://github.com/0day-ci/linux/commits/David-Brazdil/Split-off-nVHE-hyp-code/20200618-203230
> base:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 1b5044021070efa3259f3e9548dc35d1eb6aa844
> config: arm64-randconfig-r021-20200624 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project
> 8911a35180c6777188fefe0954a2451a2b91deaf)
> reproduce (this is a W=1 build):
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 
> ARCH=arm64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> arch/arm64/kvm/hyp/nvhe/switch.c:244:28: warning: no previous 
>>> prototype for function 'hyp_panic' [-Wmissing-prototypes]
>    void __hyp_text __noreturn hyp_panic(struct kvm_cpu_context 
> *host_ctxt)

I really wish we could turn these warnings off. They don't add much.
Or is there an annotation we could stick on the function (something
like __called_from_asm_please_leave_me_alone springs to mind...)?

         M.
-- 
Jazz is not dead. It just smells funny...
