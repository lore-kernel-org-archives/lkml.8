Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0632C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D1F206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgGNVrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:47:11 -0400
Received: from ms.lwn.net ([45.79.88.28]:42786 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgGNVrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:47:10 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 35E9260C;
        Tue, 14 Jul 2020 21:47:10 +0000 (UTC)
Date:   Tue, 14 Jul 2020 15:47:08 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     torvalds@linux-foundation.org, ribalda@kernel.org,
        viro@zeniv.linux.org.uk, mchehab+samsung@kernel.org,
        luis.f.correia@gmail.com, geert+renesas@glider.be,
        paulburton@kernel.org, cyphar@cyphar.com, martink@posteo.de,
        davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CREDITS: remove link http://www.dementia.org/~shadow
Message-ID: <20200714154708.71b3efe2@lwn.net>
In-Reply-To: <20200714193805.49746-1-grandmaster@al2klimov.de>
References: <20200713114321.783f0ae6@lwn.net>
        <20200714193805.49746-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 21:38:05 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Rationale:
> The way it redirects looks like a fallback from a dead URL to a generic one.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Yes, I noted that some of the links removed by these "CREDITS: remove link:"
>  patches have email addresses with the same domain nearby.
> 
>  Don't worry, I'll take care of them together with all other
>  dead email addresses - but not right now.
> 
> 
>  CREDITS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/CREDITS b/CREDITS
> index 0787b5872906..92ad22b7ef56 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -483,7 +483,6 @@ D: Intel Wireless WiMAX Connection 2400 SDIO driver
>  
>  N: Derrick J. Brashear
>  E: shadow@dementia.org
> -W: http://www.dementia.org/~shadow

So thanks for addressing these.  That said, I do wonder if this is quite
the right thing to do.  I'm assuming that the old sites still exist in the
wayback machine somewhere, and somebody might actually want to find them.
Pity the poor anthropologist researching the origins of the the
billion-line, free-software kernels widely used in the 2500's...

So maybe we should either mark it as "[BROKEN]" or make a direct link into
the wayback machine instead?  That would enable the suitably motivated to
go after the content that once existed.

Thoughts anybody?

Thanks,

jon
