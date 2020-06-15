Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9802EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 02:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8025920747
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 02:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgFOCFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 22:05:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:48920 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbgFOCFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 22:05:35 -0400
IronPort-SDR: RyDhtZ9dO4cCG3PRLjKpZ/ntMumxTJDq0RMyZoUOfpLqqv9glN2kc4/fctjivzNzzotmZm8Nd0
 LahCq6ekm4TQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2020 19:05:35 -0700
IronPort-SDR: +189MtdzvtZ99W0KxVKmGChEmpBlGO9RTUWC3+JsxiywTI0yoJ/Ffq1chTqceOZ0hBLG1auzwP
 VtnDgefeTtdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,513,1583222400"; 
   d="scan'208";a="449119946"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by orsmga005.jf.intel.com with ESMTP; 14 Jun 2020 19:05:30 -0700
Subject: Re: [RFC PATCH 11/13] sched: migration changes for core scheduling
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <279f7f6606ea18e14d64517840bcada56deb0ce3.1583332765.git.vpillai@digitalocean.com>
 <20200612132127.GA90012@google.com>
 <CANaguZDguzOCvNmO1u7CZQU2DSFW0+uPt7ZwL18w4bG=-_Xe3Q@mail.gmail.com>
 <20200613022530.GA110162@google.com>
 <CANaguZA2Ti1WfvZHO8NjuS==fzGXrni-qZw5OFZ-tmhcvXH+rA@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <a16a80b1-efee-6997-4266-f6158ea86d49@linux.intel.com>
Date:   Mon, 15 Jun 2020 10:05:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CANaguZA2Ti1WfvZHO8NjuS==fzGXrni-qZw5OFZ-tmhcvXH+rA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/14 2:59, Vineeth Remanan Pillai wrote:
> On Fri, Jun 12, 2020 at 10:25 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>
>> Ok, so I take it that you will make it so in v6 then, unless of course
>> someone else objects.
>>
> Yes, just wanted to hear from Aubrey, Tim and others as well to see
> if we have not missed anything obvious. Will have this in v6 if
> there are no objections.
> 
> Thanks for bringing this up!
> 
> ~Vineeth
> 
Yes, this makes sense to me, no need to find idle core in select_idle_cpu().
Thanks to catch this!

Thanks,
-Aubrey
