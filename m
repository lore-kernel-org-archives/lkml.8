Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDDCC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF4D20A8B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+Y03lcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgEFVB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728535AbgEFVB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:01:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D45C061A0F;
        Wed,  6 May 2020 14:01:28 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so1607150pjw.0;
        Wed, 06 May 2020 14:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1PrjJgczo6pwbhVfqtxrYxW7d4ubPdJ5akMV/EdzMO8=;
        b=S+Y03lcbRfS4M03fe9S1xwCVxAew8y69Mno1QzyJ/cD0m8jpGdJg8JIK2yqt//5s/q
         TKDuS4ScDuolgCXocIib85qeZn8viFjl3ZwYbLZ74AjJPOIww2Z+qq2ecwqNJaWYqvcU
         2tfQvU8RJYpdhGsK03ZHN8a5gWrGQ2KT7tuiGdxLy/PtyCLeWYjt5xTYChefFsgTRQrh
         muaj8qoHgMIXaZSNgBd+7u0w4dVpkTHvL+WHSG8rHfvH+rKqyr+oYqER7vb9+ndZ6qIc
         j5NleHcXh5HGSEkyRv99dn7fWAMNJmGKm0khoWYkhnzH7IWcqWnaY3/iPeCO8FZpzvyI
         bh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1PrjJgczo6pwbhVfqtxrYxW7d4ubPdJ5akMV/EdzMO8=;
        b=m3k3dPqmeDthwy7mluqMlagKCoHjHkvAkZ/hjmYOGGk/mzjeMAXVMcZGivxBDRU9ND
         SPOJMjBtZqcjvQS4i7qvvmnsWLQvazPU0EEKG13CrGj5qCSMnw6CehvuciUyidc8xlus
         WWrHj6a0ER70+HxQDHBA888eu/kIeyPUUI7hLuxva01SjIl0zh3LQhQr4gQyRUPHJmCd
         WTs1L2KECtT0WkVnv5K5XyvGKkEOKux2wI7Kp82TNz3GA7lbpC1Ws229H01OMtEPHnmb
         JmdkcEV9WBvaBL4q7FKLNMrFEYPH0ZMRqJhTYVjC9OiqkS3XbnK/k0TvJ/RBORLgjWFc
         mCWQ==
X-Gm-Message-State: AGi0PuZOTL1hs2Lt/uY6yKRcjTvh/7SBpjt5JoVMk2Guz1gRPNGuknFb
        fFc3zCPYiNLH4u1RhtLeGiriElCJHsnCUnoJ1vM=
X-Google-Smtp-Source: APiQypKdZjzSlTyFQ/T9CUwUL01Xf79l+ICWYHY1E+4V+NAKRwMIyNo2UDSTCSmbRJOkOJSrbKREYvBDA7BlnuxgR6E=
X-Received: by 2002:a17:902:6901:: with SMTP id j1mr9830320plk.255.1588798888435;
 Wed, 06 May 2020 14:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200430111258.6091-1-alcooperx@gmail.com> <20200430111258.6091-4-alcooperx@gmail.com>
 <20200505110036.GB93160@kroah.com> <CAOGqxeXboYz2OQhgJsYmH5_7qEwKeWR5AA4Ljq_iFdSX=H2fkA@mail.gmail.com>
In-Reply-To: <CAOGqxeXboYz2OQhgJsYmH5_7qEwKeWR5AA4Ljq_iFdSX=H2fkA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 May 2020 00:01:16 +0300
Message-ID: <CAHp75VeA8JnsJgEgkv0wivinsxvk51JTVyaPhmLhsjzkqZYR8A@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] usb: ehci: Add new EHCI driver for Broadcom STB SoC's
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 11:23 PM Alan Cooper <alcooperx@gmail.com> wrote:
> On Tue, May 5, 2020 at 7:00 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Thu, Apr 30, 2020 at 07:12:57AM -0400, Al Cooper wrote:

...

> > > +     /* Hook the hub control routine to work around a bug */
> >
> > What bug?  This feels wrong.
>
> The bug is explained in a comment above the ehci_brcm_hub_control()
> routine as follows:
> /*
>  * ehci_brcm_hub_control
>  * Intercept echi-hcd request to complete RESUME and align it to the start
>  * of the next microframe.
>  * If RESUME is complete too late in the microframe, host controller
>  * detects babble on suspended port and resets the port afterwards.
>  * This s/w workaround allows to avoid this problem.
>  * See SWLINUX-1909 for more details
>  */
> I'll remove the internal bug tracking reference from the comment.

I guess you may leave the internal bug reference. I can tell from my
experience that's hard to understand what was going on in the driver
in years perspective. It will help whoever in this company have a
chance to look after the driver.

-- 
With Best Regards,
Andy Shevchenko
