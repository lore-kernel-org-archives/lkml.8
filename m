Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B88C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3DC20759
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466673;
	bh=A0HsRLwh+waBhbXVnQZLMzvbWT6Z1RHzCRsAim/n1ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WIlnZjjvnWp5GjaNaasbLwFvC1JxU39cMX21bSyCTzZJKKn1Ne8BqirYtQ5w2Zm0w
	 BVspn404zkcyplQ0lK4+Zdp9HUSdEoCS9/MBNWhvcPp+i8DmirLKRuxvdoiO7eZsOe
	 D2IxXsiEussB6C21MzgdQ9ta5+r8iuIO2riJPLjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgF2Vhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgF2Skd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:33 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69CF220774;
        Mon, 29 Jun 2020 04:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593405719;
        bh=A0HsRLwh+waBhbXVnQZLMzvbWT6Z1RHzCRsAim/n1ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yELho/jhyLvXCDpGccTqgeMDT6DBcXrWJCZuWHU2RcqLGOJ5NsJY58YMCERNs4Kh9
         zidsGTXRlqMSV8n/zyCtAXdxZ0EjGbCVRv8OvqSBMM2PG4zVMIWMJnQg07pt1tIoZN
         1ByoHTIgTBZSdt7rwXvaUxurf0UClDNtlcj182VE=
Date:   Mon, 29 Jun 2020 07:41:54 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: add link to sparse's home page/internal docs
Message-ID: <20200629044154.GB1492837@kernel.org>
References: <20200626112349.1292a654@lwn.net>
 <20200628095034.69520-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628095034.69520-1-luc.vanoostenryck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 11:50:34AM +0200, Luc Van Oostenryck wrote:
> Sparse's home page used to be a wiki (sparse.wiki.kernel.org)
> but this wiki only contained a short intro and the release notes.
> But nowadays, sparse's main page is sparse.docs.kernel.org,
> which contains all what was in the wiki but also other documentation,
> mainly oriented about sparse's internals.
> 
> So, add a link to this in the kernel documentation.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  Documentation/dev-tools/sparse.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/dev-tools/sparse.rst b/Documentation/dev-tools/sparse.rst
> index 6f4870528226..e20b8b8b78ed 100644
> --- a/Documentation/dev-tools/sparse.rst
> +++ b/Documentation/dev-tools/sparse.rst
> @@ -9,6 +9,8 @@ Sparse is a semantic checker for C programs; it can be used to find a
>  number of potential problems with kernel code.  See
>  https://lwn.net/Articles/689907/ for an overview of sparse; this document
>  contains some kernel-specific sparse information.
> +More information on sparse, mainly about its internals, can be found in
> +its official pages at https://sparse.docs.kernl.org.

Nit:                                       ^ kernel

>  
>  
>  Using sparse for typechecking
> -- 
> 2.27.0
> 

-- 
Sincerely yours,
Mike.
