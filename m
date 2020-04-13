Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08019C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D102020692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chca8gne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgDMOAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730187AbgDMOAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:00:00 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFEDC0A3BDC;
        Mon, 13 Apr 2020 06:59:59 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l25so9470958qkk.3;
        Mon, 13 Apr 2020 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rX4VkdwVypW94mjbVabuOl84624Ra1qiPbXHO/h11D4=;
        b=Chca8gnerzuFJzvgrAhZORgZgBxtohLRflSTKgcBbWjXsFdZo9clL8shm8GsxCGezc
         amP0Z1PU1+DKqwy8ZNYp/ZC160ZXnZUQqgyfKl3+JLgRwJGYqihXpALk58L4jMeovSqF
         4AqOECM3/LBlGRhwt4c/nNHgiPRbvyUdd+r/e3bP8L8OaI1lfpOtDp3SHtE3dpsCBYyX
         LCxFpaPuDfJ38oNGHksLPok9j2FkmqOh8xfgkJNaEkij4ZDDq7mZxpvF/tx0GH/tG7u9
         Xgq5eVluBt91EFpcF5O01cIFicdBVZKKusHAKPMvJZ7bek49oJwhO8b9EFlL16FtuVKr
         /4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rX4VkdwVypW94mjbVabuOl84624Ra1qiPbXHO/h11D4=;
        b=iD5vvCY5HRFGM7aOmpvfwcNF5o9DSzXd3yEKK5rrn5lmsUO705Aun2TfnjauXjBJYo
         V3ugQ0h2KF4V+vEJSdp/FKpkARtZPbmwOCniqKK+YQRngCOC8sX+IdSKtPFj9QMKuSmK
         Ik7HSzmQssb4G3Q7dqf49vgT79J3RY+bYL0FmXUGP1RBzeilv1a1scE2bwy8YvkA/EaB
         QSvrOCQyJjeWLsfo+OW1N8O6NOQlyoZsZHoPlR5MwopNJp2qaYXz/rxzGk7YoMl/6vFg
         Nly4Ie+uIIX2f9R82decbpXmwCLOIrnwEcjKM875kpvV7sXEQsqspP2EMyuHNeNssaxY
         izZw==
X-Gm-Message-State: AGi0PuavowWJLm/IIlr1kPUD0ohm7VJZvhpXZZgkfXsO4YYUAaLER613
        A7k3yMhoFCawFvq6D94gPUi9+EGkS1w=
X-Google-Smtp-Source: APiQypIYavolOE9CLL02qa+Qav8b7zB4ZsGHK6xpiGnKtCBbiACK4PuYiGE8V8BlscQYU9yRskNWnw==
X-Received: by 2002:a37:70c6:: with SMTP id l189mr15659867qkc.158.1586786398471;
        Mon, 13 Apr 2020 06:59:58 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n63sm8415934qka.80.2020.04.13.06.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 06:59:57 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A1929409A3; Mon, 13 Apr 2020 10:59:54 -0300 (-03)
Date:   Mon, 13 Apr 2020 10:59:54 -0300
To:     Andreas Gerstmayr <agerstmayr@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script flamegraph: python2 support, update cli args
Message-ID: <20200413135954.GA17690@kernel.org>
References: <20200406151118.GC32649@kernel.org>
 <20200409165734.165260-1-agerstmayr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409165734.165260-1-agerstmayr@redhat.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 09, 2020 at 06:57:31PM +0200, Andreas Gerstmayr escreveu:
> * removed --indent argument
> * renamed -F to -f argument to be consistent with other arguments

Ok, since I hadn't push the original patch, I've combined this one with
it it so that in systems with python2 it starts working and we can
bisect things from a good starting point.

- Arnaldo
 
> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
> ---
>  tools/perf/scripts/python/flamegraph.py | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> index 5835d190ca42..61f3be9add6b 100755
> --- a/tools/perf/scripts/python/flamegraph.py
> +++ b/tools/perf/scripts/python/flamegraph.py
> @@ -14,6 +14,7 @@
>  # Flame Graphs invented by Brendan Gregg <bgregg@netflix.com>
>  # Works in tandem with d3-flame-graph by Martin Spier <mspier@netflix.com>
>  
> +from __future__ import print_function
>  import sys
>  import os
>  import argparse
> @@ -43,11 +44,11 @@ class FlameGraphCLI:
>  
>          if self.args.format == "html" and \
>                  not os.path.isfile(self.args.template):
> -            print(f"Flame Graph template {self.args.template} does not " +
> -                  f"exist. Please install the js-d3-flame-graph (RPM) or " +
> -                  f"libjs-d3-flame-graph (deb) package, specify an " +
> -                  f"existing flame graph template (--template PATH) or " +
> -                  f"another output format (--format FORMAT).",
> +            print("Flame Graph template {} does not exist. Please install "
> +                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
> +                  "package, specify an existing flame graph template "
> +                  "(--template PATH) or another output format "
> +                  "(--format FORMAT).".format(self.args.template),
>                    file=sys.stderr)
>              sys.exit(1)
>  
> @@ -76,8 +77,7 @@ class FlameGraphCLI:
>          node.value += 1
>  
>      def trace_end(self):
> -        json_str = json.dumps(self.stack, default=lambda x: x.toJSON(),
> -                              indent=self.args.indent)
> +        json_str = json.dumps(self.stack, default=lambda x: x.toJSON())
>  
>          if self.args.format == "html":
>              try:
> @@ -85,7 +85,7 @@ class FlameGraphCLI:
>                      output_str = f.read().replace("/** @flamegraph_json **/",
>                                                    json_str)
>              except IOError as e:
> -                print(f"Error reading template file: {e}", file=sys.stderr)
> +                print("Error reading template file: {}".format(e), file=sys.stderr)
>                  sys.exit(1)
>              output_fn = self.args.output or "flamegraph.html"
>          else:
> @@ -95,24 +95,22 @@ class FlameGraphCLI:
>          if output_fn == "-":
>              sys.stdout.write(output_str)
>          else:
> -            print(f"dumping data to {output_fn}")
> +            print("dumping data to {}".format(output_fn))
>              try:
>                  with open(output_fn, "w") as out:
>                      out.write(output_str)
>              except IOError as e:
> -                print(f"Error writing output file: {e}", file=sys.stderr)
> +                print("Error writing output file: {}".format(e), file=sys.stderr)
>                  sys.exit(1)
>  
>  
>  if __name__ == "__main__":
>      parser = argparse.ArgumentParser(description="Create flame graphs.")
> -    parser.add_argument("-F", "--format",
> +    parser.add_argument("-f", "--format",
>                          default="html", choices=["json", "html"],
>                          help="output file format")
>      parser.add_argument("-o", "--output",
>                          help="output file name")
> -    parser.add_argument("--indent",
> -                        type=int, help="JSON indentation")
>      parser.add_argument("--template",
>                          default="/usr/share/d3-flame-graph/d3-flamegraph-base.html",
>                          help="path to flamegraph HTML template")
> -- 
> 2.25.2
> 

-- 

- Arnaldo
