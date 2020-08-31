Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0843C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8954A20767
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="rulFknjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgHaQEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHaQEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:04:25 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF386C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:04:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so25940wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nCvBclcKzBH5k/oraboDk32nHcQNInznXVzQum4e88U=;
        b=rulFknjgmouB6mHwBZM6x2B4xumtWEbtgZq5ADHlGW8eRg2k6lGmKUQSnydBvlK8HJ
         u/x13n5Og0niJTLg4W5BFerL8Mgrndz6sA6Q1cDDqu5OR0l7fCFDomuD6H1h3wG3kFVg
         MiY3ii6L0ojZ90XYO0lzr3UP7c+5S0W+5Uro5MFQgKCW4NajHQ06mgdnrO04OysTrFRL
         TlLZzbL6eC4tx4uAaAdnTOe2vsgRyk2fwvOcXAWq0olpbnYKAnTUiVIXpn9G7Z0re9Mk
         VcqBMsZP1ISRpXR9d58KfsEqRFQcu/hOEPd/W+e476D4eMtox3UmUOw9f8hhyWunhDsF
         70DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nCvBclcKzBH5k/oraboDk32nHcQNInznXVzQum4e88U=;
        b=gFBxVeGSso3bIjeuoAqIt277UtRRFwaA2ZyZmORvBWyAqW4+5U4M3/FthWIailGMaM
         x9dIrWkGTVDwnTAfPa8gX7tuV4vJ4eBQtCgf8IhXixc4L1aG1zTa7Mlizoo2iPi4p0B7
         VPoHdzPOE8TbUJMiZrA92bLYt+WP2OWiiDHT4T/0LNADg8OudNN0v3opkIoaWPsFwCuc
         01RFUlCMv994LX5S79UJTSeWIeyFc2c2+KBtEEIMVXvPTnkiAAbQL+GS4YdRnFqt8MXl
         3M1fqYNp/y1/uaQ1oUGLNnDv5IjBB8GWMsnAf1QY1MmCC7bULksFqT60/PCGNvoC6qfQ
         Tt6Q==
X-Gm-Message-State: AOAM533Y+z66Q9k6SZ9qPQ/n4pI6JHClGXKP1kT0cbHuNENOvq68KnZm
        JITiXGr3E4jeDbMlurAqDOy5tg==
X-Google-Smtp-Source: ABdhPJxTUsAVsYWhVS+5VSM2aslFfVrMSpKvMyie9ZUeq22oWbn9twvpHATZRscl6RMZiquXobLJSA==
X-Received: by 2002:a7b:cc11:: with SMTP id f17mr75205wmh.21.1598889863347;
        Mon, 31 Aug 2020 09:04:23 -0700 (PDT)
Received: from trex (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id q12sm9883387wrs.48.2020.08.31.09.04.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Aug 2020 09:04:22 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Mon, 31 Aug 2020 18:04:20 +0200
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jorge Ramirez-Ortiz <jorge@foundries.io>,
        jens.wiklander@linaro.org, sumit.garg@linaro.org,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        ricardo@foundries.io
Subject: Re: [PATCH] drivers: optee: fix i2c build issue
Message-ID: <20200831160420.GA13073@trex>
References: <20200831152359.9122-1-jorge@foundries.io>
 <52448a13-f3fd-d9d1-8e1f-e029db91cf5e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52448a13-f3fd-d9d1-8e1f-e029db91cf5e@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/20, Randy Dunlap wrote:
> On 8/31/20 8:23 AM, Jorge Ramirez-Ortiz wrote:
> > When the optee driver is compiled into the kernel while the i2c core
> > is configured as a module, the i2c symbols are not available.
> > 
> > This commit addresses the situation by disabling the i2c support for
> > this use case while allowing it in all other scenarios:
> > 
> >  i2c=y, optee=y
> >  i2c=m, optee=m
> >  i2c=y, optee=m
> >  i2c=m, optee=y (not supported)
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > ---
> > 
> >   This patch applies on top of
> >   https://git.linaro.org/people/jens.wiklander/linux-tee.git/tag/?h=optee-i2c-for-v5.10
> > 
> >  drivers/tee/optee/rpc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > index 64a206c56264..96e91d5f0a86 100644
> > --- a/drivers/tee/optee/rpc.c
> > +++ b/drivers/tee/optee/rpc.c
> > @@ -51,6 +51,7 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
> >  }
> >  
> >  #if IS_ENABLED(CONFIG_I2C)
> > +#if !defined(CONFIG_I2C_MODULE) || defined(CONFIG_OPTEE_MODULE)
> 
> Looks like
> #if IS_REACHABLE(CONFIG_I2C)
> 
> should work here.

yep, much nicer. will do that instead.


> 
> >  static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> >  					     struct optee_msg_arg *arg)
> >  {
> > @@ -140,6 +141,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> >  	arg->ret = TEEC_ERROR_NOT_SUPPORTED;
> >  }
> >  #endif
> > +#endif
> >  
> >  static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
> >  {
> > 
> 	
> 
> -- 
> ~Randy
> 
