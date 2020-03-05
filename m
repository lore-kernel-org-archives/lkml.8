Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480ACC3F2D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC7420842
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNehVANO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCEEH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 23:07:58 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39542 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCEEH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 23:07:58 -0500
Received: by mail-io1-f65.google.com with SMTP id h3so4959838ioj.6;
        Wed, 04 Mar 2020 20:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sv3uK9xf9C73dIUI1DIkkaJoGRZu2pQVCfWVV2VChWM=;
        b=kNehVANOiC52TvRUHxr1c+SmzU4+JpRUKLnGjZb+owOiqvsB0jHvTv7UUiKP/0cU2O
         9KifuJ+OCTkwtSK1bhGAOr5+O6pzbu7hKlGZUXqRc69oox5bxLw8ctBVVBJyFHdHn6/0
         VDs2GNnTv20EXmUSvzYlk2RVQEvNnupggtKdWvg7EzbiRd7Q3+nfENYp5+yERMxGQb2f
         osKIW7KDLRnk8Ipn0RH2pvfI4YKQn1+f9wc3C3Yv5b0ysJtoyESylO2WPV0kix64fA6z
         Xi1V22tPhf+o8Zi785JUP9/VQgsN7vwpEQAb6sCpG4cZKI+Z+NRrA66z9ZQIz1ZDffO1
         bz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sv3uK9xf9C73dIUI1DIkkaJoGRZu2pQVCfWVV2VChWM=;
        b=P73mcbhv8FreHX0Wx4CqNvJaGB7orRJF3G9LzYk9d+qFXTOIEBBm0TVEGL8TjdIBwY
         zDuLxQPF2nZaQVAot1P7c3JpUJaK5nyw47cwNoSNe8eW+PKx2ubqLRWAMszWpIBhpvgm
         doqPkIO+VXpSdrsFsp0i3ASXF7cf+3bRC6ZmRLpir9aG6hOBBZQ/n6gPtlln9eO4xNhJ
         xX3MddIpg6gFYd4qnxEWMSpkv4LN+/wDqKgA9FNH5pJYfhE2gl35B5FKvv2MEwhKEuwN
         VEpK8Q4YRNBl0EkzLnvjzRn0/ZTXhZ+rTPyhjjJQ/Iwqtmo4++XoL9laK0XLBFSsvj7Q
         zcVw==
X-Gm-Message-State: ANhLgQ338Cqoc9LIuWlKl5c4PWVWLgB/r+CoTKCd7Gq22yo6zSO1Ep2p
        oxHTZEurkfuai3Mi++3f//YLYCL5KkWrdnlZcQ8=
X-Google-Smtp-Source: ADFU+vt9uyjUN8gULjKOUZ6/cN1Ak/LMeyNVMhB2uDZnismRKn3B5kcB03r0UUywSPFnatF2WBQR/Orn5EI8Ifyg1zY=
X-Received: by 2002:a6b:b309:: with SMTP id c9mr5008105iof.6.1583381277010;
 Wed, 04 Mar 2020 20:07:57 -0800 (PST)
MIME-Version: 1.0
References: <20200301212019.2248-1-linux.amoon@gmail.com> <20200301212019.2248-2-linux.amoon@gmail.com>
 <20200303094619.GA20181@pi3>
In-Reply-To: <20200303094619.GA20181@pi3>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 5 Mar 2020 09:37:45 +0530
Message-ID: <CANAwSgRxyYsDBX2Cx4w8-U_yEv2KqrzzgTc5oTfwjCFGDgttfw@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] devicetree: bindings: exynos: Add new compatible
 for Exynos5420 dwc3 clocks support
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux USB Mailing List <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, 3 Mar 2020 at 15:16, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sun, Mar 01, 2020 at 09:20:16PM +0000, Anand Moon wrote:
> > This patch adds the new compatible string for Exynos5422 DWC3
> > to support enable/disable of core and suspend clk by DWC3 driver.
> > Also updated the clock names for compatible samsung,exynos5420-dwusb3.
>
> Some time ago I mentioned this... so once more:
> Do not use "This patch adds" but simple "Add".
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L151
>

Ok I will keep this in my mind next time I update my patchs.

> Best regards,
> Krzysztof
>

-Anand
