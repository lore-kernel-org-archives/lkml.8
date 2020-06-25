Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD9EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6D120768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xRA7a7WN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405695AbgFYO5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405536AbgFYO5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:57:33 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BC1C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:57:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so6269319wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+7QpQs6FhlpOXE9FQrO8BUOl2ttFaq7mxuLw6M5Nym0=;
        b=xRA7a7WNemF2+ECa311QCcaUwE+ZUu/cj6cIbIvkYviFl2sMvfHdyFQCKmzZaJj+eF
         1y6apB3UH2ZKIk+pPcgF+3VuQ5kQAV/ef8ebI/c/UG64L+oWxN7a5hostGrpYOAIUGNw
         KgNhlasIT2fYmlWzk37PWUYkW5yhZpOx4G0kLwbNn8bFB/lnbabAT8F5usCe9SmQtbKj
         aaZcDurCTDnB2KpfqoV1ydaJCYASOICfY7fvLQgIqT+743VBmlnjoE2DRPdKk3rL2tm6
         wnsoMvlLuITZH9lO8zx3xnUyyqMrODMB+j++YhH7p0BtK4Viv52CaeuXw/D3m3jv6eZB
         AkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+7QpQs6FhlpOXE9FQrO8BUOl2ttFaq7mxuLw6M5Nym0=;
        b=GXthH/RDBcg3yCtqlGxXu64QUJfVjeQerYLFhImkQHLXtIMzieDX1advixz3R+xAvD
         /7g4oTsP/eeWNPHd1zhGdGRiZg3bsi/IFMFQyHdcfLys3Ai3NYtCJvkCSOKFdjG1HIid
         uN2MbdVLhyi1hzjcGcJY+cCRJ0oMlVaR7j0iZxMvurPHeg+UN5TLQRENGemJ3IBYdhV0
         BSeJ+bELaNROYJXmHp/bl0yO0+601ezlwrAhfH74AHvhpFB1s2Fg2wnStC86tHoFjPSi
         F9IaKCnu23Kpt9q/4ov8bWY/f6PLmApnHOSm2HCr6CbsyCYIHEHvaYpgI8HLp2Cj/m7Z
         5fIw==
X-Gm-Message-State: AOAM5334WWfm63eRU5x2FtHgzVrPNxSfcodQYZOZx0hglWRUpXvYQgBT
        VezTeIJHRwp3EuK372SKnxe0Rg==
X-Google-Smtp-Source: ABdhPJyFueEyfmUNkHi9WsjhYIRl9UwJEKZQIopHogN7onsTa92/7L3ToUPhcpZZZf5KJVaVQ4gBtg==
X-Received: by 2002:a1c:1946:: with SMTP id 67mr3982816wmz.59.1593097050635;
        Thu, 25 Jun 2020 07:57:30 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id z1sm18241248wrh.14.2020.06.25.07.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 07:57:29 -0700 (PDT)
Date:   Thu, 25 Jun 2020 15:57:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] ARM: dts: uniphier: change support card to
 simple-mfd from simple-bus
Message-ID: <20200625145726.GT954398@dell>
References: <20200623114614.792648-1-yamada.masahiro@socionext.com>
 <20200623114614.792648-4-yamada.masahiro@socionext.com>
 <20200623122413.GA954398@dell>
 <CAK7LNAR-dm6Zbtt9MsUunn9+qqwTtRCbq4Wzb=8uKLtfaLK6TQ@mail.gmail.com>
 <20200624181605.GJ954398@dell>
 <CAK7LNATFUX56t=wn-3qOSYLwESp63gqDWjADEVQ1g1CYrGxA3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATFUX56t=wn-3qOSYLwESp63gqDWjADEVQ1g1CYrGxA3g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020, Masahiro Yamada wrote:

> On Thu, Jun 25, 2020 at 3:16 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 25 Jun 2020, Masahiro Yamada wrote:
> >
> > > On Tue, Jun 23, 2020 at 9:24 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Tue, 23 Jun 2020, Masahiro Yamada wrote:
> > > >
> > > > > 'make ARCH=arm dtbs_check' emits the following warning:
> > > > >
> > > > >   support-card@1,1f00000: $nodename:0: 'support-card@1,1f00000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> > > > >
> > > > > Maybe, simple-mfd could be a better fit for this device.
> > > >
> > > > The two should be equivalent.
> > >
> > > Yes, I know.
> > > That's why I can change "simple-bus" to "simple-mfd"
> > > with no risk.
> > >
> > > The difference is schema-check.
> > >
> > > The node name for "simple-bus" is checked by 'make dtbs_check'.
> > >
> > > See this code:
> > > https://github.com/robherring/dt-schema/blob/v2020.05/schemas/simple-bus.yaml#L17
> > >
> > > Even if I rename the node, it does not accept the
> > > unit name '1,1f00000'
> > >
> > > > What do you mean by "maybe"?  Does this squash the warning?
> > >
> > > "maybe" means I am not quite sure
> > > which compatible is a better fit
> > > to describe this device.
> > >
> > > As mentioned above, simple-bus and simple-mfd
> > > are interchangeable from a driver point of view.
> > >
> > > This add-on board is integrated with various peripherals
> > > such as 16550a serial, smsc9115 ether etc.
> > > The address-decode is implemented in a CPLD device.
> > > It has chip selects and local addresses, which are mapped to
> > > the parent.
> > >
> > > It can be either simple-bus or simple-mfd, I think.
> > >
> > >
> > > dt-schema checks the node name of simple-bus.
> > > Currently, there is no check for simple-mfd.
> > >
> > > So, I think this patch is an easy solution
> > > to fix the warning.
> >
> > Yes, looking at the documentation it seems as though 'simple-mfd'
> > would be a better fit.  Is the device a single IP with various
> > different functions?
> 
> Not an IP.
> 
> This is a small board that consists of
> a CPLD + ethernet controller + serial controller + LED, etc.

Then simple MFD does not seem like a good fit.

Neither does 'simple-bus'.

What is it you're trying to describe in the device hierarchy?

> > > Rob is in Cc. Please add comments if any.
> > >
> > > > Isn't the issue caused by the ','?
> > >
> > > Right.
> > >
> > > The node name of simple-bus
> > > must meet the regular expression:
> > > "^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$"
> > >
> > >
> > > Even if I rename the node
> > > "support-card@1,1f00000"
> > > to "bus@1,1f00000", the warning is still
> > > displayed due to ','
> > >
> > > "1,1f00000" means
> > > the address 0x01f00000 of chip select 1.
> >
> > Is this an officially accepted format?
> 
> I am not sure if it is official.
> 
> Rob said the data fields should be separated by commas.
> https://www.spinics.net/lists/devicetree/msg201565.html

Are you sure he doesn't mean in the 'reg' property.

Rather than the node-name@NNNNNNNN syntax.

BTW, I think the error you link to above is related to the
node-name@NNNNNNNN not matching the value listed in the 'reg'
property.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
