Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A22AC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1151220838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdYyZGSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgCCOMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:12:03 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39786 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgCCOMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:12:03 -0500
Received: by mail-il1-f194.google.com with SMTP id w69so2856309ilk.6;
        Tue, 03 Mar 2020 06:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9oLRc0nmTu5IkCd4vNNk7O1hyfZenptlFlSFbqIq9b0=;
        b=VdYyZGScoutk3pxfC0VoVaIu9BuHy1HCBXNmZUt+8WqM74tgN4AlUhmurTANElQaPQ
         yWkKVfparLXbkK9wP5rpSE/sQq3Hss3OvRIaujGhkC+OwuuoV4rfzH72UR1mXvCcu75N
         bVSc7fJbKr0Eo1gxqzECfP0flYFKurnkaLqmoH+pjauXp45yOZg3Aw8hLFJnKTJo8bCp
         33yx0V33Hr/GIxiiX0vKrYuVXwa/w9fY4M5yVf4jjaZVg0Uc/zUhTtih+ggCCqJkcKRZ
         8cLtv8b5Z6j4Zhi7drt4vRJ3k3qYTGPfNOh6qltZmGnkwCouqVyQCtX/5bTgPeh81ejZ
         F39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9oLRc0nmTu5IkCd4vNNk7O1hyfZenptlFlSFbqIq9b0=;
        b=Ml9uK2hasTjKqQrtAD6quKp39tLEGSNzG8rHO7mN5jhAK9+QQMm+QNBOxNOrvY5fHA
         ZVJfZ0GEsGx9ndYaiZSG/QZ0ysL/+VK7OB9j7//baiK+wVBtnF7NbtXe8tG7Htd+yeXc
         DGxn+/Qf4NeP8aJAfK+zpI0axTsZUpf2PmrzvqYBv4RVdfD0//UofoNVqWxRRH74M/Br
         aQfCy21YB9UC6RqlkGM8g19ITufN99LHoh4gmec0WmwICLnvSATDw7QNWj9ADfvNklxJ
         1Gt6RdSeV+YP9ye3mSdIpPg2cm1jddCKUaTvSPUGWAGRhpL4LifYGPewlfHhdLJ+7+99
         GRzw==
X-Gm-Message-State: ANhLgQ1gkq999gO1AKm9sz3DCUdx5DqwJ8H/otVN3EvSs/F4x8DUP+CM
        qqkYETUB09CqxsDcwIDS4eLB34K6G3wSoTHsjnQ=
X-Google-Smtp-Source: ADFU+vurE9ThOeaOHx0MHGxMnPxoGfO/3ZZeZtvaaomjQ7bHlMWt7ERjyJ02dTTMc6V00/ur6J0Ef8fA5gobdIyxzN8=
X-Received: by 2002:a92:3a55:: with SMTP id h82mr4919098ila.75.1583244722519;
 Tue, 03 Mar 2020 06:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20200302125310.742-1-linux.amoon@gmail.com> <20200302125310.742-2-linux.amoon@gmail.com>
 <7hfteqr7za.fsf@baylibre.com>
In-Reply-To: <7hfteqr7za.fsf@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 3 Mar 2020 19:41:51 +0530
Message-ID: <CANAwSgS_9uterktdPqSchyRDjfytEQFU1eci+a4oDmG-K1izuw@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] arm64: dts: meson: Add missing regulator linked to
 VDDAO_3V3 regulator to FLASH_VDD
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Mon, 2 Mar 2020 at 22:48, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Anand Moon <linux.amoon@gmail.com> writes:
>
> > As per schematics add missing VDDAO_3V3 power supply to FLASH_VDD
> > regulator.
>
> Could you please add a link to the specific schematics you used to find
> this usseu?
>
> > Also add TFLASH_VDD_EN signal name to gpio pin.
>
> Your patch does not do this part.
>
> Similarily to the other patch, can you explain in more detail (including
> kernel boot logs) how the SD card is not working?
>
> I just tested with latest mainline, and the MMC driver is detecting both
> the eMMC and the SD card.
>
> Kevin

Ok lets discard this changes, I have tried many dts changes
but I do not know where is the problem or where I am going wrong.

-Anand
