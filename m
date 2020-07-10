Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D43C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66482078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594367035;
	bh=SFQt0vxnwbG8QVBgOnlfaZeFajIEFrgh4tqcl3dJRaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h8VXzmeadcbz6LyL+T4DoLsvlgPrGKAxZGeSje5yQuI7wUhfOfFrYSuuYoznMRs4D
	 T9J1FkfcOZ1JgtktwIPXE/SEqp7hvwzy18+BXTnTV/RR8CXm0lKTYAxw7idMpNE6Vt
	 roKgKSlQISfJj3VyXH8FVnsW13pgN7c5zZ6VXbQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgGJHny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgGJHny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:43:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE02D206A5;
        Fri, 10 Jul 2020 07:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594367033;
        bh=SFQt0vxnwbG8QVBgOnlfaZeFajIEFrgh4tqcl3dJRaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aN4Z3vbCN2d9QS2ITUdxqDzj3cytW5esIu1oMWQq4xVBbMNCIzyulWCz3at2y+nqr
         j3ExIwo38spxxdY21kALdjLLm8MgIZaPYx+IXSjAIHkpRhG2MyHCL4BUsW9+Qe4MEI
         hk1j3yfYTMfIJtNvqSA+LMR7ttlGThTLrdQsu77s=
Date:   Fri, 10 Jul 2020 09:43:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB PHY LAYER: Replace HTTP links with HTTPS ones
Message-ID: <20200710074358.GB1179998@kroah.com>
References: <20200710072045.29133-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710072045.29133-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 09:20:45AM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.

Again, subject lines...
