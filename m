Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C13CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C1222081A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461121;
	bh=u/7iyrvQ3LzsCNLl/ZBd2xHjBP2XLskqDAzPtHt/Jw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1uh4unf0OUw5k3T4f5OQ9dxqhHAcqnI2Knn9tMjF7b8SukYQrdz7fYtmwWDFWESG6
	 Q4M9Ab1Poy1GJ0+PXFc99ns0Mv7W9g/0Fcs9jdzTU8qmqqj5GjXExfzyh9py+9Thtb
	 DaW0CFiwzvGnr3JjI+u4V9a7eiDmCbz8xbweJVf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388823AbgF2UFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732035AbgF2UFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:05:16 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92A2020702;
        Mon, 29 Jun 2020 20:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593461116;
        bh=u/7iyrvQ3LzsCNLl/ZBd2xHjBP2XLskqDAzPtHt/Jw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHUr5A6mJj30a5qZEXoAkoLFDQ0EUls2Wd/7WNsTQhe16JoK8NOEYZuv25mCbFGME
         Ythz2afVpxY19lU4XHuWTN74WSn4/wSjmScPOHt1Et5R5+9bNn+qN7Fif8scE5iVha
         V/nVKaNKwuiaPjYveohhRgIDPVLqujmjyYn3CGLA=
Date:   Mon, 29 Jun 2020 23:05:09 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc: add link to sparse's home page/internal docs
Message-ID: <20200629200509.GE1492837@kernel.org>
References: <20200629044154.GB1492837@kernel.org>
 <20200629161310.89783-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629161310.89783-1-luc.vanoostenryck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 06:13:10PM +0200, Luc Van Oostenryck wrote:
> Sparse's home page used to be a wiki (sparse.wiki.kernel.org)
> but this wiki only contained a short intro and the release notes.
> But nowadays, sparse's main page is sparse.docs.kernel.org,
> which contains all what was in the wiki but also other documentation,
> mainly oriented about sparse's internals.
> 
> So, add a link to this in the kernel documentation.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> 
> Changes since v1:
> * fix a typo (s/kernl/kernel/) thanks to Mike Rapoport.
> 
>  Documentation/dev-tools/sparse.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/dev-tools/sparse.rst b/Documentation/dev-tools/sparse.rst
> index 8a7055593c31..02102be7ff49 100644
> --- a/Documentation/dev-tools/sparse.rst
> +++ b/Documentation/dev-tools/sparse.rst
> @@ -9,6 +9,8 @@ Sparse is a semantic checker for C programs; it can be used to find a
>  number of potential problems with kernel code.  See
>  https://lwn.net/Articles/689907/ for an overview of sparse; this document
>  contains some kernel-specific sparse information.
> +More information on sparse, mainly about its internals, can be found in
> +its official pages at https://sparse.docs.kernel.org.
>  
>  
>  Using sparse for typechecking
> -- 
> 2.27.0
> 

-- 
Sincerely yours,
Mike.
