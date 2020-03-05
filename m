Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306B4C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6C820658
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgCEMMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:12:47 -0500
Received: from foss.arm.com ([217.140.110.172]:47852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgCEMMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:12:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEB9A4B2;
        Thu,  5 Mar 2020 04:12:46 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E34463F6C4;
        Thu,  5 Mar 2020 04:12:45 -0800 (PST)
Subject: Re: 5.6-rc3: WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380
 enqueue_task_fair+0x328/0x440
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200228163545.GA18662@vingu-book>
 <be45b190-d96c-1893-3ef0-f574eb595256@de.ibm.com>
 <49a2ebb7-c80b-9e2b-4482-7f9ff938417d@de.ibm.com>
 <ad0f263a-6837-e793-5761-fda3264fd8ad@de.ibm.com>
 <CAKfTPtCX4padfJm8aLrP9+b5KVgp-ff76=teu7MzMZJBYrc-7w@mail.gmail.com>
 <CAKfTPtD9b6o=B6jkbWNjfAw9e1UjT9Z07vxdsVfikEQdeCtfPw@mail.gmail.com>
 <2108173c-beaa-6b84-1bc3-8f575fb95954@de.ibm.com>
 <7be92e79-731b-220d-b187-d38bde80ad16@arm.com>
 <805cbe05-2424-7d74-5e11-37712c189eb6@de.ibm.com>
 <f28bc5ac-87fa-2494-29db-ff7d98b7372a@de.ibm.com>
 <20200305093003.GA32088@vingu-book>
 <15252de5-9a2d-19ae-607a-594ee88d1ba1@de.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <ef1be100-2c6a-bcff-69a2-25878589a111@arm.com>
Date:   Thu, 5 Mar 2020 13:12:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <15252de5-9a2d-19ae-607a-594ee88d1ba1@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2020 12:28, Christian Borntraeger wrote:
> 
> On 05.03.20 10:30, Vincent Guittot wrote:
>> Le mercredi 04 mars 2020 à 20:59:33 (+0100), Christian Borntraeger a écrit :
>>>
>>> On 04.03.20 20:38, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 04.03.20 20:19, Dietmar Eggemann wrote:

[...]

> It seems to speed up the issue when I do a compile job in parallel on the host:
> 
> Do you also need the sysfs tree?

[   87.932552] CPU23 path=/machine.slice/machine-test.slice/machine-qemu\x2d18\x2dtest10. on_list=1 nr_running=1 throttled=0 p=[CPU 2/KVM 2662]
[   87.932559] CPU23 path=/machine.slice/machine-test.slice/machine-qemu\x2d18\x2dtest10. on_list=0 nr_running=3 throttled=0 p=[CPU 2/KVM 2662]
[   87.932562] CPU23 path=/machine.slice/machine-test.slice on_list=1 nr_running=1 throttled=1 p=[CPU 2/KVM 2662]
[   87.932564] CPU23 path=/machine.slice on_list=1 nr_running=0 throttled=0 p=[CPU 2/KVM 2662]
[   87.932566] CPU23 path=/ on_list=1 nr_running=1 throttled=0 p=[CPU 2/KVM 2662]
[   87.951872] CPU23 path=/ on_list=1 nr_running=2 throttled=0 p=[ksoftirqd/23 126]
[   87.987528] CPU23 path=/user.slice on_list=1 nr_running=2 throttled=0 p=[as 6737]
[   87.987533] CPU23 path=/ on_list=1 nr_running=1 throttled=0 p=[as 6737]

Arrh, looks like 'char path[64]' is too small to hold 'machine.slice/machine-test.slice/machine-qemu\x2d18\x2dtest10.scope/vcpuX' !
                                                                                                                    ^  
But I guess that the 'on_list=0' for 'machine-qemu\x2d18\x2dtest10.scope' could be the missing hint?
