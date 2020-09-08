Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890FCC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FACA20768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgIHRSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:18:11 -0400
Received: from foss.arm.com ([217.140.110.172]:57126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731547AbgIHQSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:18:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ABF01045;
        Tue,  8 Sep 2020 09:18:08 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2683E3F66E;
        Tue,  8 Sep 2020 09:18:07 -0700 (PDT)
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     peterz@infradead.org, vincent.donnefort@arm.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, Phil Auld <pauld@redhat.com>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
 <20200907104845.6rust2lf2o3d5gmq@e107158-lin.cambridge.arm.com>
 <20200907111320.GP2674@hirez.programming.kicks-ass.net>
 <20200907145155.fsmeygi4fiypikzk@e107158-lin.cambridge.arm.com>
 <cbad58a5-758b-ded9-ed41-1be74e8663a6@arm.com>
 <20200908151722.b7ai2bpgvixlimz3@e107158-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d3fd557f-e38d-c4b4-1137-fcf0b06d3ba2@arm.com>
Date:   Tue, 8 Sep 2020 18:17:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908151722.b7ai2bpgvixlimz3@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2020 17:17, Qais Yousef wrote:
> On 09/08/20 13:17, Dietmar Eggemann wrote:
>> On 07/09/2020 16:51, Qais Yousef wrote:
>>> On 09/07/20 13:13, peterz@infradead.org wrote:
>>>> On Mon, Sep 07, 2020 at 11:48:45AM +0100, Qais Yousef wrote:
>>>>> IMHO the above is a hack. Out-of-tree modules should rely on public headers and
>>>>> exported functions only. What you propose means that people who want to use
>>>>> these tracepoints in meaningful way must have a prebuilt kernel handy. Which is
>>>>> maybe true for us who work in the embedded world. But users who run normal
>>>>> distro kernels (desktop/servers) will fail to build against
>>>>
>>>> But this isn't really aimed at regular users. We're aiming this at
>>>> developers (IIUC) so I dont really see this as a problem.
>>
>> This is what I thought as well. All these helpers can be coded directly
>> in these tracepoint-2-traceevent (tp-2-te) converters. As long as they
>> are build from within kernel/sched/ there is no issue with the export
>> via kernel/sched/sched.h. Otherwise this little trick would be necessary.
>> But since it is a tool for developers I guess we can assume that they
>> can build it from within kernel/sched/.
> 
> I think this will reduce the usefulness of these tracepoints. But if you really
> want to remove them, I am certainly not strongly attached to them and they were
> meant to be removable anyway. So fine by me :-)

I would like to see them go. Less stuff to maintain. And as we see with
the new cpu_capacity tp there are always more helper functions coming.

IMHO, the ability to build those modules via public headers is less
important since they are meant for developers.
