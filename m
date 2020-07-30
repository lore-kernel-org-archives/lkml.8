Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AAFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AAAB20829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWuHm23T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbgG3QSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3QSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:18:42 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D6DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 09:18:42 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z17so7840344ill.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFpUgsSUr/jtVIusv5yowX+L5bNHFtEGoq677Selrmc=;
        b=GWuHm23TrFWnj5is5q4cfElU1gXC+8A3ORSZrC8HLTqvdjnzKRa3mL3W7RHQ58gsNe
         cU3XThUbR2EwhMEMQlGI4/+O2T9ZHFUEBUBD5QqNeIzRYt2M2eUoPsl2V/fw2GG9ulIx
         oMiz+inoHqyxe/Lz9iwW78+XwiAXLVrv5TaPsrxHFVU28T/LLciGXiPIcCzyMNSA7C64
         qFmJiejEcoyxFE5unYO7ODTKt9Dg1bbh2nMKzWWtzh5TH6WUDRsCapIR91sHcNZtwoaS
         aQWMi/ZZYgE67Gx6DLjkvvXlw04Rs9KqDHEpmXbzyRU7KUGSwJIk2XenNGMO6Xhz+tm3
         Emjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFpUgsSUr/jtVIusv5yowX+L5bNHFtEGoq677Selrmc=;
        b=kUDdeLT4PRPZByigVaMANzplE6ujT270QQNst+QFxylw7bgP3ABrBzh0iSjSI4SQZE
         QzCTMMiAdSBD6snsEBAoQUDSlwyM3u0fwPXbGkwwhztYlSdNDqsQZZ0MCH+Z8H0ayC9B
         Xg3tvoNq4+bQC0VbRMIduYz4Oe4BVT4DmUsWrYA/L8UKF8iNhVHwiHNeHuFkmvfMCmho
         RMxGKRMayD/pTsQUlDghlGf4ht+K2aQjsqYX9xQ+57CfVxqEk4N3qhYjK0RLC6QtMWVc
         xsaq17aqLVNm+erNdtzUqVbDSkk3aXnLkweQgV05C0a7lqP6N3NEzJhTKuFFBetCceI+
         a4RA==
X-Gm-Message-State: AOAM532vVJwRrTBG4RFRt+yECDaqhm/3fyyGVy5NHTljIIV6tWDWDd+Z
        T8pMNB+ZiGWpqVELAA+E7T7vK09pa+Uc+HqTM7k=
X-Google-Smtp-Source: ABdhPJyXPg4c6fWqnKb2CCajM+SSAbdZ0W93Ppa+Cn0Gt64j1ss1Vv9bCOTf9jgsn0br8Q5KQbfaX4stm6hrnk3m4P0=
X-Received: by 2002:a92:bb4d:: with SMTP id w74mr26338540ili.161.1596125921599;
 Thu, 30 Jul 2020 09:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200713144331eucas1p25911c4ffa9315f632d8f6dd833588981@eucas1p2.samsung.com>
 <20200713144324.23654-1-a.hajda@samsung.com> <e55a23bf-59bb-43c6-f7d7-467c282b8648@samsung.com>
 <20200730070832.GA4045592@kroah.com>
In-Reply-To: <20200730070832.GA4045592@kroah.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 30 Jul 2020 09:18:30 -0700
Message-ID: <CAKdAkRTKjHg2y8yTFgxr4yY98M8D2noutDBfB1mh7wwLLQrYbw@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] driver core: add probe error check helper
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 12:10 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 28, 2020 at 05:05:03PM +0200, Andrzej Hajda wrote:
> > Hi Greg,
> >
> > Apparently the patchset has no more comments.
> >
> > Could you take the patches to your tree? At least 1st and 2nd.
>
> All now queued up, thanks!

I believe it still has not been answered why this can't be pushed into
resource providers (clock, regulators, gpio, interrupts, etc),
especially for devm APIs where we know exactly what device we are
requesting a resource for, so that individual drivers do not need to
change anything. We can mark the device as being probed so that probe
deferral is only handled when we actually execute probe() (and for the
bonus points scream loudly if someone tries to return -EPROBE_DEFER
outside of probe path).

And now with coccinelle script we can expect a deluge of patches
reshuffling drivers...

Thanks.

-- 
Dmitry
