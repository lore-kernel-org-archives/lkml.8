Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8B3C5ACC4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201EF206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VGTfGueC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgBSXFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:05:07 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:43541 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgBSXFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 18:05:07 -0500
Received: by mail-il1-f193.google.com with SMTP id p78so2215170ilb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 15:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4rTZrvjd+k43gH59N0+bWBoBUjxR7f3cs7vatzlSe4=;
        b=VGTfGueCM+KyWZU8BdKTSiD81U6AeL1BlAl5hB3Hh1E7L8o0QADNfN3PnyJ8INQ4R5
         VcIQ2vNhiXgA8xQUIgGArs3zlHsQei8Q7P1pH+n3bhZaGGQKa6ql9f3KtU7TAcwBD1sC
         /5ORI1SfifdkmxAVrow86X+yCVVLuqbvVHtMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4rTZrvjd+k43gH59N0+bWBoBUjxR7f3cs7vatzlSe4=;
        b=Dy5yJb0gRkM/iEDcZ1nwiAO1JvJvVzbpsC1k+UKFXb/ecLAqA8Yx1CQcQKNIZNqD4y
         ei4PH1ekCHQzK76Tnqm39DvALBgFL59YQoqESkdWKxEwGF8AFhiGiqlFnU1rjSTHoNKm
         pX3CRIklC0WW9ZCNLH5j4Z9DCiFkm/CEeRIL5a4Hi7p/IadxooIugUV0U/ENGHgFSedA
         p6ZUuPnc2SDoMRxUkIW8vYKjvbe/jEUChKYMKnnRpQpSrDKdAMVPkfm+VPQVHXA15+ye
         A59u0zshB6OBb8kjSn8ZxpuOMk6ApOx8kMp5L/3JddoU7p1V4mrTVVKaOiBlDzwWVCH9
         2qHA==
X-Gm-Message-State: APjAAAWFSt3dNvyCe2rkJu3POrpakYnJoCRVWi1Xeqg6JYUEfOYZiKOD
        dEKklukTJ/VAprijsAiMWlBEHBKUnPvOO3x01lv2UQ==
X-Google-Smtp-Source: APXvYqz0Hv+AqnqULyyOEjWy2y/iGz/X3D6tQWeT971GwBfXnyFor9qS0ZWsIGSLE44SwblEyg4zITIUPLDiEw5WlBY=
X-Received: by 2002:a92:8c54:: with SMTP id o81mr26451570ild.163.1582153506521;
 Wed, 19 Feb 2020 15:05:06 -0800 (PST)
MIME-Version: 1.0
References: <20200214062637.216209-1-evanbenn@chromium.org>
 <20200214172512.1.I02ebc5b8743b1a71e0e15f68ea77e506d4e6f840@changeid> <20200219223046.GA16537@bogus>
In-Reply-To: <20200219223046.GA16537@bogus>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 19 Feb 2020 15:04:54 -0800
Message-ID: <CAODwPW8JspiUtyU4CC95w9rbNRyUF-Aeb9TuPm1PzmP6u=y1EA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: Add arm,smc-wdt watchdog
 arm,smc-wdt compatible
To:     Rob Herring <robh@kernel.org>
Cc:     Evan Benn <evanbenn@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
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

> You are not the first 'watchdog in firmware accessed via an SMC call'.
> Is there some more detail about what implementation this is? Part of
> TF-A? Defined by some spec (I can dream)?

This is just some random implementation written by me because we
needed one. I would like it to be the new generic implementation, but
it sounds like people here prefer the naming to be MediaTek specific
(at least for now). The other SMC watchdog we're aware of is
imx_sc_wdt but unfortunately that seems to hardcode platform-specific
details in the interface (at least in the pretimeout SMC) so we can't
just expand that. With this driver I tried to directly wrap the kernel
watchdog interface so it should be platform-agnostic and possible to
expand this driver to other platforms later if desired. The SMC
function ID would still always have to be platform-specific,
unfortunately (but we could pass it in through the device tree), since
the Arm SMC spec doesn't really leave any room for OS-generic SMCs
like this.
