Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C71C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681AE2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NBWF02fE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgHNTWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHNTWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 15:22:54 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9842DC061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 12:22:53 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id bo3so11020179ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 12:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oiNMm6FF5XKaj0T6wdRHFF4cYaSW0F3pSaRh9jzk7hI=;
        b=NBWF02fE5aok65sYlsKAguAGBhIi0yOEDEIpAg4NnCiZlfpKo/Bo5H+uqcf1vrmTbl
         cDy1oMclgrqlYE3VkShRO7PrfvXP3mqoExvqqQG7Kho6LXqxRAEAJ7LHZJPYH1IgmoXO
         b4oSo5jRdCJgwsDViQFNMltfaUj0s49jkYPglpXhGd1NdFtIlxJoVR97WT+j0Rc7ucId
         xO654p4Wf0SlwJKJTx5GfM27NPlWVuTdH9WEupRKwU49LpvAM9mdtjzNU7LMkDlRuRZ6
         dB0Q4Vj/MvUqnFDdaT1jua9Ei+QuO5E/mVdnh75I4Fsk6RhR20r/pI6wIGT7qS5hlnJJ
         F1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oiNMm6FF5XKaj0T6wdRHFF4cYaSW0F3pSaRh9jzk7hI=;
        b=jDKGzUjyVrOVPpb4q9u+p4m2WpWzvb/cwtVAa/lv5JdGr+3ugrlpy4MXTUSkv3qiVT
         E4N/WMo4GfZlAt64QP3kE5nQbMyCptqrapsXGtakro4XHU54IRy7SJIzGkK2gyFOQ68m
         RE/qBCA0pmPlYtXewWwR4+NCjOzM4QEJlsqabunvvxh0ZSUl1eaEVPmAc1+Heg2SIXti
         UvezXf9xOO/r7Z6P9Aq6ZPS+YJT9dxgZj//k7vNOUdF4FAYmb4e7/jIH1U1fiET6UFn2
         vJukvP8JJThQF67JVMefkRdqeFzZttCOIgR16W6IiCGFZ1ZcMJjYG0wvoR1Qh7ap8eNE
         iolA==
X-Gm-Message-State: AOAM532qsLjqAylHliVB9Z5crZmLC8jndg3jwuCaZmzidFzLoi/aDkmq
        12QvEZTK7cAW/ZBDBZRsN8mPyM3fpeFLu0urIBAD0Q==
X-Google-Smtp-Source: ABdhPJy1LGMGslwbxEbeZovOCWCkPEUxGJyJQFGFqxsDCl1xJrR6njxAdcpGXUNR23cjEUtboIPf0+SnLxFncrZKNbQ=
X-Received: by 2002:a17:907:11d0:: with SMTP id va16mr4031828ejb.426.1597432972238;
 Fri, 14 Aug 2020 12:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200814055239.47348-1-sangyan@huawei.com> <20200814065845.GA18234@dhcp-128-65.nay.redhat.com>
 <ad098e21-d689-f655-1e32-c93adcf0cb2d@huawei.com> <20200814112413.GA8097@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20200814112413.GA8097@dhcp-128-65.nay.redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 14 Aug 2020 15:22:16 -0400
Message-ID: <CA+CK2bDG9mzzpLhyQS=MiyNNcYsUdV=VQt9LufL7VrqKH8cK_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] kexec: Add quick kexec support for kernel
To:     Dave Young <dyoung@redhat.com>
Cc:     Sang Yan <sangyan@huawei.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>, xiexiuqi@huawei.com,
        guohanjun@huawei.com, luanjianhai@huawei.com, zhuling8@huawei.com,
        luchunhua@huawei.com, James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 7:24 AM Dave Young <dyoung@redhat.com> wrote:
>
> Hi,
>
> On 08/14/20 at 04:21pm, Sang Yan wrote:
> >
> >
> > On 08/14/20 14:58, Dave Young wrote:
> > > On 08/14/20 at 01:52am, Sang Yan wrote:
> > >> In normal kexec, relocating kernel may cost 5 ~ 10 seconds, to
> > >> copy all segments from vmalloced memory to kernel boot memory,
> > >> because of disabled mmu.
> > >
> > > It is not the case on all archs, I assume your case is arm64, please
> > > describe it in patch log :)
> > >
> > Yes, it's particularly obvious on arm64. I will add it to the patch log,
> > and test how long it takes on x86 and other arch.
> >
> > > About the arm64 problem, I know Pavel Tatashin is working on a patchset
> > > to improve the performance with enabling mmu.
> > >
> > > I added Pavel in cc, can you try his patches?
> > >
> > Thanks for your tips, I will try these patches. @Pavel.
> > Disable mmu after finishing copying pages?
> > >>
> > >> We introduce quick kexec to save time of copying memory as above,
> > >> just like kdump(kexec on crash), by using reserved memory
> > >> "Quick Kexec".
> > >
> > > This approach may have gain, but it also introduce extra requirements to
> > > pre-reserve a memory region.  I wonder how Eric thinks about the idea.
> > >
> > > Anyway the "quick" name sounds not very good, I would suggest do not
> > > introduce a new param, and the code can check if pre-reserved region
> > > exist then use it, if not then fallback to old way.
> > >
> > aha. I agree with it, but I thought it may change the old behaviors of
> > kexec_load.
> >
> > I will update a new patch without introducing new flags and new params.
>
> Frankly I'm still not sure it is worth to introduce a new interface if the
> improvement can be done in arch code like Pavel is doing.  Can you try
> that first?

Hi Dave,

Thank you for including me into this discussion.

My patches will fix this issue. This is an ARM64 specific problem and
I did not see this to be performance problem on x86 during kexec
relocation. This happens because on ARM64 relocation is performed with
MMU disabled, and when MMU is disabled the caching is disabled as
well.

I have a patch series that fixes this entirely, but James Morse
(+CCed) and I still have not agreed on the final approach. We had an
off-list conversation about it, and we need to continue it in public
ML.

Here is some history:

This is the original series that I sent a year ago. It basically
proposes the same thing as this series from Sang Yan:
https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com/

Once, I realized that with enabling MMU the relocation is issue is
gone completely, I sent a new series, and this is the latest version
of that series:
https://lore.kernel.org/lkml/20200326032420.27220-1-pasha.tatashin@soleen.com/

It has been tested in production, and several people from different
companies commented to me that they are using it as well.

After my patch series was sent out, James created a new branch in his
tree with his approach of enabling MMU without having a new VA space,
but instead re-use what the kernel  has now. I have not tested that
branch yet.

Here are some comments from James Morse and the off-list discussion we had:
-------
It sounds like you are depending on write streaming mode to meet your
target performance.
This isn't even CPU specific, its cache and firmware configuration specific!
I don't think we should optimise a general purpose operating system
based on things like this.
..
I think the best approach is going to be to eliminate the relocations entirely.
...
I'm afraid I view this kexec-map thing as high-risk duct-tape over the
kexec core code
deliberately scattering the kexec payload.
I'd prefer any approach that causes the payload to be stored in-place
from the beginning
as that benefits other architectures too.
-------

It appears James is leaning to the approach of not performing
relocation at all and use what is proposed by Sang Yan and me during
my first approach for this problem. However, I have several issues
with this take, which if addressed would be OK for me.
1. The newer, more secure kexec syscall kexec_file_load(), which
allows to check the IMA integrity of the loaded file does not have a
way to specify the area in memory where to place the kernel. We are
using this syscall in production, and cannot go back to kexec_load()
for security reasons.
2. Reserving memory means wasting memory during run-time. Our machine
has only 8G of RAM, and reserving even 128M for the next kernel is an
expensive proposition. Now we start loading the next kernel after some
non essential processes are stopped, but before essential processes
are stopped for the lowest downtime possible.
3. Disabling relocation means changes in the common code, which I am
not sure actually helps any other platform beside ARM64, so I am
worried it won't be accepted into upstream.

Thank you,
Pasha
