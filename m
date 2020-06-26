Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3EBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A2CE2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L758zaU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgFZP67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFZP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:58:59 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A33C03E979;
        Fri, 26 Jun 2020 08:58:58 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dg28so7318735edb.3;
        Fri, 26 Jun 2020 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Cz0LL2XZk3y/0batObSdPZVErezhlLZ1JCOZ/N0G1k=;
        b=L758zaU6Q5soAykwZ2Cj4fZCxEiq0bK5AbIT76HtieRMWdp0AKiaw2I0bPdddlx3JP
         uQf+XHrpnMqigdETNytKi8CDGYjZFLa0zC2gijvdyXgO1LLhgW9J9X1Eh12kBtIyTSQM
         8Ib2PegUFK28yRiGYXIfPy1cM7F1oT1g06o/jeWuDF7KehSatUXzGf7x32g/6CYIxS8y
         IfTYQx2jRY70LvRk1CZVL1vLMdWeIOLDUA3e9dUiIrQcsnunAZa0T5X3VtzPAUXiAYcF
         L6wBXc1PZ+SRpVhgww8sS5zoClBFUWiy3h9qEWcPMkVrGJnpg20wSEseQdj8FpsumCcz
         HhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Cz0LL2XZk3y/0batObSdPZVErezhlLZ1JCOZ/N0G1k=;
        b=qnlQFXzVyhJnv+gX/41B7UMJy4jTPE0SJCWgtAMEt3YcIT73+p0TXpv7JPYc5iibtj
         3XoXnszxZJZ33W4Wkjas3ZdRuy4dE59dYbKwSXqeqCkF7QU3xfiZ+/tvfFrbJ4/xyFlz
         rZ0Rnj8iCDk7UQZPzLK3tJPq2qPUoNVLloUg41m2LFuq9zENWyxGum51LTDVj7iDtSpw
         o/w16nc+WTEiv1ljHC9qZQIQwlqkhX3zXZEmGG2MRPzKRQa3uP9+9vor3MFAN69zdMsa
         M57KdKzUGlzRRss8xwGnPY77/Zq+Xe9cebX92d7ct96YkYJg2+rc9bvTCqaibXQS+FPN
         Fiog==
X-Gm-Message-State: AOAM532QpXVZoqvnquxHDha7ZL7+glePoy3GwxeDsYTx5Zv9In72rbo7
        iou1rU6qkz6oSEkb9GE9jqM=
X-Google-Smtp-Source: ABdhPJyoCTdM4ZvkweJXXQubH3n4cD7yadzdQkILMeSfZTtDa9VjctDnNDOsHdf8HzPbB8IhwNCiCQ==
X-Received: by 2002:a50:fa0c:: with SMTP id b12mr4178260edq.226.1593187137753;
        Fri, 26 Jun 2020 08:58:57 -0700 (PDT)
Received: from BV030612LT ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id s2sm21132439edu.39.2020.06.26.08.58.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jun 2020 08:58:57 -0700 (PDT)
Date:   Fri, 26 Jun 2020 18:58:54 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v2 6/6] MAINTAINERS: Add reset binding entry for Actions
 Semi Owl SoCs
Message-ID: <20200626155854.GB6611@BV030612LT>
References: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
 <c7db5abf78656af8d5a4ff8d677a08e03713c1f3.1592941257.git.cristian.ciocaltea@gmail.com>
 <20200626135415.GD8333@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626135415.GD8333@Mani-XPS-13-9360>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 07:24:16PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 24, 2020 at 08:47:57PM +0300, Cristian Ciocaltea wrote:
> > Add a reset binding entry to match all members of Actions Semi Owl SoCs.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7b5ffd646c6b..e6285c13bab0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1533,6 +1533,7 @@ F:	drivers/mmc/host/owl-mmc.c
> >  F:	drivers/pinctrl/actions/*
> >  F:	drivers/soc/actions/
> >  F:	include/dt-bindings/power/owl-*
> > +F:	include/dt-bindings/reset/actions,*-reset.h
> 
> You can just use, reset/actions,*
> 
> Thanks,
> Mani

Done, thanks!

> 
> >  F:	include/linux/soc/actions/
> >  N:	owl
> >  
> > -- 
> > 2.27.0
> > 
