Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55263C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EEB820708
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yh6uQc0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgFVO5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbgFVO5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:57:08 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AABC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:57:08 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id h190so1388658vkh.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DaQaRL/n2na4izh2TsmRyDKAg7niGqHtN8UJRlkcUNk=;
        b=Yh6uQc0Tk44UUcYHHPdxzcHe4JMuPLNwLsMpf1hfB3Jh8Tu5KzLiUZOVxNrSzFNeRC
         1VX+uZFI62Ls1+BJbg7pP2QF3IogycASPqdpS7cK4qx+8UL3mK0h3koU2KF86qJLyXNp
         ISsh8AdquX9pm+IhFbc8LzxKYCLQ8dhUJwD7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaQaRL/n2na4izh2TsmRyDKAg7niGqHtN8UJRlkcUNk=;
        b=OddyixyEqS1drP9zHfM4nNRcSwEC5oemezzlYfWGgptPqYT3fKVWemWZ+4+6m92kWZ
         0Htl7TKqZ8MfiHJrFaSId2ayy1S5F6dTpHu79UN8CJpK6P7FFVLOgfu1LvY58Vxm+Axs
         B3mWf42pMUpqWBSsu0Nt8dAR0LbBycW2AIVkprx3KmoABFE9AXx8zU7JTqpAnTIpvCR5
         xRGBemDUZnQUfXi97f+0PAg0jbQtbrpCEDT1OZygHjUglr7aNBwDFmj4pqo7EtNbTojq
         mV7LppVk5gTrWtkg6E328RnPmsr2Jo07irHPQeVFETABl7YxxXfKxoXPVzKRBHJgwPoF
         LOIQ==
X-Gm-Message-State: AOAM533Iu+1rwjjUReGyb2xxKhq9nkHhLPhPMd3RdNtogmEwyk1zk96O
        IJkCS8HNBNj/XQHtM14MLtxpnmtu4QQ=
X-Google-Smtp-Source: ABdhPJwzx4bwvEx8BZEUPSrKMIh+8QmnD0QjCLcI6BKhT70C1hhApMLhkSyj6qtokstyBbn1SfE87w==
X-Received: by 2002:a1f:9e8a:: with SMTP id h132mr9462823vke.14.1592837827205;
        Mon, 22 Jun 2020 07:57:07 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id x16sm2083598vko.54.2020.06.22.07.57.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:57:06 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id s192so4024493vkh.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:57:06 -0700 (PDT)
X-Received: by 2002:ac5:ce86:: with SMTP id 6mr16311424vke.75.1592837825897;
 Mon, 22 Jun 2020 07:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200619141958.1.I58d549fded1fd2299543ede6a103fe2bb94c805d@changeid>
In-Reply-To: <20200619141958.1.I58d549fded1fd2299543ede6a103fe2bb94c805d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Jun 2020 07:56:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VCX27cMs4q+jJ528UdEM93yZ96+kYTQPgU3ZqZ-whgEw@mail.gmail.com>
Message-ID: <CAD=FV=VCX27cMs4q+jJ528UdEM93yZ96+kYTQPgU3ZqZ-whgEw@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis_spi: Prefer async probe
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Andrey Pronin <apronin@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 19, 2020 at 2:20 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> On a Chromebook I'm working on I noticed a big (~1 second) delay
> during bootup where nothing was happening.  Right around this big
> delay there were messages about the TPM:
>
> [    2.311352] tpm_tis_spi spi0.0: TPM ready IRQ confirmed on attempt 2
> [    3.332790] tpm_tis_spi spi0.0: Cr50 firmware version: ...
>
> I put a few printouts in and saw that tpm_tis_spi_init() (specifically
> tpm_chip_register() in that function) was taking the lion's share of
> this time, though ~115 ms of the time was in cr50_print_fw_version().
>
> Let's make a one-line change to prefer async probe for tpm_tis_spi.
> There's no reason we need to block other drivers from probing while we
> load.
>
> NOTES:
> * It's possible that other hardware runs through the init sequence
>   faster than Cr50 and this isn't such a big problem for them.
>   However, even if they are faster they are still doing _some_
>   transfers over a SPI bus so this should benefit everyone even if to
>   a lesser extent.
> * It's possible that there are extra delays in the code that could be
>   optimized out.  I didn't dig since once I enabled async probe they
>   no longer impacted me.

I will note that I did continue to dig into the delays, actually.  I
haven't fully resolved all of them, but I'm fairly sure that most of
them are actually inefficiencies in the SPI driver on my platform,
which seems to have a lot of overhead in starting a new transfer.
I'll work on fixing that, but in any case we should still do the async
probe because it's very safe and gives a perf boost.  Why do I say
it's safe?

1. It's not like our probe order was defined by anything anyway.  When
we probe is at the whim of when the SPI controller probes and that can
be any time.

2. If someone needs to access the TPM from another driver then they
have to handle the fact that it might not have probed yet anyway
because perhaps the SPI controller hasn't probed yet.

3. There may be other drivers probing at the same time as us anyway
because _they_ used async probe.

While I won't say that it's impossible to tickle a bug by turning on
async probe, I would assert that in almost all cases the bug was
already there and needed to be fixed anyway.  ;-)


-Doug
