Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124B7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F2D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pAz/ZPYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbgF2Uwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731316AbgF2TNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10FDC0A893F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 00:43:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so15451299wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 00:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1sq32oAMuFrxXberw1BKNrHbzi1OK3+z0FC4sQL74aY=;
        b=pAz/ZPYE7uXU4YYEjEHHPu8m/bh3dmQNZLzGPuccgUDjj4KIDswfVpH6KdQRVRmtIh
         rgScM7rfEUIRN5CyiCl5Ik6iSsDjS74UmWGOy6YMdjX/BLff3hjIdwIg550RHSHxfZ9a
         RIr+5sqalGa4Y5RYRI7pd1CUlokFz+XNrXtVohPbEY61IY9CbJqofNEloFXBDbnrMOwH
         LtPo8jIn/C9zptLX7jIAC/6bH+gL3H3WzRRwt+w2XGQGeBrCwOq38SxPG53d5HykmApN
         ROMPQvsKttzoEZI84zGb4Jwc/r+WYDcflbLJGSqT1lD0eRoCGU/lY5aP50NcUOWqTxNk
         AOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1sq32oAMuFrxXberw1BKNrHbzi1OK3+z0FC4sQL74aY=;
        b=Cak163z+5UgAMp4PMEV1lYhKjv+C8N8zB1+IC5tdto2HZ+UNeKnf0RdkZlHZm8iVMH
         2HDZDys3EeZqOGiJ2Sh3y39ETZFxYftv59To4oasKbg5LLw0JnG8dRp8yZbmRDdV8Kp/
         yp33dwW279zElHoI7w6MJWTcHnXETwY5Hi9q4Pvfa2pzEnlUGPb9qujLLeLRUD/ctSOp
         UKYPTYbE7C+6bDARhnHCpkA8ert9gGjmwh4qj1Rcf05smmS8lq3ArMmZHjlP7HyV7cyV
         5QH7eHY5h9WjJ7hlkWikKg9djDqw+oKirgr7Q4x7pGqUF8uzvEutpR8Zak7B7F/7VITo
         wm6Q==
X-Gm-Message-State: AOAM530KLIarl6PIlDl6HvzqibzC175n4Oii1mkqrMm2eStyFkmLzCMU
        MtMTWe2E91kn8sTAKXm0aeWRO8sbIQU=
X-Google-Smtp-Source: ABdhPJxT1sVMN+aZdzQqvMgPc3XF+a9fbNx7SqgAirl+kJm8AuQtiP9+nKblPZrqHh8+YtSwV/Lo7Q==
X-Received: by 2002:adf:f082:: with SMTP id n2mr16571247wro.326.1593416607481;
        Mon, 29 Jun 2020 00:43:27 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id y6sm28755120wmy.0.2020.06.29.00.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 00:43:26 -0700 (PDT)
Date:   Mon, 29 Jun 2020 08:43:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] ARM: dts: uniphier: change support card to
 simple-mfd from simple-bus
Message-ID: <20200629074324.GG177734@dell>
References: <20200623114614.792648-1-yamada.masahiro@socionext.com>
 <20200623114614.792648-4-yamada.masahiro@socionext.com>
 <20200623122413.GA954398@dell>
 <CAK7LNAR-dm6Zbtt9MsUunn9+qqwTtRCbq4Wzb=8uKLtfaLK6TQ@mail.gmail.com>
 <20200624181605.GJ954398@dell>
 <CAK7LNATFUX56t=wn-3qOSYLwESp63gqDWjADEVQ1g1CYrGxA3g@mail.gmail.com>
 <20200625145726.GT954398@dell>
 <CAK7LNAQdoe_eS8d9AoF1p4QgAB7oUM9aA+qgFS2GwPZsZbTnhg@mail.gmail.com>
 <20200629073617.GF177734@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200629073617.GF177734@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020, Lee Jones wrote:

> On Mon, 29 Jun 2020, Masahiro Yamada wrote:
> 
> > On Thu, Jun 25, 2020 at 11:57 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Thu, 25 Jun 2020, Masahiro Yamada wrote:
> > >
> > > > On Thu, Jun 25, 2020 at 3:16 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > >
> > > > > On Thu, 25 Jun 2020, Masahiro Yamada wrote:
> > > > >
> > > > > > On Tue, Jun 23, 2020 at 9:24 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > >
> > > > > > > On Tue, 23 Jun 2020, Masahiro Yamada wrote:
> > > > > > >
> > > > > > > > 'make ARCH=arm dtbs_check' emits the following warning:
> > > > > > > >
> > > > > > > >   support-card@1,1f00000: $nodename:0: 'support-card@1,1f00000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> > > > > > > >
> > > > > > > > Maybe, simple-mfd could be a better fit for this device.
> > > > > > >
> > > > > > > The two should be equivalent.
> > > > > >
> > > > > > Yes, I know.
> > > > > > That's why I can change "simple-bus" to "simple-mfd"
> > > > > > with no risk.
> > > > > >
> > > > > > The difference is schema-check.
> > > > > >
> > > > > > The node name for "simple-bus" is checked by 'make dtbs_check'.
> > > > > >
> > > > > > See this code:
> > > > > > https://github.com/robherring/dt-schema/blob/v2020.05/schemas/simple-bus.yaml#L17
> > > > > >
> > > > > > Even if I rename the node, it does not accept the
> > > > > > unit name '1,1f00000'
> > > > > >
> > > > > > > What do you mean by "maybe"?  Does this squash the warning?
> > > > > >
> > > > > > "maybe" means I am not quite sure
> > > > > > which compatible is a better fit
> > > > > > to describe this device.
> > > > > >
> > > > > > As mentioned above, simple-bus and simple-mfd
> > > > > > are interchangeable from a driver point of view.
> > > > > >
> > > > > > This add-on board is integrated with various peripherals
> > > > > > such as 16550a serial, smsc9115 ether etc.
> > > > > > The address-decode is implemented in a CPLD device.
> > > > > > It has chip selects and local addresses, which are mapped to
> > > > > > the parent.
> > > > > >
> > > > > > It can be either simple-bus or simple-mfd, I think.
> > > > > >
> > > > > >
> > > > > > dt-schema checks the node name of simple-bus.
> > > > > > Currently, there is no check for simple-mfd.
> > > > > >
> > > > > > So, I think this patch is an easy solution
> > > > > > to fix the warning.
> > > > >
> > > > > Yes, looking at the documentation it seems as though 'simple-mfd'
> > > > > would be a better fit.  Is the device a single IP with various
> > > > > different functions?
> > > >
> > > > Not an IP.
> > > >
> > > > This is a small board that consists of
> > > > a CPLD + ethernet controller + serial controller + LED, etc.
> > >
> > > Then simple MFD does not seem like a good fit.
> > >
> > > Neither does 'simple-bus'.
> > 
> > Then, I do not know what to do.
> > 
> > 
> > This board connection is so simple
> > that no hardware initialization needed to get access
> > to peripherals.
> > 
> > So, 'simple-bus' or 'simple-mfd' is preferred.
> > 
> > If this is not either simple-bus or simple-mfd,
> > I need a special driver to probe the
> > child devices such as ethernet, serial etc.
> > 
> > 
> > 
> > > What is it you're trying to describe in the device hierarchy?
> > 
> > 
> > The connection is as follows:
> > 
> > 
> > |-Main board -|      |----- add-on board ----|
> > |             |      |     (this board)      |
> > |             |      |                       |
> > |    (SoC) ---|------|--- CPLD --- ethernet  |
> > |             |      |          |- serial    |
> > |-------------|      |          |- LED       |
> >                      |                       |
> >                      |-----------------------|
> > 
> > 
> > 
> > uniphier-support-card.dtsi describes the
> > "add-on board" part.
> > Address-decode is implemented in CPLD.
> > 
> > 
> > So, the criteria to become MFD is
> > whether it is an IP integrated into SoC.
> > 
> > 
> > - implemented in an SoC  --> MFD
> 
> If
> 
>  s/in an SoC/in a single piece of silicon/
> 
> ... then yes.
> 
> > - implemented in a board + CPLD  --> not MFD
> > 
> > Right?
> 
> Right.  Unless all H/W is represented inside the CPLD, in which case
> the CPLD is, in theory, the MFD.  Although, due to the nature of
> CPLDs, this is a slippery slope.
> 
> You may want something like:
> 
>   arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
> 
> ... where the add-on board is represented separately (not in the
> same hierarchical structure as the main board.  The main board is then
> included as a DTSI from the add-on board.
> 
> It might also be worth looking at how consumer boards such as the
> RaspberryPi, BeagleBoard and the like handle their add-on boards,
> mezzanines, capes, hats, etc.

Another option; if the add-on board PCB really doesn't do anything
except provide some copper lines to the on-board components, then does
it need representing in Device Tree at all?  I suggest not.

Your issue will come when you want to swap out that board and insert
another, which contains different functionality.  This is why it would
be better to represent the whole board as an orthogonal *.dts file.
Whether you decide to lay it out as it's own board (as above) or as
children to the system-bus will be up to you.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
