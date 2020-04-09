Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD84DC2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 05:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9372220771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 05:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586411630;
	bh=PZpwEDZqalrcZdaZXg391xQtawvNQl0BlnXyC7AWgW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kIkN9Ezn07Dpb5MdnAxdzFOBZWy7jg9Lr1uiTTqvu7BmCStyUOSrkgAP3ncTOzCeh
	 lvM1sIxsOSyuMqdDOVBdtAK+CWmPq9dOpF7LeIfgW5M3g8VrGC1W6sHc/zHnlv5eO3
	 N5n4s4eb3BL7eIajS1isMMj1R8TY3cxJzAZRkL6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDIFxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 01:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgDIFxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 01:53:22 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2702B20771;
        Thu,  9 Apr 2020 05:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586411602;
        bh=PZpwEDZqalrcZdaZXg391xQtawvNQl0BlnXyC7AWgW8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ORXGoZ2Tz6as4vV23sFw8z/3wIbJRRFAQmahJjuY70zN/mX4V0IsA5Peh3ADZ48tI
         oXoKzz9WSuUi9EP4aCzT/P6lr9Qu2K2hXuGtFhng9d45Grt/4zzT8tcllUxJAqPzaZ
         kouAO9cFh8+hqfd/DlS8y39QrfaIjOZLCFElIq04=
Date:   Thu, 9 Apr 2020 07:53:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 31/35] powerpc: docs: cxl.rst: mark two section titles
 as such
Message-ID: <20200409075316.01edd295@coco.lan>
In-Reply-To: <fc649189-91cc-bb73-8d07-34054629a2b3@linux.ibm.com>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
        <cccd2886af9961aad2a69fce96c0cf4f06995d6d.1586359676.git.mchehab+huawei@kernel.org>
        <fc649189-91cc-bb73-8d07-34054629a2b3@linux.ibm.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 9 Apr 2020 10:37:52 +1000
Andrew Donnellan <ajd@linux.ibm.com> escreveu:

> On 9/4/20 1:46 am, Mauro Carvalho Chehab wrote:
> > The User API chapter contains two sub-chapters. Mark them as
> > such.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Thanks.
> 
> Though the other subsections in this file use ----- rather than ^^^^^, 
> what's the difference?

ReST syntax allows the usage of several different markup symbols for
titles. It dynamically attributes the first one it finds as level 1,
the second one as level 2 and so on.

As we added the "^^^^" markup before "-----", after this patch, it now has:

	=======
	level 1
	=======

	level 2
	=======

	level 3
	^^^^^^^

	level 4
	-------


> 
> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
> 
> > ---
> >   Documentation/powerpc/cxl.rst | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/powerpc/cxl.rst b/Documentation/powerpc/cxl.rst
> > index 920546d81326..d2d77057610e 100644
> > --- a/Documentation/powerpc/cxl.rst
> > +++ b/Documentation/powerpc/cxl.rst
> > @@ -133,6 +133,7 @@ User API
> >   ========
> >   
> >   1. AFU character devices
> > +^^^^^^^^^^^^^^^^^^^^^^^^
> >   
> >       For AFUs operating in AFU directed mode, two character device
> >       files will be created. /dev/cxl/afu0.0m will correspond to a
> > @@ -395,6 +396,7 @@ read
> >   
> >   
> >   2. Card character device (powerVM guest only)
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   
> >       In a powerVM guest, an extra character device is created for the
> >       card. The device is only used to write (flash) a new image on the
> >   
> 



Thanks,
Mauro
