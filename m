Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A927C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3989E222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ai8FMPZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCJUmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:42:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40826 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgCJUmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:42:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id h17so2140401otn.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/deQQvgAa+oP9j87xo/rUZaCa5U0Y9db6yvuNAirEL0=;
        b=Ai8FMPZwPDU7dLeUmmQ5IrGiGriK5BF4c8C/goY7nt9A9p0gwe5maK+FI7+io4/LeT
         TH75Po6PkJ8cLhul21gKVq5bWmL9bTskL2/wNLmg/UhfqLGQmIZTlDwwzbG4bhIx/8Wv
         nl67KGQquy1o2acEsx4cOKOda/SY8w9A9rZBy4UxDDi2XSDeodDuMiMmGE448FGGfIHQ
         US1d67PAbkslxP0i5Ev6LK+9hnyhEL4jnDxjpu/dzCkvxOA6VRtuB0PUXr6qtk9lROVD
         NYYE3TiPoonSAGo6CIxmgX00jAcsnM1upezPCYcMpmmNna94s8ehKfcP/zP+lB6K5b1w
         sjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/deQQvgAa+oP9j87xo/rUZaCa5U0Y9db6yvuNAirEL0=;
        b=n5eBYWs/yeqmA8UajAcXJzlTZ1+lWKi5R66ZEExGCooGEMTanTq2WUfxH9NRnPpMBJ
         jpJeTo1h5/B7DAH/vVI1gTz/Y5srkwJcndLmHnEMkwXUuc488bbkQweyG5wDxbtN3Lf1
         wZUCvIILIetfdtP4gJemX4+wRyvCYpPrbl+sJIHzoddyb4Lt6sDgyjhnE5RNFE/GkPCE
         9a52H1J1VZ4AseM4HPEJ/28Z+uWKXl2dyuKToPIsw9Gpz6tl2iXwW6W3LLAJyT+7Aj2N
         IiVeCvfG+uVjoLNaRFl7V8uDwpQmA//txpLzd1vqeyYc8C0KNzhId+1T2tnqvlBWdRI6
         GdcA==
X-Gm-Message-State: ANhLgQ33NmMNj3oZ2LOXN0h8zOVndMXBU82iWtvsG7we3QWV/VivVCcN
        OX4omAxYJffahQEkBFQ8gq/lWDfvBPVijLRgukb+tg==
X-Google-Smtp-Source: ADFU+vtGvITp2sg+JZTjjfj9Q4pfx+/tRU62/dj4Jx5MF0ePB3TZaCSIkHsvrMO5+nTGln9aZv0pNAz+jfn/4+0y8w0=
X-Received: by 2002:a05:6830:118c:: with SMTP id u12mr17412267otq.124.1583872928122;
 Tue, 10 Mar 2020 13:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod62gypsxCYOpGsR6SWwp7roh8eEEKvZ8WNFtjB0bH=okg@mail.gmail.com>
 <C17G1V88F2XD.EQFO8E8QX1YO@dlxu-fedora-R90QNFJV>
In-Reply-To: <C17G1V88F2XD.EQFO8E8QX1YO@dlxu-fedora-R90QNFJV>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 10 Mar 2020 13:41:57 -0700
Message-ID: <CALvZod6mcoKTqi=OvyHQLbm1LszijDV-traf4Rx9oXmLSZe-Gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kernfs: kvmalloc xattr value instead of kmalloc
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Cgroups <cgroups@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 1:40 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Shakeel,
>
> On Tue Mar 10, 2020 at 12:40 PM, Shakeel Butt wrote:
> > Hi Daniel,
> >
> >
> > On Thu, Mar 5, 2020 at 1:16 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > >
> > > It's not really necessary to have contiguous physical memory for xattr
> > > values. We no longer need to worry about higher order allocations
> > > failing with kvmalloc, especially because the xattr size limit is at
> > > 64K.
> > >
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> >
> >
> > The patch looks fine to me. However the commit message is too cryptic
> > i.e. hard to get the motivation behind the change.
> >
>
> Thanks for taking a look. The real reason I did it was because Tejun
> said so :).
>
> Tejun, is there a larger reason?
>

I understand the reason. I am just suggesting to rephrase it to be more clear.
