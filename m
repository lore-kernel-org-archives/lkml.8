Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13D4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2452080D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbgFPPOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgFPPOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:14:15 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4561BC061573;
        Tue, 16 Jun 2020 08:14:14 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jlDHn-00A1dX-5X; Tue, 16 Jun 2020 15:14:03 +0000
Date:   Tue, 16 Jun 2020 16:14:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Subject: Re: linux-next: build failures after merge of the vfs tree
Message-ID: <20200616151403.GM23230@ZenIV.linux.org.uk>
References: <20200616103330.2df51a58@canb.auug.org.au>
 <20200616103440.35a80b4b@canb.auug.org.au>
 <20200616010502.GA28834@gondor.apana.org.au>
 <20200616033849.GL23230@ZenIV.linux.org.uk>
 <20200616143807.GA1359@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616143807.GA1359@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:38:07AM +1000, Herbert Xu wrote:
> On Tue, Jun 16, 2020 at 04:38:49AM +0100, Al Viro wrote:
> >
> > Folded and pushed
> 
> Thanks Al.  Here's another one that I just got, could you add this
> one too?

Done...
