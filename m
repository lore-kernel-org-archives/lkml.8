Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02713C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8A620709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKd7R7wU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgEOLrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgEOLrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:47:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D39C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:47:09 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a4so1534771lfh.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=45kgRpXG7i03a8aYK/zze6qISAEx5tj2uQAGZ3I6Xt4=;
        b=wKd7R7wUiPSkGeRLR4bmBvnxjAzoa5bDzea1mQC2TC//iywTDOrnscPWHHwnT2wBRN
         zG8RPapwFSNe2yLBw1PXmFO6PN9t9xLbL896mRUWVF9opqw2ZHGDnhB6XvEwXjjP5TK0
         QqouoNlAk0oH0zKaljb+LQkkj3wEL5MnpeBDibbTUc4WMpfg1YGPftPOBoD+6POZn/Oc
         7XdVcsS1epDgWiiQZNemBG39s5HVAejKAA0uLa+z44cVYvuzj9Itr3dM7DaaBQ6OBq8o
         wKBXN9qcML/zCSC0xBAXK6bR9aFjkfEPHfdF//RUaPw4ZOlAcA3K95HOsCJonF4js6vA
         l0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=45kgRpXG7i03a8aYK/zze6qISAEx5tj2uQAGZ3I6Xt4=;
        b=dUAzrYWS4EmXU6ImeDZDmv2x3ZEeJYTvoTu24YWpLgzndToGUDAhRkGF8qRybaUus/
         D08mEcwL9BRDY+1ewo9jacn5uMuJR0pMBhGusv/F8hlVYsD5uF1KZ4dS6wm1BPX+WRss
         /+UY2bng54ysGRP3azuxsXvCKGfpENCVdmKcX9w/0T6P3d5kmZt9Lk40gYX6asXzbLq9
         cdf3/UMTXJG4utdXPDb1qgSGx1l8Ebb7apZbUVldVNhq6HJHqNQjvIqjZHOEljRdipzj
         j918BYPLjOuLU3U54vmSanK4aTI+2o1iR9w1RCVixDA7TOZxOnmGaqQgxdwbKNiav1Pp
         wJ0A==
X-Gm-Message-State: AOAM531qY8R5J3cyJ/BO5nte82i819zc90EBH17zCSIhvCR4T4oHFJhS
        GnchmZOt7UzQzGNwvX8Rhu7e9yUceRbfeKBF5OGHig==
X-Google-Smtp-Source: ABdhPJw9T3ehRz1QGBgsSsq2YD8Ju6RCQuQKhNJM37NZA8yAbN3ISFFjuFeCQtTytOPKHcPPQtpoqw0eVjB0lzPbnI4=
X-Received: by 2002:ac2:5f7a:: with SMTP id c26mr2071360lfc.4.1589543228067;
 Fri, 15 May 2020 04:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200514204901.3199-1-xc-racer2@live.ca> <BN6PR04MB0660FE5CCD136539A328B29EA3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
In-Reply-To: <BN6PR04MB0660FE5CCD136539A328B29EA3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 May 2020 13:46:57 +0200
Message-ID: <CACRpkdaPWcbbrEP=HFeLu8ZUcxeQray+9o7E62SfL9VNx9jzWw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] iio: accel: Make bma180 conflict with input's bma150
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:49 PM Jonathan Bakker <xc-racer2@live.ca> wrote:

> The bma180 IIO driver is being extended for support for the chips
> support by input's bma150 driver (bma023, bma150, smb380). Don't
> allow both drivers to be enabled simultaneously as they're for the
> same hardware.
>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
