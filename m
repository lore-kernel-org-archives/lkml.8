Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED613C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8777208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K58VDUtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgD1Rea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgD1Rea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:34:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AE8C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:34:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p8so10691113pgi.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Hq1q1mnJoP2paSR/R7OXn312kKcNLyIMvnjuhvouCkM=;
        b=K58VDUtmyQvj/iLoc30RsS2j/WCyVrAefbG72Iee2W3GxQR2siQCLGI8R04W+JPLFc
         mSav2rT3PVIf+TS0ZpEw9brbMhhOhT0o85TN9wAg4lgEiWhzspHqqpE/5gESe58Fg9jY
         /t7kjQT+ZZPA2b50l7cRWc3vqr0WsEhQ+5RNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Hq1q1mnJoP2paSR/R7OXn312kKcNLyIMvnjuhvouCkM=;
        b=nfT2QMxZ3EryQABEuBaNwnJ6M22ZyeXZ/dzzNoBxieNt1t+kigIwJDW9zoWnr1m3Zz
         6mq+O5VJtyk4IqWxxqO0myqNeRUkKdK3IJzconl7pCgVBUp4CzBXu+7ZT0ZerGPINh2g
         Usdy6YK8LO65ibSLzeH4+vlBBCVSIiJo+rbj4ltjqqxhP7NlgPkM0st4EuOZr7TV8MLJ
         WKhACfjS6v97f8jhPqw95c//+k/qrSZSLPVn4IVcVRv/DqxNOtsniqEvZ2OAHjiA2sZ2
         AmyaCPlTG+bo3oyVNttS4k1G6UNVf3CinOvazDn5hYc/BagLhfGkUMMx/mHlDfpYEp5Z
         qn2Q==
X-Gm-Message-State: AGi0PuYGv2JvPuRmkiMK95C5gqyhCqNBuU0kUtMBT1mZmdev9XxfPU4W
        m+HPJ//l9LDkNvTObztsnJor1iNicLc=
X-Google-Smtp-Source: APiQypIZMt6MMwYV4S1v9x7vgPnqCllbfzaTQXxPuXwyKkX4R4PMuOM9/eU0KS/F2uFJfSvhkzglTQ==
X-Received: by 2002:a62:17c3:: with SMTP id 186mr20673137pfx.159.1588095268756;
        Tue, 28 Apr 2020 10:34:28 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o1sm2619138pjs.39.2020.04.28.10.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 10:34:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200427163446.GB10601@xps15>
References: <20200426185805.14923-1-swboyd@chromium.org> <20200426185805.14923-2-swboyd@chromium.org> <20200427163446.GB10601@xps15>
Subject: Re: [PATCH 1/5] coresight: Include required headers in C files
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 28 Apr 2020 10:34:27 -0700
Message-ID: <158809526723.117437.7665630882841875855@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mathieu Poirier (2020-04-27 09:34:46)
> On Sun, Apr 26, 2020 at 11:58:01AM -0700, Stephen Boyd wrote:
> > diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtr=
acing/coresight/coresight-cti.h
> > index 004df3ab9dd0..d80123b905a8 100644
> > --- a/drivers/hwtracing/coresight/coresight-cti.h
> > +++ b/drivers/hwtracing/coresight/coresight-cti.h
> > @@ -7,8 +7,10 @@
> >  #ifndef _CORESIGHT_CORESIGHT_CTI_H
> >  #define _CORESIGHT_CORESIGHT_CTI_H
> > =20
> > -#include <asm/local.h>
> > +#include <linux/list.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/types.h>
> > +
> >  #include "coresight-priv.h"
> > =20
> >  /*
> > @@ -52,6 +54,12 @@
> >   */
> >  #define CTIINOUTEN_MAX               32
> > =20
> > +struct attribute;
> > +struct attribute_group;
> > +struct coresight_device;
> > +struct device;
> > +struct fwnode_handle;
> > +
>=20
> I would prefer adding the headers rather than forward declarations, it sc=
ales
> better.
>=20

Ok. I'm worried that including too many headers when they're not
necessary means it's easier to get into the problem that I'm trying to
solve here where kcalloc() isn't defined. Anyway, I'll update the
patch and resend!
