Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B344C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5774720731
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599774718;
	bh=kPOBDw/9ka9jRxKxmeiFvPl/dcpSjIPubIYDikC/5SA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cIgvTwVfkeBMF9AREwCw6QxnV4v7MuzqWYxRdqS+zwwFQOt0fWAn8e673cmiYw9Of
	 tO5EKwcKNlSGXgo4eDVzn8fDGpjuan2MuJ4tW8fo6OfT4DfGWCKwLG8MBWUYJD+dps
	 UJCV299S6HPka9HqlcSGacGsYQxa0Dpqrzko2pWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgIJVux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730439AbgIJMiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:38:23 -0400
Received: from coco.lan (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A851208FE;
        Thu, 10 Sep 2020 12:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599741497;
        bh=kPOBDw/9ka9jRxKxmeiFvPl/dcpSjIPubIYDikC/5SA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sKBop0vFfTGsz708b68LvN9bv279DcFtKkIHL69Eo2ibgfYu7D8L3ziVZrlv9POrB
         +IQwaPAQSNKbEGUneqT4OxF/fMPkifErOwx4x9H9htNjz4aSLe5ZQ9GbDd6VPw/3c7
         eGhUrxpd1lhiQdnJdE7PL/E0TBd6HmJfJvAZUfYY=
Date:   Thu, 10 Sep 2020 14:38:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/14] XArray: docs: add missing kernel-doc parameters
 for xas_split_alloc()
Message-ID: <20200910143812.4316722a@coco.lan>
In-Reply-To: <20200910111322.GQ6583@casper.infradead.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
        <17aed0aeb9dad9ad3a1ca97da11bec16a6283f3c.1599732764.git.mchehab+huawei@kernel.org>
        <20200910111322.GQ6583@casper.infradead.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 10 Sep 2020 12:13:22 +0100
Matthew Wilcox <willy@infradead.org> escreveu:

> On Thu, Sep 10, 2020 at 12:23:56PM +0200, Mauro Carvalho Chehab wrote:
> >  /**
> > - * Allocate memory for splitting an entry of @order size into the order
> > - * stored in the @xas.
> > + * xas_split_alloc() - Allocate memory for splitting an entry of
> > + *		       @order size into the order stored in the @xas.
> > + *
> > + * @xas: is the 'xarray operation state'.  It may be either a pointer to
> > + * an xa_state, or an xa_state stored on the stack.  This is an unfortunate
> > + * ambiguity.
> > + * @entry: refers to something stored in a slot in the xarray
> > + * @order: size of each entry
> > + * @gfp: GFP allocation flags
> >   */  
> 
> No.  I'll do this properly. 

Thanks! Yeah, you should be able to document it better than me, as I'm
not familiar with XArray subsystem ;-)

> Sorry for forgetting to document the arguments.

No problem. I know it was hard to identify such warnings in the past,
as we used to have hundreds of warnings. Btw, while writing this
series that finally gets rid of them, I even identified one such
warning on media that slept though my review ;-)

Thanks,
Mauro
