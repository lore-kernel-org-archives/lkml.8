Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E8EC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1240F208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="qlADmI86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBSTbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:31:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34135 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSTbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:31:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id j7so487316plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 11:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QhXQ/cXtwYHdMsHGCBQq3KT1zCPY2mBxOplKOphUcO0=;
        b=qlADmI86J0XVdWbUcyyqOAzkIo/erCaqAHsFJej8QGQc9MASUfjo4tracziYv76Rde
         Ibn9uj/Tw41+og1tTJjmZ0JHhDaiLACkoyT1z5PR2pIfIYF1tCSrPC1+nVqVXLWUWpOK
         b3nnAguYvMtvPie/n1u3eIs8ht8viK+cvNzOzop6C1Qgms2x0rG4k5x+NfKa1OnS73zt
         9+EFEwuQMuFxJsC0fQSo8TgvSJ1tIg9proQW0HJ9WR76oARr0s/8mLtFoKlY6U35iIwH
         E3xFk11LekDO7F9zYeQT2PJXwl2Oo25Gicnf9vxqP+XeyB/of8lgiwde/EVtN2Z0oqlm
         bICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QhXQ/cXtwYHdMsHGCBQq3KT1zCPY2mBxOplKOphUcO0=;
        b=Vtq8L4pN2BAJW0hvNuUkx3b5DOfq/Pb0L+e/nbuipvb9EscHMAZBDs6tBXYs0302ta
         6mdDSbYSs9rOeKOh59Olrz+tsbsLMM6EClA1/HgXF42CqMmXSvH9KE4WISLXnnEN3iZf
         LU+ewfrBsmGGG8+CDuiF6awhFTrgX/Jf0uRHPDm3iurV5rcVdsxw8JZ36ErLDO4eFCv6
         oIdyW3e1oYYwshL7xIgEezClxLK3Rc3dHgdngJufAs30ca/xAJ23+QN3S+MXC5Y89wRn
         XTJcn969bHms8e7u/Cw33s5ajgc5XuohMwe3Ruj0djITvPcwdF+z3k5fKOae6REgF3hk
         4pKw==
X-Gm-Message-State: APjAAAU2Ly/HMg9QiBI+k948DoHA00eegm2tG8pdYnw/O840CMvoZeLR
        BaNW1Bm1MxMa35k5Yd2cS/EsCcrw6XPbRzc3
X-Google-Smtp-Source: APXvYqwN5bpa2pBX6QeC9TD8aVtDM1ClvbzJcPqmW4HL7uQ83xvSRAUOhmj5p6kGzu9msSBSUefyXQ==
X-Received: by 2002:a17:902:a984:: with SMTP id bh4mr28037054plb.281.1582140689769;
        Wed, 19 Feb 2020 11:31:29 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id 10sm397662pfu.132.2020.02.19.11.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 11:31:29 -0800 (PST)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
X-Google-Original-From: Kaaira Gupta <Kaairakgupta@es.iitr.ac.in>
Date:   Thu, 20 Feb 2020 01:01:23 +0530
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: change CamelCase to CAPS
Message-ID: <20200219193123.GA31142@kaaira-HP-Pavilion-Notebook>
References: <20200219174646.GA27559@kaaira-HP-Pavilion-Notebook>
 <20200219184741.GB2854654@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219184741.GB2854654@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 07:47:41PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 19, 2020 at 11:16:46PM +0530, Kaaira Gupta wrote:
> > fix checkpatch.pl check of 'Avoid CamelCase' by changing NI_CtrSource to
> > NI_CTRSOURCE in all the files. Change it to CAPS because it is a MICRO
> > 
> > Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
> > ---
> >  drivers/staging/comedi/comedi.h               |   4 +-
> >  .../staging/comedi/drivers/ni_routing/README  |   4 +-
> 
> As proof of what I said in my previous email, see the changelog message
> for this README file, and read it to see whre the names came from.

Sorry, a typo, it was MACRO.
Again, really sorry for the comfusion. I should have gone through the
README well.

Thanks!

> 
> thanks,
> 
> greg k-h
