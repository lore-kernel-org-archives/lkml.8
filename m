Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E677C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21755208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391047AbgF2VZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:25:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:30075 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729104AbgF2Smt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:49 -0400
IronPort-SDR: uD6OGMuOo7eiurt2635f876GBaK9NIfB4a1RgygfC3tflqLoF/uVKoB9sSCIjVJ9EHEAYgkoM0
 blEspmYeY5PA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="133384436"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="133384436"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 05:34:00 -0700
IronPort-SDR: 8fG8xVq429eM07+smEpJlcZATwZAdR411SM5hbOvFo4KF+c+JTOBJhxcoqkoKcPlEbrNOEBgfV
 GQ0M+UzUEuOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="294869715"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by orsmga002.jf.intel.com with ESMTP; 29 Jun 2020 05:33:55 -0700
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Paul Turner <pjt@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <CANaguZBQMarzMb-iXBEx8wJqkTYtRskTL+xQnShuAW7hP9UdqA@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <1e3c84b1-78c3-af2c-cfe5-bdd96f520576@linux.intel.com>
Date:   Mon, 29 Jun 2020 20:33:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CANaguZBQMarzMb-iXBEx8wJqkTYtRskTL+xQnShuAW7hP9UdqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineeth,

On 2020/6/26 4:12, Vineeth Remanan Pillai wrote:
> On Wed, Mar 4, 2020 at 12:00 PM vpillai <vpillai@digitalocean.com> wrote:
>>
>>
>> Fifth iteration of the Core-Scheduling feature.
>>
> Its probably time for an iteration and We are planning to post v6 based
> on this branch:
>  https://github.com/digitalocean/linux-coresched/tree/coresched/pre-v6-v5.7.y
> 
> Just wanted to share the details about v6 here before posting the patch
> series. If there is no objection to the following, we shall be posting
> the v6 early next week.
> 
> The main changes from v6 are the following:
> 1. Address Peter's comments in v5
>    - Code cleanup
>    - Remove fixes related to hotplugging.
>    - Split the patch out for force idling starvation
> 3. Fix for RCU deadlock
> 4. core wide priority comparison minor re-work.
> 5. IRQ Pause patch
> 6. Documentation
>    - https://github.com/digitalocean/linux-coresched/blob/coresched/pre-v6-v5.7.y/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> 
> This version is much leaner compared to v5 due to the removal of hotplug
> support. As a result, dynamic coresched enable/disable on cpus due to
> smt on/off on the core do not function anymore. I tried to reproduce the
> crashes during hotplug, but could not reproduce reliably. The plan is to
> try to reproduce the crashes with v6, and document each corner case for crashes
> as we fix those. Previously, we randomly fixed the issues without a clear
> documentation and the fixes became complex over time.
> 
> TODO lists:
> 
>  - Interface discussions could not come to a conclusion in v5 and hence would
>    like to restart the discussion and reach a consensus on it.
>    - https://lwn.net/ml/linux-kernel/20200520222642.70679-1-joel@joelfernandes.org
> 
>  - Core wide vruntime calculation needs rework:
>    - https://lwn.net/ml/linux-kernel/20200506143506.GH5298@hirez.programming.kicks-ass.net
> 
>  - Load balancing/migration changes ignores group weights:
>    - https://lwn.net/ml/linux-kernel/20200225034438.GA617271@ziqianlu-desktop.localdomain

According to Aaron's response below:
https://lwn.net/ml/linux-kernel/20200305085231.GA12108@ziqianlu-desktop.localdomain/

The following logic seems to be helpful for Aaron's case.

+	/*
+	 * Ignore cookie match if there is a big imbalance between the src rq
+	 * and dst rq.
+	 */
+	if ((src_rq->cfs.h_nr_running - rq->cfs.h_nr_running) > 1)
+		return true;

I didn't see any other comments on the patch at here:
https://lwn.net/ml/linux-kernel/67e46f79-51c2-5b69-71c6-133ec10b68c4@linux.intel.com/

Do we have another way to address this issue?

Thanks,
-Aubrey
