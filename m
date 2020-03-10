Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C40C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9912520637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YJM7O1fA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgCJSzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:55:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:35407 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgCJSzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583866504;
        bh=Lev0mWhay02+toqB31RrcDL7dSW9ZMHbMQUGpcxVYvk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YJM7O1fAqCUH4O3p1Q1jG/94xFCU+Rn4nsxgLkh9WCGUV0XOEN+8Ypy2nDiGwAF6d
         1sdv4BLnNrF3Ykz5Onql3378V0YDwGLRLyefU/HYh8AF1uBltmPNRm+HOOSYM85Gfu
         Hg7BLZ62/Qahb+sRTv752c6jgOZHZX4DALaQwXpQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.202] ([95.91.236.254]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYXs-1jcWoA0qOE-00m4NP; Tue, 10
 Mar 2020 19:55:04 +0100
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
References: <20200310002524.2291595-1-guro@fb.com>
 <5cfa9031-fc15-2bcc-adb9-9779285ef0f7@oracle.com>
 <20200310180558.GD85000@carbon.dhcp.thefacebook.com>
 <4b78a8a9-7b5a-eb62-acaa-2677e615bea1@oracle.com>
From:   Andreas Schaufler <andreas.schaufler@gmx.de>
Autocrypt: addr=andreas.schaufler@gmx.de; keydata=
 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
 pMd1zB+/DJ0=
Message-ID: <1b5ada08-1baf-4f2d-3ecd-b940e7ee0e0d@gmx.de>
Date:   Tue, 10 Mar 2020 19:54:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4b78a8a9-7b5a-eb62-acaa-2677e615bea1@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SI0t3dK8bDg1AzSN79aI/+U65LtCVKSjjGkjL67ihXYsAmZOwYR
 5wccwjLuWCqgALqlhaSA5KGVBzq6j4EY/PWhQOY1XD9pcvZLYxUNhxov4DFyMgW2MSGCoXD
 lXZPXc5uME73X9tIIGUz/Vz6rSHrfTuHEWXJZJYzvK2f9tS+4SdiSRl37BSB5IOIIC0eWcj
 FOJzMPGFDDuSVEjDtprUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:84xHcT19Ga8=:ZVswujb9SGBXFGlR2p3o2u
 xC1iXP8uOzTVawah7cW56GQOVB+zDWw7CqIB25rtc700k+YjUuwTdbbVKacPc6cu7oeG0Wap5
 KoAdmVezmoNrtddx2aBHrFJOxxvWIpnxggrnnTRW+jy3o/z0px9sLFmogxesx0ZPvS7esZeHE
 YseOyHsnzBOLossfqNGYa6OKX6mPh1700qDPKVSyzXaaAEe6vOSsIVUKDDonOoBS5McU6JJrJ
 D+fM417+uAbUzz+LV442XH5d8BuKSsWA8cEAywbYnNEQLA22irqUAeqjceuRsS6dUxmEeh3Yw
 8DqvutzeC3vd+lyqqb98DB6OJ0Fyrf8qnCGD/i5r+Fk6ch10QERehve2D78fkLpkmPx/fIXFw
 JdWe+29pxmF0jHn/y/b7O/7BFFvYLkcM82EAC42pjIrehDayRCmnUJkSJ0gL6icMjXqfYnLgF
 5pg5xRVzObKa/tEOLvSLLBkix8JPAaFrXeaj8qMzliAAwajAuKTbnoNGXKFsfIskTYTii/DRk
 hsqy6pgrLdC6PK8LrpdfJaHHZ+FdWPzcE+dsmlC7xGMrkGE66WqDqSJxoJEKxMmwtUa9C6I+r
 +Zgl8tBoGVthXjIVAiRMLVrwh5ivzhcW9P6xHlIL69lbRp7p/iwbIp3B6D4Mfj2kXbhL0m62b
 B2tqqAr5aYqzx1s93X4lxJQM+hPmGrMwnJj+VMS/2z8KpUamjxaoTmdBLBVNK2VzsaLt2f8vh
 U9pvwTM4CwbwvC88OLXqZeY6CqxxSTmclhbjlbfgWhhnIN9FJMlu+AgzI8uRmiAdibVXeTyCa
 SX8MwVD37FcWrXFazW0ldo+rfa9YNWwWjMA9U3BzfaiKT3WPzq7WIu98hB/nMi4n6MfkbAzAd
 jSEG/rA4Awt1J9FH0vg1b2OzHUf9ykT1VVTba6Ofl0k0xUmKcJI5IpjNjyIKdnMmwPAPQiJvs
 hO52TXRfP7388IXpZxHLC+exvfAlRnEwOwMVerJY/7K/Ux+3bci9maQ3avUoR0gd6DD1foA96
 ZgiOGdTsRcRobUvwbv+0VMDNugdtvUDxEbOMlNHlEGPiIjSF8aCaKd2YxvyBWfDxkeVolBSUf
 HvBpyz+qEEGAYvpKdZaVa78Wc6d/xdFudvtXN/HJyCgYqYgEFFdHb7VD7DroYfxECnmliPq/D
 RX2UeWHUfTn6s/nqkPaQ0mUV5GrnNFSpTAotpZWXsWR1m54eCj30gjSND36feIGDjUcb1HVa7
 IzEGSBstZyD4QlsfI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

sorry for bumping into this discussion, but this is exactly the feature
I am currently looking for on ARM64. You may browse under
linux-arm-msm@vger.kernel.org for a message I posted there recently.

I read somewhere in this thread that it should be easily portable to
other architectures than x86. I am ready to give it a try, but I would
need a few pointers where to hook in in the ARM64 code.

Thanks and best regards
Andreas

On 10.03.2020 19:33, Mike Kravetz wrote:
> On 3/10/20 11:05 AM, Roman Gushchin wrote:
>> On Tue, Mar 10, 2020 at 10:27:01AM -0700, Mike Kravetz wrote:
>>> On 3/9/20 5:25 PM, Roman Gushchin wrote:
>>>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>>>> index a74262c71484..ceeb06ddfd41 100644
>>>> --- a/arch/x86/kernel/setup.c
>>>> +++ b/arch/x86/kernel/setup.c
>>>> @@ -16,6 +16,7 @@
>>>>  #include <linux/pci.h>
>>>>  #include <linux/root_dev.h>
>>>>  #include <linux/sfi.h>
>>>> +#include <linux/hugetlb.h>
>>>>  #include <linux/tboot.h>
>>>>  #include <linux/usb/xhci-dbgp.h>
>>>>
>>>> @@ -1158,6 +1159,8 @@ void __init setup_arch(char **cmdline_p)
>>>>  	initmem_init();
>>>>  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
>>>>
>>>> +	hugetlb_cma_reserve();
>>>> +
>>>
>>> I know this is called from arch specific code here to fit in with the =
timing
>>> of CMA setup/reservation calls.  However, there really is nothing arch=
itecture
>>> specific about this functionality.  It would be great IMO if we could =
make
>>> this architecture independent.  However, I can not think of a straight=
 forward
>>> way to do this.
>>
>> I agree. Unfortunately I have no better idea than having an arch-depend=
ent hook.
>>
>>>
>>>>  	/*
>>>>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
>>>>  	 * won't consume hotpluggable memory.
>>> <snip>
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> <snip>
>>>> +void __init hugetlb_cma_reserve(void)
>>>> +{
>>>> +	unsigned long totalpages =3D 0;
>>>> +	unsigned long start_pfn, end_pfn;
>>>> +	phys_addr_t size;
>>>> +	int nid, i, res;
>>>> +
>>>> +	if (!hugetlb_cma_size && !hugetlb_cma_percent)
>>>> +		return;
>>>> +
>>>> +	if (hugetlb_cma_percent) {
>>>> +		for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn,
>>>> +				       NULL)
>>>> +			totalpages +=3D end_pfn - start_pfn;
>>>> +
>>>> +		size =3D PAGE_SIZE * (hugetlb_cma_percent * 100 * totalpages) /
>>>> +			10000UL;
>>>> +	} else {
>>>> +		size =3D hugetlb_cma_size;
>>>> +	}
>>>> +
>>>> +	pr_info("hugetlb_cma: reserve %llu, %llu per node\n", size,
>>>> +		size / nr_online_nodes);
>>>> +
>>>> +	size /=3D nr_online_nodes;
>>>> +
>>>> +	for_each_node_state(nid, N_ONLINE) {
>>>> +		unsigned long min_pfn =3D 0, max_pfn =3D 0;
>>>> +
>>>> +		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
>>>> +			if (!min_pfn)
>>>> +				min_pfn =3D start_pfn;
>>>> +			max_pfn =3D end_pfn;
>>>> +		}
>>>> +
>>>> +		res =3D cma_declare_contiguous(PFN_PHYS(min_pfn), size,
>>>> +					     PFN_PHYS(max_pfn), (1UL << 30),
>>>
>>> The alignment is hard coded for x86 gigantic page size.  If this suppo=
rts
>>> more architectures or becomes arch independent we will need to determi=
ne
>>> what this alignment should be.  Perhaps an arch specific call back to =
get
>>> the alignment for gigantic pages.  That will require a little thought =
as
>>> some arch's support multiple gigantic page sizes.
>>
>> Good point!
>> Should we take the biggest possible size as a reference?
>> Or the smallest (larger than MAX_ORDER)?
>
> As mentioned, it is pretty simple for architectures like x86 that only
> have one gigantic page size.  Just a random thought, but since
> hugetlb_cma_reserve is called from arch specific code perhaps the arch
> code could pass in at least alignment as an argument to this function?
> That way we can somewhat push the issue to the architectures.  For examp=
le,
> power supports 16GB gigantic page size but I believe they are allocated
> via firmware somehow.  So, they would not pass 16G as alignment.  In thi=
s
> case setup of the CMA area is somewhat architecture dependent.  So, perh=
aps
> the call from arch specific code is not such a bad idea.
>
> With that in mind, we may want some type of coordination between arch
> specific and independent code.  Right now, cmdline_parse_hugetlb_cma
> is will accept a hugetlb_cma command line option without complaint even
> if the architecture does not call hugetlb_cma_reserve.
>
> Just a nit, but cma_declare_contiguous if going to round up size by alig=
nment.  So, the actual reserved size may not match what is printed with,
> +		pr_info("hugetlb_cma: successfully reserved %llu on node %d\n",
> +			size, nid);
>
> I found this out by testing code and specifying hugetlb_cma=3D2M.  Messa=
ges
> in log were:
> 	kernel: hugetlb_cma: reserve 2097152, 1048576 per node
> 	kernel: hugetlb_cma: successfully reserved 1048576 on node 0
> 	kernel: hugetlb_cma: successfully reserved 1048576 on node 1
> But, it really reserved 1GB per node.
>
