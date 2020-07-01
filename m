Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5964DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2F320702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwunnEyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgGANb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgGANb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:31:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27C3C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 06:31:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so23803621wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lq1WgfFmu61MO0/hvCR2LLZLBy3Uwi0n25/FVtw+Y/w=;
        b=WwunnEypi/tYVE2V155Ye9Rh/r/EYrbOmZ5Ze7uXWdwNLTMxsDt+qmLlvLGzUf/5wn
         MhBJOLsvSF5a4nAEjB89oHQzzesPsj/X5sUyOA6HIGjvfowcx4ONyiJJHWvh+3XFrqnW
         Kv8q3fGn2B2XZXcGKOiJh64bHNs/oX5yMAXtC5i+K/YezXsslIdWBt0u63pG8mxFuUb0
         gNSmzAQuFS++PNyNJzbGRvD9mqKCqjASXLBDWRfli/qSckBNiJBb/JluRE1l9aB9wAvw
         0UJv7QMdbnhhbROFzoqV8VgD3Dq9jXUi7ethv9LhVGDhMNZs9AIh5KN5OrQRR3YBili8
         lyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lq1WgfFmu61MO0/hvCR2LLZLBy3Uwi0n25/FVtw+Y/w=;
        b=OZ85kiQlWlJMx2K7/UgIUtGnEuFeXDdrKv3S/v5073HLjozJ+YoiI2oSj/dNsB/1ph
         jWf8tzjSvw04fJaKVTK+q/n/ZxvWzfPywHBu38dvfAuikimU9uEgMTTIu2bQHIHPrXbJ
         lQCrbkzoApgS6sxNd8q1ARCHWHKJkF+grSWJbZ/n4oyj1j1iTSKcgPhEJdo2qWhHg4wl
         874hJU/ShLvVmOxvqGjfGc8ahIMq+JK+xCx0wCIsM95UAtjMVpYTOj4PtD9OySRgBJ7h
         yiCvQ6MUOFOejvFQlyuFa2S0ozvGWLX0GJOQrVgSdeW35a4cVe3zXAgNl8+NQYNlj9H+
         h6mQ==
X-Gm-Message-State: AOAM530ZcjhaHaMJxz3Br0geE58DDMJSqPIX/MWnh5hH7NBv2MO/D2t4
        u1GL+XMDocHtewXXC5TA5/Bkbw==
X-Google-Smtp-Source: ABdhPJwhdkzScuksrLgsGHtd1S+LMC2f5NlZILsVEvoZFQRAUH3Vi/kjs90CM8WPKDtHvgXwrhb6kA==
X-Received: by 2002:adf:ed87:: with SMTP id c7mr25800533wro.422.1593610286355;
        Wed, 01 Jul 2020 06:31:26 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t15sm7332266wmj.14.2020.07.01.06.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:31:25 -0700 (PDT)
Date:   Wed, 1 Jul 2020 14:31:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 30/30] misc: cxl: flash: Remove unused pointer
Message-ID: <20200701133123.GF1179328@dell>
References: <20200701083118.45744-1-lee.jones@linaro.org>
 <20200701083118.45744-31-lee.jones@linaro.org>
 <20200701131357.GA2298198@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701131357.GA2298198@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jul 2020, Greg KH wrote:

> On Wed, Jul 01, 2020 at 09:31:18AM +0100, Lee Jones wrote:
> > The DRC index pointer us updated on an OPCODE_ADD, but never
> > actually read.  Remove the used pointer and shift up OPCODE_ADD
> > to group with OPCODE_DELETE which also provides a noop.
> > 
> > Fixes the following W=1 kernel build warning:
> > 
> >  drivers/misc/cxl/flash.c: In function ‘update_devicetree’:
> >  drivers/misc/cxl/flash.c:178:16: warning: variable ‘drc_index’ set but not used [-Wunused-but-set-variable]
> >  178 | __be32 *data, drc_index, phandle;
> >  | ^~~~~~~~~
> > 
> > Cc: Frederic Barrat <fbarrat@linux.ibm.com>
> > Cc: Andrew Donnellan <ajd@linux.ibm.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/misc/cxl/flash.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
> > index cb9cca35a2263..24e3dfcc91a74 100644
> > --- a/drivers/misc/cxl/flash.c
> > +++ b/drivers/misc/cxl/flash.c
> > @@ -175,7 +175,7 @@ static int update_devicetree(struct cxl *adapter, s32 scope)
> >  	struct update_nodes_workarea *unwa;
> >  	u32 action, node_count;
> >  	int token, rc, i;
> > -	__be32 *data, drc_index, phandle;
> > +	__be32 *data, phandle;
> >  	char *buf;
> >  
> >  	token = rtas_token("ibm,update-nodes");
> > @@ -206,15 +206,12 @@ static int update_devicetree(struct cxl *adapter, s32 scope)
> >  
> >  				switch (action) {
> >  				case OPCODE_DELETE:
> > +				case OPCODE_ADD:
> >  					/* nothing to do */
> >  					break;
> >  				case OPCODE_UPDATE:
> >  					update_node(phandle, scope);
> >  					break;
> > -				case OPCODE_ADD:
> > -					/* nothing to do, just move pointer */
> > -					drc_index = *data++;
> > -					break;
> 
> I think this is not correct, as *data++ changes the value there, and so
> this changes the logic of the code.

Great spot.

Looks like I overlooked that the pointer itself is being incremented.

> Dropping this one from my queue.

Sounds good.

I'll fix-up and send this separately at a later date.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
