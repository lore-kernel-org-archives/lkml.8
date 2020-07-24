Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7DAC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCDEA20714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Di956j2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGXFcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 01:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgGXFcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 01:32:45 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30451C0619D3;
        Thu, 23 Jul 2020 22:32:44 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gg18so5310900ejb.6;
        Thu, 23 Jul 2020 22:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxeF3MdXzIoVsbazhbqXkh5Gq8fRGjKClAu6VjOvpaQ=;
        b=Di956j2aZtrmMHcejr07uX82Ow70coVnOGXPMEEuPUjfwmVcAT2UMOPHutzGowc6ee
         PrcgaF2BmKXQcGyY3GplupS/zOgati5XyXj7L+kKf0sWU3xvRDx/o3eysq3xLNtd5B8d
         UIkRU1OgFsWoBWSJR53ArBd94RfbELr182ysY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxeF3MdXzIoVsbazhbqXkh5Gq8fRGjKClAu6VjOvpaQ=;
        b=TaSgl7Ytas0s/M+CY9FxhPbTd3KvYqGa98YhsbRzYCo9xLeK8ABh1Bb5JRQIORUDad
         GEBt7wiOqffg8ZTlBINb1zEgbELLsp6DK1sSoh+uro39llL7S5bhr7kh38lLGfb9i1gA
         BouamtDZmgLJMxyU+lRNq0YeMpdzZ8XPAMAuUGD3T5IM/F8uaZhZ40AEx8lOBvBbMcL/
         8lmm/8Va6zggi6edfEyBqHyvRBgLlroZAEoiaSnmFzdagaa4aj8Q0H4dM5EVEq+DhkMb
         YYbIQ4Vh6pT8EUNoQeqpWq3IzmCWLVnR0mvDjc+EQpfDCK8BpMio7K/7hkTx9Ho6DM6/
         Reow==
X-Gm-Message-State: AOAM532A8LpomImtnX1LFSz4JnKatvVkfhUdeDQh0UcaOp0Q0JWKuI0M
        0XvkN3tMXAupJJYGOXxzu4zizmGQuC653kj9YYs=
X-Google-Smtp-Source: ABdhPJyvBQHzeEYsM37+wecHEG0VWauRr3W7csro+jM1re12/9nqf22Nc6d1EFG2E/ReH5XyqMDpOAvaHjCnOFMBhaA=
X-Received: by 2002:a17:906:c187:: with SMTP id g7mr8032732ejz.108.1595568762913;
 Thu, 23 Jul 2020 22:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200723230539.17860-1-rentao.bupt@gmail.com>
In-Reply-To: <20200723230539.17860-1-rentao.bupt@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 24 Jul 2020 05:32:30 +0000
Message-ID: <CACPK8XdiHLcBBhXjCpTZotVPuRj4bFh0x8TFhSj1TBK2xB0SiQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ARM: dts: aspeed: fixup wedge40 device tree
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 at 23:05, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> The patch series update several devices' settings in Facebook Wedge40
> device tree.
>
> Patch #1 disables a few i2c controllers as they are not being used at
> present.
>
> Patch #2 enables adc device for voltage monitoring.
>
> Patch #3 enables pwm_tacho device for fan control and monitoring.
>
> Tao Ren (3):
>   ARM: dts: aspeed: wedge40: disable a few i2c controllers
>   ARM: dts: aspeed: wedge40: enable adc device
>   ARM: dts: aspeed: wedge40: enable pwm_tacho device

I have merged this series into the aspeed dt-for-5.9 branch.

Cheers,

Joel

>
>  .../boot/dts/aspeed-bmc-facebook-wedge40.dts  | 42 +++++++++++++++----
>  1 file changed, 34 insertions(+), 8 deletions(-)
>
> --
> 2.17.1
>
