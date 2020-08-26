Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8239C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E4B20786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MCwrx6B9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgHZL2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:28:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47419 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgHZLXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:23:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200826112342euoutp01bd149cb47bd696aefd25d08aa593f5ef~uzaQV1LZ00932909329euoutp01b
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 11:23:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200826112342euoutp01bd149cb47bd696aefd25d08aa593f5ef~uzaQV1LZ00932909329euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598441022;
        bh=OaqqbA/pn8yxkZtcsoCbwwD4lOczMZiTQ0XXc8L0Zi4=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=MCwrx6B9MdiqnJCCXJRt1mISZiIrLHSCcsW/BqJRohufxFFq0a/mgyqN6l0q6XTs7
         MpdVnMg/thc0TUl1f1hAYS+CW1/FLc1RYHBpTbeQnkU8CdX2InwRWeonDYhAp/e6XM
         LAqrpTbmuRZdBYWPjWW8IIkV0FQkHD3fix3RzC94=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200826112342eucas1p2ecba0e12b32fd7e500247bd0c2a666be~uzaQO_AOg0890108901eucas1p2C;
        Wed, 26 Aug 2020 11:23:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C4.05.06456.E36464F5; Wed, 26
        Aug 2020 12:23:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200826112341eucas1p2c66787ef33dc49a6f36f565f1d3989ff~uzaP4adjg1709517095eucas1p2u;
        Wed, 26 Aug 2020 11:23:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200826112341eusmtrp29932ef2bb2e379d5de7960c2313f87e7~uzaP3qQJG1966219662eusmtrp2Q;
        Wed, 26 Aug 2020 11:23:41 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-1f-5f46463e6383
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A8.BF.06314.D36464F5; Wed, 26
        Aug 2020 12:23:41 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200826112341eusmtip120289db9a2db6497c4260b65cabf62f5~uzaPaXVh81214412144eusmtip1r;
        Wed, 26 Aug 2020 11:23:41 +0000 (GMT)
Subject: Re: [PATCH v1] driver core: Annotate dev_err_probe() with
 __must_check
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <1e3708e5-24f2-18e0-40c0-284853171338@samsung.com>
Date:   Wed, 26 Aug 2020 13:23:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826104459.81979-1-andriy.shevchenko@linux.intel.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djP87p2bm7xBr8u8Fr0Nk1nsmhevJ7N
        4vKuOWwWc79MZXZg8di0qpPNY97JQI/9c9ewe3zeJBfAEsVlk5Kak1mWWqRvl8CVsWn1W8aC
        rawV3xrmsjYwNrN0MXJySAiYSCx8u5Opi5GLQ0hgBaPEhxP9jBDOF0aJdVMPs0E4nxklTsy6
        zA7T0rtsNytEYjmjxOH1m6Cq3jNK7Gu9CDZYWCBQYuXxfmaQhIjAFkaJKVPbmUESbAKaEn83
        32QDsXkF7CQu7vzBBGKzCKhKnL70AaxGVCBOYuvxq0wQNYISJ2c+ARvKKeAu8fjuP7BeZgF5
        ieats5khbHGJpi8rwU6SEGhmlzhzeDaQwwHkuEisOVwEcbawxKvjW6BekJH4v3M+E4RdL3F/
        RQszRG8Ho8TWDTuZIRLWEnfO/WIDmcMMdPT6XfoQYUeJqQd2MUKM55O48VYQ4gQ+iUnbpjND
        hHklOtqEIKoVJe6f3Qo1UFxi6YWvbBC2h8ShH1OZJzAqzkLy5Cwkj81C8tgshBsWMLKsYhRP
        LS3OTU8tNsxLLdcrTswtLs1L10vOz93ECEwtp/8d/7SD8eulpEOMAhyMSjy8C9hc44VYE8uK
        K3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQi
        mCwTB6dUA+P0Y1yFCZ1BEll75XR3bZn6xppHdYtUfuHmok2z6u4y7+/YL+W/f/lbgWg+lo/c
        oWv+vWW1OsNeUXw14L3pVseXK2VmSRvxpU1hf8Lb1PGDuSH2jtpb3iWdPn+DPJWsjuf4v9wj
        4ciQ4/BqyYx1jm/5eqd2nFpo+TfLzLf3YMDOjqg73MatjUosxRmJhlrMRcWJAGOeLxkpAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7q2bm7xBj8/mFj0Nk1nsmhevJ7N
        4vKuOWwWc79MZXZg8di0qpPNY97JQI/9c9ewe3zeJBfAEqVnU5RfWpKqkJFfXGKrFG1oYaRn
        aGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsWn1W8aCrawV3xrmsjYwNrN0MXJySAiY
        SPQu283axcjFISSwlFFi3rFbzBAJcYnd899C2cISf651sUEUvWWUWHBmI1hCWCBQYuXxfjBb
        RGALo8S2jTwgtpDALEaJVx1uIDabgKbE38032UBsXgE7iYs7fzCB2CwCqhKnL30A6xUViJN4
        3PufGaJGUOLkzCdg13EKuEs8vvsPrJdZwExi3uaHzBC2vETz1tlQtrhE05eVrBMYBWchaZ+F
        pGUWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIyZbcd+bt7BeGlj8CFGAQ5G
        JR7eBWyu8UKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5Hxg
        POeVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamCc9j/J6Tdf0tZA
        ZsfYdxE7e+t+JmpweMmKcRxjvJc766GxV+a63bqsRW+SJpTGqzNtsrrPuEj+qsOiJ822Feev
        PrqgYC4mzmng/uDWvYeabdoft0YbP0949+XxMpfMM/5HKt7XFd20M3xQnL/KV/ewWErg1NPl
        DvwnWqvOW618XDvN9lob22QlluKMREMt5qLiRAA1k10YrwIAAA==
X-CMS-MailID: 20200826112341eucas1p2c66787ef33dc49a6f36f565f1d3989ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200826104505eucas1p2e6ac15abfb6104fdbc4229fc148cbe02
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826104505eucas1p2e6ac15abfb6104fdbc4229fc148cbe02
References: <CGME20200826104505eucas1p2e6ac15abfb6104fdbc4229fc148cbe02@eucas1p2.samsung.com>
        <20200826104459.81979-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 26.08.2020 12:44, Andy Shevchenko wrote:
> We have got already new users of this API which interpret it differently
> and miss the opportunity to optimize their code.
>
> In order to avoid similar cases in the future, annotate dev_err_probe()
> with __must_check.


There are many cases where __must_check can be annoying, for example:

ret = ...;

if (ret < 0) {

     dev_err_probe(...);

     goto cleanup;

}


Or (less frequently):

ptr = ...;

if (IS_ERR(ptr)) {

     dev_err_probe(...);

     return ptr;

}


Of course in both cases one can add workarounds, but I am not sure what 
is better.


Regards

Andrzej


