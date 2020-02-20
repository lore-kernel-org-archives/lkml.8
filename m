Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425FBC761A6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B60224672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k5J7L+u1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgBTGlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:41:39 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40780 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgBTGlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:41:39 -0500
Received: by mail-ua1-f68.google.com with SMTP id g13so1176685uab.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FII6SdDOT5LM0XD58UCmM9UhU3FnY2YeLrE2lk53Is=;
        b=k5J7L+u1jOqu5YUkSY9+Wm+SZ9fEd0plNX6vVCCQMNxtJ17xPFpHlzurSPf923XUx5
         fGd8FKC/yCneBjJp84L4iNCbiXagGjaBqqevwWiGJTr6ZgEhG51rY5aoA+f0Upr+DuoI
         aK9EFDfSdNNI3IUdXgtYEmwjegBCvffppiAHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FII6SdDOT5LM0XD58UCmM9UhU3FnY2YeLrE2lk53Is=;
        b=E77Zfv5Pa0WtPg3Z0PU+OPsnBtaURiSw60kmpYQJH0R6doCkWneLX0g0A8j0jiB0U5
         dE1DEsT6WAgAgXh8QHpNUaDtpHqlLy7vnbjRzZbA/NV615kmxd9zwCNMzrx+3Unamgac
         94En3NtQ4w+V+gWewXPhS59dlxrnMQINOAtE+VYQL0H3D8+TXyr7vjgSFpgouHk7+rYd
         sIdsw93hDTG4sW/3OgNHJYeMyJd0EMpNNOPVcOEUISxd1ll48jxT3kmJZCF66P5FXxFV
         8KxeHuAZgFd83YbLLFuddhAUliA8mZ4QNMScheDGTr3/9p8rouRw+CZgwaNcrX5T9XG5
         H5ZA==
X-Gm-Message-State: APjAAAWBOJ+PubBRhUkr+pjmApwmJCFGqlGySDuxul5zpzjLDC6nBDWF
        d18gof2SiNYhk5lZwRIkd5RXjCW6vtg=
X-Google-Smtp-Source: APXvYqwinmFpEEfgphOe3vXDhlBv66CCHZbJ4JZcv7kl38fLJRQWyNU4mv64uRSNYrVZMNlw/BL1hw==
X-Received: by 2002:ab0:21cc:: with SMTP id u12mr14212438uan.55.1582180898202;
        Wed, 19 Feb 2020 22:41:38 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id i22sm501279uap.17.2020.02.19.22.41.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 22:41:36 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id n27so2031936vsa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:41:36 -0800 (PST)
X-Received: by 2002:a67:f541:: with SMTP id z1mr15813130vsn.70.1582180895674;
 Wed, 19 Feb 2020 22:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20200214062637.216209-1-evanbenn@chromium.org>
 <20200214172512.1.I02ebc5b8743b1a71e0e15f68ea77e506d4e6f840@changeid>
 <20200219223046.GA16537@bogus> <CAODwPW8JspiUtyU4CC95w9rbNRyUF-Aeb9TuPm1PzmP6u=y1EA@mail.gmail.com>
 <20200219232005.GA9737@roeck-us.net>
In-Reply-To: <20200219232005.GA9737@roeck-us.net>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Thu, 20 Feb 2020 17:41:09 +1100
X-Gmail-Original-Message-ID: <CAKz_xw2hvHL=a4s37dmuCTWDbxefQFR3rfcaNiWYJY4T+jqabA@mail.gmail.com>
Message-ID: <CAKz_xw2hvHL=a4s37dmuCTWDbxefQFR3rfcaNiWYJY4T+jqabA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: Add arm,smc-wdt watchdog
 arm,smc-wdt compatible
To:     xingyu.chen@amlogic.com
Cc:     Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Xingyu,

Could this driver also cover your usecase? I am not familiar with
meson, but it seems like the meson calls could
be replaced with arm_smccc calls. Then this driver will cover both
chips. I am not sure if your firmware is upstream
somewhere, but this might be adapted;
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405

Thanks


On Thu, Feb 20, 2020 at 10:20 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Feb 19, 2020 at 03:04:54PM -0800, Julius Werner wrote:
> > > You are not the first 'watchdog in firmware accessed via an SMC call'.
> > > Is there some more detail about what implementation this is? Part of
> > > TF-A? Defined by some spec (I can dream)?
> >
> > This is just some random implementation written by me because we
> > needed one. I would like it to be the new generic implementation, but
> > it sounds like people here prefer the naming to be MediaTek specific
> > (at least for now). The other SMC watchdog we're aware of is
> > imx_sc_wdt but unfortunately that seems to hardcode platform-specific
>
> There is one more pending, for Meson SMC.
>
> https://patchwork.kernel.org/project/linux-watchdog/list/?series=227733
>
> Unfortunately it uses Meson firmware API functions, though it has pretty
> much the same functionality since those ultimately end up calling
> arm_smccc_smc().
>
> Guenter
>
> > details in the interface (at least in the pretimeout SMC) so we can't
> > just expand that. With this driver I tried to directly wrap the kernel
> > watchdog interface so it should be platform-agnostic and possible to
> > expand this driver to other platforms later if desired. The SMC
> > function ID would still always have to be platform-specific,
> > unfortunately (but we could pass it in through the device tree), since
> > the Arm SMC spec doesn't really leave any room for OS-generic SMCs
> > like this.
