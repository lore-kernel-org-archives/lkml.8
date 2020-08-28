Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FCDC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18CC2078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="hAHFJWwU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KaZOa7vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgH1KO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:14:56 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:33169 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728016AbgH1KOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:14:54 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 0AAFEAF8;
        Fri, 28 Aug 2020 06:14:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 28 Aug 2020 06:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=NmL6Y2ExxI2GoaPkCBt2WSxtBuj
        WQ4FpjKL9PFQlnmc=; b=hAHFJWwUXQ0Hc/WeFvgOIO8Y4dI3B8xz9MlKJLCBF41
        QxDPsUnpjKcjXuJnNMKX+bdvBjvVA27Qb7S4Qp7Kxj8I5in4W5n38XHnzfsnYUdY
        uOPBEpofwn634NwHvnWoAwQJCcxVtGPkwV5XfUG1gKV/0kIbELSimrpFaQIYAqTT
        pS1IiMQvaj+vWoSqnalv4nLSrqsqQ/IgMyXvjbhrjXs2OtAD8kDZy9r7jNOxwOQB
        Eu3XfruIRn1R3J0A5GFKI9tug4VqWu8AAquHNy09z+vnZV3Bh4+LI2nTcrfcQpyp
        Yw4P+a7U0EdDK7x+CWOiFWm7kJDDAVNNmVRoqwPMY1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=NmL6Y2
        ExxI2GoaPkCBt2WSxtBujWQ4FpjKL9PFQlnmc=; b=KaZOa7vtdx4GpBHLHLII11
        TnnnDBI4Hy6ICIJE1Qm0pidZj42b40byhXCEwJQi+ly47d3uFUCucCAmPGJrFZTy
        o6N4dFp5w6mJ+1yZhbmIlmjrkxz0T5nfEslyprgFYG80h3NyHiD9InYwrib0aH9D
        3zsGn1xlwqg6U6TflNf+hL+CdPKj30zYKiUk+kX7OO3W1RK1SI5e8rneJ6b1YYwQ
        UzDPkCojkEHhXJnGmhITRZVZ0GwhGRCaXOzq9HhFXVR+Fb7M8dmx8q7Pd6ycTvJb
        uVVh6iyiimnTxrxhmKO9RD/GpJhGw/UDv21ct3HOkVmQi7DWubvQpMqC80KU6PDQ
        ==
X-ME-Sender: <xms:HdlIX_DvsC7x-uJrl0XcsIMTseazl01nS4WOZUcEBb067S_IFhXxtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvjedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecukfhppeekfedrkeeirdekledruddtjeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homh
X-ME-Proxy: <xmx:HdlIX1jlHXLSpSaoXreZYQsDbuesipYnPMzNXy-IOSLB4mjeMz9r7Q>
    <xmx:HdlIX6kOSCcA_2oFUBfgR4uFU1YCPYCP9HJx3__B5wAeylNEv-8CqQ>
    <xmx:HdlIXxyAic0Dws3Vvg7mef98UKCoz0_Trq3TSceLGoTO9O2KYx6wgA>
    <xmx:HdlIX973Hg-aKQJWgW9--hdIYKppn2tQLSy0UHeCNraR9Uad8wG4rA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 24F5D30600B4;
        Fri, 28 Aug 2020 06:14:53 -0400 (EDT)
Date:   Fri, 28 Aug 2020 12:15:05 +0200
From:   Greg KH <greg@kroah.com>
To:     Valery Ivanov <ivalery111@gmail.com>
Cc:     arve@android.com, riandrews@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: android: ion: remove unnecessary intermediate
 variable 'objs'
Message-ID: <20200828101505.GB1352233@kroah.com>
References: <20200827112448.85831-1-ivalery111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827112448.85831-1-ivalery111@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 02:24:48PM +0300, Valery Ivanov wrote:
> It is not necesssary to use 'objs' as an intermediate variable for assignment operation.
> 
> Signed-off-by: Valery Ivanov <ivalery111@gmail.com>
> ---
>  drivers/staging/android/ion/ion.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index 3c9f09506ffa..137bef25dcbc 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -523,15 +523,12 @@ static int debug_shrink_set(void *data, u64 val)
>  {
>  	struct ion_heap *heap = data;
>  	struct shrink_control sc;
> -	int objs;
>  
>  	sc.gfp_mask = GFP_HIGHUSER;
>  	sc.nr_to_scan = val;
>  
> -	if (!val) {
> -		objs = heap->shrinker.count_objects(&heap->shrinker, &sc);
> -		sc.nr_to_scan = objs;
> -	}
> +	if (!val)
> +		sc.nr_to_scan = heap->shrinker.count_objects(&heap->shrinker, &sc);
>  
>  	heap->shrinker.scan_objects(&heap->shrinker, &sc);
>  	return 0;
> -- 
> 2.25.1
> 

Please use scripts/get_maintainer.pl to determine who and what mailing
list to send patches to.  You missed the actual maintainers of this
code.

thanks,

greg k-h
