Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A94CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014CB2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597313445;
	bh=8S6jKUx46BaOyd6AEOnq4IBcGElO3fsBbXuThZ9ef9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MiI+chMlrVu/usjxt7MqAYKOcB3UUxyriusbDEobNIlgG9sSZsvDtRNSOfKi7Io3B
	 e42owTnm/Fn+pD45KYwxryKODiGuF05wtvc0PcgvFOxTYTQXRPRlYAgWe0UzeAHpn/
	 fV5cBA+42qBkisNy5yYgoXcGC/NZp4nOnvcK2lG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgHMKKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgHMKKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:10:43 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D96E520781;
        Thu, 13 Aug 2020 10:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597313442;
        bh=8S6jKUx46BaOyd6AEOnq4IBcGElO3fsBbXuThZ9ef9Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B/O/ZSqBYDBJzorx/2d7HlkU1ilrHm2wLKnb0Tq0ft8UhED82Fpxw1SNCHwYh01ML
         Po/6cfpStrpfdUTWfs88AqPqQmiQ0YmuAF/abzvBdZNJxeM+xHCpuUICNvqymCze1u
         rOq0O+poRpNHojmOg34CDYSTSI1vXxT+A1T2QV10=
Date:   Thu, 13 Aug 2020 12:10:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 35/44] staging: regulator: hi6421v600-regulator: add a
 driver-specific debug macro
Message-ID: <20200813121036.126c4797@coco.lan>
In-Reply-To: <6a424468eb61e2eb9b014817819dd4da61f2ada1.camel@perches.com>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
        <7cb10b3910e9fa3e52d36e4e416030175cc761ab.1597247164.git.mchehab+huawei@kernel.org>
        <6a424468eb61e2eb9b014817819dd4da61f2ada1.camel@perches.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 12 Aug 2020 09:10:29 -0700
Joe Perches <joe@perches.com> escreveu:

> On Wed, 2020-08-12 at 17:56 +0200, Mauro Carvalho Chehab wrote:
> > Using dev_dbg() is not too nice, as, instead of printing the
> > name of the regulator, it prints "regulator.<number>", making
> > harder to associate what is happening with each ldo line.
> > 
> > So, add a debug-specific macro, which will print the rdev's
> > name, just like the regulator core.  
> 
> Seems sensible, but trivially:
> 
> > diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c  
> []
> > @@ -209,10 +212,10 @@ static unsigned int hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev
> >  	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
> >  
> >  	if (load_uA || ((unsigned int)load_uA > sreg->eco_uA)) {
> > -		dev_dbg(&rdev->dev, "%s: normal mode", __func__);
> > +		rdev_dbg(rdev, "normal mode");
> >  		return REGULATOR_MODE_NORMAL;
> >  	} else {
> > -		dev_dbg(&rdev->dev, "%s: idle mode", __func__);
> > +		rdev_dbg(rdev, "idle mode");  
> 
> missing terminating newlines

As per request from Jonathan, I ended dropping those rdev_dbg()
on a followup patch.

Btw, after this changeset:

	commit 563873318d328d9bbab4b00dfd835ac7c7e28697
	Merge: 24532f768121 bfd8d3f23b51
	Author: Linus Torvalds <torvalds@linux-foundation.org>
	Date:   Mon Oct 10 09:29:50 2016 -0700

	    Merge branch 'printk-cleanups'
    
	    Merge my system logging cleanups, triggered by the broken '\n' patches.

the printk lib will add a line feed if a "\n" is missing. I had
to get rid of pr_cont() & friends on that time on media, due to that. 

Thanks,
Mauro
