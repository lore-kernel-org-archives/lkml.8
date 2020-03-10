Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52896C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252E12464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgCJGWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:22:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:38100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgCJGWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:22:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CC0BBB35A;
        Tue, 10 Mar 2020 06:21:59 +0000 (UTC)
Subject: Re: [PATCH v2] xen: Use evtchn_type_t as a type for event channels
To:     Yan Yankovskyi <yyankovskyi@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Jan Beulich <jbeulich@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200307134322.GA27756@kbp1-lhp-F74019>
 <d190793c-fe6b-263e-7793-ccd73f9ccad4@oracle.com>
 <20200308131944.GA18740@kbp1-lhp-F74019>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <eccf0d74-fdc6-d3bb-ca79-5761008c3efd@suse.com>
Date:   Tue, 10 Mar 2020 07:21:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200308131944.GA18740@kbp1-lhp-F74019>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.20 14:19, Yan Yankovskyi wrote:
> On Sat, Mar 07, 2020 at 02:41:44PM -0500, Boris Ostrovsky wrote:
>>
>>
>> On 3/7/20 8:43 AM, Yan Yankovskyi wrote:
>>> Make event channel functions pass event channel port using
>>> evtchn_port_t type. It eliminates signed <-> unsigned conversion.
>>>
>>
>>
>>>   static int find_virq(unsigned int virq, unsigned int cpu)
>>>   {
>>>   	struct evtchn_status status;
>>> -	int port, rc = -ENOENT;
>>> +	evtchn_port_t port;
>>> +	int rc = -ENOENT;
>>>   
>>>   	memset(&status, 0, sizeof(status));
>>>   	for (port = 0; port < xen_evtchn_max_channels(); port++) {
>>> @@ -962,7 +963,8 @@ EXPORT_SYMBOL_GPL(xen_evtchn_nr_channels);
>>>   int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
>>>   {
>>>   	struct evtchn_bind_virq bind_virq;
>>> -	int evtchn, irq, ret;
>>> +	evtchn_port_t evtchn = xen_evtchn_max_channels();
>>> +	int irq, ret;
>>>   
>>>   	mutex_lock(&irq_mapping_update_lock);
>>>   
>>> @@ -990,7 +992,6 @@ int bind_virq_to_irq(unsigned int virq, unsigned int cpu, bool percpu)
>>>   			if (ret == -EEXIST)
>>>   				ret = find_virq(virq, cpu);
>>>   			BUG_ON(ret < 0);
>>> -			evtchn = ret;
>>
>>
>> This looks suspicious. What would you be passing to
>> xen_irq_info_virq_setup() below?
> 
> Right, this line should be preserved.
> 
>> I also think that, given that this patch is trying to get types in
>> order, find_virq() will need more changes: it is supposed to return
>> evtchn_port_t. But then it also wants to return a (signed) error.
>   
> As we don't care which error we got during find_virq call, we can just
> return 0 in case of error, and port number otherwise. Port 0 is never
> valid, so this approach can work for the other functions as well.
> On the other hand, passing port using pointer and returning actual
> error message, as it's done in xenbus_alloc_evtchn(), sounds like a
> better approach overall. What do you think?

You can use the same approach as Xen tools do and define something like:

typedef int evtchn_port_or_error_t;


Juergen
