Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D85EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E15320714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WIhLPAMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgC3KAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:00:00 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:11651 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgC3KAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:00:00 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200330095957epoutp0174c8e56b15a1ab17efc8aa2f897fccb7~BDJmE8_u61272812728epoutp01M
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 09:59:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200330095957epoutp0174c8e56b15a1ab17efc8aa2f897fccb7~BDJmE8_u61272812728epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585562397;
        bh=auVWg6nVu/gwx9lFp54ApevoIaYZeZZq96L32jMRfRg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WIhLPAMqGUlsMUY9ChPz+Sjp5eEr7ms2mUJJI9tWG4XsuMhusVNFT4Bk10SglL8Mq
         CVg5uGLwrGPilE89A9my1kn2qwYCqrjW+tAT1futC1q4gxCq1xS5zU10HtaoS5oYR1
         +//TE3nKQmdO3DM0McXbUqEj1zYNBwmYiaIFbDo8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200330095956epcas1p380ace43586df2199d5b2ef442c1c7402~BDJlttRPN1825318253epcas1p3t;
        Mon, 30 Mar 2020 09:59:56 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48rScX03BmzMqYkV; Mon, 30 Mar
        2020 09:59:56 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.07.04160.B13C18E5; Mon, 30 Mar 2020 18:59:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200330095955epcas1p1829e254b88000bf79864aefb2ee02093~BDJkRvu2Z1262012620epcas1p1J;
        Mon, 30 Mar 2020 09:59:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200330095955epsmtrp1dab9287d8cde136affe02fd8a426f69d~BDJkRGY6S2991829918epsmtrp1F;
        Mon, 30 Mar 2020 09:59:55 +0000 (GMT)
X-AuditID: b6c32a38-2afff70000001040-31-5e81c31bf847
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.79.04024.B13C18E5; Mon, 30 Mar 2020 18:59:55 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200330095954epsmtip188a668e9578540f76c43df362bcff187~BDJjG3W6T1006710067epsmtip1u;
        Mon, 30 Mar 2020 09:59:53 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] mm: mmap: add trace point of vm_unmapped_area
To:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Cc:     walken@google.com, bp@suse.de, akpm@linux-foundation.org,
        srostedt@vmware.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        Steven Rostedt <rostedt@goodmis.org>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E81C319.7080508@samsung.com>
Date:   Mon, 30 Mar 2020 18:59:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <1ccdcd2e-2a56-af61-5b37-26ad64da0e7d@suse.cz>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmrq704cY4g1v9NhZz1q9hs5jYr2nR
        vXkmo8XlXXPYLO6t+c9qsa/jAZPF0V8vWSxmN/YxWvybVGvx+8ccNgcuj52z7rJ7tOy7xe6x
        YFOpx+YVWh6bPk1i9zgx4zeLx5kFR9g9Np+u9vi8Sc7j3fy3bAFcUTk2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCXKimUJeaUAoUCEouLlfTtbIry
        S0tSFTLyi0tslVILUnIKDA0K9IoTc4tL89L1kvNzrQwNDIxMgSoTcjIu7OtmL7jMWfF+Vxdr
        A2MDRxcjJ4eEgInEpAkvmbsYuTiEBHYwSuw+/xXK+cQosf/jVyYI5xujxNzZB1hhWhbP2whV
        tZdR4kjbA3aQhJDAW0aJsz8cuxg5OIQFPCVWPqgBCYsIeElsP7+DBaSeWeAoo8Td9olsIAk2
        AW2J9wsmgQ3lFdCSWHgHZCgnB4uAqkTzrLssILaoQITEjrkfGSFqBCVOznwCFucUsJZ43jgN
        LM4sIC/RvHU22EESAu3sEkdefWWBuNRF4sn5a8wQtrDEq+Nb2CFsKYmX/W3sEA3NjBJvZ25m
        hHBagM7b1MsIUWUs0dtzgRnkHWYBTYn1u/QhwooSO3/PhdrMJ/Huaw8rSImEAK9ER5sQRIma
        RMuzr9DQkpH4++8ZlO0h8XfiNBZIYK1gkpjWpjeBUWEWkt9mIflnFsLiBYzMqxjFUguKc9NT
        iw0LTJCjeBMjOO1qWexg3HPO5xCjAAejEg/vh+0NcUKsiWXFlbmHGCU4mJVEeNn8gUK8KYmV
        ValF+fFFpTmpxYcYTYHBPZFZSjQ5H5gT8kriDU2NjI2NLUzMzM1MjZXEeadez4kTEkhPLEnN
        Tk0tSC2C6WPi4JRqYFw0V9Jcb8uJCUIm8hanema1WvEvVlmTPSVkSVfEJx6RCfbas6fPjas6
        cJNP7QJjheUEvut/NH+9aElbpZt3zbuU+daeHeVx00ViOY7H3woUOrWPx/IFu/ykwhOZHXZx
        HnLshk7Pu9epvq3fdO/1puWuMsZODN+u26U7HVw0f0GBZu38gFuyXkosxRmJhlrMRcWJAGC8
        uWXRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhJTlf6cGOcwecuYYs569ewWUzs17To
        3jyT0eLyrjlsFvfW/Ge12NfxgMni6K+XLBazG/sYLf5NqrX4/WMOmwOXx85Zd9k9WvbdYvdY
        sKnUY/MKLY9Nnyaxe5yY8ZvF48yCI+wem09Xe3zeJOfxbv5btgCuKC6blNSczLLUIn27BK6M
        C/u62Qsuc1a839XF2sDYwNHFyMkhIWAisXjeRuYuRi4OIYHdjBIPp11ih0jISLw5/5Sli5ED
        yBaWOHy4GKLmNaPEsqbVrCBxYQFPiZUPakDKRQS8JLaf38ECUbOCSaJl018wh1ngKKPEnLW3
        2ECq2AS0Jd4vmMQKYvMKaEksvAOymZODRUBVonnWXRYQW1QgQmL1umvMEDWCEidnPgGLcwpY
        SzxvnMYIYjMLqEv8mXeJGcKWl2jeOpt5AqPgLCQts5CUzUJStoCReRWjZGpBcW56brFhgWFe
        arlecWJucWleul5yfu4mRnA0aWnuYLy8JP4QowAHoxIP74ftDXFCrIllxZW5hxglOJiVRHjZ
        /IFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJxcEo1MCpedlk2
        tU5uJ/tvQa/IU85XUxybZkW8M26UkePl/Okxeem5B1fsNVmDDwkcvzNv92UL0QqOyyo/7q+O
        NRT/+FbFalNBgJOTkffszbe3Sx0++C391qK/UkE/Ncy9bae7la00sjqccWrtH/GMLKdghpj+
        gpSzu22iwoJmngjv+LNnSUdmciTDDiWW4oxEQy3mouJEAOCdML+iAgAA
X-CMS-MailID: 20200330095955epcas1p1829e254b88000bf79864aefb2ee02093
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
        <1ccdcd2e-2a56-af61-5b37-26ad64da0e7d@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 03월 30일 18:56, Vlastimil Babka wrote:
> On 3/29/20 6:14 PM, Matthew Wilcox wrote:
>> On Fri, Mar 20, 2020 at 02:58:23PM +0900, Jaewon Kim wrote:
>>> +	TP_printk("addr=%lx err=%ld total_vm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx\n",
>>> +		IS_ERR_VALUE(__entry->addr) ? 0 : __entry->addr,
>>> +		IS_ERR_VALUE(__entry->addr) ? __entry->addr : 0,
>> I didn't see the IS_ERR_VALUE problem that Vlastimil mentioned get resolved?
> Steven is fixing it in trace-cmd:
> https://lore.kernel.org/r/20200324200956.821799393@goodmis.org
Good news for me.
Thank you
>
>> I might suggest ...
>>
>> +++ b/include/linux/err.h
>> @@ -19,7 +19,8 @@
>>  
>>  #ifndef __ASSEMBLY__
>>  
>> -#define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
>> +#define __IS_ERR_VALUE(x) ((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
>> +#define IS_ERR_VALUE(x) unlikely(__IS_ERR_VALUE(x))
> So this shouldn't be needed, as we are adding a new tracepoint, not "breaking"
> an existing one?
>
>>  static inline void * __must_check ERR_PTR(long error)
>>  {
>>
>> and then you can use __IS_ERR_VALUE() which removes the unlikely() problem.
>>
>
>

