Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24C5C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4DE206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbgELOkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:40:31 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:58513 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727118AbgELOkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:40:31 -0400
Received: from [192.168.0.7] (ip5f5af0be.dynamic.kabel-deutschland.de [95.90.240.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id F2B432002EE1D;
        Tue, 12 May 2020 16:40:29 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [for-linus][PATCH 3/3] bootconfig: Fix to prevent warning message
 if no bootconfig option
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20200512132317.343672858@goodmis.org>
 <20200512132348.029291894@goodmis.org>
Message-ID: <a236ad2c-ee39-f2c3-9f07-a1ed6c9bfe22@molgen.mpg.de>
Date:   Tue, 12 May 2020 16:40:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200512132348.029291894@goodmis.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Steven,


Am 12.05.20 um 15:23 schrieb Steven Rostedt:
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Commit de462e5f1071 ("bootconfig: Fix to remove bootconfig
> data from initrd while boot") causes a cosmetic regression
> on dmesg, which warns "no bootconfig data" message without
> bootconfig cmdline option.
> 
> Fix setup_boot_config() by moving no bootconfig check after
> commandline option check.
> 
> Link: http://lkml.kernel.org/r/9b1ba335-071d-c983-89a4-2677b522dcc8@molgen.mpg.de
> Link: http://lkml.kernel.org/r/158916116468.21787.14558782332170588206.stgit@devnote2

It’d be great if you could update your script to include HTTPS URLs. 
That would save one redirect.

```
$ curl -I 
http://lkml.kernel.org/r/9b1ba335-071d-c983-89a4-2677b522dcc8@molgen.mpg.de
HTTP/1.1 301 Moved Permanently
[ prevent LKML HTML mail detection ]
```

> Fixes: de462e5f1071 ("bootconfig: Fix to remove bootconfig data from initrd while boot")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>   init/main.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 1a5da2c2660c..5803ecb411ab 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -400,9 +400,8 @@ static void __init setup_boot_config(const char *cmdline)
>   	char *data, *copy;
>   	int ret;
>   
> +	/* Cut out the bootconfig data even if we have no bootconfig option */
>   	data = get_boot_config_from_initrd(&size, &csum);
> -	if (!data)
> -		goto not_found;
>   
>   	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>   	parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> @@ -411,6 +410,11 @@ static void __init setup_boot_config(const char *cmdline)
>   	if (!bootconfig_found)
>   		return;
>   
> +	if (!data) {
> +		pr_err("'bootconfig' found on command line, but no bootconfig found\n");
> +		return;
> +	}
> +
>   	if (size >= XBC_DATA_MAX) {
>   		pr_err("bootconfig size %d greater than max size %d\n",
>   			size, XBC_DATA_MAX);
> @@ -446,8 +450,6 @@ static void __init setup_boot_config(const char *cmdline)
>   		extra_init_args = xbc_make_cmdline("init");
>   	}
>   	return;
> -not_found:
> -	pr_err("'bootconfig' found on command line, but no bootconfig found\n");
>   }
>   
>   #else

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
