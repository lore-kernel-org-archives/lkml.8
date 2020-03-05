Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37AFC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899B020870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pnDwBpEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgCEIdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:33:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50293 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgCEIdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:33:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so5190964wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 00:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYxbC9qPC4/N8la63J08DdmEKfQjapCeK8070Jjm4tE=;
        b=pnDwBpExPbjgZWp+2ubL9D0tUj9nEaKK3jT6M7Fn/TH0G3Lbjyut3g6DzXdhjjvMzZ
         +GwXPkburw2SlIZECET8JCrPSWp08OG9VmI97nCqbT/gCRUWZtZ13dQ+1v1cDc5MGctH
         7UqV3uyIM+74eOfjbH888lQp7DrypwbfNMUIJ5VMeU09Y8O8PAL9V2ObNjEhNB2yUN12
         IzctO8945uQQ9pj1cnw+4xUjZf4j2N9fKfRQF0mL/yN+nq+k+q3ItDifWlfgVRQB2jKu
         BzSPkUZ8qbCcAgghnmBJHDgpjV0TZaCPM4kZFXu3JpPW11jebQ1OELOrmpI1tybI/zQB
         PdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYxbC9qPC4/N8la63J08DdmEKfQjapCeK8070Jjm4tE=;
        b=IIol7jo+4wxhYnxXS+4mFyvbX87TZRYj6WZDYiqtp1hhIkfXWrHjG81X6Xa072XTIs
         0JGqwjeOBgVE3TVKalDbepsqrehdAvQsKGGPqbQyOd8kHKFKqerUGWZY7OyECqQek+vO
         gqjuOkULajueq/2IyN3/D82JlUMdichNwrYEJ6Pp+K+wFicDppl7/w9GxWDJ1e25dAkU
         +1J7Fek0MT1iHdbVMUvitaqQrZ9d/5EaERKD1IhgGh+qjui9dvOQcJkYpe1rJkRZxwrR
         9VXLeszoQdGPleQ8VUuCKv6dZHpWA+vJTx9vIurxpQzWOcLHNPmvNBwyiWWQcRbb6nJF
         PVWA==
X-Gm-Message-State: ANhLgQ3TYrW94jXXyy5SBTcvp5/4miKVONZEod/mzQwtqMbQVY+igQ6j
        sClz8htwbNyA0LW4ZkRxEZLFWCO0PLFY0x52KavT1A==
X-Google-Smtp-Source: ADFU+vtsmIq6Grq3pIa+Q9kL3rRxGKy8PNQt+HhO/d+bzsAYuCAVV9DLBh1QKsu/Mzegk3X+xrTzBlQYplaaQNWsLEg=
X-Received: by 2002:a7b:c254:: with SMTP id b20mr4315045wmj.165.1583397199527;
 Thu, 05 Mar 2020 00:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20200302130430.201037-2-glider@google.com> <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
 <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com>
 <4cac10d3e2c03e4f21f1104405a0a62a853efb4e.camel@perches.com>
 <CAG_fn=XOyPGau9m7x8eCLJHy3m-H=nbMODewWVJ1xb2e+BPdFw@mail.gmail.com>
 <18b0d6ea5619c34ca4120a6151103dbe9bfa0cbe.camel@perches.com>
 <CAG_fn=U2T--j_uhyppqzFvMO3w3yUA529pQrCpbhYvqcfh9Z1w@mail.gmail.com>
 <20200303093832.GD24372@kadam> <202003040951.7857DFD936@keescook>
 <20200305080756.GB19839@kadam> <202003050010.A1A965BF37@keescook>
In-Reply-To: <202003050010.A1A965BF37@keescook>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 5 Mar 2020 09:33:07 +0100
Message-ID: <CAG_fn=WSw0Wt=mJs5Vm_133g0--i0yMOTsuEQ-9YbmLo77+w_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] binder: do not initialize locals passed to copy_from_user()
To:     Kees Cook <keescook@chromium.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>, Joe Perches <joe@perches.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 9:26 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Mar 05, 2020 at 11:07:56AM +0300, Dan Carpenter wrote:
> > On Wed, Mar 04, 2020 at 10:13:40AM -0800, Kees Cook wrote:
> > > On Tue, Mar 03, 2020 at 12:38:32PM +0300, Dan Carpenter wrote:
> > > > The real fix is to initialize everything manually, the automated
> > > > initialization is a hardenning feature which many people will disable.
> > >
> > > I cannot disagree more with this sentiment. Linus has specifically said he
> > > wants this initialization on by default[1],
> >
> > Fine, but as long as it's a configurable thing then we need to manually
> > initialize as well or it's still a CVE etc.  It will take a while before
> > we drop support for old versions of GCC as well.
>
> Yes, I agree; that's totally true. We need to continue to fix all the
> uninitialized flaws we encounter unless this is on by default for all
> supported compiler versions (which will be a looong time). (But it's
> not relevant to this patch because copy_from_user() does already do
> the initialization.)
>
> This set of patches was about dealing with the pathological cases of
> auto-init colliding with functions that do, in fact, fully init. Though
> I must say, I remain concerned about inventing such markings for fear
> they'll be used in places where the "trust me, it's fully initialized"
> state does not actually hold[1] but the author thinks it does.
>
> -Kees

Right now I'm trying to make Clang understand that output arguments of
inline assembly initialize the memory.
Then it would be possible to write something like:

  struct binder_transaction_data tr;
  asm("": "=m"(tr));
  if (copy_from_user(&tr, ptr, sizeof(tr))) ...

, and the asm directive can be hidden into copy_from_user().
