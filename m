Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C2AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2BD20658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597667122;
	bh=RCadk8ibATBlC4OXsKfPUxVYLbnc1pQ2OO78rBZG6yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EmCun2gHcr8fLOKeEujQn7HYsc6PdPOBsZLkaGUq3oNqPPui5skQmKkPDcNLebW14
	 wIif2sOd8LZ/V4UO1o1w/d+HagwN4v/tONIlHxT3wBpWKJpJ51h3fpOePey1LA+2o6
	 fpJ5lRNyhrO2cy7G+pKqCE/tfPW68fGk8BpSjdus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHQMZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbgHQMZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:25:08 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99FFA20658;
        Mon, 17 Aug 2020 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597667107;
        bh=RCadk8ibATBlC4OXsKfPUxVYLbnc1pQ2OO78rBZG6yc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h9GmAFF/1R9Kaz+2nZ1gJUEdSkuolk7DrWiYGIpCxI2BkfTQ3AZlmTOWwUPSjSmQ3
         FL5bikAbznQlWFNqieMVDUj5Y54rBaOuCeSvavd2eS5oepKBLM9TD6qmCeReqgmA+d
         3H9UVjKoWqs6x1dNCWP7nfXphqkIY/UpohdzoDGY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k7eCI-003YxY-1H; Mon, 17 Aug 2020 13:25:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Aug 2020 13:25:05 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     yezengruan <yezengruan@huawei.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, will@kernel.org,
        joelaf@google.com, linux-kernel@vger.kernel.org,
        suleiman@google.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>
Subject: Re: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be
 preempted
In-Reply-To: <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
 <20200817020310.GA1210848@jagdpanzerIV.localdomain>
 <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <cbcfb402b7fdb8a2a45b80fbb0e79f3e@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yezengruan@huawei.com, sergey.senozhatsky@gmail.com, will@kernel.org, joelaf@google.com, linux-kernel@vger.kernel.org, suleiman@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-17 13:03, yezengruan wrote:
> On 2020/8/17 10:03, Sergey Senozhatsky wrote:
>> On (20/07/21 13:17), Sergey Senozhatsky wrote:
>>> Hello,
>>> 
>>> 	RFC
>>> 
>>> 	We noticed that in a number of cases when we wake_up_process()
>>> on arm64 guest we end up enqueuing that task on a preempted VCPU. The 
>>> culprit
>>> appears to be the fact that arm64 guests are not aware of VCPU 
>>> preemption
>>> as such, so when sched picks up an idle VCPU it always assumes that 
>>> VCPU
>>> is available:
>>> 
>>>       wake_up_process()
>>>        try_to_wake_up()
>>>         select_task_rq_fair()
>>>          available_idle_cpu()
>>>           vcpu_is_preempted()    // return false;
>>> 
>>> Which is, obviously, not the case.
>>> 
>>> This RFC patch set adds a simple vcpu_is_preempted() implementation 
>>> so
>>> that scheduler can make better decisions when it search for the idle
>>> (v)CPU.
>> Hi,
>> 
>> A gentle ping.
>> 
>> 	-ss
>> _______________________________________________
>> kvmarm mailing list
>> kvmarm@lists.cs.columbia.edu
>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>> .
> 
> Hi Sergey,
> 
> I have a set of patches similar to yours.
> 
> https://lore.kernel.org/lkml/20191226135833.1052-1-yezengruan@huawei.com/

It really isn't the same thing at all. You are exposing PV spinlocks,
while Sergey exposes preemption to vcpus. The former is a massive,
and probably unnecessary superset of the later, which only impacts
the scheduler (it doesn't change the way locks are implemented).

You really shouldn't conflate the two (which you have done in your
series).

         M.
-- 
Jazz is not dead. It just smells funny...
