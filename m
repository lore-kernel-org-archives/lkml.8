Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07666C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE36020730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580940727;
	bh=wLj9S/LrD7DGjH5YcOEpC8127mrsFwg+os8Ywv2dxeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zaDz/QsawSu9gz1Gw2yvXXIOCnOGShACSwtk9QjztaqyQatPMa69aTjzNlTauOWIB
	 4EURKnCdUu42waHpcGzgBdxsVwdZZJL9jUXCAldwOXri/ZNkKxIkvIh0/YnYXKS+/P
	 O28MBV7LdA8zTd0y2RfAVIg423/Jtjod3VnZWRSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgBEWMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:34538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgBEWMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:12:06 -0500
Received: from localhost (unknown [193.117.204.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94ACF20730;
        Wed,  5 Feb 2020 22:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580940726;
        bh=wLj9S/LrD7DGjH5YcOEpC8127mrsFwg+os8Ywv2dxeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xxxobtZePOFSC3oxNo0XgoWC3sI4l19XXnTHQyBGSL0wS8OMh7RlGQxv3rXlZa2Ug
         f9zt03Z1rcP5ErUlRw/4wObyxyZONT4Ux5O1hL8J1mPY1jGE48Ayiko/+Q/o/2dnQi
         ITK78s2zNJ/9nflvqN68OTLMJ6vfCuvbGqc2uk2E=
Date:   Wed, 5 Feb 2020 22:12:03 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     James Morris <jmorris@namei.org>
Cc:     Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
        linux-kernel@vger.kernel.org, kys@microsoft.com,
        jamorris@microsoft.com
Subject: Re: [PATCH] Documentation/process: Change Microsoft contact for
 embargoed hardware issues
Message-ID: <20200205221203.GA1471886@kroah.com>
References: <20200205213621.31474-1-sashal@kernel.org>
 <20200205214716.GA1468203@kroah.com>
 <alpine.LRH.2.21.2002060854230.17039@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2002060854230.17039@namei.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 08:54:51AM +1100, James Morris wrote:
> On Wed, 5 Feb 2020, Greg KH wrote:
> 
> > On Wed, Feb 05, 2020 at 04:36:21PM -0500, Sasha Levin wrote:
> > > Remove Sasha Levin as the Microsoft contact. A new contact will be
> > > assigned by Microsoft.
> > > 
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > >  Documentation/process/embargoed-hardware-issues.rst | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> > > index 33edae654599..a6f4f6e5c78b 100644
> > > --- a/Documentation/process/embargoed-hardware-issues.rst
> > > +++ b/Documentation/process/embargoed-hardware-issues.rst
> > > @@ -250,7 +250,7 @@ an involved disclosed party. The current ambassadors list:
> > >    Intel		Tony Luck <tony.luck@intel.com>
> > >    Qualcomm	Trilok Soni <tsoni@codeaurora.org>
> > >  
> > > -  Microsoft	Sasha Levin <sashal@kernel.org>
> > > +  Microsoft
> > 
> > That's fine, but when will that contact "be assigned"?  I'd rather not
> > go without one at all for no good reason other than "people need to
> > figure their stuff out" :)
> 
> Add me for this: jamorris@linux.microsoft.com

Can you send me a patch please?

thanks,

greg k-h
