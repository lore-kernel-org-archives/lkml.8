Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81729C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA7620774
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgHLSvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:51:16 -0400
Received: from foss.arm.com ([217.140.110.172]:47586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgHLSvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:51:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E256CD6E;
        Wed, 12 Aug 2020 11:51:14 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 929C53F22E;
        Wed, 12 Aug 2020 11:51:13 -0700 (PDT)
References: <20200812125300.11889-7-valentin.schneider@arm.com> <202008130025.XjiXqp1O%lkp@intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kbuild-all@lists.01.org, mingo@kernel.org, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v5 06/17] sched/debug: Output SD flag names rather than their values
In-reply-to: <202008130025.XjiXqp1O%lkp@intel.com>
Date:   Wed, 12 Aug 2020 19:51:08 +0100
Message-ID: <jhjpn7v66lf.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/08/20 17:35, kernel test robot wrote:
> Hi Valentin,
>
> Thank you for the patch! Perhaps something to improve:
>

[...]


> url:    https://github.com/0day-ci/linux/commits/Valentin-Schneider/sched-Instrument-sched-domain-flags/20200812-205638
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 949bcb8135a96a6923e676646bd29cbe69e8350f
> config: i386-randconfig-s001-20200811 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.2-168-g9554805c-dirty
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386
>

>>> kernel/sched/debug.c:279:17: sparse: sparse: non size-preserving pointer to integer cast
>>> kernel/sched/debug.c:279:17: sparse: sparse: non size-preserving integer to pointer cast
>
>    271
>    272		tmp = kcalloc(data_size + 1, sizeof(tmp), GFP_KERNEL);
>    273		for_each_set_bit(idx, &flags, __SD_FLAG_CNT) {
>    274			char *name = sd_flag_debug[idx].name;
>    275
>    276			len += snprintf(tmp + len, strlen(name) + 2, "%s ", name);
>    277		}
>    278
>  > 279		tmp += *ppos;

I pretty much copied kernel/sysctl.c::_proc_do_string() and I think that's
exactly the same types here: char* buffer incremented by loff_t offset. It
does look fine to me, but I can't really parse that warning.

>    280		len -= *ppos;
>    281
>    282		if (len > *lenp)
>    283			len = *lenp;
>    284		if (len)
>    285			memcpy(buffer, tmp, len);
>    286		if (len < *lenp) {
>    287			((char *)buffer)[len] = '\n';
>    288			len++;
>    289		}
>    290
>    291		*lenp = len;
>    292		*ppos += len;
>    293
>    294		kfree(tmp);
>    295
>    296		return 0;
>    297	}
>    298
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
