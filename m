Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2A6C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D8F62071C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587666162;
	bh=xFQ9Q3vM+7y9hc9c9uKbOxxkbGkui3VYraUb1WBywZc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oTLdIMqPwt8VKELSdn880wVYt9Cruc1GYNVG9eVNP9blKydw7CJtfrkmNZ1CYIDLj
	 A6W/EQ9+mGYGBj68MLjedHalhpQRwt3UOJJh9ft7Bp8cH4IkSLikw3zEIa+4GvyAUY
	 l/pJ44BTKqzvcnrxXS6Ji4mlBCC4YORqa4o/B+bA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgDWSWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbgDWSWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:22:41 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A4BC09B043
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:22:40 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u10so5548668lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LscwPz73Lt0pgGTl+o/FebA5dRZodM4/3xJx4XGRFWs=;
        b=ZgjkI/0hqXjrYL+1zMORXDCbPO/cbFMR+PA+1RlleHhrFArqqZqVDrF2naxr2O/nZ8
         8DcrKKqA2CocQV8SGpC3aPyDpPzeFJT3QtO/W+6TFqOD/cqopRZBQi+Y/GW8PBeaNBp0
         IcU9neWFV5iGS7i3ZNxhsiHXnEpr7As01GU3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LscwPz73Lt0pgGTl+o/FebA5dRZodM4/3xJx4XGRFWs=;
        b=B3ofI5oMszXS10Pv91LU/XJzq8yOrSUlYaxDGP/PK2YsQV9TBpaY62dSr1BJYifIOK
         4jTWYAnxfH7nJC96fwLH7cf8a9f58AhTsc6kYtW3/jU4t7BWC98djXHT97BuG7t3pHmF
         +gVjUglUPRKxvIt2/lSDKZUEx3nAraxhu5RzMtD99ThMTayCv8aBMFDPpi94b2SiJUdX
         FPVCVAOdrZwANuPBGkZoq8F1HFLQJsSsqVJqiAXUoZPD4khr17ezPZ7jpdaY84ePzOj1
         KJ128vXFKP6LzynmLB87tByveM/gpCK2riJOxAWFxTbsn4wDxlbLwPrJRNhaEXblJrx7
         c48A==
X-Gm-Message-State: AGi0PubljOz1HbiFg0AdUXv5rsS18rBtulWKKyAstFptOy9ZXacqM7Gu
        itv93Tpsu2i+mTV0Ib3e/kPNbhNchqM=
X-Google-Smtp-Source: APiQypJ1Bg366jRuX9u7PCtUBgi8YSLddiWXUYbV+5w8nrPhUi/akSy08YoYRgTsdCwbmbnLbDgNXg==
X-Received: by 2002:ac2:4859:: with SMTP id 25mr3263545lfy.59.1587666157504;
        Thu, 23 Apr 2020 11:22:37 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id d3sm2821991lfq.63.2020.04.23.11.22.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 11:22:36 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id g10so5508080lfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:22:36 -0700 (PDT)
X-Received: by 2002:a19:9109:: with SMTP id t9mr3320601lfd.10.1587666155908;
 Thu, 23 Apr 2020 11:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200423173955.GA193359@google.com>
In-Reply-To: <20200423173955.GA193359@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Apr 2020 11:22:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7f3HJxmhP_SKQoFwuSx-OQgvp41pbgJN7TtspQj=RUA@mail.gmail.com>
Message-ID: <CAHk-=wj7f3HJxmhP_SKQoFwuSx-OQgvp41pbgJN7TtspQj=RUA@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v5.7
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 10:40 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>   - Workaround Apex TPU class code issue that prevents resource
>     assignment (Bjorn Helgaas)

Hmm.

I have no objections to that patch, but I do wonder if it might not be
better to try to actually assign the resource at enable_resource time?

Put another way: if I read the situation correctly, what happened is
that the hardware is broken and doesn't have the proper class code,
and so the resource is not initially assigned at all. But then the
driver matches on the device ID, and tries to use the device, and then
we get into trouble at pci_enable_resources().

But is there any reason we don't just at least try to do
pci_assign_resource() at that point? Yeah, because we didn't do it at
bus scanning, maybe there's no room for it, but that's what we do for
the PCI ROM resources (which I think we also don't claim by default)
when drivers ask to map them.

The pci/rom.c code does

        /* assign the ROM an address if it doesn't have one */
        if (res->parent == NULL && pci_assign_resource(pdev, PCI_ROM_RESOURCE))
                return NULL;

could we perhaps do the same in enable_resource?

Your patch is obviously much better for an -rc kernel, so this is more
of a longer-term "wouldn't it be less fragile to ..." query.

Alternatively, maybe we should do resource assignment even for
PCI_CLASS_NOT_DEFINED?

                     Linus
