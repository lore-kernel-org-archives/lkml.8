Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D57C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 21:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A87F20720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 21:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJDLP1iX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgGKVVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 17:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgGKVU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 17:20:59 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1221FC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 14:20:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q4so10417060lji.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93XQLwbYeCf63UE53dzUuC+1/WTpcTLL+8N2oF5rDc4=;
        b=qJDLP1iXoAM81422yIDaPc1PG6sOEHznGDN8/VKgkfLNQ2wCmsj0Oh1uvNyBlz0qXi
         K34Y0frnlwnr8m14T6GQIGdTLz1hiUvncbBk9nqtBpCseQoexmz1OZ06v8bddbRKnJIl
         IXLpkYuhwd8QGVnxSYtKSZT/f2pMxOXq0y9Rr9HTwBU7RqM2GPzaftE2bC98Lib8Baep
         9BIv0ZE9nnxKtIaRpFsG91jRMCDUJqZDyMsW8Bh7OWP2UuXE06wfS/c+tg6D+ulO0n2F
         mgj6O+QQKrRh1yiIcFj5zi6PbnisW0k7pT55dyXFpL8rzJFy/tDkRJs7B/Tu6W7kEybf
         2LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93XQLwbYeCf63UE53dzUuC+1/WTpcTLL+8N2oF5rDc4=;
        b=WdjuQcPKhDZ8WJO7QjgLpS2ezmBTABgn/6b9k0bv+rYYGsL/G4gBuJQ+zCmzE3xei+
         I2SsxuRyGm4UbrhRxGOfgJU82bdwr0d2C2x1D9F/1bFYt4dpWxlgoxu98NVwtrpbqyzt
         6jhbdLxWQGZRJO9G4c/hrzdqeE5SZeUMrO7K8WfkbQB9dStB85kGGE9e2vD+aJR2JzD4
         D8jaTxdGah5GBFS7BgAhOx+DmwCJewvZ0PkCaKNlFk24bAy6FN3RvxOeBANKUjCPxzij
         n43vmMbFQGV0t3A2hexgXCRj+ah1McQY9rNIeYQQ6iLzi2QcFryfcmsiXRRcpFymIDXu
         NFWA==
X-Gm-Message-State: AOAM530UE4V04+hLgIRrDUkbPZIIeIIS7kwQ1UUGNK2DhcmHXufDoTbx
        FOjRg98+lY0Bw7FJaSoYajVBLFavOARMp+z6NZ7NFA==
X-Google-Smtp-Source: ABdhPJyRywStsernS8d7kyTXfXyBxHOAwr2Z7AJaTgpqKviYKWGPUloD1O+LjRFo98TleMDWYy7LWFT9g9zKibl0fic=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr38335802ljg.144.1594502456595;
 Sat, 11 Jul 2020 14:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200630212958.24030-1-mark.tomlinson@alliedtelesis.co.nz>
 <a1dc8f14-187d-a804-45bb-d1fa25ff7b01@broadcom.com> <760595a8cdfeb0156d5180ecaeb2ee4487f50cc7.camel@alliedtelesis.co.nz>
 <86c009a8-05c4-40a3-daef-6d9e848642a3@gmail.com> <db96187e25342cd36133cde64ef742e03325c8c3.camel@alliedtelesis.co.nz>
 <cd40f919-f8d9-cde4-6cc5-f523e4973c3b@gmail.com> <CACRpkdZRQq3EbibSWcKnTp6+iFJACeaytQEX+zR69Y_4LMSkYg@mail.gmail.com>
 <e5d97c2a-95fb-e02d-029a-c19ceb1b166f@gmail.com>
In-Reply-To: <e5d97c2a-95fb-e02d-029a-c19ceb1b166f@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 11 Jul 2020 23:20:45 +0200
Message-ID: <CACRpkda_hYA23mC3qnF_jUuhgU9+JZj1rWv2h3o8e+8oxnth1Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: initialise nsp-mux earlier.
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>,
        "ray.jui@broadcom.com" <ray.jui@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 11:09 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 7/11/2020 2:07 PM, Linus Walleij wrote:

> > I never got an updated patch. My last message was:
> >
> >>> so you mean something like this?
> >>>
> >>> if (err == -EPROBE_DEFER)
> >>>         dev_info(dev, "deferring probe\n")
> >>> else
> >>>         dev_err(dev, "... failed to register\n")
> >>
> >> Yes exactly.
> >
> > Patches welcome :D
>
> Not sure how useful the dev_info(dev, "deferring probe\n") is nowadays
> given that the device driver core will show which devices are on the
> probe deferral list, maybe we can turn this into a dev_dbg() instead?

Oh right. Yeah that sounds right, then we can see that it's the
GPIO core bailing and deferring it when we turn on debug.

Yours,
Linus Walleij
