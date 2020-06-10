Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3E4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB94206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WeB/IASB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgFJQtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgFJQto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:49:44 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A29BC03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 09:49:44 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d7so1840640lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=91n3/Zl9eLHHH5qIw3vnPWPSc0rFiBL6Qnqh8RW28VM=;
        b=WeB/IASBAmThwXzK2oTtBvqWprtOfGeXH+riXG/DfFGVe6+jGpcj9sKI97hrAmf8X5
         FdqSEJJndQlfJojZe1IJEMD6koy/GdH9p37fB1JD8bz5sJ8awhnfcnKZnX6YwM729L7N
         tQ9zSh4N/FKvn7BIihcEjGBfW4lhXWSBQflx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=91n3/Zl9eLHHH5qIw3vnPWPSc0rFiBL6Qnqh8RW28VM=;
        b=nstkxJfJHx1mZvRfNSOD4pL5ZqQvoqM2qNKjnhxn81lP+HFKA1YCIV7qsLNGdMmhZ5
         3G+o2lExba4SvH15PQRVxUvH13yz9qKnU4HTA2koLOHrMxcY5j9v9vAWLpNhPuakyd/4
         QA2nUS/X8+BKR0Q+RwE5CaVHJQQk/ZNxA0pP0qN8YT4rq1mD3BASH6OqtBOK+GbQhRet
         UZCJVVeDTI5vP3IrCrGB/MoBhulO2K6ehITSrBNGVh0fOxaaLP0SkeJrkmyGGXQdKZbP
         Q1bNeEwoO4YlDhbn0E8ybdKUTv2izKu1mxy1CZUf4xtDvnd4FenP/sAFqoFfcwvA43cK
         62oA==
X-Gm-Message-State: AOAM532d5W6DddKqO7fGEmq5tg8WwwPmi71wDNhuqQGCuDjo6yxZA9Cx
        ntYzQGSYku31HzmjEIbthPtR1KncMD6mCgwobDwpgw==
X-Google-Smtp-Source: ABdhPJzjDdNu+vWCgQ02I2W89ieHop/hf2pH7D+LXZz0azQiY1HeTCeyqmrjp37878ajgSWGVFawehOf8nD0kbTJq7M=
X-Received: by 2002:a05:6512:20d:: with SMTP id a13mr2227655lfo.36.1591807782586;
 Wed, 10 Jun 2020 09:49:42 -0700 (PDT)
From:   Bharat Gooty <bharat.gooty@broadcom.com>
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
 <1575057559-25496-3-git-send-email-bhsharma@redhat.com> <63d6e63c-7218-d2dd-8767-4464be83603f@arm.com>
 <af0fd2b0-99db-9d58-bc8d-0dd9d640b1eb@redhat.com> <f791e777-781c-86ce-7619-1de3fe3e7b90@arm.com>
 <351975548.1986001.1578682810951.JavaMail.zimbra@redhat.com>
 <04287d60-e99e-631b-c134-d6dc39e6a193@redhat.com> <974f3601-25f8-f4e6-43a8-ff4275e9c174@arm.com>
 <CACi5LpOK6Q3ud3M3zakexLJNOtHy9TODHyYSHVwE3JHVakKzqA@mail.gmail.com>
 <d401b003-af3e-c525-ba00-0de48486b7a0@broadcom.com> f644ddb6fdb926606bb376a9f491ee79@mail.gmail.com
In-Reply-To: f644ddb6fdb926606bb376a9f491ee79@mail.gmail.com
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGa98r5q5qEPCZDE5DL4GJrrz9qcAGNQyRgApgGah0B/ao0mwIUlx9FAsYr/NkBJYrXxQK1AqgNAhb3920BQkNqpai3DgCQgAAEa2A=
Date:   Wed, 10 Jun 2020 22:19:40 +0530
Message-ID: <2fd8e2d3f2805aca00cb1bd3d7b40839@mail.gmail.com>
Subject: RE: Re: [RESEND PATCH v5 2/5] arm64/crash_core: Export TCR_EL1.T1SZ
 in vmcoreinfo
To:     Scott Branden <scott.branden@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Amit Kachhap <amit.kachhap@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        Will Deacon <will@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        James Morse <james.morse@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        bhupesh linux <bhupesh.linux@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Steve Capper <steve.capper@arm.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Bharat Gooty <bharat.gooty@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, error message was not posted. Following is the error message

crash: cannot determine VA_BITS_ACTUAL

-----Original Message-----
From: Bharat Gooty [mailto:bharat.gooty@broadcom.com]
Sent: Wednesday, June 10, 2020 10:18 PM
To: Scott Branden; 'Bhupesh Sharma'; 'Amit Kachhap'
Cc: 'Mark Rutland'; 'x86@kernel.org'; 'Will Deacon'; 'Linux Doc Mailing
List'; 'Catalin Marinas'; 'Ard Biesheuvel'; 'kexec mailing list'; 'Linux
Kernel Mailing List'; 'Kazuhito Hagio'; 'James Morse'; 'Dave Anderson';
'bhupesh linux'; 'linuxppc-dev@lists.ozlabs.org'; 'linux-arm-kernel'; 'Steve
Capper'; Ray Jui
Subject: RE: Re: [RESEND PATCH v5 2/5] arm64/crash_core: Export TCR_EL1.T1SZ
in vmcoreinfo

Hello Bhupesh,
V6 patch set on Linux 5.7, did not help.
I have applied makedump file
http://lists.infradead.org/pipermail/kexec/2019-November/023963.html changes
also (makedump-1.6.6). Tried to apply it on makedumpfile 1.6.7.  Patch set_2
failed. Would like to know, if you have V5 patch set for makedump file
changes. With makedump 1.6.6, able to collect the vmore file.
I used latest crash utility
(https://www.redhat.com/archives/crash-utility/2019-November/msg00014.html
changes are present)
When I used crash utility, following is the error:

Thanks,
-Bharat


-----Original Message-----
From: Scott Branden [mailto:scott.branden@broadcom.com]
Sent: Thursday, April 30, 2020 4:34 AM
To: Bhupesh Sharma; Amit Kachhap
Cc: Mark Rutland; x86@kernel.org; Will Deacon; Linux Doc Mailing List;
Catalin Marinas; Ard Biesheuvel; kexec mailing list; Linux Kernel Mailing
List; Kazuhito Hagio; James Morse; Dave Anderson; bhupesh linux;
linuxppc-dev@lists.ozlabs.org; linux-arm-kernel; Steve Capper; Ray Jui;
Bharat Gooty
Subject: Re: Re: [RESEND PATCH v5 2/5] arm64/crash_core: Export TCR_EL1.T1SZ
in vmcoreinfo

Hi Bhupesh,

On 2020-02-23 10:25 p.m., Bhupesh Sharma wrote:
> Hi Amit,
>
> On Fri, Feb 21, 2020 at 2:36 PM Amit Kachhap <amit.kachhap@arm.com> wrote:
>> Hi Bhupesh,
>>
>> On 1/13/20 5:44 PM, Bhupesh Sharma wrote:
>>> Hi James,
>>>
>>> On 01/11/2020 12:30 AM, Dave Anderson wrote:
>>>> ----- Original Message -----
>>>>> Hi Bhupesh,
>>>>>
>>>>> On 25/12/2019 19:01, Bhupesh Sharma wrote:
>>>>>> On 12/12/2019 04:02 PM, James Morse wrote:
>>>>>>> On 29/11/2019 19:59, Bhupesh Sharma wrote:
>>>>>>>> vabits_actual variable on arm64 indicates the actual VA space size,
>>>>>>>> and allows a single binary to support both 48-bit and 52-bit VA
>>>>>>>> spaces.
>>>>>>>>
>>>>>>>> If the ARMv8.2-LVA optional feature is present, and we are running
>>>>>>>> with a 64KB page size; then it is possible to use 52-bits of
>>>>>>>> address
>>>>>>>> space for both userspace and kernel addresses. However, any kernel
>>>>>>>> binary that supports 52-bit must also be able to fall back to
>>>>>>>> 48-bit
>>>>>>>> at early boot time if the hardware feature is not present.
>>>>>>>>
>>>>>>>> Since TCR_EL1.T1SZ indicates the size offset of the memory region
>>>>>>>> addressed by TTBR1_EL1 (and hence can be used for determining the
>>>>>>>> vabits_actual value) it makes more sense to export the same in
>>>>>>>> vmcoreinfo rather than vabits_actual variable, as the name of the
>>>>>>>> variable can change in future kernel versions, but the
>>>>>>>> architectural
>>>>>>>> constructs like TCR_EL1.T1SZ can be used better to indicate
>>>>>>>> intended
>>>>>>>> specific fields to user-space.
>>>>>>>>
>>>>>>>> User-space utilities like makedumpfile and crash-utility, need to
>>>>>>>> read/write this value from/to vmcoreinfo
>>>>>>> (write?)
>>>>>> Yes, also write so that the vmcoreinfo from an (crashing) arm64
>>>>>> system can
>>>>>> be used for
>>>>>> analysis of the root-cause of panic/crash on say an x86_64 host using
>>>>>> utilities like
>>>>>> crash-utility/gdb.
>>>>> I read this as as "User-space [...] needs to write to vmcoreinfo".
>>> That's correct. But for writing to vmcore dump in the kdump kernel, we
>>> need to read the symbols from the vmcoreinfo in the primary kernel.
>>>
>>>>>>>> for determining if a virtual address lies in the linear map range.
>>>>>>> I think this is a fragile example. The debugger shouldn't need to
>>>>>>> know
>>>>>>> this.
>>>>>> Well that the current user-space utility design, so I am not sure we
>>>>>> can
>>>>>> tweak that too much.
>>>>>>
>>>>>>>> The user-space computation for determining whether an address lies
>>>>>>>> in
>>>>>>>> the linear map range is the same as we have in kernel-space:
>>>>>>>>
>>>>>>>>      #define __is_lm_address(addr)    (!(((u64)addr) &
>>>>>>>> BIT(vabits_actual -
>>>>>>>>      1)))
>>>>>>> This was changed with 14c127c957c1 ("arm64: mm: Flip kernel VA
>>>>>>> space"). If
>>>>>>> user-space
>>>>>>> tools rely on 'knowing' the kernel memory layout, they must have to
>>>>>>> constantly be fixed
>>>>>>> and updated. This is a poor argument for adding this to something
>>>>>>> that
>>>>>>> ends up as ABI.
>>>>>> See above. The user-space has to rely on some ABI/guaranteed
>>>>>> hardware-symbols which can be
>>>>>> used for 'determining' the kernel memory layout.
>>>>> I disagree. Everything and anything in the kernel will change. The
>>>>> ABI rules apply to
>>>>> stuff exposed via syscalls and kernel filesystems. It does not apply
>>>>> to kernel internals,
>>>>> like the memory layout we used yesterday. 14c127c957c1 is a case in
>>>>> point.
>>>>>
>>>>> A debugger trying to rely on this sort of thing would have to play
>>>>> catchup whenever it
>>>>> changes.
>>>> Exactly.  That's the whole point.
>>>>
>>>> The crash utility and makedumpfile are not in the same league as other
>>>> user-space tools.
>>>> They have always had to "play catchup" precisely because they depend
>>>> upon kernel internals,
>>>> which constantly change.
>>> I agree with you and DaveA here. Software user-space debuggers are
>>> dependent on kernel internals (which can change from time-to-time) and
>>> will have to play catch-up (which has been the case since the very
>>> start).
>>>
>>> Unfortunately we don't have any clear ABI for software debugging tools -
>>> may be something to look for in future.
>>>
>>> A case in point is gdb/kgdb, which still needs to run with KASLR
>>> turned-off (nokaslr) for debugging, as it confuses gdb which resolve
>>> kernel symbol address from symbol table of vmlinux. But we can
>>> work-around the same in makedumpfile/crash by reading the 'kaslr_offset'
>>> value. And I have several users telling me now they cannot use gdb on
>>> KASLR enabled kernel to debug panics, but can makedumpfile + crash
>>> combination to achieve the same.
>>>
>>> So, we should be looking to fix these utilities which are broken since
>>> the 52-bit changes for arm64. Accordingly, I will try to send the v6
>>> soon while incorporating the comments posted on the v5.
>> Any update on the next v6 version. Since this patch series is fixing the
>> current broken kdump so need this series to add some more fields in
>> vmcoreinfo for Pointer Authentication work.
> Sorry for the delay. I was caught up in some other urgent arm64
> user-space issues.
> I am preparing the v6 now and hopefully will be able to post it out
> for review later today.

Did v6 get sent out?

>
> Thanks,
> Bhupesh
>
>
Regards,
Scott
