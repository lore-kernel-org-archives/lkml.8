Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D8FC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC17207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AN/2BJ8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgG1G40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgG1G4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:56:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342B1C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:56:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id p14so15882962wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EzvrXWpHQNdpSbezzz5RHbcrWIdGyn8mBuYW7/LNbzE=;
        b=AN/2BJ8ftihaC5U7VYaGUe51vSbgZBy0qgZKto5kdNZYHnMMU0klhv9/thZCz2DkDt
         dDxR2di/EgMBX5g/fOZXZcBeU6DbcT57YbEGbJG/kTWUuSOzJzV8O4RMU0+EmduM9cMg
         2YrS+SqmfKDxhdBRo9CudmQrzMu35wRH3I1IJhs5caPwQ/jktBAkwH5iELcp/UkXRYWm
         S+Nr7PQ10VU16ICkcXkIjg2pYuJo9zNlFLGGib/eOzI2BX80dftzNtJBkpsj+WGeqrUR
         KHX2zV1SA8I2AjT0Eh4rPiWPbMSSyEu8lfLb+CgqlqnkZpfy93Xsa3lnz7qGBm64apHu
         76sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EzvrXWpHQNdpSbezzz5RHbcrWIdGyn8mBuYW7/LNbzE=;
        b=FXC650nw4a4XwsQDmaHLLVquHnryAwJx+ZbPK1n97yRFEGtlIrhzo7JHG4OtXYq/c3
         LFCY9u9EcMjApolkLQr82lU/HveDKYCIN80HGnoQ04vPw1mQUqbfhIdIvDN26S4KJkmH
         PGHKidTQIh2N6agnxVcTHMM7mS8GMuKl8ksOaXHj60Fhz01jxO1cjWkDiGOqb/hgrzDY
         Cl06zbhNCoz3ojNlOGy62ieCVtVtiByXhYKcBxNGaZIl/KJkgFR8pzE6cYJk7nfHzD1/
         KbiXOdeqxUtcxWV7bm7DBv3W8Ei3aHVms9joOwOj+xZ2+FgX7v35Vn81k89yzZ4Q5u+j
         FsMw==
X-Gm-Message-State: AOAM5311qa4nbXyJ4zflEvQsKXmhWcvJsgXAIN7V+0raoeZ487I0e3nq
        +2/ziRH+Y7OkS7DrhhxH7xqGSA==
X-Google-Smtp-Source: ABdhPJz2E995BnQURgOq+VOSHacfZHoxet9ax0lW2Q3YzkefTZM18rSXI9SMEvORfr9BIIubRt2bgA==
X-Received: by 2002:a1c:2d89:: with SMTP id t131mr2655127wmt.151.1595919383931;
        Mon, 27 Jul 2020 23:56:23 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id 78sm2777722wma.31.2020.07.27.23.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 23:56:23 -0700 (PDT)
Date:   Tue, 28 Jul 2020 07:56:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 1/9] mfd: mt6360: Rearrange include file
Message-ID: <20200728065621.GC1850026@dell>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
 <1594983811-25908-2-git-send-email-gene.chen.richtek@gmail.com>
 <20200727110821.GH1850026@dell>
 <CAE+NS34FexE-LwbzkOLepKytKCbKm3RowPQKqROR_a6wCrVLLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS34FexE-LwbzkOLepKytKCbKm3RowPQKqROR_a6wCrVLLA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020, Gene Chen wrote:

> Lee Jones <lee.jones@linaro.org> 於 2020年7月27日 週一 下午7:08寫道：
> >
> > On Fri, 17 Jul 2020, Gene Chen wrote:
> >
> > > From: Gene Chen <gene_chen@richtek.com>
> > >
> > > Rearrange include file without sorting by alphabet.
> >
> > Why are you making this change?
> >
> 
> Personal coding style references from upstream code.
> I can discard this change if it doesn't make sense.

That is really wrong.

This is upstream code.  You should abide by the coding style.

Include files should be arranged alphabetically, not arbitrarily.

> > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > ---
> > >  drivers/mfd/mt6360-core.c | 11 +++++------
> > >  1 file changed, 5 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > > index e9cacc2..df4506f 100644
> > > --- a/drivers/mfd/mt6360-core.c
> > > +++ b/drivers/mfd/mt6360-core.c
> > > @@ -5,15 +5,14 @@
> > >   * Author: Gene Chen <gene_chen@richtek.com>
> > >   */
> > >
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > >  #include <linux/i2c.h>
> > > -#include <linux/init.h>
> > > +#include <linux/crc8.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/regmap.h>
> > >  #include <linux/interrupt.h>
> > > -#include <linux/kernel.h>
> > >  #include <linux/mfd/core.h>
> > > -#include <linux/module.h>
> > > -#include <linux/of_irq.h>
> > > -#include <linux/of_platform.h>
> > > -#include <linux/version.h>
> > >
> > >  #include <linux/mfd/mt6360.h>
> > >
> >

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
