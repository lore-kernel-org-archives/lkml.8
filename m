Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230ECC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24832064C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbfasWIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgGUNpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgGUNpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:45:51 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06923C061794;
        Tue, 21 Jul 2020 06:45:51 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id l1so21407066ioh.5;
        Tue, 21 Jul 2020 06:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7/kb+noIptWBZlCNM0tUJLWKrJyK4Uc4q4vqikSmVA=;
        b=EbfasWIh4+wlDSDclRW4JCtu3k/GkwYZwV4FMR6NllX9SWWtKFfGVdiXqylXEhXJ4l
         qs4HJ4MP0gNf0rnixDh1zehc4SYMLc1CcT6QRVUU00eH8CwaryFpY/hz0a7sVYkYv9fH
         87IL11VjluA1leN7c2M294bHJzLa5twS3hNCyYfEuV/s8+iQGCGSN5sQpox7Xx5VfB0z
         Pn8wk5cx4TsgxVsmGc8YWx4h0+Q5BKl4yJ4SJStOdTnOA1aGTU1C4FAATJVyFRa/0IvY
         IiNuSfSVXP4uhcs/IhDW5rCEo0wWnCimYa1YrwxuzmDsb6XojBukIVwKHY6L8OKAIIbs
         qyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7/kb+noIptWBZlCNM0tUJLWKrJyK4Uc4q4vqikSmVA=;
        b=G2AdmKoHAh4DBA2M18sGdaeu24ceLeYDwLotMBfkwadsVJR8T1X16j7n3GdNbzG3/J
         7wIeC46Tw4J/l0jeCoy5W5D1FgQD2lR8zYtzSiuQXrQ+axZeKqPy5zPSllM+svssVyy0
         g3V7rQOEAB/4s6pdUmhBWYuEo2tI9pyQ9/nO+pWTwUZmy20PphxGfP6qW1uOIfP7bkSP
         81rlLjDDjtzwpd9UbQ42xZXMg1zadJLdwRc+HAweFl2rK//4IfVEaCOqWKB0MayBVbMv
         q1Csi82CEJxq3AycwdgpG2UHGLyreTbBnv/EfRUhzgxQr3y+EjtK2IteqwjBSfgyr9J3
         VztA==
X-Gm-Message-State: AOAM533M/ICmbeE5uejyK0SA0wZHkmBmjR/V4Fmm7Le9iNF4x6aLsRU6
        Ge994ePDKRx9LALnyWQo0xhg2DcvZ9DYcrXyptb57A==
X-Google-Smtp-Source: ABdhPJw/AZflFKi8OhGhIi6gmJFA8xwTDeb81j9HKz/LcvMaEDr7KG2453i+UNvoNjCdsRwNGe2tREyMIuIhlwYjc3s=
X-Received: by 2002:a02:b897:: with SMTP id p23mr32678862jam.32.1595339150299;
 Tue, 21 Jul 2020 06:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200717152307.36705-1-alcooperx@gmail.com> <87h7u1p5zd.fsf@kernel.org>
In-Reply-To: <87h7u1p5zd.fsf@kernel.org>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Tue, 21 Jul 2020 09:45:38 -0400
Message-ID: <CAOGqxeW9hd+_FJnS2ZBq0gEye9P15HM4fSmmPbJGC5Fb5nv_Fg@mail.gmail.com>
Subject: Re: [PATCH 0/7] usb: bdc: Updates and fixes to the USB BDC driver
To:     Felipe Balbi <balbi@kernel.org>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 5:33 AM Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> Al Cooper <alcooperx@gmail.com> writes:
> > Updates and fixes to the Broadcom USB BDC driver.
> >
> > Al Cooper (4):
> >   dt-bindings: usb: bdc: Update compatible strings
> >   usb: bdc: Add compatible string for new style USB DT nodes
> >   usb: bdc: Adb shows offline after resuming from S2
> >   usb: bdc: driver runs out of buffer descriptors on large ADB transfers
> >
> > Danesh Petigara (1):
> >   usb: bdc: Halt controller on suspend
> >
> > Florian Fainelli (1):
> >   usb: bdc: Use devm_clk_get_optional()
> >
> > Sasi Kumar (1):
> >   bdc: Fix bug causing crash after multiple disconnects
>
> What should we do here? There are few comments which seem
> unresolved. Are we getting a new version?

I'm resolving the comments and submitting v2 today.

Thanks
Al

>
> --
> balbi
