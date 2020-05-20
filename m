Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C271CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A645F204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgETKaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:30:21 -0400
Received: from foss.arm.com ([217.140.110.172]:52538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgETKaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:30:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9347655D;
        Wed, 20 May 2020 03:30:16 -0700 (PDT)
Received: from [10.37.8.79] (unknown [10.37.8.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B658C3F68F;
        Wed, 20 May 2020 03:30:13 -0700 (PDT)
Subject: Re: [PATCH 0/3] arm64: perf: Add support for Perf NMI interrupts
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lecopzer Chen <lecopzer@gmail.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jian-Lin Chen <lecopzer.chen@mediatek.com>,
        Will Deacon <will@kernel.org>,
        alexander.shishkin@linux.intel.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        yj.chiang@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        acme@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        matthias.bgg@gmail.com, namhyung@kernel.org, jolsa@redhat.com,
        julien.thierry.kdev@gmail.com
References: <20200516124857.75004-1-lecopzer@gmail.com>
 <CAFA6WYNwp+_ENiS8QDao5+RXyt5ofJZyq6c5CKG_d0CNEmBNYg@mail.gmail.com>
 <CANr2M19unLW8n0P2DiOYEZ=GZcaD-L2ygPht_5HNtNZ6e4h6xQ@mail.gmail.com>
 <20200518104524.GA1224@C02TD0UTHF1T.local>
 <a9002b5e-aec5-b6e0-7174-87b93351d60c@arm.com>
Message-ID: <8a1022c0-da2b-c83d-81cd-44b11149496b@arm.com>
Date:   Wed, 20 May 2020 11:30:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a9002b5e-aec5-b6e0-7174-87b93351d60c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/18/20 12:17 PM, Alexandru Elisei wrote:
> Hi,
>
> On 5/18/20 11:45 AM, Mark Rutland wrote:
>> Hi all,
>>
>> On Mon, May 18, 2020 at 02:26:00PM +0800, Lecopzer Chen wrote:
>>> HI Sumit,
>>>
>>> Thanks for your information.
>>>
>>> I've already implemented IPI (same as you did [1], little difference
>>> in detail), hardlockup detector and perf in last year(2019) for
>>> debuggability.
>>> And now we tend to upstream to reduce kernel maintaining effort.
>>> I'm glad if someone in ARM can do this work :)
>>>
>>> Hi Julien,
>>>
>>> Does any Arm maintainers can proceed this action?
>> Alexandru (Cc'd) has been rebasing and reworking Julien's patches, which
>> is my preferred approach.
>>
>> I understand that's not quite ready for posting since he's investigating
>> some of the nastier subtleties (e.g. mutual exclusion with the NMI), but
>> maybe we can put the work-in-progress patches somewhere in the mean
>> time.
>>
>> Alexandru, do you have an idea of what needs to be done, and/or when you
>> expect you could post that?
> I'm currently working on rebasing the patches on top of 5.7-rc5, when I have
> something usable I'll post a link (should be a couple of days). After that I will
> address the review comments, and I plan to do a thorough testing because I'm not
> 100% confident that some of the assumptions around the locks that were removed are
> correct. My guess is this will take a few weeks.

Pushed a WIP branch on linux-arm.org [1]:

git clone -b WIP-pmu-nmi git://linux-arm.org/linux-ae

Practically untested, I only did perf record on a defconfig kernel running on the
model.

[1] http://www.linux-arm.org/git?p=linux-ae.git;a=shortlog;h=refs/heads/WIP-pmu-nmi

Thanks,
Alex
>
> Thanks,
> Alex
>> Thanks,
>> Mark.
>>
>>> This is really useful in debugging.
>>> Thank you!!
>>>
>>>
>>>
>>> [1] https://lkml.org/lkml/2020/4/24/328
>>>
>>>
>>> Lecopzer
>>>
>>> Sumit Garg <sumit.garg@linaro.org> 於 2020年5月18日 週一 下午1:46寫道：
>>>> + Julien
>>>>
>>>> Hi Lecopzer,
>>>>
>>>> On Sat, 16 May 2020 at 18:20, Lecopzer Chen <lecopzer@gmail.com> wrote:
>>>>> These series implement Perf NMI funxtionality and depends on
>>>>> Pseudo NMI [1] which has been upstreamed.
>>>>>
>>>>> In arm64 with GICv3, Pseudo NMI was implemented for NMI-like interruts.
>>>>> That can be extended to Perf NMI which is the prerequisite for hard-lockup
>>>>> detector which had already a standard interface inside Linux.
>>>>>
>>>>> Thus the first step we need to implement perf NMI interface and make sure
>>>>> it works fine.
>>>>>
>>>> This is something that is already implemented via Julien's patch-set
>>>> [1]. Its v4 has been floating since July, 2019 and I couldn't find any
>>>> major blocking comments but not sure why things haven't progressed
>>>> further.
>>>>
>>>> Maybe Julien or Arm maintainers can provide updates on existing
>>>> patch-set [1] and how we should proceed further with this interesting
>>>> feature.
>>>>
>>>> And regarding hard-lockup detection, I have been able to enable it
>>>> based on perf NMI events using Julien's perf patch-set [1]. Have a
>>>> look at the patch here [2].
>>>>
>>>> [1] https://patchwork.kernel.org/cover/11047407/
>>>> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2020-May/732227.html
>>>>
>>>> -Sumit
>>>>
>>>>> Perf NMI has been test by dd if=/dev/urandom of=/dev/null like the link [2]
>>>>> did.
>>>>>
>>>>> [1] https://lkml.org/lkml/2019/1/31/535
>>>>> [2] https://www.linaro.org/blog/debugging-arm-kernels-using-nmifiq
>>>>>
>>>>>
>>>>> Lecopzer Chen (3):
>>>>>   arm_pmu: Add support for perf NMI interrupts registration
>>>>>   arm64: perf: Support NMI context for perf event ISR
>>>>>   arm64: Kconfig: Add support for the Perf NMI
>>>>>
>>>>>  arch/arm64/Kconfig             | 10 +++++++
>>>>>  arch/arm64/kernel/perf_event.c | 36 ++++++++++++++++++------
>>>>>  drivers/perf/arm_pmu.c         | 51 ++++++++++++++++++++++++++++++----
>>>>>  include/linux/perf/arm_pmu.h   |  6 ++++
>>>>>  4 files changed, 88 insertions(+), 15 deletions(-)
>>>>>
>>>>> --
>>>>> 2.25.1
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-arm-kernel mailing list
>>>>> linux-arm-kernel@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
