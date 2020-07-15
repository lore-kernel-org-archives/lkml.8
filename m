Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8BFC433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9622064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kDh3emLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgGOJCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:02:50 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45636 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729856AbgGOJCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:02:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200715090247euoutp02b74c5aba2934f0396645e932918694af~h4ZOziQR70272902729euoutp02n
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 09:02:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200715090247euoutp02b74c5aba2934f0396645e932918694af~h4ZOziQR70272902729euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594803767;
        bh=rOtt1S2tLpV7KmVBOIjaAMcUlP/xKM8TZrQQvNLV85w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kDh3emLiWOEEnza7g3jncBibpte5i1LFWHa27Fa5IApdcX7mm09ADRwBNFepd8GNc
         L0gcHH5QkohKKjoJk0vwCEFC2O8JJVDF6oSjtLMd7k8mzQStE1osZH6kTw7g6vcTfs
         zMrqg3WCvPVKYE4EmiHbPHoLcuaNaArspVag35X4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200715090247eucas1p2f8e6a287cc19a540620fdad4ef20f00c~h4ZOYHV4y2167121671eucas1p2P;
        Wed, 15 Jul 2020 09:02:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F0.B7.06318.636CE0F5; Wed, 15
        Jul 2020 10:02:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200715090246eucas1p28b89f81cd6b5979677e2ff9f2fe52c0a~h4ZN9UPKj2380523805eucas1p25;
        Wed, 15 Jul 2020 09:02:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200715090246eusmtrp1b4d856a270c0bc108c3b462602fdc1f8~h4ZN5asmu2399223992eusmtrp1V;
        Wed, 15 Jul 2020 09:02:46 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-36-5f0ec6360793
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 15.A8.06314.636CE0F5; Wed, 15
        Jul 2020 10:02:46 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200715090246eusmtip287b49e933ac303b20b32e1fabe502a24~h4ZNbGex-2995429954eusmtip2-;
        Wed, 15 Jul 2020 09:02:46 +0000 (GMT)
Subject: Re: [PATCH v3 0/3] driver core: Add device link related sysfs files
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <14bafea4-3cf3-91ea-2c82-c9917ac100f1@samsung.com>
Date:   Wed, 15 Jul 2020 11:02:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx9EnpxV_zKQtVToGvq5NQZJNNTCHrssEOKvkt5srYagsA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djPc7rmx/jiDSZ5W2ycsZ7VonnxejaL
        M791LXZsF7G4vGsOm8WM8/uYLOZ+mcps0XXoL5sDh8e23dtYPRZsKvXYtKqTzePOtT1sHvvn
        rmH36NuyitHj8ya5APYoLpuU1JzMstQifbsEroy920ULnvJX9Oy+wNbA+Ieni5GTQ0LARGL3
        xX6mLkYuDiGBFYwSH2++ZYVwvjBK/L3/mhHC+cwocfvlB6AyDrCWR7uZQLqFBJYzSix/XgtR
        855RYlPDdxaQhLCAj8TUBQ/AikQEtCQ2XXvMAlLELHCaSWJF73FmkASbgKFE19suNhCbV8BO
        Ys3SCewgNouAqsSnp+vAmkUF4iTWv9zOBFEjKHFy5hOwBZwCgRJXuh+xgtjMAvIS29/OYYaw
        xSVuPZkP9o+EwDF2iQUX57BDPOoi8XTSMmYIW1ji1fEtUHEZidOTe1ggGpoZJR6eW8sO4fQw
        SlxumsEIUWUtcefcLzaQ/5kFNCXW79KHCDtK/Nz5mRUSLHwSN94KQhzBJzFp23RmiDCvREeb
        EES1msSs4+vg1h68cIl5AqPSLCSvzULyziwk78xC2LuAkWUVo3hqaXFuemqxcV5quV5xYm5x
        aV66XnJ+7iZGYGI6/e/41x2M+/4kHWIU4GBU4uG1mM4bL8SaWFZcmXuIUYKDWUmE1+ns6Tgh
        3pTEyqrUovz4otKc1OJDjNIcLErivMaLXsYKCaQnlqRmp6YWpBbBZJk4OKUaGBMYd2wLULp8
        JZ97z90rN/Mu3XCfe85dM0VO/er5qNzp07usJnPsjdkp0h6qXPgwNXbPbO0f5Xm9TmF6/1vV
        Pho8brJcOVd4/fyouTde5p2PXCkT08DgNe/iKhd/kW736FkGbG8MF21e2jaB5QW/T8dih4ub
        K5nmp0pv/Pb+sKVHbOheTU7to0osxRmJhlrMRcWJAP5MIoBIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xe7pmx/jiDTo/yFtsnLGe1aJ58Xo2
        izO/dS12bBexuLxrDpvFjPP7mCzmfpnKbNF16C+bA4fHtt3bWD0WbCr12LSqk83jzrU9bB77
        565h9+jbsorR4/MmuQD2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTub
        lNSczLLUIn27BL2MvdtFC57yV/TsvsDWwPiHp4uRg0NCwETi0W6mLkYuDiGBpYwSR+5eYOxi
        5ASKy0icnNbACmELS/y51sUGYgsJvGWUWN+jBWILC/hITF3wgAnEFhHQkth07TELyCBmgbNM
        EndmHGaFmLqWReLL063sIFVsAoYSXW8hJvEK2EmsWToBLM4ioCrx6ek6sEmiAnESy7fMZ4eo
        EZQ4OfMJC4jNKRAocaX7EdhFzAJmEvM2P2SGsOUltr+dA2WLS9x6Mp9pAqPQLCTts5C0zELS
        MgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBsbjt2M/NOxgvbQw+xCjAwajEwzth
        Jm+8EGtiWXFl7iFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5gm8kri
        DU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MEZzK14tWp69b0m3rvSK
        PUJXjASWSaZsDj0XcTdt4u0dtW/frRVPL6gun+az2DvPxuGL/8Vp227NvKVQxcD2ZoeW6qKD
        vKlRx/R398zkto5d03WYR4t9y2/n1P/Mrwx50gMcs+fMUzyxVSmj2HKh74Y7DSue9b3Ni1+d
        wbKrsXv6N9Mst8IlDEosxRmJhlrMRcWJAOeDWg7bAgAA
X-CMS-MailID: 20200715090246eucas1p28b89f81cd6b5979677e2ff9f2fe52c0a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200715082233eucas1p261d4c5133226b800c3656c9010aa5940
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200715082233eucas1p261d4c5133226b800c3656c9010aa5940
References: <20200521191800.136035-1-saravanak@google.com>
        <CAGETcx8UGps6bz1YhYcbjCAAXenBuR6XDT0qv5WED5zbyfzNFw@mail.gmail.com>
        <20200529123025.GA1710508@kroah.com>
        <CAGETcx-QiAysfd7AVV2Y7_GWRd2sj4N=8KwQ_T4fUZ5gVaV8Jw@mail.gmail.com>
        <CAGETcx94Os7o+xZPSs3vVOQAzGtESAGFXtUNdrEAK9iya05s1w@mail.gmail.com>
        <CGME20200715082233eucas1p261d4c5133226b800c3656c9010aa5940@eucas1p2.samsung.com>
        <20200710132305.GA1920995@kroah.com>
        <f564bac4-1120-cee4-4ea5-aad5fcc7bd91@samsung.com>
        <CAGETcx9EnpxV_zKQtVToGvq5NQZJNNTCHrssEOKvkt5srYagsA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 15.07.2020 10:53, Saravana Kannan wrote:
> On Wed, Jul 15, 2020 at 1:22 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 10.07.2020 15:23, Greg Kroah-Hartman wrote:
>>> On Mon, Jul 06, 2020 at 03:45:02PM -0700, Saravana Kannan wrote:
>>>> On Tue, Jun 16, 2020 at 8:45 PM Saravana Kannan <saravanak@google.com> wrote:
>>>>> On Fri, May 29, 2020 at 5:30 AM Greg Kroah-Hartman
>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>> Looks semi-sane, but it's too close to the merge window at the moment
>>>>>> for me to take this.  If there's no objections by the time 5.8-rc1 is
>>>>>> out, I'll queue it up in my tree for 5.9-rc1.
>>>>> Another friendly reminder :)
>>>> *nudge* *nudge*
>>> Looks sane, given no objections, let's see what linux-next thinks about
>>> it...
>> linux-next is not very happy from this patchset... Starting from
>> next-20200713 I see a few new issues on various Samsung Exynos based
>> boards. Here are examples from Exynos4412-based Odroid U3 board (ARM
>> 32bit, kernel compiled from exynos_defconfig):
> Thanks for the bug reports.
>
>> BUG: sleeping function called from invalid context at
>> kernel/locking/mutex.c:935
>> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworker/0:1
>> 2 locks held by kworker/0:1/12:
>>    #0: ee8074a8 ((wq_completion)rcu_gp){+.+.}-{0:0}, at:
>> process_one_work+0x174/0x7dc
>>    #1: ee921f20 ((work_completion)(&sdp->work)){+.+.}-{0:0}, at:
>> process_one_work+0x174/0x7dc
>> Preemption disabled at:
>> [<c01b10f0>] srcu_invoke_callbacks+0xc0/0x154
> Sigh... probably some SRCU screw up when the device link is deleted.
> I'll look at it by the end of this week. If you don't mind, what SRCU
> debug config caught this for you? That way, I can reproduce it on my
> end.

Just the options enabled in the default exynos_defconfig in current 
linux-next. I didn't check any particular options yet.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

