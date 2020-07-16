Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB8BC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E628C206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594909548;
	bh=PKHHa2U0Q/fS+204ojzXqyjFZw5lyyFrrzNLEaQzU9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NdV2+yNKZ9j2ULX0zxfa0ujbPKwV34S7xzwcgHbEF4aAAgYpAd8Zz/7DPKqJrrAYd
	 G0cGP2T8Ew5obm5EnvZcIJom2Sp6bxoVTeiKCLtbz44jxELzdkROYi5Dck/CKTHElb
	 ILsJGzWXkuVJOXQnaWRUEooRBJXxgrpj4NsBxbGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgGPOZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbgGPOZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:25:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66BEF207CB;
        Thu, 16 Jul 2020 14:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594909543;
        bh=PKHHa2U0Q/fS+204ojzXqyjFZw5lyyFrrzNLEaQzU9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jiHRefMypriSTxbcAZBCIT2gM7OotHWPd2OzKoj4aJLrgXi28At0mE73ZBwwIt09f
         Aj3Tsu2oNHp3Jh4im+q02Nm3bVeLte7b3IAHBo9IRXQoY2DhkNiyTixShVIfe3RHZh
         bOeZOnbXDULXOBVtAR37UqwB1cdHdpWaO3cFR2vQ=
Date:   Thu, 16 Jul 2020 16:25:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Michel Lespinasse <walken@google.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: comedi: comedi_fops.c: added casts to get
 rid of sparse warnings
Message-ID: <20200716142537.GA2176745@kroah.com>
References: <20200716141747.wewrnejrygosqhd5@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716141747.wewrnejrygosqhd5@pesu-pes-edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:17:47AM -0400, B K Karthik wrote:
> fixed sparse warnings by adding a cast in assignment from
> void [noderef] __user * to unsigned int __force *
> and a reverse cast in argument from
> unsigned int * to  unsigned int __user * .
> 
> Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> ---
>  drivers/staging/comedi/comedi_fops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

What changed from previous versions?

That always goes below the --- line.

Please fix that up and resend a v4.

thanks,

greg k-h
