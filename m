Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202B6C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E068720720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589216876;
	bh=oU4wnuMG2tVZrqGZWWwWWjiCk1bSVglLeFNFnisiDqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wD/Okl87piLTWI1cLgrNvMmGQ/d3i3L8V5yayBTtGRTcfTgJeVvXOXzOGe7tnXaqZ
	 FeF/MddPnQ1ywkyZmIptxlD9unD1Zv06zyXfBHutlGwZseoPPpQ8RJeF1FEf0UWKBU
	 5fY7L+Dn5ssaxIYcCe5qP5sjzVkgpMTgtMHViPsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgEKRHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730629AbgEKRHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:07:54 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26ABA20714;
        Mon, 11 May 2020 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589216874;
        bh=oU4wnuMG2tVZrqGZWWwWWjiCk1bSVglLeFNFnisiDqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RT2QuW4BGM8QX7GrS0chUCA2XBYuntrsOijBo2yXxZs1cJ/P8CuU8op78Z/7nWGte
         2HLAZJ2zf31YDYi6dvn8apSvZsATiKmlQkcIA7ZBa3Cd5sTOPg+FkrBMcDGNwfDcJN
         i/P243chAJ55052F8smYS7YdwW/yulWkQP+Y3h70=
Date:   Mon, 11 May 2020 10:07:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     davem@davemloft.net, Andrew Morton <akpm@linux-foundation.org>,
        netdev@vger.kernel.org, andrew@lunn.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] checkpatch: warn about uses of ENOTSUPP
Message-ID: <20200511100747.15637fa2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <c4b600b5455fcb48975cfc9d8214cdbbc01f2e2f.camel@perches.com>
References: <20200511165319.2251678-1-kuba@kernel.org>
        <c4b600b5455fcb48975cfc9d8214cdbbc01f2e2f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 10:03:31 -0700 Joe Perches wrote:
> On Mon, 2020-05-11 at 09:53 -0700, Jakub Kicinski wrote:
> > ENOTSUPP often feels like the right error code to use, but it's
> > in fact not a standard Unix error. E.g.:  
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl  
> []
> > @@ -4199,6 +4199,17 @@ sub process {
> >  			     "ENOSYS means 'invalid syscall nr' and nothing else\n" . $herecurr);
> >  		}
> >  
> > +# ENOTSUPP is not a standard error code and should be avoided in new patches.
> > +# Folks usually mean EOPNOTSUPP (also called ENOTSUP), when they type ENOTSUPP.
> > +# Similarly to ENOSYS warning a small number of false positives is expected.
> > +		if (~$file && $line =~ /\bENOTSUPP\b/) {  
> 
> It's probably my typo or my brain thinking "not" and hitting
> the tilde and not the bang, but this should be
> 
> 		if (!$file & ...)

Ahh! :)

> Otherwise:
> 
> Acked-by: Joe Perches <joe@perches.com>

Thanks!
