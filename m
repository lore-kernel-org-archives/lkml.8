Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C74C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9502245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgGaPPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgGaPPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:15:13 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C618C21744;
        Fri, 31 Jul 2020 15:15:11 +0000 (UTC)
Date:   Fri, 31 Jul 2020 11:15:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Joe Perches <joe@perches.com>, Rob Herring <robh@kernel.org>,
        Grant Likely <grant.likely@arm.com>
Subject: Re: [PATCH v1 2/3] lib/vsprintf: Replace custom spec to print
 decimals with generic one
Message-ID: <20200731111510.27c2ef73@oasis.local.home>
In-Reply-To: <20200731123145.22357-2-andriy.shevchenko@linux.intel.com>
References: <20200731123145.22357-1-andriy.shevchenko@linux.intel.com>
        <20200731123145.22357-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 15:31:44 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> When printing phandle in %pOF the custom spec is used. First of all,
> it has SMALL flag which makes no sense for decimal numbers. Second,
> we have already default spec for decimal numbers. Use the latter in
> %pOF case as well.

The change log threw me off, as this is specifically for %pOFp. This
only affects the phandle ('p') portion. Please update the change log to
reflect that.

Also, I would add in Cc those that added this code and looked it over:

Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Joe Perches <joe@perches.com>
Cc: Rob Herring <robh@kernel.org>

And mentioned in that code's change log:

Cc: Grant Likely <grant.likely@arm.com>


Otherwise,

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve



> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/vsprintf.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 8a8ac7ce0289..90d818ef03c5 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1979,12 +1979,6 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>  	char *buf_start = buf;
>  	struct property *prop;
>  	bool has_mult, pass;
> -	static const struct printf_spec num_spec = {
> -		.flags = SMALL,
> -		.field_width = -1,
> -		.precision = -1,
> -		.base = 10,
> -	};
>  
>  	struct printf_spec str_spec = spec;
>  	str_spec.field_width = -1;
> @@ -2024,7 +2018,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>  			str_spec.precision = precision;
>  			break;
>  		case 'p':	/* phandle */
> -			buf = number(buf, end, (unsigned int)dn->phandle, num_spec);
> +			buf = number(buf, end, (unsigned int)dn->phandle, default_dec_spec);
>  			break;
>  		case 'P':	/* path-spec */
>  			p = fwnode_get_name(of_fwnode_handle(dn));

