Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D559C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A096208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLzUGqrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgFQGpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFQGpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 02:45:53 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB9FC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 23:45:53 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id d13so727573ybk.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 23:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6VYHd5h0CrKt/2yr6GObm6CaI8Wbrm7EKPsSDWfxLXY=;
        b=iLzUGqrkPbLXAoEnWcSVHgCY+LGh7gOt3ou7QDXKY/NSR5BMmuoOvemoFSYsNHGgqe
         kR54Xb69bK4eljpJJhPDM440/EFxcg63kh3B0bSVQug7j9UV2Css/Fl9O8ZtLOxb/kPa
         SdcrGk7tDY0aMMN81vBAfOMWZGIZWnB9e6Y89rI+VGSuoUqE60Wzy4/y1QPSsx7XZSj7
         B7ZDafvUqwQ6yzyT0ZFRGueYzwOAju7CQ7h6eocZaqoAgEzz5O+UZyjMaA4lWlgA7aVI
         yVyX8G0rTxA5c1fCyT+rXlOxRNJtOS+cVFj6SHFBF1vnMgv/99cFMOhJa426Ae2Sgaka
         4KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6VYHd5h0CrKt/2yr6GObm6CaI8Wbrm7EKPsSDWfxLXY=;
        b=rO2SiCJe6XORlYpa3GpSIFleGgDs5cSN1R6eRszRTWQWKS7VutwotctKsU+NFYKEv0
         euxgPoIYua9Hy//z8EUjQqF37eqaqokDmnZb3hAX4mZXMJDfdkkGNG1Zmi+sZkEUsVa8
         fBvOpPO3Pzib8mHGnaoGKAiOkfQoeOviuKl8ZEqOwYZEBhL50U27i4bomSaLHTExgewf
         Ha/kZizJ3NwS11CPIsQlh4goUc2aq4umFYxg+eg8VE7/s3DcLTsX/s1/9mNNTrUGFA5F
         SyvIPvX95guiN1fKr1lGkYPypMiIYY+9Rbp8NZgnqh2gFRFTbuAcskU5OqM83TK4EoVK
         e2/Q==
X-Gm-Message-State: AOAM533uXGArcvSVIlARavQzZ9CLtjKGvLlNoZmDAF/Sv0Tn0MaBV9zi
        ZZaKhp9ofs8Fh2gSWwhP5SEp8pZVALbBJXGDNQL31A==
X-Google-Smtp-Source: ABdhPJznH4F+WsSad9UYdRlV+0Nnoj5+CjP9UaQ+8p3tl8M9ir3hb0SP+7jMIH9NUsgjiA/Bv/k1zv2AOBfmDRGlPg4=
X-Received: by 2002:a25:4cc6:: with SMTP id z189mr9833280yba.153.1592376352141;
 Tue, 16 Jun 2020 23:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <20200616205017.GC20943@linux.intel.com> <CAFA6WYO1X3zdOMgVnHvKm7MAWWyE=dhbLpCcU5zJG7R2fCuycg@mail.gmail.com>
In-Reply-To: <CAFA6WYO1X3zdOMgVnHvKm7MAWWyE=dhbLpCcU5zJG7R2fCuycg@mail.gmail.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Wed, 17 Jun 2020 09:45:41 +0300
Message-ID: <CAD8XO3Y2b5SDfyjUtQWA+nVSSTUABZX603UZynxbgztTcN-9iw@mail.gmail.com>
Subject: Re: [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 at 09:07, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Wed, 17 Jun 2020 at 02:20, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Thu, Jun 04, 2020 at 08:58:49PM +0300, Maxim Uvarov wrote:
> > > With the evolving use-cases for TEE bus, now it's required to support
> > > multi-stage enumeration process. But using a simple index doesn't
> > > suffice this requirement and instead leads to duplicate sysfs entries.
> > > So instead switch to use more informative device UUID for sysfs entry
> > > like:
> > > /sys/bus/tee/devices/optee-ta-<uuid>
> > >
> > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >
> > Sumit, are you able to test these easily?
>
> Yes, I could give them a try.
>
> Maxim,
>
> Could you share fTPM TA tree which I should use for testing?
>
> -Sumit

Yes, I will send you an email.

>
> >
> > /Jarkko
