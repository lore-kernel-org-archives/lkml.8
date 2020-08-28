Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84251C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC74207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BsNX3lbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgH1WPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:15:07 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39046 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgH1WPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:15:06 -0400
Received: from [192.168.86.25] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0510920B7178;
        Fri, 28 Aug 2020 15:15:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0510920B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598652905;
        bh=OOViSgP/vlzkrI+MHTAMLnmBxE7NC/MzAZ7Dvd+pYU8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BsNX3lbFHpBpqop45YezYrjBlS+h9z6gFZsb/9o687wsQMyntzZ56u/etay55PWUV
         cmLsri5zFrCIs0bN0LwTuUX6nHKoy77df9W8Q/m8BcrApRnFRQHhyNM9pTo8SGbvBT
         KcCoK8t7FXgzcEn9ObyUhyVNUCMZhLO1xeC23orM=
Subject: Re: [RFC PATCH v7 08/23] sched: Add core wide task selection and
 scheduling.
To:     Peter Zijlstra <peterz@infradead.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
 <20200828205526.GC29142@worktop.programming.kicks-ass.net>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <ca34288c-f7c5-e722-2d05-0fbde74b2bda@linux.microsoft.com>
Date:   Fri, 28 Aug 2020 18:15:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828205526.GC29142@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/20 4:55 PM, Peter Zijlstra wrote:
> On Fri, Aug 28, 2020 at 03:51:09PM -0400, Julien Desfossez wrote:
>> +		if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
>> +			rq_i->core_forceidle = true;
> Did you mean: rq_i->core_pick == rq_i->idle ?
>
> is_idle_task() will also match idle-injection threads, which I'm not
> sure we want here.
Thanks for catching this. You are right, we should be checking for
rq_i->idle. There are couple other places where we use is_idle_task.
Will go through them and verify if we need to fix there as well.

Thanks,
Vineeth

