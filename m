Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABDCC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0462074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588021385;
	bh=QS/Ws0tcWAQM2ZkiRv7X5brt2YRcz7Xl1zO1Ihaw5ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2RlSyDjYRSCRJV/hkx0PIfCUfPfEscm1yR7/cjhJ3G5IS2xzfHRnohtmNe/AmYjXq
	 S6VvxtxavWxgJL0AB614RtaRBb/YBBRtnSUyiBSJZfGihYY+bN64a/klC0Q/QctV8C
	 9gkYXWiwngHn+v/DE8xr/YT2dtj6a25I8Z+h++eI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgD0VDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgD0VDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:03:04 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4CEC206E2;
        Mon, 27 Apr 2020 21:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588021383;
        bh=QS/Ws0tcWAQM2ZkiRv7X5brt2YRcz7Xl1zO1Ihaw5ak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EaQ/aOuYRpyZxVjpy0mYaR17gkB6Qks3k8Es7a63FM3/DBkMq27/LnMmxV1mNcDiP
         eXRqq+uChKse7fsyH/vEXyNLzRY+gIt5UL1/7wlkdB5bAOvpTESRIsFZjAbT8FgMUv
         gVY3foIecwO3fNk3mw5qttjURpHk7Jdg8z+jbdsg=
Date:   Mon, 27 Apr 2020 23:02:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Peter Lister <peter@bikeshed.quignogs.org.uk>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 08/29] docs: filesystems: convert configfs.txt to
 ReST
Message-ID: <20200427230258.5f1cd909@coco.lan>
In-Reply-To: <31da15f2-7755-3e56-d05c-1e3f388e0933@bikeshed.quignogs.org.uk>
References: <cover.1587487612.git.mchehab+huawei@kernel.org>
        <278a9befc98b49ea866c9b687d070c70cde20628.1587487612.git.mchehab+huawei@kernel.org>
        <31da15f2-7755-3e56-d05c-1e3f388e0933@bikeshed.quignogs.org.uk>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 24 Apr 2020 18:34:17 +0100
Peter Lister <peter@bikeshed.quignogs.org.uk> escreveu:

> > -configfs - Userspace-driven kernel object configuration.
> > +=======================================================
> > +Configfs - Userspace-driven Kernel oOject Configuration
> > +=======================================================  
> 
> Typo, presumably intended to be Object, not oOject?

Yeah, sorry for the typo.

> Why amend capitalisation as part of converting to REST? Normal 
> Linux/Unix convention is lower case for things like filesystems.

This is to make things more uniform. The thing is: before the
ReST conversion, there were a mess of capitalization on titles.
Some documents all caps, others just the first letter, others
camel case and there were even some documents whose titles
were all lower case. Now, almost all documents are using the
same capitalization for titles.

> 
> > -IMPORTANT: drop_item() is void, and as such cannot fail.  When rmdir(2)
> > -is called, configfs WILL remove the item from the filesystem tree
> > -(assuming that it has no children to keep it busy).  The subsystem is
> > -responsible for responding to this.  If the subsystem has references to
> > -the item in other threads, the memory is safe.  It may take some time
> > -for the item to actually disappear from the subsystem's usage.  But it
> > -is gone from configfs.
> > +.. Important::
> > +
> > +   drop_item() is void, and as such cannot fail.  When rmdir(2)
> > +   is called, configfs WILL remove the item from the filesystem tree
> > +   (assuming that it has no children to keep it busy).  The subsystem is
> > +   responsible for responding to this.  If the subsystem has references to
> > +   the item in other threads, the memory is safe.  It may take some time
> > +   for the item to actually disappear from the subsystem's usage.  But it
> > +   is gone from configfs.  
> 
> Using a  REST admonition is probably OK but, again, why change case?
> 
> The original author used shouting caps for IMPORTANT. A change can be 
> argued for consistency or if there is an established preference for 
> style. But, if so, that's a style patch, not a conversion.

It is for consistency reasons. On all converted docs I touched, I used
the same convention for such markups: "Notes", "Important", "Warning"...

Thanks,
Mauro
