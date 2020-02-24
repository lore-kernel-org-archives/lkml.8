Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB69DC11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929A420836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="ZwdohMMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgBXQr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:47:29 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40389 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgBXQr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:47:29 -0500
Received: by mail-pj1-f66.google.com with SMTP id 12so4441379pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 08:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2zePMqHb3pxqOSl/NHaUkMDrUSvpWjI4HscCu6Jr28k=;
        b=ZwdohMMjroCJi5cDmXzMY1AW4fuHeMb0XbtE7ZyLvdY2TmdNxW4nhXx6yqm4f03V4O
         eT3TFPHeWwM2FEyVDDAvDi+WtbvSyoqjV6MkeirxuqmP70depek/y+KRWpeWdnaiqGFS
         Z+76/2ZoqQLn0ew3wr7AJ39b3DSalwhweP2CQvZ+O4/N03aQ5R9CV9iSLCv0j9dL6TD7
         kUY6/Bb4yRNNfLGRj60fR0SUuwvkwcMrTFRjB/tqpFiiMhw1aKdRg1Tq7qyEe8SKRNxZ
         uNmI5mAV5zoffPBG/GN2+NvnGFdN5MUCEB3F34AXL5kmt26jahSW5Do+o6OUe1BLRTfL
         buyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2zePMqHb3pxqOSl/NHaUkMDrUSvpWjI4HscCu6Jr28k=;
        b=XM+my4xUUjhh8BmSfFxf4ntlXM0XefsHvsyo8xKXJvDPMHengbwnPD+5v+S4tejBO1
         iGMN4QCLDoic0lyzSnL7crwgLIfExH4TDHlh9O46Otr1OpeCuPFf3tNMjd9gwz71C0yZ
         qXweh0SOhR1JHe2uyuw1nhXWm5t2gRn5MIyylX+RodXO8T8hTF3+ab4+3+SClqXUMSc2
         /DtxXpzFHLdvN/2ewVgmw0gnHguoF/U8D0HB1ka/yTNwv+0clfWNNZ5AdVJHsQwBomzq
         pJBsQb+IFU8KIlli0rTyHrYlxz/MK8wt52sHKNWYslwl4a+z07D6zv86lLh9oLQytjN+
         HP9g==
X-Gm-Message-State: APjAAAUmLtEHxGlCeeGi8AbqXnJ+FH3HuNca8+dXDe74bWM/UfDd4zAy
        xf1tyZbMVdTAEWyBBEpWgo43Kg==
X-Google-Smtp-Source: APXvYqwecQZyBx2Lu6irbcoubh2qjH4GBrXCroPb6bZfgoJ7nVIHn8R8yjAR6JV/sdr+Y/WoSHiLuw==
X-Received: by 2002:a17:902:9342:: with SMTP id g2mr49081074plp.339.1582562848308;
        Mon, 24 Feb 2020 08:47:28 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.170])
        by smtp.gmail.com with ESMTPSA id d3sm13201089pfn.113.2020.02.24.08.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 08:47:27 -0800 (PST)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
X-Google-Original-From: Kaaira Gupta <Kaairakgupta@es.iitr.ac.in>
Date:   Mon, 24 Feb 2020 22:17:21 +0530
To:     Joe Perches <joe@perches.com>, Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: qlge: emit debug and dump at same level
Message-ID: <20200224164721.GA7214@kaaira-HP-Pavilion-Notebook>
References: <20200224082448.GA6826@kaaira-HP-Pavilion-Notebook>
 <84410699e6acbffca960aa2944e9f5869478b178.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84410699e6acbffca960aa2944e9f5869478b178.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 05:38:09AM -0800, Joe Perches wrote:
> On Mon, 2020-02-24 at 13:54 +0530, Kaaira Gupta wrote:
> > Simplify code in ql_mpi_core_to_log() by calling print_hex_dump()
> > instead of existing functions so that the debug and dump are
> > emitted at the same KERN_<LEVEL>
> []
> > diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
> []
> > @@ -1324,27 +1324,10 @@ void ql_mpi_core_to_log(struct work_struct *work)
> >  {
> >  	struct ql_adapter *qdev =
> >  		container_of(work, struct ql_adapter, mpi_core_to_log.work);
> > -	u32 *tmp, count;
> > -	int i;
> >  
> > -	count = sizeof(struct ql_mpi_coredump) / sizeof(u32);
> > -	tmp = (u32 *)qdev->mpi_coredump;
> > -	netif_printk(qdev, drv, KERN_DEBUG, qdev->ndev,
> > -		     "Core is dumping to log file!\n");
> 
> There is no real need to delete this line.
> 
> And if you really want to, it'd be better to mention
> the removal in the commit message description.
> 
> As is for this change, there is no "debug" and "dump"
> as the commit message description shows, just "dump".

This patch has already been added to the tree, if I amend the commit now
using git rebase, won't it affect the upstream as the SHA-1 of the
commit and it's children will change?

> 
> 
> 
> 
