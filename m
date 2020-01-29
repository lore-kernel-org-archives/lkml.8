Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CDAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755B420674
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxSawPEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgA2VTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 16:19:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37840 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgA2VTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:19:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so308418pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 13:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+hDQAX34j2Scqm0cOO1CyUImmUew2WxU5247BGER7dY=;
        b=UxSawPEjuU8FcEVTFXeV+8fPyjejUz2O2GIiBAdoDAVFy9BgrpyDdwrWW/Qw/2J7ya
         FZ3Hx7C3W8oBpKsfbmp0gcB6UuG6HCj996xrlRomauFSWUUkw1WSDiYPt+gyeAvsDM8J
         KOcA9yUDtsyGqXt3j9CoaEHIZjsv5vX9WRJS+1BFVxd2ZZsKZ61Y5xn2O9TyueeSevNe
         3HynVm+hSZdJHxWhsiP6dcIrpF1AqWQTN1wm7n/YeICb9e29ywqkZW8GbIbfpGFKmKzZ
         fBgtZeeHipIaN5zsaA1KEPpdP38j6n64hmv3cpQViCU8n8pwKNaxkHJeeBc4f/NHQRvk
         NZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+hDQAX34j2Scqm0cOO1CyUImmUew2WxU5247BGER7dY=;
        b=Jn1SJGANSJyM6jrPftxR9rA+ls8iSTvZMVSKFv+HBi/3XGp9/1hrPu8JmxPCg8nqd0
         b73IdD56AnsAAQILf4Kpn9o9ZOGCYhSL951cWfue93b+g4pQsemngrSWAeV6wK0uFi/l
         CIzFUof3PqNXbrxqg1qbsg6pTds6oZsmgrzvjUt0CNefiTGdcBM8L98MnqWLWeQLt1tP
         rYsG7iU40X8OGZqzVQx39oK/6sw3zp8Vfj9tFoxi67mtcUQaFQXCMVkJeuNJgJrffUba
         c15Vzmb03BQsIhQTA9PDtNlEE4efGLoN6/2q4ve0DwPU68Q8qRIVCNJ6UXtcSRmv8HMC
         CJuQ==
X-Gm-Message-State: APjAAAU0pn+s6k/LgvWZ9xgKHZZ/L3OZMBsYxulQRf0ZiFbvgNZ2ltVU
        ZhL2IFZTlYE6AQ6suGno6wd10qpAbxeZ60VFep68Pw==
X-Google-Smtp-Source: APXvYqz8Ek9aAZM7bbtF2TInvqPq0TxdAQovVbgPfNg0x3Ic53N8b+s11tC5qEwNcBJ6IzRzAQElzR1+afYbaPQH8+4=
X-Received: by 2002:a63:597:: with SMTP id 145mr1045907pgf.384.1580332747259;
 Wed, 29 Jan 2020 13:19:07 -0800 (PST)
MIME-Version: 1.0
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20200106224022.GX11244@42.do-not-panic.com> <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com>
 <594b7815-0611-34ea-beb5-0642114b5d82@gmail.com> <CAFd5g469TWzrLKmQNR2i0HACJ3FEu-=4-Rk005g9szB5UsZAcw@mail.gmail.com>
 <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com> <ECADFF3FD767C149AD96A924E7EA6EAF982C9840@USCULXMSG17.am.sony.com>
 <CAFd5g46Ut9Suptmp_bBspkp=KKt2GP+=1C5zLu0FXJY9dGJbFQ@mail.gmail.com> <dcf2d008-c044-f2d4-63b9-47151157eeb4@gmail.com>
In-Reply-To: <dcf2d008-c044-f2d4-63b9-47151157eeb4@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 29 Jan 2020 13:18:55 -0800
Message-ID: <CAFd5g45g7B0HFpcxd-fjpj4h4gaxijSQ+LZb1=6v3t_u_=192w@mail.gmail.com>
Subject: Re: [RFC v1 0/6] kunit: create a centralized executor to dispatch all
 KUnit tests
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     "Bird, Timothy" <Tim.Bird@sony.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 8:24 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 1/28/20 1:53 PM, Brendan Higgins wrote:
> > On Tue, Jan 28, 2020 at 11:35 AM <Tim.Bird@sony.com> wrote:
> >>
> >>> -----Original Message-----
> >>> From:  Frank Rowand on January 28, 2020 11:37 AM
> >>>
> >>> On 1/28/20 1:19 AM, Brendan Higgins wrote:
> >>>> On Mon, Jan 27, 2020 at 9:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >> ...
> >>>> we could add Kconfigs to control this, but the compiler nevertheless
> >>>> complains because it doesn't know what phase KUnit runs in.
> >>>>
> >>>> Is there any way to tell the compiler that it is okay for non __init
> >>>> code to call __init code? I would prefer not to have a duplicate
> >>>> version of all the KUnit libraries with all the symbols marked __init.
> >>>
> >>> I'm not sure.  The build messages have always been useful and valid in
> >>> my context, so I never thought to consider that possibility.
> >>>
> >>>> Thoughts?
> >>
> >> I'm not sure there's a restriction on non __init code calling __init
> >> code.  In init/main.c arch_call_reset_init() is in __init, and it calls
> >> rest_init which is non __init, without any special handling.
> >>
> >> Is the compiler complaint mentioned above related to  calling
> >> into __init code, or with some other issue?
> >
> > I distinctly remember having the compiler complain at me when I was
> > messing around with the device tree unit tests because of KUnit
> > calling code marked as __init. Maybe it's time to start converting
> > those to KUnit to force the issue? Frank, does that work for you?
>
> I have agreed to try converting the devicetree unittest to KUnit.
>
> Now that KUnit is in 5.5, I think there is a solid foundation for
> me to proceed.

Awesome! Last time we talked (offline), it sounded like you had a
clear idea of what you wanted to do; nevertheless, feel free to reuse
anything from my attempt at it, if you find anything useful, or
otherwise rope me in if you have any questions, comments, or
complaints.
