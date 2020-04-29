Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA94C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16BE6205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RY7T64tE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgD2TY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2TYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:24:55 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6598AC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:24:54 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id e9so3499322iok.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AKsdWrButU9zZh7f3zPyNruBBcTlhNf0ix/ZdV3ytX8=;
        b=RY7T64tE1A0/zDQsrHGsORQp+bRJbj+IDkWlJWFcXLIJ6DtFUFKKsqOGJ1CBx1bo1B
         96MWfo7UEkcGMPOhJpnFjaZ5MjxQgpgYXstKPrhHQcG8sim9Hpq8dF4EPQd2AudNkRMz
         +h+/r6DRyE0+ZU/kRMd76A0Pyrm48yMF1eD1nXXGdAn47kZoD3dvBX6R2tfE58Y9WC4E
         VgQlH5B7ywAsWRlfpawOYFasrbArde0iJBrzOclzay7HsR5uFCT6r8DxvsXIJOOPHMBt
         HyO8LIUJxT0h8e8tXp73WXC1HwZ/E0x0u5rTsxSL2V/Zsp6Q4NHpx44YPCAj2wThWcS+
         2ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKsdWrButU9zZh7f3zPyNruBBcTlhNf0ix/ZdV3ytX8=;
        b=K8iD1O4A+hofPUx/a/pmm+RkAMsQO9kgS43DDKS3ceTJBvrEDLTIeNYE5IZ4UOYIUa
         3tnNXSUFWA8RF18YdKf8i8ehj2xAyNJrun6VmMKYa43QZr0+Sa7oMW3VsIF8TSeibv4c
         sU5vgxvFuo9ZzUgsTpAP6tqZF9Jgwq6u1f/UVl69Qsn1hTZxDPlEx0wtuIvSfK36/jWX
         8cHGplgs6KzGavXiQ02rmGkVT5dkkNTW3+9XNGqDq0Ak8qRyttMTYSRSdlMmq7hURRSI
         JcVIARXArxCIklU2xF0dpK6oLvWJ09Z1dSw2y9cLlp5VuOJXEv1Y2ZiN7BJ68RTrWSzX
         KWWQ==
X-Gm-Message-State: AGi0PubL87UDebe7C/69LQWbMDPMlGD47kWu1atm3NI+vxrcDbo+IAEQ
        KWwWVtL9K5HVk2Z23LyMwigNdYbNnDbizoA4HIY5sg==
X-Google-Smtp-Source: APiQypL1/XY8YVXayBS6hnXqD/4WFPsvji7taGqv2UK6Db5TMixiDkDqDRnm6+H7EUrv2W0NA0xTru5Y18nPCwILdQg=
X-Received: by 2002:a02:b88e:: with SMTP id p14mr30394751jam.36.1588188293662;
 Wed, 29 Apr 2020 12:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200428181010.170568-1-swboyd@chromium.org> <20200428181010.170568-2-swboyd@chromium.org>
 <20200429180818.GA3062@xps15> <158818506575.117437.11635372928426076937@swboyd.mtv.corp.google.com>
In-Reply-To: <158818506575.117437.11635372928426076937@swboyd.mtv.corp.google.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 29 Apr 2020 13:24:42 -0600
Message-ID: <CANLsYkzkq=EuKx_=W2jv2TeWpM3P=Pd9NYS18VfG9KCey=2--g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] coresight: Include required headers in C files
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 at 12:31, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Mathieu Poirier (2020-04-29 11:08:18)
> > Hi Stephen,
> >
> > On Tue, Apr 28, 2020 at 11:10:09AM -0700, Stephen Boyd wrote:
> > > diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > > index aeea39cbd161..77e14e770806 100644
> > > --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > > +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > > @@ -4,7 +4,14 @@
> > >   * Author: Mike Leach <mike.leach@linaro.org>
> > >   */
> > >
> > > +#include <linux/atomic.h>
> > >  #include <linux/coresight.h>
> > > +#include <linux/device.h>
> > > +#include <linux/io.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/spinlock.h>
> > > +#include <linux/sysfs.h>
> >
> > What is io.h and slab.h used for in coresight-cti-sysfs.c ?
>
> io.h is for readl_relaxed() usage in this file. I added slab for the
> devm_kcalloc() but it doesn't look necessary given that device.h is
> where that is defined, not slab.h. Thanks for catching that!
>
> >
> > >
> > >  #include "coresight-cti.h"
> > >
> > > diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
> > > index 7fc1fc8d7738..be61c1705916 100644
> > > --- a/drivers/hwtracing/coresight/coresight-cti.c
> > > +++ b/drivers/hwtracing/coresight/coresight-cti.c
> > > @@ -4,7 +4,20 @@
> > >   * Author: Mike Leach <mike.leach@linaro.org>
> > >   */
> > >
> > > +#include <linux/amba/bus.h>
> > > +#include <linux/atomic.h>
> > > +#include <linux/bits.h>
> > > +#include <linux/coresight.h>
> > > +#include <linux/device.h>
> > > +#include <linux/io.h>
> >
> > Same comment as above.
> >
> > No need to send another version if these are mistakes - just let me know and
> > I'll do the adjustment.
> >
>
> Same here, io.h is for the readl_relaxed() and writel_relaxed() calls.

I just noticed the "asm/io.h" at the top of linux/io.h - ok for that one.

>
> So please remove slab.h from the two files (but not the other one) when
> applying. Thanks.

You got it.
