Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A294AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B38207BC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592843492;
	bh=NtdWqKvTd/VNjC32MyidJh32ZtdjWCh87PdbDpZ7sKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UB4pHKPAvNhfPBzE5pzSZ96oQ5K4yJeJuUT0xsid7MURFmsONJTQ+L2ZKmyFSk5dC
	 LIr5tiIal8YbkRo1Q1H6S3GyYOB27pZiUOgWfnbyufGRJDI7YJxwmmbJQSTLXpmzG8
	 d5cLk4wgPWQeBOa5qP0FBkpt2VudmxRBO5Bic3rI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgFVQba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729456AbgFVQba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:31:30 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C86592076E;
        Mon, 22 Jun 2020 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592843490;
        bh=NtdWqKvTd/VNjC32MyidJh32ZtdjWCh87PdbDpZ7sKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uS9RmRKKg6cbZw423vs5FcQnWsi7YT0RlqRxjPGYrJ1YkpGxdE7hCMPmvue+1UKsv
         q7FiVl5YXb5KS8sT2YFq+bE8d9vL5H2c0Jea0CajCNxmVEm7WNMndSea2W4sHn/XwT
         sZRU0R+5yRkdlQLAJoeO4bRi5Gy0gqIDF6jPAdDE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3B5A8405FF; Mon, 22 Jun 2020 13:31:27 -0300 (-03)
Date:   Mon, 22 Jun 2020 13:31:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andreas Gerstmayr <agerstmayr@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf flamegraph: explicitly set utf-8 encoding
Message-ID: <20200622163127.GB30611@kernel.org>
References: <20200619130745.153113-1-agerstmayr@redhat.com>
 <20200619153232.203537-1-agerstmayr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619153232.203537-1-agerstmayr@redhat.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 19, 2020 at 05:32:31PM +0200, Andreas Gerstmayr escreveu:
> on some platforms the default encoding is not utf-8,
> which causes an UnicodeDecodeError when reading the flamegraph template
> and writing the flamegraph

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
> ---
> 
> changelog v2: also write to stdout with utf-8 encoding
> 
>  tools/perf/scripts/python/flamegraph.py | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> index 61f3be9add6b..65780013f745 100755
> --- a/tools/perf/scripts/python/flamegraph.py
> +++ b/tools/perf/scripts/python/flamegraph.py
> @@ -17,6 +17,7 @@
>  from __future__ import print_function
>  import sys
>  import os
> +import io
>  import argparse
>  import json
>  
> @@ -81,7 +82,7 @@ class FlameGraphCLI:
>  
>          if self.args.format == "html":
>              try:
> -                with open(self.args.template) as f:
> +                with io.open(self.args.template, encoding="utf-8") as f:
>                      output_str = f.read().replace("/** @flamegraph_json **/",
>                                                    json_str)
>              except IOError as e:
> @@ -93,11 +94,12 @@ class FlameGraphCLI:
>              output_fn = self.args.output or "stacks.json"
>  
>          if output_fn == "-":
> -            sys.stdout.write(output_str)
> +            with io.open(sys.stdout.fileno(), "w", encoding="utf-8", closefd=False) as out:
> +                out.write(output_str)
>          else:
>              print("dumping data to {}".format(output_fn))
>              try:
> -                with open(output_fn, "w") as out:
> +                with io.open(output_fn, "w", encoding="utf-8") as out:
>                      out.write(output_str)
>              except IOError as e:
>                  print("Error writing output file: {}".format(e), file=sys.stderr)
> -- 
> 2.25.4
> 

-- 

- Arnaldo
