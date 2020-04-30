Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0064C47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B7520731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vVUQtbBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgD3Tvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgD3Tvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:51:50 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C43C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:51:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d16so5553393edv.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+FwAVJSyrEXzkxSrmCS02v7oMdKUwO+F0o4wshx4Ek=;
        b=vVUQtbBBW2Z6/5fnVMc/CHaP+nmdWUZ9QxTg9U+zXdocuJvECmz2ZYNIGKPPz6wnQ8
         Y/blY8yPzeccGFk3m1sEppcnDb2DSh0FgHkCsa362EpoiStkcCEFl/jvgV3GTQCJGqIR
         1F5ZNP+5RAyCH89lA/zS+VK58cK0uw0HhqVN63Enq4YTlK6yQyXV4DIfnL10P+OqgGw/
         HCg5266Eh5MmmWWOvAC6lE6/rve3bHhcEcgVc+Td4DD9a+Td1zEyKuOO0czcYWrzhCcT
         tvoeMJf89WE0O/M4IxIXqvfJwcRgTiFBEmYdGzxdktpJKukTKOFi25Kns4jm5Sm2dyAU
         yc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+FwAVJSyrEXzkxSrmCS02v7oMdKUwO+F0o4wshx4Ek=;
        b=aft6zDHMVdvBd6O1LqIudGiZGL+1XQzm8SAt1Er6PPPYqKjq7dRACvf51j03ZDuQWN
         NKAcm2fLsYaq5uJE5b+F500rFUO7pzwo4dkmoxXysH6JvvLqzt4zp2uFZcqZNm9TP15e
         /sgQ5MblkCpo+v7GrCxzQ0BNpAg2n/bnsmMzcxfByu5SRYAHgtemnPem2aLS+Ms5k2tA
         I9IO5SyK3JuQUU5yHeqZPZ22++UpocgTd598OMysDZA0GyyhwwB+e13A+iC25gAIEASg
         asdG5LGo0nbPQsyGFBAfGOlFIZdANTnNk+iQmFzXiPaq7EDLGQxzuoH7SZEMzdN06NGq
         zysg==
X-Gm-Message-State: AGi0PuZR+N02a4rqQSl4G8B2NHCq8UbQOtqcMSbxSO+l2kb0h4Ege/ZM
        YszTCIqXftEgowPEjiJ2LP6Dl0/98cmrEuYXdKeS4w==
X-Google-Smtp-Source: APiQypKSjYZOD7xk1KJYIgeWWnr+Sy7zH5f3yAinfHlnQz1vSgERtk1La4XpoWwZWcsoyFjvzfAAP5KPRwAA/g7JUtg=
X-Received: by 2002:aa7:c643:: with SMTP id z3mr620607edr.154.1588276309142;
 Thu, 30 Apr 2020 12:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <158823509800.2094061.9683997333958344535.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHk-=wh6d59KAG_6t+NrCLBz-i0OUSJrqurric=m0ZG850Ddkw@mail.gmail.com>
 <CALCETrVP5k25yCfknEPJm=XX0or4o2b2mnzmevnVHGNLNOXJ2g@mail.gmail.com>
 <CAHk-=widQfxhWMUN3bGxM_zg3az0fRKYvFoP8bEhqsCtaEDVAA@mail.gmail.com>
 <CALCETrVq11YVqGZH7J6A=tkHB1AZUWXnKwAfPUQ-m9qXjWfZtg@mail.gmail.com> <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200430192258.GA24749@agluck-desk2.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 30 Apr 2020 12:51:38 -0700
Message-ID: <CAPcyv4g8rA2TRvoFHqEjs5Xn74gdZx8uF0PXFYCjTcx56yA=Jw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        stable <stable@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:23 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Thu, Apr 30, 2020 at 11:42:20AM -0700, Andy Lutomirski wrote:
> > I suppose there could be a consistent naming like this:
> >
> > copy_from_user()
> > copy_to_user()
> >
> > copy_from_unchecked_kernel_address() [what probe_kernel_read() is]
> > copy_to_unchecked_kernel_address() [what probe_kernel_write() is]
> >
> > copy_from_fallible() [from a kernel address that can fail to a kernel
> > address that can't fail]
> > copy_to_fallible() [the opposite, but hopefully identical to memcpy() on x86]
> >
> > copy_from_fallible_to_user()
> > copy_from_user_to_fallible()
> >
> > These names are fairly verbose and could probably be improved.
>
> How about
>
>         try_copy_catch(void *dst, void *src, size_t count, int *fault)
>
> returns number of bytes not-copied (like copy_to_user etc).
>
> if return is not zero, "fault" tells you what type of fault
> cause the early stop (#PF, #MC).

I do like try_copy_catch() for the case when neither of the buffers
are __user (like in the pmem driver) and _copy_to_iter_fallible()
(plus all the helpers it implies) for the other cases.

copy_to_user_fallible
copy_fallible_to_page
copy_pipe_to_iter_fallible

...because the mmu-fault handling is an aspect of "_user" and fallible
implies other source fault reasons. It does leave a gap if an
architecture has a concept of a fallible write, but that seems like
something that will be handled asynchronously and not subject to this
interface.
