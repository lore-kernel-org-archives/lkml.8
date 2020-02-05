Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55A0C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E85E214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580945091;
	bh=awwg/drPT6NpUw5oW833nxqJgOrW4ij+PIWl0U/eMIw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=dA/8a0L754Ppt0WQdnPrvMyjjXclobHls6DXDDB7Nt6ejWxskyMmSBiH7ZGXzKVv9
	 fE4J8kGTSqvyEP04vfmUc+0wVOgOhrLb0Cml9/rabLfJ66/Ox3e4bhtMSmvMHEn9qH
	 kezcJHRXNMMlolok0whNApmAXkY5cN99sw8gnehU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBEXYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:24:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgBEXYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:24:50 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF4E52082E;
        Wed,  5 Feb 2020 23:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580945090;
        bh=awwg/drPT6NpUw5oW833nxqJgOrW4ij+PIWl0U/eMIw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PRt1hIQ39qgbYrX5eh0lEQG2dy0H2kmVTi1Br+JjKIfZqW06HSqtW6WjxuFVSFPNB
         Nf1m5Bd3UKy4lOmBZhB8j0dMd1cVBV0UPKZu8ZjBP+fJnSatuRXu91n6d7GUKl/aDF
         flBDiBYjyaI4FNRiItP5AblHuFrnTeCa92QPD6Ds=
Message-ID: <1580945088.2032.2.camel@kernel.org>
Subject: Re: [PATCH][next] tracing/kprobe: Fix uninitialized variable bug
From:   Tom Zanussi <zanussi@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 05 Feb 2020 17:24:48 -0600
In-Reply-To: <20200205223404.GA3379@embeddedor>
References: <20200205223404.GA3379@embeddedor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Wed, 2020-02-05 at 16:34 -0600, Gustavo A. R. Silva wrote:
> There is a potential execution path in which variable *ret* is
> returned
> without being properly initialized, previously.
> 
> Fix this by initializing variable *ret* to 0.
> 

Good catch.  Thanks for fixing this!

Reviewed-by: Tom Zanussi <zanussi@kernel.org>



> Addresses-Coverity-ID: 1491142 ("Uninitialized scalar variable")
> Fixes: 2a588dd1d5d6 ("tracing: Add kprobe event command generation
> functions")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  kernel/trace/trace_kprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c
> b/kernel/trace/trace_kprobe.c
> index d8264ebb9581..362cca52f5de 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1012,7 +1012,7 @@ int __kprobe_event_add_fields(struct
> dynevent_cmd *cmd, ...)
>  {
>  	struct dynevent_arg arg;
>  	va_list args;
> -	int ret;
> +	int ret = 0;
>  
>  	if (cmd->type != DYNEVENT_TYPE_KPROBE)
>  		return -EINVAL;
