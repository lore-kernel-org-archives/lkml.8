Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C3EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2AF2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgEUMfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 08:35:38 -0400
Received: from foss.arm.com ([217.140.110.172]:45608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgEUMfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 08:35:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 929EF30E;
        Thu, 21 May 2020 05:35:36 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3591B3F305;
        Thu, 21 May 2020 05:35:34 -0700 (PDT)
Subject: Re: [PATCH 0/3] arm64: perf: Add support for Perf NMI interrupts
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lecopzer Chen <lecopzer@gmail.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        Jian-Lin Chen <lecopzer.chen@mediatek.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "yj.chiang@mediatek.com" <yj.chiang@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>
References: <20200516124857.75004-1-lecopzer@gmail.com>
 <CAFA6WYNwp+_ENiS8QDao5+RXyt5ofJZyq6c5CKG_d0CNEmBNYg@mail.gmail.com>
 <CANr2M19unLW8n0P2DiOYEZ=GZcaD-L2ygPht_5HNtNZ6e4h6xQ@mail.gmail.com>
 <20200518104524.GA1224@C02TD0UTHF1T.local>
 <a9002b5e-aec5-b6e0-7174-87b93351d60c@arm.com>
 <8a1022c0-da2b-c83d-81cd-44b11149496b@arm.com>
 <B926444035E5E2439431908E3842AFD24B2728@DGGEMI525-MBS.china.huawei.com>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <1d615c32-89f0-d9ba-43db-3d90c7d53e15@arm.com>
Date:   Thu, 21 May 2020 13:36:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <B926444035E5E2439431908E3842AFD24B2728@DGGEMI525-MBS.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/21/20 4:00 AM, Song Bao Hua (Barry Song) wrote:

>
>> -----Original Message-----
>> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
>> On Behalf Of Alexandru Elisei
>> Sent: Wednesday, May 20, 2020 10:31 PM> 
>> Hi,
>>
>> On 5/18/20 12:17 PM, Alexandru Elisei wrote:
>>> Hi,
>>>
>>> On 5/18/20 11:45 AM, Mark Rutland wrote:
>>>> Hi all,
>>>>
>>>> On Mon, May 18, 2020 at 02:26:00PM +0800, Lecopzer Chen wrote:
>>>>> HI Sumit,
>>>>>
>>>>> Thanks for your information.
>>>>>
>>>>> I've already implemented IPI (same as you did [1], little difference
>>>>> in detail), hardlockup detector and perf in last year(2019) for
>>>>> debuggability.
>>>>> And now we tend to upstream to reduce kernel maintaining effort.
>>>>> I'm glad if someone in ARM can do this work :)
>>>>>
>>>>> Hi Julien,
>>>>>
>>>>> Does any Arm maintainers can proceed this action?
>>>> Alexandru (Cc'd) has been rebasing and reworking Julien's patches,
>>>> which is my preferred approach.
>>>>
>>>> I understand that's not quite ready for posting since he's
>>>> investigating some of the nastier subtleties (e.g. mutual exclusion
>>>> with the NMI), but maybe we can put the work-in-progress patches
>>>> somewhere in the mean time.
>>>>
>>>> Alexandru, do you have an idea of what needs to be done, and/or when
>>>> you expect you could post that?
>>> I'm currently working on rebasing the patches on top of 5.7-rc5, when
>>> I have something usable I'll post a link (should be a couple of days).
>>> After that I will address the review comments, and I plan to do a
>>> thorough testing because I'm not 100% confident that some of the
>>> assumptions around the locks that were removed are correct. My guess is
>> this will take a few weeks.
>>
>> Pushed a WIP branch on linux-arm.org [1]:
>>
>> git clone -b WIP-pmu-nmi git://linux-arm.org/linux-ae
>>
>> Practically untested, I only did perf record on a defconfig kernel running on the
>> model.
>>
>> [1]
>> http://www.linux-arm.org/git?p=linux-ae.git;a=shortlog;h=refs/heads/WIP-pm
>> u-nmi
> Fortunately, it does work. I used this tree to perf annotate arm_smmu_cmdq_issue_cmdlist() which
> is completely disabling IRQ. Luckily, it reports correct data. Before that, it reported all time was spent by
> the code which enabled IRQ .

That's good news that it works for you, thanks for letting me know.

Alex

