Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5810EC2D0EC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F91120737
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUQfHuNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgCZRQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:16:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34416 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgCZRQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:16:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id i24so7784113eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4Bafici+74bpF8/r43zm3/RopJlj6eRGLXVN/i+YAg=;
        b=qUQfHuNsWF6kO67FxUkLRz1M4ZFMCKjyrWxyDnE7r/Isct3HcfF2g8z3i2KR9arNjt
         CpgVwwczRA74FnXG3R3V+Hc2blucW5GbCvG+HrpFYo+QoZCHfeiK9V6IdZVKknJo68Pb
         9i5FIhLcGzaNgey/mIOBGYk9eTRDHwtDC6GPXK6X9xQ1rVgoqc6mXnE3COOJdA0rv5gU
         WSpd9l7bOT1awZi7+RyWXmvYEILyBN2Z81CgGIi3HUSg5t0osLBoVMZmFHuIeeDXUyiW
         rH36ZQBdOuD4rMKMdkbjXJHaVhbd1zEwiRTJxinPePp+a0pAeFzTSoA28ae1PjM9mBvc
         eR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4Bafici+74bpF8/r43zm3/RopJlj6eRGLXVN/i+YAg=;
        b=jDeZSBUFIPrfPKUbOY4wQ6m1brFGvZe4b0CLVHr5LwNmSno/v/MACctrqOaoQh38IG
         QS8LPBovZnoCzr7B/utuZZgzpb3syFgO0fiRAEr3qoAl+I4bESB9INF2maOpw7FWNyCb
         BmVg2F0MYtciUHw6qIiWjsGlngpxoDi2enwyZ0V390cP7JD6ZXEddXYhLtqtTU03iGQP
         CG1cWrEgniRX3Qg0djyOHGAOBonbDYykXdZNeU7yowGqzewNV/T9rtr+vwIMnXevB5BC
         tOglU+n+DMVAx2oCVtXi248D1fMg1OeABNEVvdA1K8M2CAI5QG9SfVlUYs8RlhX2bbOF
         BjCA==
X-Gm-Message-State: ANhLgQ2oMxm4f5WM/nNc5OzREpjFsiKJg7CLt+29/a5zlOrOKhwABGQU
        iWZsXp6pOqCBU7sQGMqAkln1Qn0+9vVrulAl4jtPyA==
X-Google-Smtp-Source: ADFU+vvXOq3qtuPx24TK/wg4PIU6jSvq4+J/DaUbhlRxbosamCkpUbgMonGFEWLs123uOLU63ziMY8FIUgjT8Nr5Itc=
X-Received: by 2002:a50:8d02:: with SMTP id s2mr9395936eds.81.1585242999701;
 Thu, 26 Mar 2020 10:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200320175910.180266-1-yonghyun@google.com> <20200323111404.GA4554@infradead.org>
 <CAEauFbww3X2WZuOvMbnhOD2ONBjqR-JS2BrxWPO=HqzXVcKakw@mail.gmail.com> <20200326093807.GB12078@infradead.org>
In-Reply-To: <20200326093807.GB12078@infradead.org>
From:   Yonghyun Hwang <yonghyun@google.com>
Date:   Thu, 26 Mar 2020 10:16:26 -0700
Message-ID: <CAEauFbz_ACeQtn-=fmyhcrh4Ljctuij=3t908qjo_nehwKbXXQ@mail.gmail.com>
Subject: Re: [PATCH] vfio-mdev: support mediated device creation in kernel
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Havard Skinnemoen <hskinnemoen@google.com>,
        Moritz Fischer <mdf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 2:38 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Mar 23, 2020 at 02:33:11PM -0700, Yonghyun Hwang wrote:
> > On Mon, Mar 23, 2020 at 4:14 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Fri, Mar 20, 2020 at 10:59:10AM -0700, Yonghyun Hwang wrote:
> > > > To enable a mediated device, a device driver registers its device to VFIO
> > > > MDev framework. Once the mediated device gets enabled, UUID gets fed onto
> > > > the sysfs attribute, "create", to create the mediated device. This
> > > > additional step happens after boot-up gets complete. If the driver knows
> > > > how many mediated devices need to be created during probing time, the
> > > > additional step becomes cumbersome. This commit implements a new function
> > > > to allow the driver to create a mediated device in kernel.
> > >
> > > Please send this along with your proposed user so that we can understand
> > > the use.  Without that new exports have no chance of going in anyway.
> >
> > My driver is still under development. Do you recommend me to implement
> > an example code for the new exports and re-submit the commit?
>
> Hell no.  The point is that we don't add new APIs unless we have
> actual users (not example code!).  And as Alex mentioned the use case
> is rather questionable anyway, so without a user that actually shows a
> good use case which would remove those doubts it is a complete no-go.

I see. Thank you for your clarification. (I got confused with the use
case.) I hope you can understand email communication results in some
confusion from time to time, which is especially true for kernel
newbie like me.
