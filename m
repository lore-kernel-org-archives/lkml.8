Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4FBC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959972082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBEVzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:55:02 -0500
Received: from namei.org ([65.99.196.166]:43528 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgBEVzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:55:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 015LspWn020124;
        Wed, 5 Feb 2020 21:54:51 GMT
Date:   Thu, 6 Feb 2020 08:54:51 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
        linux-kernel@vger.kernel.org, kys@microsoft.com,
        jamorris@microsoft.com
Subject: Re: [PATCH] Documentation/process: Change Microsoft contact for
 embargoed hardware issues
In-Reply-To: <20200205214716.GA1468203@kroah.com>
Message-ID: <alpine.LRH.2.21.2002060854230.17039@namei.org>
References: <20200205213621.31474-1-sashal@kernel.org> <20200205214716.GA1468203@kroah.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2020, Greg KH wrote:

> On Wed, Feb 05, 2020 at 04:36:21PM -0500, Sasha Levin wrote:
> > Remove Sasha Levin as the Microsoft contact. A new contact will be
> > assigned by Microsoft.
> > 
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  Documentation/process/embargoed-hardware-issues.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> > index 33edae654599..a6f4f6e5c78b 100644
> > --- a/Documentation/process/embargoed-hardware-issues.rst
> > +++ b/Documentation/process/embargoed-hardware-issues.rst
> > @@ -250,7 +250,7 @@ an involved disclosed party. The current ambassadors list:
> >    Intel		Tony Luck <tony.luck@intel.com>
> >    Qualcomm	Trilok Soni <tsoni@codeaurora.org>
> >  
> > -  Microsoft	Sasha Levin <sashal@kernel.org>
> > +  Microsoft
> 
> That's fine, but when will that contact "be assigned"?  I'd rather not
> go without one at all for no good reason other than "people need to
> figure their stuff out" :)

Add me for this: jamorris@linux.microsoft.com


-- 
James Morris
<jmorris@namei.org>

