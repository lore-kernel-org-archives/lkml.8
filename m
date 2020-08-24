Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A84C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A22D2078D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHXTJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:09:59 -0400
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:50168 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725976AbgHXTJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:09:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id CE64A837F24A;
        Mon, 24 Aug 2020 19:09:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lace57_3816ffb27055
X-Filterd-Recvd-Size: 2902
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Aug 2020 19:09:56 +0000 (UTC)
Message-ID: <1bf51283e26e6dd5f3c3e017d15cbb50dd84e507.camel@perches.com>
Subject: Re: [PATCH 2/3] dyndbg: refine export, rename to
 dynamic_debug_exec_queries()
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Aug 2020 12:09:55 -0700
In-Reply-To: <20200824185412.1617174-3-jim.cromie@gmail.com>
References: <20200824185412.1617174-1-jim.cromie@gmail.com>
         <20200824185412.1617174-3-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 12:54 -0600, Jim Cromie wrote:
> commit 59cf47e7df31 dyndbg: export ddebug_exec_queries
> left a few configs broken, fix them with ifdef-stubs.
> 
> Rename the export to dynamic_debug_exec_queries().  This is a more
> canonical function name, instead of exposing the 'ddebug' internal
> name prefix.  Do this now, before export hits v5.9.0
> 
> Implement as new function wrapping ddebug_exec_queries(now static
> again), which copies the query-string, preserving ddebug_exec_queries'
> in-place parsing, while allowing users to pass "const strings".
[]
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
[]
> @@ -210,6 +215,13 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
>  		print_hex_dump(KERN_DEBUG, prefix_str, prefix_type,	\
>  				rowsize, groupsize, buf, len, ascii);	\
>  	} while (0)
> -#endif
> +
> +static inline int dynamic_debug_exec_queries(const char *query, const char *modname)
> +{
> +	printk(KERN_WARNING "kernel not built w CONFIG_DYNAMIC_DEBUG_CORE\n");

pr_warn and w should be with

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
[]
> @@ -557,7 +557,27 @@ int ddebug_exec_queries(char *query, const char *modname)
>  		return exitcode;
>  	return nfound;
>  }
> -EXPORT_SYMBOL_GPL(ddebug_exec_queries);
> +
> +/**
> + * dynamic_debug_exec_queries - apply changes to selected dynamic-debug prints
> + * @query: string with callsite-selectors +enablement+decorations
> + * @modname: string containing module name
> + *
> + * This implements the >/proc/dynamic_debug/control reader, allowing
> + * module authors to modify their dynamic-debug callsites. The modname
> + * is canonically struct module.mod_name, but can also be null or a
> + * module-wildcard, for example: "drm*".
> + */
> +int dynamic_debug_exec_queries(const char *query, const char *modname)
> +{
> +	char *qry = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	int rc;
> +	strncpy(qry, query, PAGE_SIZE);

kstrndup?


