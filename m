Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB80BC4BA14
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB9320637
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="CHv6lt1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgBZPtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:49:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32781 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgBZPtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:49:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay11so1453186plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 07:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U9WKbn7eUI8LUbesJ+Yk9/AWmRKMXsTcSgQUjkk/JHA=;
        b=CHv6lt1QTsRrYpqIKySsJjJM96z3+Q0onx/x4Fks6aMfSt1yLflnFCuQgACmvCBCi9
         d5CKr7NIyQAOLh5DTYxdQJo2W6AEEpeOYbJtc5o4Xf64VNMAhGUHMc/ojYuOIVxhmysd
         h8MYwheYrbDZjHejql0I4KdPD0yaa0R32xU4IonDxbljLhBdnh2OZvN5LeM3tQcA+q6O
         3i555HZVL7y63pZefglQ6H9/zV4OObhQbR4r6Jjtjmpq69OEtFyLr3FGszLnRy7eARuq
         ZdFM/3BAgWWQfSaXeaKO0tJNX9vXwmwgegb1NF5io20jyXkeZAB6w5Q+5LU5l0hzQQPY
         x8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U9WKbn7eUI8LUbesJ+Yk9/AWmRKMXsTcSgQUjkk/JHA=;
        b=WTKqxarDy4VZ7ogYE2Kn7qfCIoxwL/LUPqxWi0PxQOaltkFNGNFqJeS8h8zbyr5vrx
         rRM1jJxxqeXKKPePVGmy7bqgu1uRIs5TCUS5Ft90khbPKZyZdCWWlTDutxyV/lE+prf+
         Z1GA7roepizASX2I2TIIv1nmUTuQaOVNtNjVghO88/Hy+eIYY4V6Rw9vpURuBp2Xvx4c
         d0UmLQeri07LhqhCU7prd442TOMfgpHySbvORLzqaEXxX3SX2kbIiIoP8hWZPetWkLpX
         rNvP0Ozbhnf72GdF+KqR8jnlIfKQmF49NgKTkc2GXybcD8mZLdQ4E9SKmUCFbEEnOjS0
         d79g==
X-Gm-Message-State: APjAAAVbzqQuJkBN/elespfJAoRwHqVwPtbBqbH7MoaNd1ZRHF/3+wg/
        V2mzNkdB3f3sOkyW7lh2IrC29w==
X-Google-Smtp-Source: APXvYqyhQ3pFoxq98IxNoIfqWV00FOB+deyWQ+YPQXar4yNv3LLTLZx5YJs472J4x+rqsFX+SQ3jbg==
X-Received: by 2002:a17:902:d20f:: with SMTP id t15mr4921351ply.55.1582732156436;
        Wed, 26 Feb 2020 07:49:16 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.170])
        by smtp.gmail.com with ESMTPSA id z16sm3506506pff.125.2020.02.26.07.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Feb 2020 07:49:15 -0800 (PST)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
X-Google-Original-From: Kaaira Gupta <Kaairakgupta@es.iitr.ac.in>
Date:   Wed, 26 Feb 2020 21:19:09 +0530
To:     Benjamin Poirier <benjamin.poirier@gmail.com>
Cc:     manishc@marvell.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: add braces around macro arguments
Message-ID: <20200226154909.GA5599@kaaira-HP-Pavilion-Notebook>
References: <20200221195649.GA18450@kaaira-HP-Pavilion-Notebook>
 <20200224053225.GB312634@f3>
 <20200224075231.GA4806@kaaira-HP-Pavilion-Notebook>
 <20200225003016.GA360989@f3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225003016.GA360989@f3>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 09:30:16AM +0900, Benjamin Poirier wrote:
> On 2020/02/24 13:22 +0530, Kaaira Gupta wrote:
> > On Mon, Feb 24, 2020 at 02:32:25PM +0900, Benjamin Poirier wrote:
> > > On 2020/02/22 01:26 +0530, Kaaira Gupta wrote:
> > > > Fix checkpatch.pl warnings of adding braces around macro arguments to
> > > > prevent precedence issues by adding braces in qlge_dbg.c
> > > > 
> > > > Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
> > > > ---
> > > >  drivers/staging/qlge/qlge_dbg.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
> > > > index 8cf39615c520..c7af2548d119 100644
> > > > --- a/drivers/staging/qlge/qlge_dbg.c
> > > > +++ b/drivers/staging/qlge/qlge_dbg.c
> > > > @@ -1525,7 +1525,7 @@ void ql_dump_regs(struct ql_adapter *qdev)
> > > >  #ifdef QL_STAT_DUMP
> > > >  
> > > >  #define DUMP_STAT(qdev, stat)	\
> > > > -	pr_err("%s = %ld\n", #stat, (unsigned long)qdev->nic_stats.stat)
> > > > +	pr_err("%s = %ld\n", #stat, (unsigned long)(qdev)->nic_stats.stat)
> > > >  
> > > >  void ql_dump_stat(struct ql_adapter *qdev)
> > > >  {
> > > > @@ -1578,12 +1578,12 @@ void ql_dump_stat(struct ql_adapter *qdev)
> > > >  #ifdef QL_DEV_DUMP
> > > >  
> > > >  #define DUMP_QDEV_FIELD(qdev, type, field)		\
> > > > -	pr_err("qdev->%-24s = " type "\n", #field, qdev->field)
> > > > +	pr_err("qdev->%-24s = " type "\n", #field, (qdev)->(field))
> > > >  #define DUMP_QDEV_DMA_FIELD(qdev, field)		\
> > > >  	pr_err("qdev->%-24s = %llx\n", #field, (unsigned long long)qdev->field)
> > >                                                                    ^^^^
> > > You missed one.
> > 
> > It makes the line characaters greater than 80. Shall I still add braces?
> > I mean it's better that I add them to prevent precedence issues, but it
> > adds another warning, hence I wasn't sure.
> 
> Generally speaking, it's ok to spread the macro body onto multiple
> lines.
> In this case, it would be better to replace this printk format type with
> "%pad". See Documentation/core-api/printk-formats.rst

Soryy for late reply, I have my college exams going on.
But yes, I'll make the required changes and submit a patch. Thanks!
