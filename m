Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDA8C4BA00
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683322176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgBYWc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:32:27 -0500
Received: from smtprelay0184.hostedemail.com ([216.40.44.184]:34866 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726827AbgBYWc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 17:32:26 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 710EC181D3030;
        Tue, 25 Feb 2020 22:32:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fowl93_894fd78211c48
X-Filterd-Recvd-Size: 2234
Received: from XPS-9350 (unknown [172.58.27.58])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Feb 2020 22:32:23 +0000 (UTC)
Message-ID: <635523a920bcc317eaf48230f003cd050f51c9bb.camel@perches.com>
Subject: Re: [PATCH 1/2] modpost: rework and consolidate logging interface
From:   Joe Perches <joe@perches.com>
To:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 25 Feb 2020 14:30:51 -0800
In-Reply-To: <20200225173526.9617-1-jeyu@kernel.org>
References: <20200225173526.9617-1-jeyu@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-25 at 18:35 +0100, Jessica Yu wrote:
> Rework modpost's logging interface by consolidating merror(), warn(),
> and fatal() to use a single function, modpost_log(). Introduce different
> logging levels (WARN, ERROR, FATAL) as well as a conditional warn
> (warn_unless()). The conditional warn is useful in determining whether
> to use merror() or warn() based on a condition. This reduces code
> duplication overall.
[]
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
[]
> @@ -51,41 +51,39 @@ enum export {
>  
>  #define MODULE_NAME_LEN (64 - sizeof(Elf_Addr))
>  
> -#define PRINTF __attribute__ ((format (printf, 1, 2)))
> +#define PRINTF __attribute__ ((format (printf, 2, 3)))
>  
> -PRINTF void fatal(const char *fmt, ...)
> +PRINTF void modpost_log(enum loglevel loglevel, const char *fmt, ...)
>  {
> +	char *level = NULL;
>  	va_list arglist;
>  
> -	fprintf(stderr, "FATAL: ");
> +	switch(loglevel) {
> +	case(LOG_WARN):
> +		level = "WARNING: ";
> +		break;
> +	case(LOG_ERROR):
> +		level = "ERROR: ";
> +		break;
> +	case(LOG_FATAL):
> +		level = "FATAL: ";
> +		break;
> +	default: /* invalid loglevel, ignore */
> +		break;

Odd parentheses around case labels and
likely level should be initialized as ""
and not NULL.

	const char *level = "";
	...
	switch (loglevel) {
	case LOG_WARN:
		level = "WARNING: ";
		break;
	...
	}


