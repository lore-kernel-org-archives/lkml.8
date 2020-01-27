Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BADC35247
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 07:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8912071E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 07:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSO/uE+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgA0Hzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 02:55:48 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35146 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgA0Hzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 02:55:47 -0500
Received: by mail-vs1-f67.google.com with SMTP id x123so5061688vsc.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 23:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JisW5FdHqDfpueRuACrKxki3mS2+DqkIGJ6tqvYKBYg=;
        b=kSO/uE+41usEvH7ebSjUhk6e1/GR1kdSgxZbiRxsCAhlZoPKgznwup/h/2aiurqXba
         seFxgj3oUfrgEWcKa+G614+LeCAaTNBjCdbjJPXw0HZTQ7jIJIx56MVRyj5idy2Njihw
         1lvg7u/sCsRI9lQAUgiE+1pj3eYt3mM8RKqpvOqGY4GoQ8WpnDC8loBTB3RIAdXpJd1t
         uvhGn77x1mkhssxugQBP4QZX/BGJNtXHXbfds528PcECqhauXzE+uRrC+XgHw3VmoWxm
         cfiAWEvIJOhatU7LA2qPT3/WwEw8MlcDjWSC/qZE6TC9IgUl8qSgQSK+hpv1LKGzU+vi
         04YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JisW5FdHqDfpueRuACrKxki3mS2+DqkIGJ6tqvYKBYg=;
        b=axOr7iTBNwHRDj8UvCUOJ2ZWGKrShxhWgYtmnewNCxJ1cq2EA0IT6G9Spcr1wLybA1
         FNLLIqiX/gLstI9njChU0Ro8xzlWDaXgzCaYACd0pIWh3cKjMg9smEqyMFq2Kt9CykS1
         yhYeOS+v+74djA/+gLY9FS3tJpB0RegylWNNCKDFd4G0HkH7fq9f+zZVqHQ0kWAu1xR3
         Lg7ibWVOjrMwM/B1es+tzN754R4tW3fXN0kZ5ogFdnydrN0uSHn3Kt0ArkqQRm0FCxnU
         Y3XsFQHyl3KLxdRIMzNUJorla7uCusB7fr0jeCcYdMSvRMEKwLOvQCEs4X5NdlJz7G2G
         eGSw==
X-Gm-Message-State: APjAAAXD8x1egdcQJDNfgBe9eWDSXU4MXtg/QCQFaWeBc6VF37fHCeZ0
        uXQ+9qp2gTxrzHvsuVhSb5h5IK6wOkowpWCCUPeCTA==
X-Google-Smtp-Source: APXvYqyL1TCg49AaeGX4CVUErd9kezem7knF5p9I+JWV1m4AIpmUm9yBXdiHxcp8rC0t9W4QBLYziKJLuXWuYii+iQs=
X-Received: by 2002:a67:ee02:: with SMTP id f2mr584267vsp.165.1580111746386;
 Sun, 26 Jan 2020 23:55:46 -0800 (PST)
MIME-Version: 1.0
References: <20200108052337.65916-1-drinkcat@chromium.org> <20200108052337.65916-6-drinkcat@chromium.org>
 <b58a8cf9-3275-cf89-6dff-596aceeb8000@arm.com> <CANMq1KBcNr=1_poBHrA_SDo_h-5i3e5TMqASEVaDj5LevsRcOQ@mail.gmail.com>
In-Reply-To: <CANMq1KBcNr=1_poBHrA_SDo_h-5i3e5TMqASEVaDj5LevsRcOQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Jan 2020 08:55:10 +0100
Message-ID: <CAPDyKFr4Vz1ihuFQNnhDLEnOs=BZ1n2wzw3CATgPcDXs9g54uA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] drm/panfrost: Add support for multiple power
 domain support
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Steven Price <steven.price@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 at 02:53, Nicolas Boichat <drinkcat@chromium.org> wrote=
:
>
> +Ulf to keep me honest on the power domains
>
> On Thu, Jan 9, 2020 at 10:08 PM Steven Price <steven.price@arm.com> wrote=
:
> >
> > On 08/01/2020 05:23, Nicolas Boichat wrote:
> > > When there is a single power domain per device, the core will
> > > ensure the power domains are all switched on.
> > >
> > > However, when there are multiple ones, as in MT8183 Bifrost GPU,
> > > we need to handle them in driver code.
> > >
> > >
> > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > ---
> > >
> > > The downstream driver we use on chromeos-4.19 currently uses 2
> > > additional devices in device tree to accomodate for this [1], but
> > > I believe this solution is cleaner.
> >
> > I'm not sure what is best, but it seems odd to encode this into the Pan=
frost driver itself - it doesn't have any knowledge of what to do with thes=
e power domains. The naming of the domains looks suspiciously like someone =
thought that e.g. only half of the cores could be powered, but it doesn't l=
ook like that was implemented in the chromeos driver linked and anyway that=
 is *meant* to be automatic in the hardware! (I.e. if you only power up one=
 cores in one core stack then the PDC should only enable the power domain f=
or that set of cores).
>
> This is actually implemented in the Chrome OS driver [1]. IMHO power
> domains are a bit confusing [2]:
>  i. If there's only 1 power domain in the device, then the core takes
> care of power on the domain (based on pm_runtime)
>  ii. If there's more than 1 power domain, then the device needs to
> link the domains manually.
>
> So the Chrome OS [1] driver takes approach (i), by creating 3 devices,
> each with 1 power domain that is switched on/off automatically using
> pm_runtime.
>
> This patch takes approach (ii) with device links to handle the extra doma=
ins.
>
> I believe the latter is more upstream-friendly, but, as always,
> suggestions welcome.

Apologies for the late reply. A few comments below.

If the device is partitioned across multiple PM domains (it may need
several power rails), then that should be described with the "multi PM
domain" approach in the DTS. As in (ii).

Using "device links" is however optional, as it may depend on the use
case. If all multiple PM domains needs to be powered on/off together,
then it's certainly recommended to use device links.

However, if the PM domains can be powered on/off independently (one
can be on while another is off), then it's probably easier to operate
directly with runtime PM, on the returned struct *device from
dev_pm_domain_attach_by_id().

Also note, there is dev_pm_domain_attach_by_name(), which allows us to
specify a name for the PM domain in the DTS, rather than using an
index. This may be more future proof to use.

[...]

Hope this helps.

Kind regards
Uffe
