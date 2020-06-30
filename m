Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45D9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CEB62076C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgF3COU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:14:20 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60500 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgF3COT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:14:19 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jq5mb-0006gx-9Q; Tue, 30 Jun 2020 12:14:02 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 30 Jun 2020 12:14:01 +1000
Date:   Tue, 30 Jun 2020 12:14:01 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Subject: Re: linux-next: build failures after merge of the vfs tree
Message-ID: <20200630021401.GA20427@gondor.apana.org.au>
References: <20200616103440.35a80b4b@canb.auug.org.au>
 <20200616010502.GA28834@gondor.apana.org.au>
 <20200616033849.GL23230@ZenIV.linux.org.uk>
 <20200616143807.GA1359@gondor.apana.org.au>
 <20200617165715.577aa76d@canb.auug.org.au>
 <20200617070316.GA30348@gondor.apana.org.au>
 <20200617173102.2b91c32d@canb.auug.org.au>
 <20200617073845.GA20077@gondor.apana.org.au>
 <20200618100851.0f77ed52@canb.auug.org.au>
 <20200630115857.48eab55d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630115857.48eab55d@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 11:58:57AM +1000, Stephen Rothwell wrote:
>
> > > OK, here's a patch for both of these together:
> > > 
> > > diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
> > > index 32b7a30b2485..eb382ceaa116 100644
> > > --- a/arch/s390/lib/test_unwind.c
> > > +++ b/arch/s390/lib/test_unwind.c
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/kallsyms.h>
> > >  #include <linux/kthread.h>
> > >  #include <linux/module.h>
> > > +#include <linux/slab.h>
> > >  #include <linux/string.h>
> > >  #include <linux/kprobes.h>
> > >  #include <linux/wait.h>
> > > diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> > > index feb70283b6a2..903b2bb97e12 100644
> > > --- a/drivers/remoteproc/qcom_q6v5_mss.c
> > > +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> > > @@ -26,6 +26,7 @@
> > >  #include <linux/reset.h>
> > >  #include <linux/soc/qcom/mdt_loader.h>
> > >  #include <linux/iopoll.h>
> > > +#include <linux/slab.h>
> > >  
> > >  #include "remoteproc_internal.h"
> > >  #include "qcom_common.h"  
> > 
> > I have applied those 2 by hand for today.
> 
> I am still applying the above patch.

Hi Al:

Could you please fold these changes into your tree?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
