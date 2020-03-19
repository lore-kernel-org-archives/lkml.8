Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A61C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06CE208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfrmVs7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgCSOB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:01:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34778 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgCSOB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:01:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id z15so3162015wrl.1;
        Thu, 19 Mar 2020 07:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AKfKixYunr8acU9EKxMbpxcmQFyK603ftvwA9L+/SD4=;
        b=QfrmVs7plt//YETSc+/owSuFJ61VH3rGKKnCR+Js6F8T2DpMaVMYdMwM6n+fpXMuW1
         WVeV783ja/9Cmh+El5E2y138kEJko3XDtQIJAl+PjP9VkePmx6y30TIjL9mveADQ2yIw
         jmwt30GRfG78XnHXqkMj0eCzYi7wIj3LOV6/Vw1exhLRz99JCOFjweCSNKsxUe7SLhCs
         Fdkdxv1I8DuM0WbmPWcIPC3kLp7SlQIB2Y/kjjCLXxsQ3iovIj0F7OrZaK1GvarikolY
         U+PxylQWr9CBeA6TkQtltMnx872PB80aFDJGV/NvMZxptQW5zvnwAvTYUnR/XjTlZf9I
         WVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AKfKixYunr8acU9EKxMbpxcmQFyK603ftvwA9L+/SD4=;
        b=GdPyujf8UpKT1BLCD6UwtsUZ9OnywGfqB0eXhY/W2jgMh5VyHSGu5l4gFuf5P1LTZ5
         nikuoJy+/p2DtibI9vDmfmNhSo41UpgEg0Z+sdVVdRmka4GDOZwXE7Z/0AjR3/UTO9Qs
         mXxRZoel2GKKzDwSsY6RsjVYm302UNBUaj+oLHmCp5VfSV2whu6ooCIzrXxO8arNN5se
         htW4hjZjWJ66N6RI205iXqXJHkbs56nQfiGPvmXW0AA1yQlPMXNSvPypeIg4j9rSS0Lz
         lw96+Ghmo9URSjrgvolZy40Ej31DwYiEFBOD8ej1FvpaoY6WALd8CaKsTBymLBXyOHIS
         DcMQ==
X-Gm-Message-State: ANhLgQ1ZEGMHIhglXXlDFpJvfJQsO676jvV79P1iP1NhSk4Gwh3Q9LUc
        hBzekgcbUnCXR1ZgAZrz6+U=
X-Google-Smtp-Source: ADFU+vu1VD+Vv4fiPbuRPt6ywzDJB+mqX1BMAOsNjxLh7T4rDR50T1cBacWaKUofi38Vf5WIJYmvSQ==
X-Received: by 2002:adf:db41:: with SMTP id f1mr4684099wrj.247.1584626484738;
        Thu, 19 Mar 2020 07:01:24 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b12sm3471485wro.66.2020.03.19.07.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:01:23 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] phy: phy-rockchip-inno-usb2: remove support for
 rockchip, rk3366-usb2phy
To:     Robin Murphy <robin.murphy@arm.com>, kishon@ti.com
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200318192901.5023-1-jbx6244@gmail.com>
 <20200318192901.5023-2-jbx6244@gmail.com>
 <233769c3-a44a-0ebd-7a2c-6fab17fb56f2@arm.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <625d2904-458b-1edc-d91c-21614653a274@gmail.com>
Date:   Thu, 19 Mar 2020 15:01:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <233769c3-a44a-0ebd-7a2c-6fab17fb56f2@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some questions.
Can Rockchip or Heiko explain why we have half finished support in the
upstream kernel for rk3366? What happened?
Are any plans to add a rk3366.dtsi?
How wide spread was the use of rk3366? Products?
ie. When does support stop?

There's also a rk3368. Is there a need for "rockchip,rk3368-usb2phy"?

We'll keep "rockchip,rk3366-usb2phy" aboard for v2.

Thanks

On 3/19/20 2:07 PM, Robin Murphy wrote:
> Hi Johan,
> 
> On 2020-03-18 7:29 pm, Johan Jonker wrote:
>> 'phy-rockchip-inno-usb2.txt' is updated to yaml, whereby
>> the compatible string 'rockchip,rk3366-usb2phy' was removed,
>> because it's not in use by a dts file, so remove support
>> in the code as well.
> 
> Here's a DT using it:
> 
> https://github.com/rockchip-linux/kernel/blob/develop-4.4/arch/arm64/boot/dts/rockchip/rk3366.dtsi#L820
> 
> 
> Please note that although DT bindings happen to be primarily maintained
> in the upstream kernel tree at the moment, it is mostly as a consequence
> of Linux being the source of most active development. Bindings should
> not be considered to be "owned" by upstream Linux since there are many
> other consumers, both downstream, and in completely different projects
> like the BSDs. As far as I'm aware there is still a long-term plan to
> eventually flip the switch and move maintenance to a standalone repo:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
> 
> 
> Things like PCI Device IDs and ACPI HIDs aren't even documented as
> formally as DT bindings, so by the reasoning here we could arguably
> delete the majority of drivers from the kernel...
> 
> Robin.
