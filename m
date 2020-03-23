Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA632C10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C8E2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584946511;
	bh=lrWhTzB6xgIB0JiiTBsh5jvnmI6j4FZbM7p/RbCrzdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fO/Y2MLN89as8M2l1Mc1qqoGIU1c1JZIVKt3nmu+9JHh877hpvUI23ukXW17Ht8+x
	 dzU6f22/1delkE+x237lXi3BSHQLx1mdWTx/rJeKLrViQgSDW+e1Z00rlLU6y+HVyE
	 0jiKNwlDXb2hA5K73kIOjW7XWiwPAE8wZjZIaeqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCWGzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 02:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgCWGzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 02:55:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD4E120736;
        Mon, 23 Mar 2020 06:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584946508;
        bh=lrWhTzB6xgIB0JiiTBsh5jvnmI6j4FZbM7p/RbCrzdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0xL1w2abErjmfCO1gQbf2yVoe+9vnOyllcISy8RQNWW9Ula0pSdZqnewZur8OlCL
         Yab5JpM62US0Ur6+36zRL8uOo8qVYBkwZB3rzHTcrn1ESlRfp97FpP6NIzj461VNlu
         IXWLq7DK3mDmhlpvQh+/wkEWZjQRuHgoB6CbgFDM=
Date:   Mon, 23 Mar 2020 07:55:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Xin Tan <tanxin.ctf@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Vishnu DASA <vdasa@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Marshall <hubcap@omnibond.com>,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, kjlu@umn.edu
Subject: Re: Re: [PATCH] VMCI: Fix NULL pointer dereference on context ptr
Message-ID: <20200323065506.GA131098@kroah.com>
References: <1584426607-89366-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <20200318110204.GB2305113@kroah.com>
 <20200323045302.GA117440@sherlly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323045302.GA117440@sherlly>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 12:53:02PM +0800, Xiyu Yang wrote:
> Hi Greg,
> 
> On Wed, Mar 18, 2020 at 12:02:04PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Mar 17, 2020 at 02:29:57PM +0800, Xiyu Yang wrote:
> > > The refcount wrapper function vmci_ctx_get() may return NULL
> > > context ptr. Thus, we need to add a NULL pointer check
> > > before its dereference.
> > > 
> > > Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> > > Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> > > ---
> > >  drivers/misc/vmw_vmci/vmci_context.c    |  2 ++
> > >  drivers/misc/vmw_vmci/vmci_queue_pair.c | 17 +++++++++++------
> > >  2 files changed, 13 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
> > > index 16695366ec92..a20878fba374 100644
> > > --- a/drivers/misc/vmw_vmci/vmci_context.c
> > > +++ b/drivers/misc/vmw_vmci/vmci_context.c
> > > @@ -898,6 +898,8 @@ void vmci_ctx_rcv_notifications_release(u32 context_id,
> > >  					bool success)
> > >  {
> > >  	struct vmci_ctx *context = vmci_ctx_get(context_id);
> > > +	if (context == NULL)
> > > +		return;
> > 
> > Same comment as on your other patch.
> > 
> > And is this a v2?
> 
> Thanks! Yes, this is a v2. 
> 
> According  to our observation, vmci_ctx_rcv_notifications_release() 
> currently is only called by vmci_host_do_recv_notifications() which 
> guarantees a valid context object can be acquired with this context_id. 
> 
> However, we argue that a NULL-check here is still necessary because 
> this function may be called by other functions in the future who may 
> fail/forget to provide such guarantee. 

No, that's not how we write code in the kernel, if it does not need to
be checked for because this can not happen, then do not check for it.

Don't try to plan for random users of your code in the future when you
control those users directly :)

thanks,

greg k-h
