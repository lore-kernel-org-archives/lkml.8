Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE48DC33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 00:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09B9246AE
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 00:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="byvFSGFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgASAds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 19:33:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42429 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgASAdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 19:33:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so21185761lfl.9;
        Sat, 18 Jan 2020 16:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MmaQokh5a/DLTYKgznDuxS/Z2BqMQMRVUTv6i4zCRcE=;
        b=byvFSGFGou6SaScURYCchNOH7OMFxlHgNP78hzMwf7sth9vDpwtKkfQgZVzGWYXamG
         b9IEh+G5RvT+8z2tq5jXsRAZnvdQQj5kJfjlJDWQjJWIF8exX9GkCLgTV9+GKcUl0zsV
         lubfGI2DZXcnNeJ4mVKA5It+07Pi4wECAF6j/m3S7hb2aTiZgIfGt/yby5m+nCQe2c/Y
         UColufngjvFz0nrEeA5VTw1lNgDG4tIoa1B4sXo2tke8yPPwxdM+3Dbu+VdkD2OX+kTm
         YBHeY6ccejFduVUBIoEum2M45FnS5ms+7pYETJrDh8OGga78q7hzvZscRvtKpysd8Tn/
         UUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MmaQokh5a/DLTYKgznDuxS/Z2BqMQMRVUTv6i4zCRcE=;
        b=MMHQpMd1qWkAf1vUQFOsUTH5uQfTLaiy7PjEnsgA3k96BfkPIz0PQTphy2uInnhXdL
         3wACH5a2I9oNB8kZTsVmuE7YOM8l+FfCmgsEIqIxzv3VOD4Jlu2i+lmvzHjxJoG9PTOy
         6xKEGJy8KWiEL8rP+XTcyaXqba9qmo5W+v38QfqM0P+69FQJ0RJYAZwaACysAFTrD1Ut
         q1FQDORpWVidoqG2BVnBKi6pGFspyqUwcZMseodL/hENaFv11ZJxwYrPSk57coJC0mlH
         hoochpo0CNtZ6gXT+WoC8kU4I7pbx8L8J03Rzzu4mvk2EAvHLDx+Yide73kYddKc9Tec
         5Jaw==
X-Gm-Message-State: APjAAAWHishaEgZ6h6+65pV95e20RCcaK0pbgpQBK3MEpL99cyIbCp1h
        93TOIi3oiMmjcPsfaUbMzF9IRXOJo8fSo8qykR8=
X-Google-Smtp-Source: APXvYqy9fjL/lO36Drihr4Gn/KuATmxU5kBZ/RMlbYV0awIZi/MwkQd74JT9ipvgIULbSWgIDebMGcaLIHlKmxpOmtk=
X-Received: by 2002:ac2:5498:: with SMTP id t24mr9417574lfk.84.1579394025414;
 Sat, 18 Jan 2020 16:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20200118172615.26329-1-linux@roeck-us.net>
In-Reply-To: <20200118172615.26329-1-linux@roeck-us.net>
From:   Ken Moffat <zarniwhoop73@googlemail.com>
Date:   Sun, 19 Jan 2020 00:33:34 +0000
Message-ID: <CANVEwpbgi5sUdBTyo330oCZ1T-cD+DoBJWrE9JbXw-DvYTiBvw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] hwmon: k10temp driver improvements
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        =?UTF-8?Q?Ondrej_=C4=8Cerman?= <ocerman@sda1.eu>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Brad Campbell <lists2009@fnarfbargle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2020 at 17:26, Guenter Roeck <linux@roeck-us.net> wrote:
>
> This patch series implements various improvements for the k10temp driver.
>
> Patch 1/5 introduces the use of bit operations.
>
> Patch 2/5 converts the driver to use the devm_hwmon_device_register_with_=
info
> API. This not only simplifies the code and reduces its size, it also
> makes the code easier to maintain and enhance.
>
> Patch 3/5 adds support for reporting Core Complex Die (CCD) temperatures
> on Ryzen 3 (Zen2) CPUs.
>
> Patch 4/5 adds support for reporting core and SoC current and voltage
> information on Ryzen CPUs.
>
> Patch 5/5 removes the maximum temperature from Tdie for Ryzen CPUs.
> It is inaccurate, misleading, and it just doesn't make sense to report
> wrong information.
>
> With all patches in place, output on Ryzen 3900X CPUs looks as follows
> (with the system under load).
>
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:        +1.36 V
> Vsoc:         +1.18 V
> Tdie:         +86.8=C2=B0C
> Tctl:         +86.8=C2=B0C
> Tccd1:        +80.0=C2=B0C
> Tccd2:        +81.8=C2=B0C
> Icore:       +44.14 A
> Isoc:        +13.83 A
>
> The voltage and current information is limited to Ryzen CPUs. Voltage
> and current reporting on Threadripper and EPYC CPUs is different, and the
> reported information is either incomplete or wrong. Exclude it for the ti=
me
> being; it can always be added if/when more information becomes available.
>
> Tested with the following Ryzen CPUs:
>     1300X A user with this CPU in the system reported somewhat unexpected
>           values for Vcore; it isn't entirely if at all clear why that is
>           the case. Overall this does not warrant holding up the series.

As the owner of that machine, very much agreed.

>     1600
>     1800X
>     2200G
>     2400G
>     3800X
>     3900X
>     3950X
>

I also had sensible results for v1 on 2500U and 3400G

> v2: Added tested-by: tags as received.
>     Don't display voltage and current information for Threadripper and EP=
YC.
>     Stop displaying the fixed (and wrong) maximum temperature of 70 degre=
es C
>     for Tdie on model 17h/18h CPUs.

For v2 on my 2500U, system idle and then under load -

--- k10temp-idle 2020-01-19 00:16:18.812002121 +0000
+++ k10temp-load 2020-01-19 00:22:05.595470877 +0000
@@ -1,15 +1,15 @@
 k10temp-pci-00c3
 Adapter: PCI adapter
-Vcore:        +0.98 V
+Vcore:        +1.15 V
 Vsoc:         +0.93 V
-Tdie:         +38.2=C2=B0C
-Tctl:         +38.2=C2=B0C
-Icore:       +10.39 A
-Isoc:         +6.49 A
+Tdie:         +76.2=C2=B0C
+Tctl:         +76.2=C2=B0C
+Icore:       +51.96 A
+Isoc:         +7.58 A

 amdgpu-pci-0300
 Adapter: PCI adapter
 vddgfx:           N/A
 vddnb:            N/A
-edge:         +38.0=C2=B0C  (crit =3D +80.0=C2=B0C, hyst =3D  +0.0=C2=B0C)
+edge:         +76.0=C2=B0C  (crit =3D +80.0=C2=B0C, hyst =3D  +0.0=C2=B0C)

I'll ony test v2 on the 3400G if you think the results would add something.

=C4=B8en
--=20
If a man stands before a mirror and sees in it his reflection, what
he sees is not a true reproduction, but a picture of himself when he
was a younger man.        -- de Selby
