Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BEEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77F4206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fch8573d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgHXNuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:50:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34600 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXNuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:50:09 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200824135007euoutp026b3d7d6cb8745eb4280f85fa597e7bb1~uOHhHh3b20982509825euoutp02L
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 13:50:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200824135007euoutp026b3d7d6cb8745eb4280f85fa597e7bb1~uOHhHh3b20982509825euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598277007;
        bh=hr16RomBo7KKhiX1UhmSuZR88oi2sGxSmPF+y5pZ6TA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fch8573d25s7/JAXu1/nCGbW5rCUMzqyKjNUgLOvTOFHgVtE3EyEYLVxMDfGgXyoz
         vpN5QhDcxgcdHhSXAX4kPadzB893sC8Xzv4ANODVAg5UbEMMeT6oX3uBbRfsJPNGQ1
         Mv9nbYqV2Ljkq7E/YQm/jdSiBstM3aojW8LEqOPA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200824135006eucas1p1bc259aa3ac01c64a7c03aecdfce6e4ce~uOHg-dYad0188501885eucas1p15;
        Mon, 24 Aug 2020 13:50:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5C.4B.05997.E85C34F5; Mon, 24
        Aug 2020 14:50:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200824135006eucas1p1ab1caf3aa6a2dab187a4fad4ed1ee2be~uOHglvgkH0188701887eucas1p1Q;
        Mon, 24 Aug 2020 13:50:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200824135006eusmtrp28b89f9ddbdbcc83a09fe72882bb68c88~uOHglHKir2872728727eusmtrp2G;
        Mon, 24 Aug 2020 13:50:06 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-c5-5f43c58e920a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CE.01.06314.E85C34F5; Mon, 24
        Aug 2020 14:50:06 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200824135006eusmtip1daa49a35fa052614873888c431032aba~uOHgMRkQx3018430184eusmtip1f;
        Mon, 24 Aug 2020 13:50:05 +0000 (GMT)
Subject: Re: drivers/dma/pl330.c:2981:9: warning: Identical condition 'ret',
 second condition is always false
To:     Vinod Koul <vkoul@kernel.org>, kernel test robot <lkp@intel.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <9e7612e8-41a5-460d-5492-12c5ef81b914@samsung.com>
Date:   Mon, 24 Aug 2020 15:50:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200808125940.GR12965@vkoul-mobl>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjt3b1er6u7rlPbg4XSoCDDrwwZzMw0Yn+sfohBkLryNiXdbNf5
        9WsphZshYYq6RM2ibKDh8qOZaWk1RdSapVOUUKRyMhwpVmqa283y3znnOc/7nAMviQmNHv5k
        ujKbUSvlGWKCj7e/+zUSXPo2LjnsWXOEZKhkDElGO2sIib1olpBMTXbzJJamCxLzVD8WQ8ge
        dM3zZCajjpBNjXURspJ7G7jst6EHly2ZAs4TF/lRqUxGeg6jDo1O4aeNm9dQ1rowr9hYydOi
        HwI98iKBPg4LznmkR3xSSDciMDhXcY4sI5iw1mMcWULQ+XMc2155+bnt7+AxgrbxUg+OLCKY
        sy4gl8uHVkHPjSHChX3pLOh7YuO5MEbLYaXmkYcLE3Q46B36LQ9JUnQ02K1uGacPwYeRF7gL
        +9FJ0Gb55F6laG8YqJ5z6150GJSWmxH3ZCB0OGowDotgcq6O58oDtMkTau9+wbnUp0HXP8Dj
        sA/YLa2eHD4Am+bthSIEM8NNnhy5jWC0sApxLilMDa+6k2L0EXjaGcrJp6C1rsUtAy0Am8Ob
        CyGAsvZKjJMpKL4l5NyHwWBp/nf29XsrdgeJDTuqGXbUMeyoY/h/tx7hRiRiNGymgmGPKZnc
        EFaeyWqUipArqkwT2vpBgxuW5eeoc/1yL6JJJN5DabvjkoUe8hw2P7MXAYmJfanYocEkIZUq
        zy9g1KpktSaDYXvRfhIXi6iIhvlLQlohz2auMUwWo96e8kgvfy1SSHQHC20Bu1YgbtaWXxCS
        O/19xrK092rzt4eNlSn1N/cdrT45WRZfrglIaKnqn7DrTvT1B9aanJGiBW3kK2lwRVT87nOi
        8AoqUeoQTOcFEfFhQ4br0gZLR/Hi/dgq01mnmj1jTPwaleAdE2bP9dMoN6WmmLVpVUTaR9nk
        mzoxzqbJw4MwNSv/A6INJN49AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7p9R53jDd53Slqc7b7GaHF51xw2
        i1fNj9gs7tzax2RxfG24xc47J5gd2DwW73nJ5LFpVSebx51re9g8umf/Y/H4O2s/i8fnTXIB
        bFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gdd3
        /mYs+CNU0bFqOlMD43e+LkZODgkBE4m997cydzFycQgJLGWU2HD4EytEQkbi5LQGKFtY4s+1
        LjaIoreMEm8PXWABSQgL5EvsbzzLBmKLCBRIbFm8ACzOLJAocavhHDtEw2pGiQ83DjCBJNgE
        DCW63oJM4uDgFbCTeHUJbAGLgKrExfO7wXpFBeIkHvf+ZwaxeQUEJU7OfAIW5xQwkOibspMR
        Yr6ZxLzND5khbHmJ7W/nQNniEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGh
        XnFibnFpXrpecn7uJkZgzG079nPzDsZLG4MPMQpwMCrx8Dbsc44XYk0sK67MPcQowcGsJMLr
        dPZ0nBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA9NBXkm8oamhuYWlobmxubGZhZI4b4fA
        wRghgfTEktTs1NSC1CKYPiYOTqkGxqJVd6TObF+qt2CZS3nS6rC0h/4m/F5znjpyeleJFdj9
        +WeUlLPrdalZe6rc/s1CLMXXb7dueX5qU+Nn/80eSxcs+XYxRNbwhFuxbT9rXmnutNnz4k7m
        Kv16/M+f1fnlfbfDoqoTzCf/vDOL16dkyiWlJZE1l73+LWgKdD0hu+Xhv1nzznrEPldiKc5I
        NNRiLipOBACwszhhzwIAAA==
X-CMS-MailID: 20200824135006eucas1p1ab1caf3aa6a2dab187a4fad4ed1ee2be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200808125949eucas1p2d02178719f81ee811aae13097d382670
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200808125949eucas1p2d02178719f81ee811aae13097d382670
References: <202008081010.0bKKNfQp%lkp@intel.com>
        <CGME20200808125949eucas1p2d02178719f81ee811aae13097d382670@eucas1p2.samsung.com>
        <20200808125940.GR12965@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 08.08.2020 14:59, Vinod Koul wrote:
> On 08-08-20, 10:53, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   30185b69a2d533c4ba6ca926b8390ce7de495e29
>> commit: a39cddc9e3775100100a4272feed64faac831be9 dmaengine: pl330: Drop boilerplate code for suspend/resume
>> date:   8 months ago
>> compiler: aarch64-linux-gcc (GCC) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> cppcheck warnings: (new ones prefixed by >>)
>>
>>>> drivers/dma/pl330.c:2981:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
>>      return ret;
>>             ^
>>     drivers/dma/pl330.c:2976:6: note: first condition
>>      if (ret)
>>          ^
>>     drivers/dma/pl330.c:2981:9: note: second condition
>>      return ret;
> This one could be fixed by making this as return 0, but is harmless

Right, with CONFIG_PM disabled, pm_runtime_force_resume() is noop, what 
causes the above warning.

>>             ^
>>>> drivers/dma/pl330.c:2798:23: warning: Variable 'desc->rqcfg.brst_len' is reassigned a value before the old one has been used. [redundantAssignment]
>>      desc->rqcfg.brst_len = get_burst_len(desc, len);
>>                           ^
>>     drivers/dma/pl330.c:2796:24: note: Variable 'desc->rqcfg.brst_len' is reassigned a value before the old one has been used.
>>       desc->rqcfg.brst_len = 1;
>>                            ^
>>     drivers/dma/pl330.c:2798:23: note: Variable 'desc->rqcfg.brst_len' is reassigned a value before the old one has been used.
>>      desc->rqcfg.brst_len = get_burst_len(desc, len);
> This one actually seems like a bug. Reading the code I think
> get_burst_len() should be called first before checking if burst size is
> smaller and setting to 1 in that case
>
> Sugar Zhang, Marek Szyprowski can you folks check this?

Indeed. It look that the commit 137bd11090d89b added 
desc->rqcfg.brst_len = 1 assignment before the desc->rqcfg.brst_len is 
set. Maybe this was a result of the broken rebase or so. No idea. It 
makes sense to switch the order and call desc->rqcfg.brst_len = 
get_burst_len(desc, len) first. I can send a patch if you want.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

