Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF88C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6297F2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WSfQ0nd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgD2SbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2SbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:31:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED49C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:31:08 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so1124164pjw.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=jipXnRNqbc0qX0ErEpuBweBWta4tR4eWXcMPowlUvJI=;
        b=WSfQ0nd4b3fJoziq3+KweOHUjLhQmQJDFTtRJ3F3TCJ5y9wh3ntqTnP/l+TCl10jFa
         6MQMQGqyFi5Y6RdAvONkeZ4dQqCyjKfJBiGfRY7mcatRrjCTM6Bfja5s9SVRbvC0fcTD
         0bcoV3hJ8okScE9Yx5aD5tG4xJ78hjMb/MjjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=jipXnRNqbc0qX0ErEpuBweBWta4tR4eWXcMPowlUvJI=;
        b=BDnmQ7+2jm/pdKeU8hS7w3l+EWWxejOrLGD09l/NkxWl9Iy9lMwYEHJauRmPQKLVCG
         Hv0GGyBaqoN/KQyQ0mI7+0bli4wPRZwI/FxgQ2AtlfE48iHgun6LS4/fGjotKfV6XdPR
         C/GjmI1DYoe4AocMmktUofijYHZCqlH2ZAdsRxug/H8TqMggvYaS588gHYB0PIQ5hiQq
         j+KB9cwd3whYcK+Te3jCbEIb9W3d1L8DHoVcZSsIRczuffETc3oSNw3jxNtzjL1st5cC
         0HYLYw46dImX7PAIt7mL+Hw7VCrGyDE4Jyou0hvtCsHA8pOiQSrrt2i8mXArNjI4VdM/
         EcOw==
X-Gm-Message-State: AGi0PuYA8c+VUQL+6MmgA8/nIYIyu/OC/PGpsUzqCOU59EbwDDBsO/Ej
        ZBj/BaaeKqWaAuUp/0uhRyAwUzURabo=
X-Google-Smtp-Source: APiQypKkmjEMnyFbV00Cl9uoPBqpsYGURW9WxlfekvOSBT01al7FcGF5ckKPor7St1anhaVTeG3rnQ==
X-Received: by 2002:a17:90a:17ed:: with SMTP id q100mr4942776pja.80.1588185067361;
        Wed, 29 Apr 2020 11:31:07 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e11sm1602547pfl.85.2020.04.29.11.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:31:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200429180818.GA3062@xps15>
References: <20200428181010.170568-1-swboyd@chromium.org> <20200428181010.170568-2-swboyd@chromium.org> <20200429180818.GA3062@xps15>
Subject: Re: [PATCH v2 1/2] coresight: Include required headers in C files
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 29 Apr 2020 11:31:05 -0700
Message-ID: <158818506575.117437.11635372928426076937@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mathieu Poirier (2020-04-29 11:08:18)
> Hi Stephen,
>=20
> On Tue, Apr 28, 2020 at 11:10:09AM -0700, Stephen Boyd wrote:
> > diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/driver=
s/hwtracing/coresight/coresight-cti-sysfs.c
> > index aeea39cbd161..77e14e770806 100644
> > --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > @@ -4,7 +4,14 @@
> >   * Author: Mike Leach <mike.leach@linaro.org>
> >   */
> > =20
> > +#include <linux/atomic.h>
> >  #include <linux/coresight.h>
> > +#include <linux/device.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/sysfs.h>
>=20
> What is io.h and slab.h used for in coresight-cti-sysfs.c ?

io.h is for readl_relaxed() usage in this file. I added slab for the
devm_kcalloc() but it doesn't look necessary given that device.h is
where that is defined, not slab.h. Thanks for catching that!

>=20
> > =20
> >  #include "coresight-cti.h"
> > =20
> > diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtr=
acing/coresight/coresight-cti.c
> > index 7fc1fc8d7738..be61c1705916 100644
> > --- a/drivers/hwtracing/coresight/coresight-cti.c
> > +++ b/drivers/hwtracing/coresight/coresight-cti.c
> > @@ -4,7 +4,20 @@
> >   * Author: Mike Leach <mike.leach@linaro.org>
> >   */
> > =20
> > +#include <linux/amba/bus.h>
> > +#include <linux/atomic.h>
> > +#include <linux/bits.h>
> > +#include <linux/coresight.h>
> > +#include <linux/device.h>
> > +#include <linux/io.h>
>=20
> Same comment as above.
>=20
> No need to send another version if these are mistakes - just let me know =
and
> I'll do the adjustment.
>=20

Same here, io.h is for the readl_relaxed() and writel_relaxed() calls.

So please remove slab.h from the two files (but not the other one) when
applying. Thanks.
