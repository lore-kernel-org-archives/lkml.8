Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D194BC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9614620786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GBB4giyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgICPXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:23:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44894 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgICLFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:05:43 -0400
Received: from [192.168.86.25] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id A9C0F20B7178;
        Thu,  3 Sep 2020 04:05:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A9C0F20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599131130;
        bh=cbjbEQfoAakgc2muysuZiPWyav4mT84ZZodemAfC4zI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GBB4giyYtQEuUoTxO/8p7uHh1HkfSLGpxbXzwchvFrWy5h7AXqmuFKECH1RWTEN5n
         p2Qcn+jCHdZFlPlBcliGBu2gLA625T41T5pxSUE7filKZ1akuGtyZT7UIq/Z3keBD3
         NTkBcXWChwByY4JofiLJatHzLMsED1O8RAND1LjI=
Subject: Re: [RFC PATCH v7 17/23] kernel/entry: Add support for core-wide
 protection of kernel-mode
To:     Joel Fernandes <joel@joelfernandes.org>,
        Dario Faggioli <dfaggioli@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <2a4398b55fe258ea53fb1fbc727063298f7eea8f.1598643276.git.jdesfossez@digitalocean.com>
 <87y2lth4qa.fsf@nanos.tec.linutronix.de>
 <20200901165052.GA1662854@google.com>
 <875z8xl0zh.fsf@nanos.tec.linutronix.de>
 <20200902012905.GB1703315@google.com>
 <87h7sgk41y.fsf@nanos.tec.linutronix.de>
 <a80babf130a45841e166fa155f84afc19b4257d3.camel@suse.com>
 <CAEXW_YRQiC_0edO5L2vVmL0NcfeZaRt4WYoyrcKmzbFcQP3PvA@mail.gmail.com>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <9471f752-1a30-d46f-be75-d3d433980385@linux.microsoft.com>
Date:   Thu, 3 Sep 2020 07:05:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEXW_YRQiC_0edO5L2vVmL0NcfeZaRt4WYoyrcKmzbFcQP3PvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/20 12:34 AM, Joel Fernandes wrote:
>>
>> Indeed! For at least two reasons, IMO:
>>
>> 1) what Thomas is saying already. I.e., even on a CPU which has HT but
>> is not affected by any of the (known!) speculation issues, one may want
>> to use Core Scheduling _as_a_feature_. For instance, for avoiding
>> threads from different processes, or vCPUs from different VMs, sharing
>> cores (e.g., for better managing their behavior/performance, or for
>> improved fairness of billing/accounting). And in this case, this
>> mechanism for protecting the kernel from the userspace on the other
>> thread may not be necessary or interesting;
> Agreed. So then I should really make this configurable and behind a
> sysctl then. I'll do that.
We already have the patch to wrap this feature in a build time and
boot time option:
https://lwn.net/ml/linux-kernel/9cd9abad06ad8c3f35228afd07c74c7d9533c412.1598643276.git.jdesfossez@digitalocean.com/

I could not get to a safe way to make it a runtime tunable at the time
of posting this series, but I think it should also be possible.

Thanks,
Vineeth

