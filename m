Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E11C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 04:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EFB206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 04:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TAnt3kv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgC3EtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 00:49:18 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21317 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgC3EtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 00:49:18 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200330044915epoutp03ec16b02c92933a695e02236ff56b6534~A_6UXBm6I1801818018epoutp03f
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 04:49:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200330044915epoutp03ec16b02c92933a695e02236ff56b6534~A_6UXBm6I1801818018epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585543755;
        bh=vJOuZeYH06qw3bVAy5RWOC35Uift6SXVkIKk7ObD1VE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TAnt3kv+CnmF3cfyzBk2J92EwDGsMeEZXVoJtpSSQqgR237S6OmTz9fFF8dW3rg6h
         UHeYNaGOSJPL/1tMchQ4BgNlQQ714fcGsexBy0hLX6lKLw5qsiu5v7lBqsnoUBYqdL
         zOcg+TwuxEIJGGcGSji8vUpKAmvN/zdrg/qLI4kg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200330044914epcas1p2e5736a81d3d25b7fdb70cb5d7c8ccffa~A_6TrGLCJ3181731817epcas1p2z;
        Mon, 30 Mar 2020 04:49:14 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48rKk14cmTzMqYkV; Mon, 30 Mar
        2020 04:49:13 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.3A.04140.84A718E5; Mon, 30 Mar 2020 13:49:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200330044906epcas1p22eb08191d957988dcdf1f2bb03e2d844~A_6L8gxT53183731837epcas1p2U;
        Mon, 30 Mar 2020 04:49:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200330044906epsmtrp12862da23ad23c4b167410a6c6c8120e4~A_6L7wCEq2510125101epsmtrp1i;
        Mon, 30 Mar 2020 04:49:06 +0000 (GMT)
X-AuditID: b6c32a36-fbbff7000000102c-74-5e817a48adc4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.FF.04158.24A718E5; Mon, 30 Mar 2020 13:49:06 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200330044905epsmtip1fb351934c65f3d0d2603fcdacee55295~A_6LCg6gf0121501215epsmtip1j;
        Mon, 30 Mar 2020 04:49:05 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] mm: mmap: add trace point of vm_unmapped_area
To:     Matthew Wilcox <willy@infradead.org>
Cc:     walken@google.com, bp@suse.de, akpm@linux-foundation.org,
        srostedt@vmware.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E817A40.2080202@samsung.com>
Date:   Mon, 30 Mar 2020 13:49:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200329161410.GW22483@bombadil.infradead.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se2xLcRTOz21vb0e5q+GkhLoesbKuXbW76JBYuEJiIRGR2NysV9u4feht
        xbCkWDxqw+bZ2VhsCfPIaJltJmLzaiRCFs+FkCCGbUxmm3m1vRP77zvf7zvnO+f8DoEpz+Aq
        wu70ch4ny1N4gqS2OVmbwmzelq3bFZHTZTXncbp4fzK9NxxEdEtDGU6/Ov9HSt/+0Sahf5fk
        0/29Zfh8gqkvfSljKkI+JnxGw4S6SmTMvWP9EiZ8fwvzLTSe6TjZjmcRq3mzjWMtnEfNOXNd
        FrvTmkEtWZGzIMdo0ulT9LPodErtZB1cBpW5NCtloZ2PdkWpN7K8L0plsYJApc41e1w+L6e2
        uQRvBsW5Lbxbr3NrBdYh+JxWba7LMVuv06UZo8q1vK3z0B6J+458U9/pKqkftckCiCCAnAlP
        /kgCSE4oyToE+wryAighirsQPDr1ExeD7wgufTiBYqpYQtHpbZj4cB1BR6R6QNWOoKYlMiRW
        diS5GKpfb43BJHIafL6cFpNg5EkEF5ob43Y4OR06K0qkMawgNXDuoWggIafAkxP+uGYUuQrq
        yr8iUZMIkeDbOC8nzfDscXU8FyMnwI4rx+MNAfkJhxd9B5A4WiZEyiix6ZHw8e5lmYhV0LZ/
        p0zU70DQHgwjMShA8DJUNDCmAYoKH2KxQhiZDDUNqSI9Eer7y5FoPBw6ugulopcCdu9UipKp
        UPC+WyricfDr9/sBzMCv4iMScVc9CBpqu6UHkLp00Gylg+Yp/e9cgbCzaDTnFhxWTtC70wZ/
        cAjFr1RjqkOnHixtQiSBqGGKL1f92Uopu1HIczQhIDAqSYEvi1IKC5u3mfO4cjw+nhOakDG6
        7mJMNSrXFb15pzdHb0wzGAz0TFO6yWigxigOP+WzlaSV9XLrOc7Nef7lDSHkKj+itl4qqMZ6
        71k7m41cSuaaVvO6d0omqBpxy7KupTLUZ/YXqle22ocm8iWpNxrtxJ2evVW1y8Paq3u2X9sw
        Y872qZVJx9+YtM/H9fTK591sDI7tSmh/OymQP6zv2dxrdT0BjennonrTyoNHmMVd9/0XDbeq
        bDIon7ymvneyszX5+lFKIthYvQbzCOxfySJ2c7sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnK5TVWOcwdOPPBZz1q9hs5jYr2nR
        vXkmo8XlXXPYLO6t+c9qcfTXSxaLf5NqLX7/mMPmwOGxc9Zddo8Fm0o9Nq/Q8tj0aRK7x4kZ
        v1k8Np+u9vi8Sc7j3fy3bAEcUVw2Kak5mWWpRfp2CVwZ76d0shQc46z4uXwJawPjS/YuRk4O
        CQETid7ljcwgtpDAbkaJpQeCIeIyEm/OP2XpYuQAsoUlDh8uhih5zShxYIYuSFhYwFNi5YMa
        EFNEQEPizRajLkYuoIrvjBI7D21hBnGYBeYzSuxdvJkVpJdNQFvi/YJJYDavgJbE6gvzGEFs
        FgFViWvzGlhAbFGBCInV664xQ9QISpyc+QQszilgI3Hj6kpWkGXMAuoS6+cJgYSZBeQlmrfO
        Zp7AKDgLSccshKpZSKoWMDKvYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjg0trR2M
        J07EH2IU4GBU4uH9sL0hTog1say4MvcQowQHs5IIL5s/UIg3JbGyKrUoP76oNCe1+BCjNAeL
        kjivfP6xSCGB9MSS1OzU1ILUIpgsEwenVANjx4F5OkyXzh64n1ORaZPW3u76iH/TDtPIgvd/
        o+61l2nn3t735ZUux/1NebUTYkPuOFR/rJeL5XtjfLBE1Ox/0JzFGhJJyhcr/6zxnJUX+189
        Wj1w5aL02Mwbefot030Pnt7JpZ+lVCKaovzkf9D1r6WnTk4RLCs5Vzp3Rc50c6fPjZfaDyso
        sRRnJBpqMRcVJwIAS6N4wIkCAAA=
X-CMS-MailID: 20200330044906epcas1p22eb08191d957988dcdf1f2bb03e2d844
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200320055839epcas1p189100549687530619d8a19919e8b5de0
References: <20200320055823.27089-1-jaewon31.kim@samsung.com>
        <CGME20200320055839epcas1p189100549687530619d8a19919e8b5de0@epcas1p1.samsung.com>
        <20200320055823.27089-3-jaewon31.kim@samsung.com>
        <20200329161410.GW22483@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 03월 30일 01:14, Matthew Wilcox wrote:
> On Fri, Mar 20, 2020 at 02:58:23PM +0900, Jaewon Kim wrote:
>> +	TP_printk("addr=%lx err=%ld total_vm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx\n",
>> +		IS_ERR_VALUE(__entry->addr) ? 0 : __entry->addr,
>> +		IS_ERR_VALUE(__entry->addr) ? __entry->addr : 0,
> I didn't see the IS_ERR_VALUE problem that Vlastimil mentioned get resolved?
Sorry I missed the problem. And thank you for your comment and suggestion.

I still do not understand why the unlikely incurs [FAILED TO PARSE] problem on trace-cmd.
Then trace log should not use the unlikely?

I may need to resubmit a new patch set with your suggestion.
Thank you
>
> I might suggest ...
>
> +++ b/include/linux/err.h
> @@ -19,7 +19,8 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -#define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
> +#define __IS_ERR_VALUE(x) ((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
> +#define IS_ERR_VALUE(x) unlikely(__IS_ERR_VALUE(x))
>  
>  static inline void * __must_check ERR_PTR(long error)
>  {
>
> and then you can use __IS_ERR_VALUE() which removes the unlikely() problem.
>
>

