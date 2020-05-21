Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCD7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4EA206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="r/V4uF2L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="r/V4uF2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgEUOOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:14:05 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59228 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726903AbgEUOOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:14:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E599B8EE333;
        Thu, 21 May 2020 07:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590070444;
        bh=f7pE+KwkGnWAFx19+XJQ1EiUf28WfjrH1yLIOgU0mCw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=r/V4uF2LZLgNe84oCqgy9i664qPWtV8wDiUFedIDUfjHC6vQ6C7uWgqYJiMhYVeig
         mdQwOUv1VsAIJs/09Ik/5DOsTEpVzdfbaVQx39fpLM1HWudjya1guO5iylQCKL7ZIO
         zG1+R+3X4HldbELUO/3Wbo+t5qsNniXuRJEOqMIc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LxAJWbji2MdW; Thu, 21 May 2020 07:14:04 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 69CD18EE105;
        Thu, 21 May 2020 07:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590070444;
        bh=f7pE+KwkGnWAFx19+XJQ1EiUf28WfjrH1yLIOgU0mCw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=r/V4uF2LZLgNe84oCqgy9i664qPWtV8wDiUFedIDUfjHC6vQ6C7uWgqYJiMhYVeig
         mdQwOUv1VsAIJs/09Ik/5DOsTEpVzdfbaVQx39fpLM1HWudjya1guO5iylQCKL7ZIO
         zG1+R+3X4HldbELUO/3Wbo+t5qsNniXuRJEOqMIc=
Message-ID: <1590070442.4669.12.camel@HansenPartnership.com>
Subject: Re: [PATCH] scrpits: Remove unneeded assignment parentheses
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Xu Wang <vulab@iscas.ac.cn>, dhowells@redhat.com,
        dwmw2@infradead.org, keyrings@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 21 May 2020 07:14:02 -0700
In-Reply-To: <20200521063226.7434-1-vulab@iscas.ac.cn>
References: <20200521063226.7434-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-21 at 06:32 +0000, Xu Wang wrote:
> Remove unneeded assignment parentheses.

I really don't think this is a good idea.  Best practice for macros is
to parenthesize every argument even if there are technically some cases
where it's unnecessary because the problems in the majority cases are
huge and unexpected.

James

> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  scripts/extract-cert.c | 2 +-
>  scripts/sign-file.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/extract-cert.c b/scripts/extract-cert.c
> index b071bf476fea..8005911926b8 100644
> --- a/scripts/extract-cert.c
> +++ b/scripts/extract-cert.c
> @@ -61,7 +61,7 @@ static void drain_openssl_errors(void)
>  
>  #define ERR(cond, fmt, ...)				\
>  	do {						\
> -		bool __cond = (cond);			\
> +		bool __cond = cond;			\
>  		display_openssl_errors(__LINE__);	\
>  		if (__cond) {				\
>  			err(1, fmt, ## __VA_ARGS__);	\
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index fbd34b8e8f57..9ea08b07a0aa 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -104,7 +104,7 @@ static void drain_openssl_errors(void)
>  
>  #define ERR(cond, fmt, ...)				\
>  	do {						\
> -		bool __cond = (cond);			\
> +		bool __cond = cond;			\
>  		display_openssl_errors(__LINE__);	\
>  		if (__cond) {				\
>  			err(1, fmt, ## __VA_ARGS__);	\

