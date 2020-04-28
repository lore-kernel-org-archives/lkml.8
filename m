Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D97C8300A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310D520663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588089531;
	bh=qXrJ1X738mDatImKsjVwSd8Q17d8jVla98VKaBYOuR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H/WKFFIMhTau3nbKMXTOAx9UahyvdsLMgADbFov0eiwATwFujpuo+aKUjD1uhXgug
	 MPXPopCSDR2tYa2yVtH82rTZ4iiU3TOwG6K25SGtK3mHlVAhNRgk+Cc2Stbo7s1Dmf
	 JI5H6X0fvnhk6IcnMB2At5cV8Xc1kGXFtRxzOAyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgD1P6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbgD1P6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:58:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D74206C0;
        Tue, 28 Apr 2020 15:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588089527;
        bh=qXrJ1X738mDatImKsjVwSd8Q17d8jVla98VKaBYOuR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUfYbW3GbJdy2X49J3YY7Qd2zXiDhOXFr2vX+KqhyXFF/aB6tldFv6Ygm/uDWhMzR
         zHLTBYQClEk5AnwX8f3FtfDJHzxrQePDL73NQz17IbAOAHKvormV6KCwuGJBvvb5Ok
         uSWckYHOlHmUOJ/bR/ou+63j64apAeMiwfsvJB1E=
Date:   Tue, 28 Apr 2020 17:58:45 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Stahl, Manuel" <manuel.stahl@iis-extern.fraunhofer.de>
Cc:     "hjk@linutronix.de" <hjk@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "sojkam1@fel.cvut.cz" <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH v4] Add new uio device for PCI with dynamic memory
 allocation
Message-ID: <20200428155845.GA1611284@kroah.com>
References: <1507296707.2915.14.camel@iis-extern.fraunhofer.de>
 <20200416163830.30623-1-manuel.stahl@iis-extern.fraunhofer.de>
 <20200428135443.GA1437053@kroah.com>
 <6e93bbcb4ba85b4cc143aa8e3e7254071b3c8bdb.camel@iis-extern.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e93bbcb4ba85b4cc143aa8e3e7254071b3c8bdb.camel@iis-extern.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 03:47:42PM +0000, Stahl, Manuel wrote:
> > 
> > > +		return err;
> > > +	}
> > > +	pci_set_master(pdev);
> > > +
> > > +	dev_info(&pdev->dev, "Legacy IRQ: %i", pdev->irq);
> > 
> > Again, remove, be quiet :)
> 
> Use dev_dbg() or remove completely?

If it helps in debugging, dev_dbg() is fine to use.

thanks,

greg k-h
