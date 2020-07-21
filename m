Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAC3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F08820792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595338268;
	bh=XU1hnquLcT3uOLI4CEBQSKNiZLfuqrOpsjs/ol0fJo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qscFrRRcatpkDIsyLCq67PitQuB2cL23V3t5Y6PILIkNIU7pBQnxQP2Bb/AdlcWHS
	 /DiNG9K1Y7dep2If3amrIAcc8aHEQzT/veEqIgfzFzDdiEOhKns1H7vUYP4MiO2d2h
	 2kywHgsB317ULmVuNkvctMXeDBzuK+jzKge5O5MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgGUNbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgGUNbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:31:06 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24AD9206E9;
        Tue, 21 Jul 2020 13:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595338266;
        bh=XU1hnquLcT3uOLI4CEBQSKNiZLfuqrOpsjs/ol0fJo0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FylJoQqJ/ehmVF0ki09SSZeGx6cTPmYCPzZySi4AGS0knaN4gPsguYtsBSrqx0B+k
         HF7WkU7SK1+eR+v4tGCovnYOrJBoO3DNjsJOgwIDa8pFIAmeIiYrVHuAaoBWS9l57+
         Ocz+h/JyemWLpd6YWSj9T5OlLyu7qht9AbfTtd6o=
Date:   Tue, 21 Jul 2020 22:31:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Replace HTTP links with HTTPS ones
Message-Id: <20200721223102.25b67b3c6b2114c146373a7a@kernel.org>
In-Reply-To: <20200709191636.26252-1-grandmaster@al2klimov.de>
References: <20200708184201.611d929ae6017c87ea98b114@kernel.org>
        <20200709191636.26252-1-grandmaster@al2klimov.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Jul 2020 21:16:36 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  I'd really would like to get HTTPSifying done before other tasks...
> 
>  Documentation/kprobes.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
> index 8baab8832c5b..88b4d2845b37 100644
> --- a/Documentation/kprobes.txt
> +++ b/Documentation/kprobes.txt
> @@ -693,7 +693,7 @@ process. Here are sample overhead figures (in usec) for x86 architectures::
>  TODO
>  ====
>  
> -a. SystemTap (http://sourceware.org/systemtap): Provides a simplified
> +a. SystemTap (https://sourceware.org/systemtap): Provides a simplified
>     programming interface for probe-based instrumentation.  Try it out.
>  b. Kernel return probes for sparc64.
>  c. Support for other architectures.
> -- 
> 2.27.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
