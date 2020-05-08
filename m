Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E86C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B071D2184D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPfOuJcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgEHUcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 16:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726843AbgEHUcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:32:52 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBD1C061A0C;
        Fri,  8 May 2020 13:32:51 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id s10so2614110iln.11;
        Fri, 08 May 2020 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SrdiPH6OCyFVL4P0giE1gaW/T/tYTKKiFjVse2DiHdE=;
        b=vPfOuJcgAHiet66XGJbX5lrCkQKcG7/JZIer2jOzf7M5qfsxezAK9to12i0iTWmBA9
         KDkuB+XawbbI0IbQHoUqahMlkKyGoKyk3mol1D0C21TTthqjxv78Y/cnStOQMPgQgKDn
         8KmNMpxAH5R7pI5BOMdYKD8LgVAiQJZGXTx9kvTQJnZ8fKJykt55zYa2mUPcEEb2LbLn
         lzyGiOpm+C2Gp+K7D1tfhWbXYeyqS43LXaavOPSDcZMAC5FVtbq4083aJ4Y4niATim0p
         pNi/VBinYJUXCIYpEJpL1zksuesAVtn8beW4uTI5Mj6ePWsIApn0oCM/KOIBX2iGnGPm
         ugeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SrdiPH6OCyFVL4P0giE1gaW/T/tYTKKiFjVse2DiHdE=;
        b=WnUAmlXr+RSlxcK+mCyE3Wh3fHOQ7ef9hq+easy0uLP2BCUnEYeRFM+2BrZhfwotni
         vmTGlOf6WViqY7+2GEdg/GQBpps+LxTvbgLb4/ejjZAjLyfSuNoAXPh8lS10bgzb4sbO
         /xUohpqaS7BeuZrdXDG2HcBxCUVaPls5nBvicwK69GH/R9Y6gRw2HLYWOhuOZUUGlvQl
         NpybwNfXDhUwCcp9guecZLif56bjHZB/y5Y4LDSYGVuf+xbGgLivbGvuWeOvkJyA3ekT
         Zeo/L1AklWEDnunROoRXm+XW3l5vbc7VmuUyEMIJi6jlYxlakh4tvDB3COv6lw3GXKZL
         4HrA==
X-Gm-Message-State: AGi0PuZukvMEmWdqcz6ASeav3kQgFjdqNkSeGXQX7+Z0yvzHLLtkOhVf
        iumhhEksQJCZ3fhiyhbzDkdDYPRX/o6ye3Gy+uY=
X-Google-Smtp-Source: APiQypLll09r7+Z6OBGxRjT/nNMNl6cyxXZI+zN/4+bWujh0sjs0E/4wnnseLP6whK1bAB+sFQFE2BnXI26lmlWMisw=
X-Received: by 2002:a92:6c0b:: with SMTP id h11mr4452205ilc.158.1588969970482;
 Fri, 08 May 2020 13:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200507173408.20754-5-alcooperx@gmail.com> <Pine.LNX.4.44L0.2005081444450.11470-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2005081444450.11470-100000@netrider.rowland.org>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Fri, 8 May 2020 16:32:39 -0400
Message-ID: <CAOGqxeVmvJxqXEqymuCJRXqLH9O70Lc7GLTBdfYt_zpB6jexyA@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] usb: ehci: Add new EHCI driver for Broadcom STB SoC's
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Fri, May 8, 2020 at 2:46 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, 7 May 2020, Al Cooper wrote:
>
> > Add a new EHCI driver for Broadcom STB SoC's. A new EHCI driver
> > was created instead of adding support to the existing ehci platform
> > driver because of the code required to workaround bugs in the EHCI
> > controller. The primary workround is for a bug where the Core
> > violates the SOF interval between the first two SOFs transmitted after
> > resume. This only happens if the resume occurs near the end of a
> > microframe. The fix is to intercept the echi-hcd request to complete
> > RESUME and align it to the start of the next microframe.
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Adding a new EHCI platform-specific driver is okay with me.  However,
> this patch does not include most of the changes you discussed with
> Greg.  I assume you will submit a revised version with those changes in
> place; when you do I will Ack it.
>
> Alan Stern
>

I mistakenly sent a partially fixed version instead of the version
with all the fixes (git stashed). I'm sending v8 will all the fixes.

Thanks



Thanks
Al
