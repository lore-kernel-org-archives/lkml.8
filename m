Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349E7C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC538206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u+gfPm+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgCMEj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 00:39:27 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:46387 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgCMEj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 00:39:26 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200313043923epoutp04e7196ab85d1f249f409b6717669d3c90~7wz23Rdis1524015240epoutp04i
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 04:39:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200313043923epoutp04e7196ab85d1f249f409b6717669d3c90~7wz23Rdis1524015240epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584074363;
        bh=v6r4BUQaJ3xXd6EYWNNxfOhW2h7BdAHlbj5DlJaTm7k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=u+gfPm+LB4ZBytdbJIbp03DOPmEsa0V4szTatMh+OGfBgWhS6TGXlFRUxjfIO+y6E
         zTCiPFEJHwzo3kQ9UT57k5kvB2AkitrzJOUx5SQ1Dr/oY6rFsHd8f0W/8eknC0I9TA
         ZBCZbRxJQb5t7aw9lmC8wv7HCuzRhAUAQHZphXyE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200313043923epcas1p3fb9b3b974760ce2b159531276b356dae~7wz2ejdqZ2220422204epcas1p3B;
        Fri, 13 Mar 2020 04:39:23 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.161]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48dtJV34h7zMqYkj; Fri, 13 Mar
        2020 04:39:22 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.3B.51241.A7E0B6E5; Fri, 13 Mar 2020 13:39:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200313043921epcas1p2ac0409f87cb53825ee30ea0f53d5ca80~7wz1JEtAu2834228342epcas1p2p;
        Fri, 13 Mar 2020 04:39:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200313043921epsmtrp2ffc8db3f6e2a08191883cc1b991288b2~7wz1ISogs1081510815epsmtrp2s;
        Fri, 13 Mar 2020 04:39:21 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-56-5e6b0e7a8211
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.C9.06963.97E0B6E5; Fri, 13 Mar 2020 13:39:21 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200313043920epsmtip1140f9ee444857f5e308c601b276dfd5a~7wzz_Nj6g2619526195epsmtip1c;
        Fri, 13 Mar 2020 04:39:20 +0000 (GMT)
Subject: Re: [RFC PATCH 0/3] meminfo: introduce extra meminfo
To:     Leon Romanovsky <leon@kernel.org>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E6B0E72.7010305@samsung.com>
Date:   Fri, 13 Mar 2020 13:39:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200311072509.GH4215@unreal>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfWwLYRj39trrDZ3TTb1ZhDohMfvoqc6ZbSSbuSCxICH+WN22Szv6lV7L
        SIitizDmYya0hiZCbBmb1mjZmEnYLES2TCRU4msMW+lUZj7m2qvYf7/nfX6/5/c8z/u+GCK/
        gyZhpSYbazUxBgKdKL5+b35a6q74bYWqlt5E6mT5KqquqRGlDnqdgKpvHRFRtaMXEKr3Zh1K
        vWwck1AXw0Ep1VzpklKvj9aIqIeBYenySbTfFZDSnoYDKO0J1UjpF09bUbrz1E8xHbzdh9L+
        kFdCD3tmFmCbDVl6lilhrUrWVGwuKTXpsonV67W5Wk2Gikwll1CLCaWJMbLZRN6agtT8UgPf
        KKHczhjs/FEBw3FEek6W1Wy3sUq9mbNlE6ylxGAhVZY0jjFydpMurdhszCRVqoUanrnFoHc+
        d0gtFQll4fflor3AO6UKxGEQXwRHKxokVWAiJsd9ADqG2kVCEALwma9FLATfAbwxcEL6T+Jw
        nUKERBuAlce/xSSDAHY33xNFWAl4NhwYa0ciOBGfC+vdgagJgv8A8FzQCSIJFF8Ag+4aSQTL
        8GR4/6o7KhbzAm/tYJQzDd8EfWe+AoEzFXY534ojOC6i7QhHW0LwWdDRcjraEsQdUnj+8nu+
        EMYHebDulU5oOwF+fHAtNkISHB5qQ2N8AAedXiAElQAGPNVAYKlh9aEnSKQQgs+HTTfThePZ
        0P/zDBCM4+FQ+JBE8JLB/fvkAmUerOwPSwQ8A/7+0x/DNLz1pTe2bQ+/4KYe5ChQusbN5ho3
        j+u/sxsgDUDBWjijjuVIi2b8JXtA9PEmL/GB+4/XdAAcA8RkmUqxtVAuYbZzO40dAGIIkSjT
        ztIVymUlzM5drNWstdoNLNcBNPy6jyFJ04rN/Fcw2bSkZqFaraYWZSzO0KiJ6bKiEF8H1zE2
        dhvLWljrP50Ii0vaC5Z+7lsWqj6SU0bBkevuEM6MnKXe2asCnrZHK3cMkLPjuz/pavOm+Afy
        +0n5A4Uj/W47Fc78cHV0zuQ313K5zj3+7hWK+sNPT2a53M0pXT01G+zB1fnBVklXkbYxJXf3
        I3rUdqWvM++4b8W6uWsP3Pi1UZF66ZVIO/R8gqVan7OSEHN6hkxGrBzzF2jx19HSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTreSLzvOYOI8I4vpjV4Wc9avYbPo
        3jyT0WLlnh9MFlN+LWW2uLxrDpvFvTX/WS2WfX3PbrGhZRa7xaMJk5gsTt39zO7A7bFz1l12
        j02rOtk8Nn2axO5x59oeNo8TM36zeLzfd5XNY+enzawenzfJBXBEcdmkpOZklqUW6dslcGXM
        vN3MXtAkXPH1eSNTA+Nm/i5GTg4JAROJ5lkzmLsYuTiEBHYzSlx6u4MFIiEj8eb8UyCbA8gW
        ljh8uBii5jWjxI+mPkaQGmEBW4mX/w8wg9giAqoSKxfcZQWxhQQ2MUq8W8IF0sAs8BNo6OJ+
        sKFsAtoS7xdMAiviFdCSOLZxAROIzQLUvHnKW7ChogIREqvXXWOGqBGUODnzCVgvJ0jvoa/s
        IAcxC6hLrJ8nBBJmFpCXaN46m3kCo+AsJB2zEKpmIalawMi8ilEytaA4Nz232LDAMC+1XK84
        Mbe4NC9dLzk/dxMjOI60NHcwXl4Sf4hRgINRiYfXQCwrTog1say4MvcQowQHs5IIb7x8epwQ
        b0piZVVqUX58UWlOavEhRmkOFiVx3qd5xyKFBNITS1KzU1MLUotgskwcnFINjKrtfP6iRQFc
        38NZnCun3v4myvfkn9/5bUlVa9cET58mueTC+kfX647Ii/5a3nZ2t6a4k88OH/azM1izmdYy
        7hKVY54Yv/HC2Yy9e5s9fsb9M3aIE2j84j5nS7oHu8fDyeVc/UpnWjbwq2hy+sb+PuqvePz2
        /jmGDXzzVx+SW+yatUJ3QZtEqBJLcUaioRZzUXEiAH5QI6+fAgAA
X-CMS-MailID: 20200313043921epcas1p2ac0409f87cb53825ee30ea0f53d5ca80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200311034454epcas1p2ef0c0081971dd82282583559398e58b2
References: <CGME20200311034454epcas1p2ef0c0081971dd82282583559398e58b2@epcas1p2.samsung.com>
        <20200311034441.23243-1-jaewon31.kim@samsung.com>
        <20200311072509.GH4215@unreal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 03월 11일 16:25, Leon Romanovsky wrote:
> On Wed, Mar 11, 2020 at 12:44:38PM +0900, Jaewon Kim wrote:
>> /proc/meminfo or show_free_areas does not show full system wide memory
>> usage status. There seems to be huge hidden memory especially on
>> embedded Android system. Because it usually have some HW IP which do not
>> have internal memory and use common DRAM memory.
>>
>> In Android system, most of those hidden memory seems to be vmalloc pages
>> , ion system heap memory, graphics memory, and memory for DRAM based
>> compressed swap storage. They may be shown in other node but it seems to
>> useful if /proc/meminfo shows all those extra memory information. And
>> show_mem also need to print the info in oom situation.
>>
>> Fortunately vmalloc pages is alread shown by commit 97105f0ab7b8
>> ("mm: vmalloc: show number of vmalloc pages in /proc/meminfo"). Swap
>> memory using zsmalloc can be seen through vmstat by commit 91537fee0013
>> ("mm: add NR_ZSMALLOC to vmstat") but not on /proc/meminfo.
>>
>> Memory usage of specific driver can be various so that showing the usage
>> through upstream meminfo.c is not easy. To print the extra memory usage
>> of a driver, introduce following APIs. Each driver needs to count as
>> atomic_long_t.
>>
>> int register_extra_meminfo(atomic_long_t *val, int shift,
>> 			   const char *name);
>> int unregister_extra_meminfo(atomic_long_t *val);
>>
>> Currently register ION system heap allocator and zsmalloc pages.
>> Additionally tested on local graphics driver.
>>
>> i.e) cat /proc/meminfo | tail -3
>> IonSystemHeap:    242620 kB
>> ZsPages:          203860 kB
>> GraphicDriver:    196576 kB
>>
>> i.e.) show_mem on oom
>> <6>[  420.856428]  Mem-Info:
>> <6>[  420.856433]  IonSystemHeap:32813kB ZsPages:44114kB GraphicDriver::13091kB
>> <6>[  420.856450]  active_anon:957205 inactive_anon:159383 isolated_anon:0
> The idea is nice and helpful, but I'm sure that the interface will be abused
> almost immediately. I expect that every driver will register to such API.
>
> First it will be done by "large" drivers and after that everyone will copy/paste.
I thought using it is up to driver developers.
If it is abused, /proc/meminfo will show too much info. for that device.
What about a new node, /proc/meminfo_extra, to gather those info. and not
corrupting original /proc/meminfo.

Thank you
> Thanks
>
>

