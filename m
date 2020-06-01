Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1181C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76FB22077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591023212;
	bh=vNa6VLzZNeMosi3EkEcZ2+clXPOGUiu3YJKVf4v0pNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q8evxMhcqC6jiGbJ+i2NHPg3Ye1ETqc7cAFkCokswEsbLjdI8QjLuUOnQoOFXiVMQ
	 G7tphyC0E5vymrBE6iPXS14gjOpIgTTa0inKDpvS2+axkj2H+qCt994JrXCj5uPBMn
	 rgYquoOKqvlLb/pjULrqxXmfK5kZN9pAojWZ3w9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgFAOxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFAOxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:53:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C89062065C;
        Mon,  1 Jun 2020 14:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591023211;
        bh=vNa6VLzZNeMosi3EkEcZ2+clXPOGUiu3YJKVf4v0pNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqupUkw8NmrFUKxVsqExzK1hjZPxbcZ2TVpL9VD4lndfswniHzsxPQZctRSrBSI/I
         8sO6dWJhcIPC//vKo9rUPgxOSBX9vwe29FyU1L7tJua/L8POeQajEobnu9vpet9HnX
         QXoXSXFFU2SoC9jqpA4jMDOLP12J+OqpekknDUOM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AFDE040AFD; Mon,  1 Jun 2020 11:53:28 -0300 (-03)
Date:   Mon, 1 Jun 2020 11:53:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/3] tools compiler.h: Add attribute to disable tail calls
Message-ID: <20200601145328.GH31795@kernel.org>
References: <20200530082015.39162-1-irogers@google.com>
 <20200530082015.39162-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530082015.39162-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, May 30, 2020 at 01:20:13AM -0700, Ian Rogers escreveu:
> Tail call optimizations can remove stack frames that are used in
> unwinding tests. Add an attribute that can be used to disable the tail
> call optimization. Tested  on clang and GCC.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/include/linux/compiler-gcc.h | 8 ++++++++
>  tools/include/linux/compiler.h     | 3 +++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
> index 95c072b70d0e..cda555b47d3d 100644
> --- a/tools/include/linux/compiler-gcc.h
> +++ b/tools/include/linux/compiler-gcc.h
> @@ -27,6 +27,14 @@
>  #define  __pure		__attribute__((pure))
>  #endif
>  #define  noinline	__attribute__((noinline))
> +#ifdef __has_attribute
> +#if __has_attribute(disable_tail_calls)
> +#define __no_tail_call	__attribute__((disable_tail_calls))
> +#endif
> +#endif
> +#ifndef __no_tail_call
> +#define __no_tail_call	__attribute__((optimize("no-optimize-sibling-calls")))
> +#endif

Added this for some retro-computing old distros when building with old
clang versions :-)

- Arnaldo

diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
index cda555b47d3d..dea7378ad646 100644
--- a/tools/include/linux/compiler-gcc.h
+++ b/tools/include/linux/compiler-gcc.h
@@ -33,7 +33,10 @@
 #endif
 #endif
 #ifndef __no_tail_call
+#if GCC_VERSION > 40201
 #define __no_tail_call	__attribute__((optimize("no-optimize-sibling-calls")))
+#else
+#define __no_tail_call
 #endif
 #ifndef __packed
 #define __packed	__attribute__((packed))
