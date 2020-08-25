Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7091C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7052074D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bacm3EUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHYURm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYURk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:17:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3213C061574;
        Tue, 25 Aug 2020 13:17:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d22so8217753pfn.5;
        Tue, 25 Aug 2020 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kTTQkj1GrVnPq+Jl1z8GjL/Z8OGPiCHoo0nN5v+V4rY=;
        b=Bacm3EUT/ArUc+tJ9DwRQAvy/UQanfr22vRs63UqaoZPXSzQYh/+7a0r6T0aQDh4uE
         LzAPULF85HO+nfixAWfuBIZc/sPjruiwm7mOQtvzQDv0GVvB2+WFW0eX4PMqoKoTsov9
         UpSUIHA+kv6ZN6VEmO8wmKc1cT6y2ChnuhrkU4QoBfUo0mvE64ZgjuEpj1Q8zO9WGL5x
         UM+uc+DVQkom+H1zEKh1RyJOA/aVSCrecCoKUepBQScc3bJ1BFMQDefHrsqq66BBSvww
         sLUFov/yW4z8jH4OEIClkRB3sRqS64/ayOG6XHYwJSqrkZVDT1uF75Kia/bBITKArVP4
         QPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kTTQkj1GrVnPq+Jl1z8GjL/Z8OGPiCHoo0nN5v+V4rY=;
        b=VUn/0zE1aJcXK77w6DHBl3Li1bm60MRurl/+Y2gxX05ehErhD0r0BWrEukv7K4RAc5
         aRDARUXWcPbJU13zXU929/ai/hiFtGUhtqd1OXdIEy7fLxFo664ht5o4gpf8k0O+55y6
         41PT7U3AIpy7HQp6J0ddMeKqo+TPmuWyLA4z0tH0nGym+4vRdyvQzyKslDl7ZenY074Q
         lkfOVD+w1KBiI7NbU5ZPTEXwr4KA/n55yi+2xMxw2jP1dXeGANoS0EtTHNll4sz/1B2W
         OPqSAnAfxjgnJ4NMz/ISsrz3h2iFmhtivnoZ6s401MpNhNuMJt5Z9rr9RTTeqqU8NljY
         fXkw==
X-Gm-Message-State: AOAM530zkvj7JsE6+lv+lz7KrgUFSTmqf4FDJ139sPW9km2DouKVoSOb
        tyEBzip6jHDcRphy6yUF9C8=
X-Google-Smtp-Source: ABdhPJy3+1AevdVVKZO0m/DyW+KokVwfuzGmzhV1klUpmR4e2P7ivu3hcck2+VYDCkh7E6/kPMLtLQ==
X-Received: by 2002:a17:902:7605:: with SMTP id k5mr9428097pll.122.1598386660168;
        Tue, 25 Aug 2020 13:17:40 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id o192sm88628pfg.81.2020.08.25.13.17.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 13:17:39 -0700 (PDT)
Date:   Tue, 25 Aug 2020 13:17:37 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Subject: Re: [PATCH 5/5] ARM: dts: aspeed: Add Facebook Wedge400 BMC
Message-ID: <20200825201736.GB22083@taoren-ubuntu-R90MNF91>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
 <20200824211948.12852-6-rentao.bupt@gmail.com>
 <CACPK8XfbUt9W9xQ4Gxj0LMq=C99V1ExBbkOKvbOvCbJR4N_Bwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XfbUt9W9xQ4Gxj0LMq=C99V1ExBbkOKvbOvCbJR4N_Bwg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 04:07:56AM +0000, Joel Stanley wrote:
> On Mon, 24 Aug 2020 at 21:20, <rentao.bupt@gmail.com> wrote:
> >
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > Add initial version of device tree for Facebook Wedge400 (AST2500) BMC.
> >
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Thank you for the review, Joel.


Cheers,

Tao
