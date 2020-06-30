Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972A4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DE72081A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vzMYZKam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbgF3HnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731204AbgF3HnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:43:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EEBC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:43:15 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so19067845wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZoRd38QGQrdDNG7r8luBguRXWeU+EfCI/iTGstHyFCU=;
        b=vzMYZKamDpf4KUnrtaCbdUxNpLq+lxCT8bXztObsjLvBanF9bvOldNXUPoSGHXnmE9
         dc2KjRbgrSHCUH/oSEZSN4B/lUlcjzLBkIPNS2K4kMXgYr1lkRS1xr8Hw2135D7ZVysd
         tiSNA9MD2XMKGaBPWeQNmfVOOS0+SuPUIdJGkcX54QjTB8/GyLe4ptJdu5IeZar5cXvO
         LegC4hGPOmkViJkQ9p9Z+QhM/T3NRadhGoegnJQiuS0rYhOKB1qObJutORQ87eg+rtPN
         Z0pg8ze/1KuNEi7v8MU2x+amzhFvLL1EZUZ5uKmxQsSUpGSQbW/5SSaVFiIBdFQl80gW
         3DDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZoRd38QGQrdDNG7r8luBguRXWeU+EfCI/iTGstHyFCU=;
        b=JzhtXkzANxre+ZNwNyaqBqZqHAxtNkCGEisPLGvX284mTD0YnW3G4ppeVgyacwiWSI
         DKi19iCppzrS2qEsSvPy+eUWH6MdcMFO2Xb+EEvmQjPivgZNzst5mN0YGoY92oGMX7jN
         /E/f+OHwp2QbmarwT3dJZlla3qemth2vBBjYxXmfGiL8UkJSM+EUxfqOZRFssLD8HIJf
         /phkJH1FbkNJRjSeqHXsiWMe41LIi8SEoMn1K0CfW0W8D+bz8GLNX2hSAESWFVyKYqqA
         X2nURe6jFvOS8ybp36e/+1XASMK4sdzagX1Eh82aW8OXDqy7h31Vk5HG33SIHZsj3AwZ
         Pa8w==
X-Gm-Message-State: AOAM530UrJpDn5dWOXnYXsSwExKTz+z+s2ZJmCKGTu/M8/3ZlVTGYgMJ
        i/hCK/JEbtMDY29hf6vzCKogdA==
X-Google-Smtp-Source: ABdhPJzlvkoJ7saZmHoJaFfgOMAemjtl3gOSLNuSoZPni4qpP36E2hSzZ02xX0WSbXP/a9yDE4Cr6w==
X-Received: by 2002:adf:fe0b:: with SMTP id n11mr20436694wrr.245.1593502994105;
        Tue, 30 Jun 2020 00:43:14 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:bcb2:95cf:b364:c337])
        by smtp.gmail.com with ESMTPSA id x185sm2595188wmg.41.2020.06.30.00.43.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 00:43:13 -0700 (PDT)
Date:   Tue, 30 Jun 2020 09:43:11 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Tao Zhou <ouwen210@hotmail.com>, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [LKP] [sched/fair] 6c8116c914: stress-ng.mmapfork.ops_per_sec
 -38.0% regression
Message-ID: <20200630074311.GA12788@vingu-book>
References: <20200421004749.GC26573@shao2-debian>
 <20200425012306.13516-1-hdanton@sina.com>
 <20200426124208.8872-1-hdanton@sina.com>
 <20200427113533.4688-1-hdanton@sina.com>
 <CAKfTPtABxPBmS6=qn96=7X5vfF0ae15M+RAiduH0sb11+gyKew@mail.gmail.com>
 <d50c9467-7b1b-346b-d4ab-107253a0a3ae@linux.intel.com>
 <BL0PR14MB377940B17C0889D725FF78599A9C0@BL0PR14MB3779.namprd14.prod.outlook.com>
 <d0faca7b-641a-e0e6-db89-443d88e2b3d8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0faca7b-641a-e0e6-db89-443d88e2b3d8@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

Le lundi 15 juin 2020 à 16:14:01 (+0800), Xing Zhengjun a écrit :
> 
> 
> On 6/15/2020 1:18 PM, Tao Zhou wrote:

...

> I apply the patch based on v5.7, the regression still existed.


Could you try the patch below  ? This patch is not a real fix because it impacts performance of others benchmarks but it will at least narrow your problem.


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9f78eb76f6fb..a4d8614b1854 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8915,9 +8915,9 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
                 * and consider staying local.
                 */

-               if ((sd->flags & SD_NUMA) &&
-                   ((idlest_sgs.avg_load + imbalance) >= local_sgs.avg_load))
-                       return NULL;
+//             if ((sd->flags & SD_NUMA) &&
+//                 ((idlest_sgs.avg_load + imbalance) >= local_sgs.avg_load))
+//                     return NULL;

                /*
                 * If the local group is less loaded than the selected

--


> =========================================================================================
> tbox_group/testcase/rootfs/kconfig/compiler/nr_threads/disk/sc_pid_max/testtime/class/cpufreq_governor/ucode:
> 
> lkp-bdw-ep6/stress-ng/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/100%/1HDD/4194304/1s/scheduler/performance/0xb000038
> 
> commit:
>   e94f80f6c49020008e6fa0f3d4b806b8595d17d8
>   6c8116c914b65be5e4d6f66d69c8142eb0648c22
>   v5.7
>   c7e6d37f60da32f808140b1b7dabcc3cde73c4cc  (Tao's patch)
> 
> e94f80f6c4902000 6c8116c914b65be5e4d6f66d69c                        v5.7
> c7e6d37f60da32f808140b1b7da
> ---------------- --------------------------- ---------------------------
> ---------------------------
>          %stddev     %change         %stddev     %change %stddev     %change
> %stddev
>              \          |                \          |                \
> |                \
>     819250 ±  5%     -10.1%     736616 ±  8%     +41.2%    1156877 ± 3%
> +43.6%    1176246 ±  5%  stress-ng.futex.ops
>     818985 ±  5%     -10.1%     736460 ±  8%     +41.2%    1156215 ± 3%
> +43.6%    1176055 ±  5%  stress-ng.futex.ops_per_sec
>       1551 ±  3%      -3.4%       1498 ±  5%      -4.6%       1480 ± 5%
> -14.3%       1329 ± 11%  stress-ng.inotify.ops
>       1547 ±  3%      -3.5%       1492 ±  5%      -4.8%       1472 ± 5%
> -14.3%       1326 ± 11%  stress-ng.inotify.ops_per_sec
>      11292 ±  8%      -2.8%      10974 ±  8%      -9.4%      10225 ± 6%
> -10.1%      10146 ±  6%  stress-ng.kill.ops
>      11317 ±  8%      -2.6%      11023 ±  8%      -9.1%      10285 ± 5%
> -10.3%      10154 ±  6%  stress-ng.kill.ops_per_sec
>      28.20 ±  4%     -35.4%      18.22           -33.4%      18.77
> -27.7%      20.40 ±  9%  stress-ng.mmapfork.ops_per_sec
>    2999012 ± 21%     -10.1%    2696954 ± 22%     -88.5%     344447 ± 11%
> -87.8%     364932        stress-ng.tee.ops_per_sec
>       7882 ±  3%      -5.4%       7458 ±  4%      -2.0%       7724 ± 3%
> -2.2%       7709 ±  4%  stress-ng.vforkmany.ops
>       7804 ±  3%      -5.2%       7400 ±  4%      -2.0%       7647 ± 3%
> -2.1%       7636 ±  4%  stress-ng.vforkmany.ops_per_sec
>   46745421 ±  3%      -8.1%   42938569 ±  3%      -5.2%   44312072 ± 4%
> -2.3%   45648193        stress-ng.yield.ops
>   46734472 ±  3%      -8.1%   42926316 ±  3%      -5.2%   44290338 ± 4%
> -2.4%   45627571        stress-ng.yield.ops_per_sec
> 
> 
> 

...

> -- 
> Zhengjun Xing
