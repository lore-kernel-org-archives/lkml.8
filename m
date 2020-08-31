Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC27AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91750206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u39+72qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgHaSu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgHaSu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:50:26 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B9BC061573;
        Mon, 31 Aug 2020 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=dtOPczxeEWL0zpkCoHpBRps/3oLg7wT88R8xl2pU2fg=; b=u39+72qoiQHwPrSdeWUiGGJplW
        tISvUrG3piBxAWNoZSWUfHWlU77dRKhXdtN8BnoTBUhZhi0ymw2yrBJwUscogKR4kuuaFdP9W3d8B
        vdP74VedQEqzkA7Umd5wWvQVku+zMv0sy7KOmUZjsK8gh4436qwGrrUClw8QRSe75cDgDmJfstjz6
        DcN6+ZGrB4B60un6sSP4MpeEeCu8Ffzs4pa722NAdzDKCSheH/DeMj5wjk0OvTclVYUAt+JkzpzZm
        1+gKKGbxQhsJFJpAvfT0F2JRg0HeKIg9XXcGTiBfBkXgWjqbpi7TJ0/8HyOFBjW05NHW3Tf0RtImC
        T8gn/tSA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCosp-0004qM-QY; Mon, 31 Aug 2020 18:50:24 +0000
Subject: Re: [PATCH 5/6] Documentation: tracing: Add %return suffix
 description
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <159887792384.1330989.5993224243767476896.stgit@devnote2>
 <159887797048.1330989.6092698289026009625.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <210c7494-da9e-5314-c648-917493081c32@infradead.org>
Date:   Mon, 31 Aug 2020 11:50:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <159887797048.1330989.6092698289026009625.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/20 5:46 AM, Masami Hiramatsu wrote:
> Add a description of the %return suffix option for kprobe tracer.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Documentation/trace/kprobetrace.rst |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> index c1709165c553..d29d1f9e6721 100644
> --- a/Documentation/trace/kprobetrace.rst
> +++ b/Documentation/trace/kprobetrace.rst

Check spacing:

> @@ -37,6 +38,7 @@ Synopsis of kprobe_events
>  		  based on SYM+offs or MEMADDR.
>   MOD		: Module name which has given SYM.
>   SYM[+offs]	: Symbol+offset where the probe is inserted.
> + SYM%return     : Return address of the symbol
>   MEMADDR	: Address where the probe is inserted.
>   MAXACTIVE	: Maximum number of instances of the specified function that
>  		  can be probed simultaneously, or 0 for the default value

If I remove the '+', the ':' lines up but the SYM does not line up.
Am I missing something?

@@ -37,6 +38,7 @@ Synopsis of kprobe_events
 		  based on SYM+offs or MEMADDR.
  MOD		: Module name which has given SYM.
  SYM[+offs]	: Symbol+offset where the probe is inserted.
 SYM%return     : Return address of the symbol
  MEMADDR	: Address where the probe is inserted.
  MAXACTIVE	: Maximum number of instances of the specified function that
 		  can be probed simultaneously, or 0 for the default value


thanks.
-- 
~Randy

