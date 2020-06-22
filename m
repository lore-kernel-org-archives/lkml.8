Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3046C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA6A20716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrCajufr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgFVMXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgFVMXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:23:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8139C061794;
        Mon, 22 Jun 2020 05:23:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z17so1520866edr.9;
        Mon, 22 Jun 2020 05:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CTAR7V/Z8zO/EvXyOnCI3u6opFpSGrn79lAtP0brC4o=;
        b=OrCajufrkP+2em4jab8O0EUkLyInrnq97bHfibUDuf2Prp6DIG52ZuCKqEnSSXByxV
         305EkbA4hU6d96Uwlkp4ifmNXh0MxmOPl0/qRQ0i73mu0+roArjE1bXdc0K9EnScimt/
         mvHVWsms4eRxlSMH2iTDXCOVAO4fC22owLSQUfbmbp/fmOjCIzqzXaEcsj9ivDWIjjMY
         MP/E9h4Os5eS88A2kED2o5tIEbaYETySLrczO8Pmm9LNbTUjmhHBVdJkZ6JBlGUdnNiB
         p5S3S0jA4yPGQtYKKuzTAQZpOwALWHV9jIhQRQKx91lihd8I8CkJ3EeXiZzg5xNe+vG6
         Dr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CTAR7V/Z8zO/EvXyOnCI3u6opFpSGrn79lAtP0brC4o=;
        b=BdsiLcHOmmyRDho3Ib5gOn0B9prwrFmOz5fDsYS7T6fydUOD+PB3rfq/ZlcLkvQR6z
         /um9R6XIRwZ4VsmJz30kZYyR9hMvn7py83a/fBA9Aun5huJ5O4We8EsKAiJzRJW8HE/T
         fE8bMTb5sd7u/7F/RuyDaDtRB12NE5luWajqdbiWizXNWbhZ8WYO0/GczTos7NrGMI/E
         EmADZqgKQGYUazMv5oyWh77b+2dW/yXMNqbwm+myRkoZpYpaUnP12FlBWtZkuh7WYbG6
         hj785MWEQfaSYjEyNYmnUA6ZgHnp0goy8+OCSIRpa8DhYeZ6ngDUZCVuFjyi1DMYaaCF
         kSJQ==
X-Gm-Message-State: AOAM530HeKlizbKw1i9EYvayHRpHnHWQFw26HXhkdJdzdIegrtuRcQEn
        gaz8me9DhYeO6bGpMHWvMDM=
X-Google-Smtp-Source: ABdhPJwahOmxgh0msKa/vZwSsJo8AdxSNjyxVr2M4XbxaHGEO/ntewNWr/iJEOM+rUWu1ncWvnA6qA==
X-Received: by 2002:aa7:cb53:: with SMTP id w19mr16162146edt.328.1592828626457;
        Mon, 22 Jun 2020 05:23:46 -0700 (PDT)
Received: from BV030612LT ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id a24sm11398519ejc.109.2020.06.22.05.23.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 05:23:45 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:23:43 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     afaerber@suse.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-actions@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] clk: actions: Add Actions S500 SoC Reset
 Management Unit support
Message-ID: <20200622122343.GB23301@BV030612LT>
References: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
 <e361b46511756070277ff10f94e1735bb69cc300.1592407030.git.cristian.ciocaltea@gmail.com>
 <159281354799.62212.7256905433525537681@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159281354799.62212.7256905433525537681@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 01:12:27AM -0700, Stephen Boyd wrote:
> Quoting Cristian Ciocaltea (2020-06-17 09:48:09)
> > Add Reset Management Unit (RMU) support for Actions Semi S500 SoC.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >  drivers/clk/actions/owl-s500.c | 80 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> > 
> > diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> > index 025a8f6d6482..3bce72301c65 100644
> > --- a/drivers/clk/actions/owl-s500.c
> > +++ b/drivers/clk/actions/owl-s500.c
> > @@ -10,6 +10,8 @@
> >   *
> >   * Copyright (c) 2018 LSI-TEC - Caninos Loucos
> >   * Author: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> > + *
> > + * Copyright (c) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> You should only add your copyright when you modify a large amount of the
> file. Adding 80 lines to a 500 line file doesn't count. Sorry.
>

Sure, I removed it. Thanks!

> >   */
> >  
> >  #include <linux/clk-provider.h>
