Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DEDC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA0720870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hcfPQNWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgCEHBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:01:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCEHBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 02:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=l8u4PSC2b1MSuE5GU9e0yGRnIE+XAp+0pmylePcjEsU=; b=hcfPQNWEDOT1RSQ+/VhhzmgyeD
        ir4+IH5xkZ9F96ObSe4OYI2kpAQVzUXQZjy8Q96nFE7hNAEUzebI/ArcDK6PjlJK6GvmhO3rO6T8V
        GBMQ4lDH4Mk6sxs55cbXrDA3lQzu/I0mlWhzWVRh0CovUFgO6Cml6ah7fJoPLTbpNFS+eWcGWSaqJ
        18jBlOpHXt5OfQdFHL7P6Wdw54iPRmVhcGmaMk0RuC7H3f2ZGD1q+I6Jyi4scko7Tk3NJGAK5rdKK
        W3Cdd4MQ3KpuQW5+HzRrO8QHgYd35kCwccNJFKdwkOaVTnzeWnj7Jt0zyEdAKv9GzQXpvSJ6vDFQl
        prhnCRxg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9kVW-0003aa-FA; Thu, 05 Mar 2020 07:01:22 +0000
Subject: Re: [PATCH v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
Date:   Wed, 4 Mar 2020 23:01:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158339066140.26602.7533299987467005089.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 10:44 PM, Masami Hiramatsu wrote:
> Update boot configuration documentation.
> 
>  - Not using "config" abbreviation but configuration or description.
>  - Rewrite descriptions of node and its maxinum number.
>  - Add a section of use cases of boot configuration.
>  - Move how to use bootconfig to earlier section.
>  - Fix some typos, indents and format mistakes.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Hi Masami,

I swear that I am not trying to cause another version...

> ---
> Changes in v5:
>  - Elaborate the document.
>  - Fix some typos.
> Changes in v4:
>  - Remove O= option from examples.
> Changes in v3:
>  - Specify that comments also count in size.
>  - Fix a confusing sentence.
>  - Add O=<builddir> to make command.
> Changes in v2:
>  - Fixes additional typos (Thanks Markus and Randy!)
>  - Change a section title to "Tree Structured Key".
> ---
>  Documentation/admin-guide/bootconfig.rst |  201 +++++++++++++++++++-----------
>  Documentation/trace/boottime-trace.rst   |    2 
>  2 files changed, 131 insertions(+), 72 deletions(-)
> 
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index cf2edcd09183..3bfc9ddf68e1 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -11,25 +11,106 @@ Boot Configuration

> +When to Use the Boot Configuration?
> +-----------------------------------
> +
> +The boot configuration supports kernel command line options and init daemon
> +boot options. All sub-keys under "kernel" root key are passed as a part of
> +the kernel command line [1]_, and ones under "init" root key are passed as
> +a part of the init daemon's command line. For example, ::
> +
> +   root=UUID=8cd79b08-bda0-4b9d-954c-5d5f34b98c82 ro quiet splash console=ttyS0,115200n8 console=tty0
> +
> +This can be written as following boot configuration file.::
> +
> +   kernel {
> +      root = "UUID=8cd79b08-bda0-4b9d-954c-5d5f34b98c82" # nvme0n1p3
> +      ro       # mount rootfs as read only
> +      quiet    # No console log
> +      splash   # show splash image on boot screen
> +      console = "ttyS0,115200n8" # 1st console to serial device
> +      console += tty0            # add 2nd console
> +   }
> +
> +If you think that kernel/init options becomes too long to write in boot-loader

                                         become

> +configuration file or you want to comment on each option, the boot
> +configuration may be suitable. If unsure, you can still continue to use the
> +legacy kernel command line.


> +Boot Configuration Syntax
> +=========================
> +
> +The boot configuration syntax is a simple structured key-value. Each key
> +consists of dot-connected-words, and key and value are connected by ``=``.
> +The value has to be terminated by semicolon (``;``) or newline (``\n``).
> +For an array, its entries are separated by comma (``,``). ::
> +
> +  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
>  
>  Unlike the kernel command line syntax, spaces are OK around the comma and ``=``.
>  
>  Each key word must contain only alphabets, numbers, dash (``-``) or underscore
>  (``_``). And each value only contains printable characters or spaces except
> -for delimiters such as semi-colon (``;``), new-line (``\n``), comma (``,``),
> +for delimiters such as semicolon (``;``), new-line (``\n``), comma (``,``),

            usually called:                  newline

>  hash (``#``) and closing brace (``}``).
>  
>  If you want to use those delimiters in a value, you can use either double-


>  Comments
>  --------
>  
> -The config syntax accepts shell-script style comments. The comments starting
> -with hash ("#") until newline ("\n") will be ignored.
> -
> -::
> +The boot configuration accepts shell-script style comments. The comments,
> +beginning with hash (``#``) continues until newline (``\n``), will be

                               and continuing until newline

> +skipped.::
>  
>   # comment line
>   foo = value # value is set to foo.


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy

