Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98836C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 04:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4074D24681
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 04:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N52PINxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgCJES4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 00:18:56 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:40611 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgCJES4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 00:18:56 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200310041852epoutp04ac770e29c6618248ed178bfcf59a7eda~61mE4-1T73230032300epoutp04_
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 04:18:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200310041852epoutp04ac770e29c6618248ed178bfcf59a7eda~61mE4-1T73230032300epoutp04_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583813932;
        bh=5Mha/f5SVWfw8/Q8Zd5koBn7mDH2Rk3jh+uI3njSA6g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=N52PINxHmueR7WWKlsLWIJDsHvgVE++LuwYn3Hneky+dMHiwfcn0amDDQnICwST/1
         MRT+4+TKsQa+keoZpPC3GazZyear+WchYHqUlqGiWlti3y2DcuCbIunNIVo413VNDh
         j0ZUcBWu0kNCGJvKOY0VUbLeyoxq5pqsRk8yI9vE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200310041851epcas1p1f559a57600d76af8315893532c922817~61mEjVwgq1001210012epcas1p10;
        Tue, 10 Mar 2020 04:18:51 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.165]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48c20B3sCvzMqYkf; Tue, 10 Mar
        2020 04:18:50 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.7E.48498.A25176E5; Tue, 10 Mar 2020 13:18:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200310041850epcas1p204b0a18243ba20692485e8efcb71cb4c~61mDKYJq_2991229912epcas1p2x;
        Tue, 10 Mar 2020 04:18:50 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200310041850epsmtrp1875fa87324f8bb4238b8566dc3a9b34f~61mDJgjvs0674306743epsmtrp1o;
        Tue, 10 Mar 2020 04:18:50 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-ef-5e67152a2d20
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.67.06569.A25176E5; Tue, 10 Mar 2020 13:18:50 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200310041849epsmtip26f4831d229229852a035803625e6c3b2~61mClYaqf1424414244epsmtip2F;
        Tue, 10 Mar 2020 04:18:49 +0000 (GMT)
Subject: Re: [PATCH] mm: mmap: show vm_unmapped_area error log
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, walken@google.com,
        bp@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5E671520.8070700@samsung.com>
Date:   Tue, 10 Mar 2020 13:18:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200309140148.GK31215@bombadil.infradead.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURT1McN0IJY8C8gNcamTuFBTaCnFUcFoRK0BleiHy0dxhLEQuqXT
        EpcYNSoYQFklUEtC0A8XYpNWTMHlo6IoGlyqMdG4EAkoCgYUY4KibQcif+fcd86799z3aELW
        SiXSRWY7bzNzRoaKJm/cTVIqFfEGverzh4Wsy91GsTVVSWyFtwmxgU4Xxb5r+xvJTtYeYSd+
        uai1El2H861E1+Jx6LyXFDrPWK1E96BxgtR5Hx3WffcsyJXsMWYU8lwBb5Pz5nxLQZHZkMlk
        78hbn6dNV6mV6pXsCkZu5kx8JpOVk6vcWGQMzsLISzijI1jK5QSBSVmTYbM47Ly80CLYMxne
        WmC0qlXWZIEzCQ6zITnfYlqlVqlStUHlXmPhx+YvpPXj/AN9zlLqGHqdUI6iaMBp8PjPe7Ic
        RdMy7EPQ0NM5RcYQBNo9ESL5iWCy8WrktCVwZYQSD24jqGq7RYhkGMGp6kkUUsXiNXD/XFfQ
        QdNxeBl8vZ4a0hDYieBOhZ8IaSi8HL611IZvlWIF3Gt0UyFM4sUw9PU7GcLxeBf4mkeRqJkD
        D5v6w/UonAHl472SECbwQjjRfj48BOA3FDzp/kSIo2aBq749QsSxMNR9XSLiRPhcVSoRDScQ
        DDd5kUhOInjrOYNElQbOVD4lQhEInATuzhSxvAg6JpqR2DkGRsYrwykBS+F0qUyULIGTA+NT
        65oHfyYHprAOfN6eqdW1kTDaUEZUI7lzRjjnjEDO/51bEHEFzeWtgsnAC2pr6sxH9qDw/1Sk
        +1Brb44fYRoxs6V4+X69LJIrEQ6a/AhogomTHlfk62XSAu7gId5mybM5jLzgR9rgvmuIxPh8
        S/C3m+15am2qRqNh09JXpGs1TIK0b3eSXoYNnJ0v5nkrb5v2RdBRicdQipvWbLl7w/W7rEtp
        i85+Ndhxvm+zftOPR4efbWga4gLUzc3qwXU9+56vJtL+xpF8nVBtzNp5dLS/8UvFUl9vzba4
        /otoNPfsrJGXgcy6OyM+R8aHmMspXWP1L25a1mrLiJiWrcWRlfSzkk/be+dea31R1jk0rBdi
        DX6Hxv30wk6GFAo5tYKwCdw/8ekRtLUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvK6WaHqcQetqdos569ewWUzs17To
        3jyT0eLyrjlsFvfW/Ge1+Dep1uL3jzlsDuweO2fdZfdYsKnUY/MKLY9Nnyaxe5yY8ZvFY/Pp
        ao/Pm+QC2KO4bFJSczLLUov07RK4Mh7Pfc1S8Fi24uGsNrYGxlviXYycHBICJhKXV71j62Lk
        4hAS2M0o0XppLRNEQkbizfmnLF2MHEC2sMThw8UgYSGB14wSB44ygtjCAnYSx6YeYQUpERHQ
        kHizxQhizBoWiav7prKC1DALzGCUOLLQGcRmE9CWeL9gElicV0BL4uiM9WwgNouAqsSrN59Z
        QGxRgQiJ1euuMUPUCEqcnPkELM4pYCPR9fUcO8RMdYk/8y4xQ9jyEs1bZzNPYBSchaRlFpKy
        WUjKFjAyr2KUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI4GLa0djCdOxB9iFOBgVOLh
        FdROixNiTSwrrsw9xCjBwawkwtuolRwnxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc+/1ikkEB6
        YklqdmpqQWoRTJaJg1OqgZHB2qFN7HOetfHWeI9EF+6/kw8I/ul0NlwdL686bZNQk2riarHX
        keYxBy4fr2Y5xDzB68wNncnMJ5oXPEo8rshg41PvnZ2i1yRzdM6NLm4p1/MvJ2+rfRdxvfZL
        vbHFtU3HPlgeYt29ZmJvv7Sye+z9+F1OKr+iRFKUc/+FL9Dym7C+3uXEHCWW4oxEQy3mouJE
        ANzrOTeCAgAA
X-CMS-MailID: 20200310041850epcas1p204b0a18243ba20692485e8efcb71cb4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4
References: <CGME20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4@epcas1p4.samsung.com>
        <20200304030206.1706-1-jaewon31.kim@samsung.com>
        <5E605749.9050509@samsung.com>
        <20200305202443.8de3598558336b1d75afbba7@linux-foundation.org>
        <5E61EAB6.5080609@samsung.com>
        <20200307154744.acd523831b45efa8d0fc1dfa@linux-foundation.org>
        <20200308015802.GD31215@bombadil.infradead.org>
        <5E64C1D7.3000208@samsung.com>
        <20200308123616.GH31215@bombadil.infradead.org>
        <5E660863.2090104@samsung.com>
        <20200309140148.GK31215@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 03월 09일 23:01, Matthew Wilcox wrote:
> On Mon, Mar 09, 2020 at 06:12:03PM +0900, Jaewon Kim wrote:
>> On 2020년 03월 08일 21:36, Matthew Wilcox wrote:
>>> On Sun, Mar 08, 2020 at 06:58:47PM +0900, Jaewon Kim wrote:
>>>> On 2020년 03월 08일 10:58, Matthew Wilcox wrote:
>>>>> On Sat, Mar 07, 2020 at 03:47:44PM -0800, Andrew Morton wrote:
>>>>>> On Fri, 6 Mar 2020 15:16:22 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:
>>>>>>> Even on 64 bit kernel, the mmap failure can happen for a 32 bit task.
>>>>>>> Virtual memory space shortage of a task on mmap is reported to userspace
>>>>>>> as -ENOMEM. It can be confused as physical memory shortage of overall
>>>>>>> system.
>>>>> But userspace can trigger this printk.  We don't usually allow printks
>>>>> under those circumstances, even ratelimited.
>>>> Hello thank you your comment.
>>>>
>>>> Yes, userspace can trigger printk, but this was useful for to know why
>>>> a userspace task was crashed. There seems to be still many userspace
>>>> applications which did not check error of mmap and access invalid address.
>>>>
>>>> Additionally in my AARCH64 Android environment, display driver tries to
>>>> get userspace address to map its display memory. The display driver
>>>> report -ENOMEM from vm_unmapped_area and but also from GPU related
>>>> address space.
>>>>
>>>> Please let me know your comment again if this debug is now allowed
>>>> in that userspace triggered perspective.
>>> The scenario that worries us is an attacker being able to fill the log
>>> files and so also fill (eg) the /var partition.  Once it's full, future
>>> kernel messages cannot be stored anywhere and so there will be no traces
>>> of their privilege escalation.
>> Although up to 10 times within 5 secs is not many, I think those log may remove
>> other important log in log buffer if it is the system which produces very few log.
>> In my Android phone device system, there seems to be much more kernel log though.
> I've never seen the logs on my android phone.  All that a ratelimit is
> going to do is make the attacker be more patient.
>
>>> Maybe a tracepoint would be a better idea?  Usually they are disabled,
>>> but they can be enabled by a sysadmin to gain insight into why an
>>> application is crashing.
>> In Android phone device system, we cannot get sysadmin permission if it is built
>> for end user. And it is not easy to reproduce this symptom because it is an user's app.
>>
>> Anyway let me try pr_devel_ratelimited which is disabled by default. I hope this is
>> good enough. Additionally I moved the code from mm.h to mmap.c.
> https://source.android.com/devices/tech/debug/ftrace
I am not sure if an end user can enable a trace point which is not writable.
Anyway I created trace mmap.h file and changed printk to trace_vm_unmapped_area
without ratelimited.

If there is no objection, I am going to resubmit whole patch as v2.
Thank you for your comment.

--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -47,6 +47,8 @@
 #include <linux/pkeys.h>
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/mmap.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -2061,10 +2063,15 @@ unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
  */
 unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
 {
+       unsigned long addr;
+
        if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
-               return unmapped_area_topdown(info);
+               addr = unmapped_area_topdown(info);
        else
-               return unmapped_area(info);
+               addr = unmapped_area(info);
+
+       trace_vm_unmapped_area(addr, info);
+       return addr;
 }

>

