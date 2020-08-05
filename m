Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5098EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2208E206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgHETYf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:24:35 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36618 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbgHER1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:27:19 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BAD4E1C0BD2; Wed,  5 Aug 2020 19:27:16 +0200 (CEST)
Date:   Wed, 5 Aug 2020 19:27:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net,
        geert+renesas@glider.be, ribalda@kernel.org, martink@posteo.de,
        luis.f.correia@gmail.com, paulburton@kernel.org, cyphar@cyphar.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CREDITS: add myself
Message-ID: <20200805172715.GA1118@bug>
References: <20200805064805.64688-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200805064805.64688-1-grandmaster@al2klimov.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Rationale:
> 50 already merged patches of mine.

I don't believe anyone really maintains (or uses) CREDITS these days. Maybe akpm would be willing
to take it?

Best regards,
									Pavel
> diff --git a/CREDITS b/CREDITS
> index 32ee70a7562e..aaa2c20c0d86 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -1933,6 +1933,11 @@ S: Schwalbenstr. 96
>  S: 85551 Ottobrunn
>  S: Germany
>  
> +N: Alexander A. Klimov
> +E: grandmaster@al2klimov.de
> +W: https://github.com/Al2Klimov
> +D: documentation
> +
>  N: Ian Kluft
>  E: ikluft@thunder.sbay.org
>  W: http://www.kluft.com/~ikluft/
> -- 
> 2.27.0

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
