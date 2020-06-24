Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94017C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB762082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592989848;
	bh=HSunofzXvpiYjRIWaOPT0OSKT5gKUPaFkaG89X7dXDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QUI0RSpvxWoZboWzqhYqQEDWqsAlzaj3CKo6az8qCcUKuUgu+ViDfhkkp+Quq/Egl
	 ixRBIW5nsBa+ZUpLs7QcCV3Mlwr3VPgLWJPpB4+dd7YATEUOnwS8ba2YeRy4nbHTN/
	 ajkSfsISgEwilX6YKbQs3MVuWhlZ17LFEgt6LtDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388749AbgFXJKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbgFXJKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:10:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8BBB206FA;
        Wed, 24 Jun 2020 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592989845;
        bh=HSunofzXvpiYjRIWaOPT0OSKT5gKUPaFkaG89X7dXDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JbIatC7Xy0oW/BY8bt3YHwqvEXiC2XaSlHJWp4GWsFpc9YIfrD8VYkCk1sFxT/JO2
         /eeuR4iKy74aWWm2L+/4epymSohLbGJeB7GikfVWbR68d5aq7T6+N71c1V4CjpBkYy
         8UiyC0vt6VWqCHqKTp6M9FM6UH+PnqqTLBjRblaw=
Date:   Wed, 24 Jun 2020 11:10:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marshall <hubcap@omnibond.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, dvhart@infradead.org,
        sgarzare@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VMCI: Avoid extra check for access_ok()
Message-ID: <20200624091043.GE1731290@kroah.com>
References: <1588709912-8065-1-git-send-email-jrdr.linux@gmail.com>
 <CAFqt6zYiiDpZE9poaEXShmWfqwjYYKa4tRqBhiaLMBPdvynWZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zYiiDpZE9poaEXShmWfqwjYYKa4tRqBhiaLMBPdvynWZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 07:11:54AM +0530, Souptick Joarder wrote:
> Hi Greg,
> 
> On Wed, May 6, 2020 at 1:40 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > get_user_pages_fast() is already having a check for the same. This
> > double check can be removed.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> 
> Does this need to be marked as stable ?

You tell me, why would it?  Does it meet the requirements for stable
kernels?  If so, which one?

thanks,
greg k-h
