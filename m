Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1D8C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2626B20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="rxarjv0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBXRSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:18:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41255 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgBXRSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:18:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id t14so4311654plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 09:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gyw3IQoCgUqeHBYgq3kf+BJNZrC8xCDPvwa+Ug1jeIY=;
        b=rxarjv0j6U/0Mn9WePM3dmGAynqBodgb0qcGxwIqrk4TVZWw97sTqpQVtxMP0sFT0S
         KBZwY3S4PVFCTll37uvZ7vy5EJrgHC/O82hs1PPzVsl2OGg4F2qHiMEMmFBZN5wmBKKL
         GDCCq7rqcNqv7zWuNGRZvqt/On3TdqBdZDtRNt9jgINp9+YN8wBEI6JYJfj6FUadIC8+
         TBEJyhq5fgG2byb3XP37tkPBOHdOEBmZiFy7Jrw298f3NpVkfHbkJ+jWXczGd8vpFwXL
         1urlhCWFuMu3jWJEfhVPxC9HDgUCWZjw7BeE6HF61dIhXALyrX0b5+LRyp6KF0FL9V02
         7qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gyw3IQoCgUqeHBYgq3kf+BJNZrC8xCDPvwa+Ug1jeIY=;
        b=fs8amMXI1nT/t0G/jqLNFoQlf8KizkYjmfBD3VkDsCNtX6srRpbGqUD7X9YoB6U/n2
         dXRnksvL9hJKw1PYqcgWZnVdEq86NEK/wUPmOcArKTyZ8iJqwOnwKT870lwsWaXqrf96
         T5pYYYwhNQvKet8rRBU0UE0rx4qs2Vq7pTUXMe4kxztNrb2n1GDOZ6BvQHEPuutGnIRF
         1JdUimjJE1By1oEE8fPhPJ+bXMR0zeYLgHwzlhO0bwMuQQ9ex+39cRhPJF89ojE3kxiT
         RVqf+ZievgkbNeKVCx2qZpb8zRRKfOjPqF2qnG6akuTFhSMGYTHIm5TOVb3krquk3biz
         TIZg==
X-Gm-Message-State: APjAAAXoO6MvDyFZfTpS7LhXPH+HVSCrPda2RO8zREgUR6AkNdyDm830
        BQOCviOWnqIpqqLpaoi1P4kvT6nVCRQdnjRQ
X-Google-Smtp-Source: APXvYqypr5gvqxegqJ49eFPGEqT53fDvW/SfNn7izliGbOcALtB1GFkm3Wv3PpxGw3FpScvNByib1w==
X-Received: by 2002:a17:90a:c691:: with SMTP id n17mr80171pjt.41.1582564711576;
        Mon, 24 Feb 2020 09:18:31 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.170])
        by smtp.gmail.com with ESMTPSA id t8sm29369pjy.20.2020.02.24.09.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 09:18:30 -0800 (PST)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
X-Google-Original-From: Kaaira Gupta <Kaairakgupta@es.iitr.ac.in>
Date:   Mon, 24 Feb 2020 22:48:23 +0530
To:     Joe Perches <joe@perches.com>, Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: qlge: emit debug and dump at same level
Message-ID: <20200224171823.GA8240@kaaira-HP-Pavilion-Notebook>
References: <20200224082448.GA6826@kaaira-HP-Pavilion-Notebook>
 <84410699e6acbffca960aa2944e9f5869478b178.camel@perches.com>
 <20200224164721.GA7214@kaaira-HP-Pavilion-Notebook>
 <9f0d39d5972553b86123873294fc9f9566130036.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f0d39d5972553b86123873294fc9f9566130036.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 08:54:43AM -0800, Joe Perches wrote:
> On Mon, 2020-02-24 at 22:17 +0530, Kaaira Gupta wrote:
> > On Mon, Feb 24, 2020 at 05:38:09AM -0800, Joe Perches wrote:
> > > On Mon, 2020-02-24 at 13:54 +0530, Kaaira Gupta wrote:
> > > > Simplify code in ql_mpi_core_to_log() by calling print_hex_dump()
> > > > instead of existing functions so that the debug and dump are
> > > > emitted at the same KERN_<LEVEL>
> > > []
> > > > diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
> > > []
> > > > @@ -1324,27 +1324,10 @@ void ql_mpi_core_to_log(struct work_struct *work)
> > > >  {
> > > >  	struct ql_adapter *qdev =
> > > >  		container_of(work, struct ql_adapter, mpi_core_to_log.work);
> > > > -	u32 *tmp, count;
> > > > -	int i;
> > > >  
> > > > -	count = sizeof(struct ql_mpi_coredump) / sizeof(u32);
> > > > -	tmp = (u32 *)qdev->mpi_coredump;
> > > > -	netif_printk(qdev, drv, KERN_DEBUG, qdev->ndev,
> > > > -		     "Core is dumping to log file!\n");
> > > 
> > > There is no real need to delete this line.
> > > 
> > > And if you really want to, it'd be better to mention
> > > the removal in the commit message description.
> > > 
> > > As is for this change, there is no "debug" and "dump"
> > > as the commit message description shows, just "dump".
> > 
> > This patch has already been added to the tree,
> 
> What tree is that?
> It's not in -next as of right now.

Its in staging-next right now.
This is the link: https://lore.kernel.org/driverdev-devel/cba75ee4d88afdf118631510ad0f971e42c1a31c.camel@perches.com/

> 
> >  if I amend the commit now
> > using git rebase, won't it affect the upstream as the SHA-1 of the
> > commit and it's children will change?
> 
> You are sending patches not pull requests.
> 
> If it's really in an actual tree that people
> care about, send another patch putting the
> netif_printk back.

I'll submit a patch, but can you please explain me why this function is
still needed when we are already using print_hex_dump()?

> 
> 
