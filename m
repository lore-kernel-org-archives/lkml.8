Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F4CC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97EB21924
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="E7zUJtlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbgDPSIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728383AbgDPSIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:08:19 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97F0C061A0C;
        Thu, 16 Apr 2020 11:08:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x1so1973469ejd.8;
        Thu, 16 Apr 2020 11:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/GV1V435fNTv1enAJ4SR/cS/jvcRTNBMioIZ9zRVBQ=;
        b=E7zUJtlDOlHe5lFxFdiJMXe6VHgBlBqRAq/HIzz8vOtD08Io7zQm4KxBjD3DHXBU3p
         cQF+mIwtvAjMdgpl4IzOyD5RBW8JxARXmrIc6R9/EyX3fSZG/wXwHvp04Myjvu9JvGu6
         SifC++Xm/0m6KXQTzumns2YrrCmYkNsKiA5x9/0xebPLXBQ2M1mXVDkT7k8eDB15peW2
         aHHC+RNfCVAkzruf1MKk9i8O1orE2o/dOBWncfQO93vhDI15iQMqGpvOhrBdkF0Abak1
         UOr88uXK/6ZjnFBVH3qTdr2zd6pHZc9y6M6rYo1lpHOcq85X7IsooURj1b509QF5qMvm
         Gx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/GV1V435fNTv1enAJ4SR/cS/jvcRTNBMioIZ9zRVBQ=;
        b=SUfkkMn1dZ8/cRe2FvSMWCptShpshj3SxCP+Ri1FeW3UNkzUUgOfXH1CsdqLZ2sXct
         iMUf3Otl5z+hSoPmL77y/qPn8yL2NL5gu9j30dgpvZh96Qkc2/a5xnoAyytp6hiK/kjy
         0iC2QeEIYZTyXaxthc32TmIJiE9lQOEjz3xfqyYHD6rG2dIvHw6/iZnDHd6moB4piTdV
         aRSlHH9YQtIwk3lL/BlSQQPTcF9JEZQCE3D6QNuDJJ32zKh3xAPwJHu5jFDnVJ/P6Bgt
         4uQvWmv/uRbM+ywDS/f37J8Jkiyk5mZktgh0sGJbsPqLqEWrDFOluW38RgXMURV5BVD6
         MFZw==
X-Gm-Message-State: AGi0PuZNRBpT0zY1td0KVqDAL2D1AZddLvX+Z9sEdPivau9kzzM+UpdG
        bbbMZiCGEhJ85/mu6XD1sBxnx0FdQkp2Wh8IvrU=
X-Google-Smtp-Source: APiQypKwYkHGxt56C0Q7SaSFBkS/Ts9n2d+vesc4d/k+CGgsFyTfR/Ehj60InmNIJ15VD5fE5OXt4rY0C8t4dTqtkN8=
X-Received: by 2002:a17:907:2098:: with SMTP id pv24mr10943933ejb.22.1587060497564;
 Thu, 16 Apr 2020 11:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200415220533.733834-1-martin.blumenstingl@googlemail.com>
 <c33c8653-16a2-5bcd-97a9-511d958b755a@linux.intel.com> <20200416113822.2ef326cb@collabora.com>
 <18568cf6-2955-472e-7b68-eb35e654a906@linux.intel.com> <20200416122619.2c481792@collabora.com>
 <d3e137fa-54a0-b4ec-eb24-3984eab2a247@linux.intel.com> <20200416131725.51259573@collabora.com>
 <de9f50b8-9215-d294-9914-e49701552185@linux.intel.com> <20200416135711.039ba85c@collabora.com>
In-Reply-To: <20200416135711.039ba85c@collabora.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 16 Apr 2020 20:08:06 +0200
Message-ID: <CAFBinCBy2QXFCU9bu6StqNMLLiDBtmvxNNuh+kPc1tgriSGBwQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     anders.roxell@linaro.org, andriy.shevchenko@intel.com,
        arnd@arndb.de, brendanhiggins@google.com, cheol.yong.kim@intel.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, masonccyang@mxic.com.tw,
        miquel.raynal@bootlin.com, piotrs@cadence.com,
        qi-ming.wu@intel.com, richard@nod.at, robh+dt@kernel.org,
        tglx@linutronix.de, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vadivel, Hi Boris,

On Thu, Apr 16, 2020 at 1:57 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
[...]
> As for the testing part, there are 4 scenarios:
>
> 1/ Your changes work perfectly fine on older platforms. Yay \o/!
this would be awesome \o/

> 2/ You break the xway driver and existing users notice it before this
>    series gets merged. Now you found someone to validate your changes.
The xway_nand driver is still used by 9 (or so) boards in OpenWrt: one
Danube, one ARX100 and the other 7 with VRX200
I can be the person to find out whether your changes break one of
these boards with VRX200 SoC and 128MB SLC NAND (and software ECC
since AFAIK this SoC doesn't have a hardware ECC engine).


Best regards,
Martin
