Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F9CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A223120789
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgHQOq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:46:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:11986 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHQOq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:46:27 -0400
IronPort-SDR: GWql5WTPG5Bfi7E2WAzlgGsWK8nEoiLNkFAP02GlMxabfhU4AKnGkosBnXxFCFbw1unCqf9DJ0
 4M9bkVvtgLow==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="216242099"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="216242099"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 07:46:25 -0700
IronPort-SDR: xNqpQ4+oAK0T5d3KMDpO/z75SQuJ4v+gLwH/xKFyVVU5I0nK7o72OOvLguw/zRys8gqjneq48h
 UWENS81sxitw==
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="310117114"
Received: from jhor-mobl.gar.corp.intel.com (HELO [10.209.166.196]) ([10.209.166.196])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 07:46:23 -0700
Subject: Re: [PATCH 00/13] soundwire: intel: add power management support
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com,
        slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
 <20200817120841.GQ2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d8f8f64f-34db-9c9a-c821-83dda3b2db9a@linux.intel.com>
Date:   Mon, 17 Aug 2020 09:46:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817120841.GQ2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/20 7:08 AM, Vinod Koul wrote:
> On 22-07-20, 04:37, Bard Liao wrote:
>> This series adds power management support for Intel soundwire links.
> 
> I had applied except 3 & 9 (few skipped in middle due to conflict while
> applying), BUT I get a build failure on patch 2 onwards :(
> 
> drivers/soundwire/intel_init.c: In function ‘sdw_intel_cleanup’:
> drivers/soundwire/intel_init.c:72:4: error: implicit declaration of function ‘pm_runtime_disable’ [-Werror=implicit-function-declaration]
>     72 |    pm_runtime_disable(&link->pdev->dev);
> 
> I suspect due to missing header? I was on x64 build with allmodconfig
> 
> So only patch 1 is applied and pushed now

I just tried on these series applied on top of soundwire/next

commit 9b3b4b3f2f2af863d2f6dd65afd295a5a673afa2 (soundwire/next)

     soundwire: intel: Add basic power management support

And I don't see any issue?

If you want to double-check merge issues, I pushed the code here: 
https://github.com/plbossart/sound/tree/sdw/pm_runtime_soundwire_next

I am really not sure what conflicts you are referring to, git am worked 
fine for me, only skipped the first patch that's already applied.

$git am ~/Downloads/alsa/122/\[PATCH\ *
Applying: soundwire: intel: Add basic power management support
error: patch failed: drivers/soundwire/intel.c:463
error: drivers/soundwire/intel.c: patch does not apply
Patch failed at 0001 soundwire: intel: Add basic power management support
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
$ git am --skip
Applying: soundwire: intel: add pm_runtime support
Applying: soundwire: intel: reset pm_runtime status during system resume
Applying: soundwire: intel: fix race condition on system resume
Applying: soundwire: intel: call helper to reset Slave states on resume
Applying: soundwire: intel: reinitialize IP+DSP in .prepare(), but only 
when resuming
Applying: soundwire: intel: pm_runtime idle scheduling
Applying: soundwire: intel: add CLK_STOP_TEARDOWN for pm_runtime suspend
Applying: soundwire: intel: add CLK_STOP_BUS_RESET support
Applying: soundwire: intel: add CLK_STOP_NOT_ALLOWED support
Applying: soundwire: intel_init: handle power rail dependencies for 
clock stop mode
Applying: soundwire: intel: support clock_stop mode without quirks
Applying: soundwire: intel: refine runtime pm for 
SDW_INTEL_CLK_STOP_BUS_RESET

I tried the compilation twice, once with our default SOF config and once 
with allmodconfig.

make drivers/soundwire/ W=1
   GEN     Makefile
   YACC    scripts/genksyms/parse.tab.[ch]
/data/pbossart/ktest/broonie-next/scripts/genksyms/parse.y: warning: 9 
shift/reduce conflicts [-Wconflicts-sr]
/data/pbossart/ktest/broonie-next/scripts/genksyms/parse.y: warning: 5 
reduce/reduce conflicts [-Wconflicts-rr]
   HOSTCC  scripts/genksyms/parse.tab.o
   HOSTCC  scripts/genksyms/lex.lex.o
   HOSTLD  scripts/genksyms/genksyms
   CC      scripts/mod/empty.o
   MKELF   scripts/mod/elfconfig.h
   HOSTCC  scripts/mod/modpost.o
   CC      scripts/mod/devicetable-offsets.s
   HOSTCC  scripts/mod/file2alias.o
   HOSTCC  scripts/mod/sumversion.o
   HOSTLD  scripts/mod/modpost
   CC      kernel/bounds.s
   CC      arch/x86/kernel/asm-offsets.s
   CALL    /data/pbossart/ktest/broonie-next/scripts/checksyscalls.sh
   CALL    /data/pbossart/ktest/broonie-next/scripts/atomic/check-atomics.sh
   DESCEND  objtool
   CC [M]  drivers/soundwire/bus_type.o
   CC [M]  drivers/soundwire/bus.o
   CC [M]  drivers/soundwire/master.o
   CC [M]  drivers/soundwire/slave.o
   CC [M]  drivers/soundwire/mipi_disco.o
   CC [M]  drivers/soundwire/stream.o
   CC [M]  drivers/soundwire/sysfs_slave.o
   CC [M]  drivers/soundwire/sysfs_slave_dpn.o
   CC [M]  drivers/soundwire/debugfs.o
   LD [M]  drivers/soundwire/soundwire-bus.o
   CC [M]  drivers/soundwire/cadence_master.o
   LD [M]  drivers/soundwire/soundwire-cadence.o
   CC [M]  drivers/soundwire/intel.o
   CC [M]  drivers/soundwire/intel_init.o
   LD [M]  drivers/soundwire/soundwire-intel.o
   CC [M]  drivers/soundwire/qcom.o
   LD [M]  drivers/soundwire/soundwire-qcom.o



