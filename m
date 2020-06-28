Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3679C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 19:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852E3204EA
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 19:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgF1TFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 15:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgF1TFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 15:05:10 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2285F206C0;
        Sun, 28 Jun 2020 19:05:09 +0000 (UTC)
Date:   Sun, 28 Jun 2020 15:05:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "glider@google.com" <glider@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: main.c: Fixed a brace coding style issue.
Message-ID: <20200628150507.5f5181fe@oasis.local.home>
In-Reply-To: <20200628134100.mseebxf3dot56eia@pesu-pes-edu>
References: <20200628134100.mseebxf3dot56eia@pesu-pes-edu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jun 2020 09:41:00 -0400
B K Karthik <bkkarthik@pesu.pes.edu> wrote:

> Fixed a coding style issue.
> 
> Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> ---
>  init/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 9127b240fd26..d8477fb95bec 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -385,11 +385,11 @@ static u32 boot_config_checksum(unsigned char *p, u32 size)
>  static int __init bootconfig_params(char *param, char *val,
>  				    const char *unused, void *arg)
>  {
> -	if (strcmp(param, "bootconfig") == 0) {
> +	if (strcmp(param, "bootconfig") == 0)
>  		bootconfig_found = true;
> -	} else if (strcmp(param, "--") == 0) {
> +	else if (strcmp(param, "--") == 0)
>  		initargs_found = true;
> -	}
> +

NAK.

perhaps for simple if () ;else ; statements I'd be OK with this change,
but this is a if () ; else if () ; which is up to the preference of the
user. I find the brackets making it easier to see that this is not a
normal if () ; else ;

-- Steve


>  	return 0;
>  }
> 
> --
> 2.20.1
> 

