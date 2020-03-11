Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB601C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879EA20578
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dHyW0iGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgCKGbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:31:15 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:59487 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgCKGbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:31:15 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200311063112epoutp030676c4ee7d69580330b02418211cac08~7LC6UBdkF0449504495epoutp03g
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 06:31:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200311063112epoutp030676c4ee7d69580330b02418211cac08~7LC6UBdkF0449504495epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583908272;
        bh=ywElNuuu6xC+7y9La5cN9vDGAgcPYYjoEwgs7wpUAG8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dHyW0iGq5F1QyC4ew5UYvBXAfh5Gg1KD9lsNpVTk6pUv03ntQdGglU9BGGkudFO+D
         bLP2dPEkK0GkFiAOz4/da9IR0xjGr0tyAVRVhVUBkcw/OO4lBbdvkBeQe8aqXGpfGy
         TMxGRRXTI/DIGUWyTFQRsMPj7mWo9QHSRKR/fItk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200311063111epcas1p31c1b524581b95b95d9b8d86d123b8c24~7LC5zXWxt0636906369epcas1p35;
        Wed, 11 Mar 2020 06:31:11 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.164]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48chtR1gpPzMqYkj; Wed, 11 Mar
        2020 06:31:11 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.65.51241.FA5886E5; Wed, 11 Mar 2020 15:31:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200311063110epcas1p157083632cf0a810c04f7adc654aaa2d6~7LC4ukLAJ0619506195epcas1p1h;
        Wed, 11 Mar 2020 06:31:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200311063110epsmtrp24d00c7240bd278954eb2b2844f96a679~7LC4tyRu31738017380epsmtrp2s;
        Wed, 11 Mar 2020 06:31:10 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-bf-5e6885afdcd7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.AC.10238.EA5886E5; Wed, 11 Mar 2020 15:31:10 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200311063109epsmtip1df6b2bd2350ee98f5d146dda7ef7c4a2~7LC3xrjfX2187521875epsmtip1Y;
        Wed, 11 Mar 2020 06:31:09 +0000 (GMT)
Subject: Re: [RFC PATCH 1/3] proc/meminfo: introduce extra meminfo
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E68859A.9050107@samsung.com>
Date:   Wed, 11 Mar 2020 15:30:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200311062509.GB83589@google.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmnu761ow4g9X/uC2mN3pZzFm/hs2i
        e/NMRouVe34wWVzeNYfN4t6a/6wWy76+Z7fY0DKL3eLRhElMFqfufmZ34PLYOesuu8emVZ1s
        Hps+TWL3uHNtD5vHiRm/WTze77vK5rHz02ZWj8+b5AI4onJsMlITU1KLFFLzkvNTMvPSbZW8
        g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4BuVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
        F5fYKqUWpOQUGBoU6BUn5haX5qXrJefnWhkaGBiZAlUm5GRsObmOqaCRu+L9vD7mBsaXHF2M
        nBwSAiYSRxqXMHUxcnEICexglFhzYRc7hPOJUeLkpTdQzjdGiRcfv7LAtFy68ZgdxBYS2Mso
        seWoIUTRW0aJlrV7WUESwgJOEnsffWMEsUUErCTurLrGAlLELHCFUeL018dgk9gEtCXeL5gE
        1sAroCVx7cR3MJtFQFWi59JiMFtUIEJix9yPjBA1ghInZz4B6+UUMJDYdW83WJxZQF6ieets
        ZpAFEgLN7BKbPx9ggjjVReLSy0YoW1ji1fEt7BC2lMTnd3vZoBoYJd7O3MwI4bQwStzd1MsI
        UWUs0dtzAWgsB9AKTYn1u/QhwooSO3/PhdrMJ/Huaw8rSImEAK9ER5sQRImaRMuzr6wQtozE
        33/PoGwPifY9KxkhwdXPJNF6fAfbBEaFWUiem4XkoVkImxcwMq9iFEstKM5NTy02LDBFjuRN
        jOB0q2W5g/HYOZ9DjAIcjEo8vC/q0uOEWBPLiitzDzFKcDArifDGywOFeFMSK6tSi/Lji0pz
        UosPMZoCw3sis5Rocj4wF+SVxBuaGhkbG1uYmJmbmRorifM+jNSMExJITyxJzU5NLUgtgulj
        4uCUamB0Pxfx/+vpCzpx5b1NlbvDjQ6e8n5guunKFOcvEv/36+lKzGd/2Pf11t3S23+P3dA6
        xmW/IuCf/RO+snlvEw13fXETmCH+omHa8vzc7eFGwoc/bFLoE/q2TGNrwYqCZdGTNm0ID3J4
        dSqkeo1UmV+q8XXXFOamqzOvFq65fkLule9dZdWpmSsvKbEUZyQaajEXFScCADySNf/NAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTndda0acwf+z2hbTG70s5qxfw2bR
        vXkmo8XKPT+YLC7vmsNmcW/Nf1aLZV/fs1tsaJnFbvFowiQmi1N3P7M7cHnsnHWX3WPTqk42
        j02fJrF73Lm2h83jxIzfLB7v911l89j5aTOrx+dNcgEcUVw2Kak5mWWpRfp2CVwZW06uYypo
        5K54P6+PuYHxJUcXIyeHhICJxKUbj9lBbCGB3YwSC/77QcRlJN6cf8rSxcgBZAtLHD5c3MXI
        BVTymlHi78F/rCA1wgJOEnsffWMEsUUErCTurLrGAlHUzyQxe/9GdhCHWeAKo8SV+RfAqtgE
        tCXeL5gE1s0roCVx7cR3MJtFQFWi59JiMFtUIEJi9bprzBA1ghInZz5hAbE5BQwkdt3bzQhy
        EbOAusT6eUIgYWYBeYnmrbOZJzAKzkLSMQuhahaSqgWMzKsYJVMLinPTc4sNCwzzUsv1ihNz
        i0vz0vWS83M3MYKjR0tzB+PlJfGHGAU4GJV4eF/UpccJsSaWFVfmHmKU4GBWEuGNlwcK8aYk
        VlalFuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwKiiInO7yfSsjjdr
        FcO8nu2u9koOx9bU9HPv+uWYrL7k7Z3/hb89pl2bcFbjhNS/pvXBe/uNgmr2epkuuB0xaeu7
        Vp5NXK3ss389qf1Y4Zmapvcq51hExqdPrjGs4hycr/j+i0z4k9l7Ynlz9aFK7tbfpu9LjjcZ
        FPPKXku71nb0yLr9NbsXz1ZiKc5INNRiLipOBAAHD6NKmgIAAA==
X-CMS-MailID: 20200311063110epcas1p157083632cf0a810c04f7adc654aaa2d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200311034454epcas1p184680d40f89d37eec7f934074c4a9fcf
References: <20200311034441.23243-1-jaewon31.kim@samsung.com>
        <CGME20200311034454epcas1p184680d40f89d37eec7f934074c4a9fcf@epcas1p1.samsung.com>
        <20200311034441.23243-2-jaewon31.kim@samsung.com>
        <20200311061836.GA83589@google.com> <20200311062509.GB83589@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 03월 11일 15:25, Sergey Senozhatsky wrote:
> On (20/03/11 15:18), Sergey Senozhatsky wrote:
>> On (20/03/11 12:44), Jaewon Kim wrote:
>> [..]
>>> +#define NAME_SIZE      15
>>> +#define NAME_BUF_SIZE  (NAME_SIZE + 2) /* ':' and '\0' */
>>> +
>>> +struct extra_meminfo {
>>> +	struct list_head list;
>>> +	atomic_long_t *val;
>>> +	int shift_for_page;
>>> +	char name[NAME_BUF_SIZE];
>>> +	char name_pad[NAME_BUF_SIZE];
>>> +};
>>> +
>>> +int register_extra_meminfo(atomic_long_t *val, int shift, const char *name)
>>> +{
>>> +	struct extra_meminfo *meminfo, *memtemp;
>>> +	int len;
>>> +	int error = 0;
>>> +
>>> +	meminfo = kzalloc(sizeof(*meminfo), GFP_KERNEL);
>>> +	if (!meminfo) {
>>> +		error = -ENOMEM;
>>> +		goto out;
>>> +	}
>>> +
>>> +	meminfo->val = val;
>>> +	meminfo->shift_for_page = shift;
>>> +	strncpy(meminfo->name, name, NAME_SIZE);
>>> +	len = strlen(meminfo->name);
>>> +	meminfo->name[len] = ':';
>>> +	strncpy(meminfo->name_pad, meminfo->name, NAME_BUF_SIZE);
>> What happens if there is no NULL byte among the first NAME_SIZE bytes
>> of passed `name'?
> Ah. The buffer size is NAME_BUF_SIZE, so should be fine.
>
> 	-ss
Hello yes correct.

For your comment of 'spinlock', it may be changed to other lock like rw semaphore.
I think there are just couple of writers compared to many readers.
Thank you for your comment.
>
>

