Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A794EC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FDC22B51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhWTacfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgDFOy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:54:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40072 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbgDFOy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:54:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id z15so10228945qki.7;
        Mon, 06 Apr 2020 07:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M23T+RlbcFsbtA7Sovrhqv9by3/H6FQN5gpwGHKT+78=;
        b=dhWTacfjpbySADGww+Zja+PC3Ota7SokYvGZ+y3mYZeFWamGYKCndbhuETtNF24T2t
         Hwqvpe9YRmxz00ZJsYtvBC9aBJ1wHHYUO0B0IuT8vP0rEvPESikszeMbgW0RSVad9n6b
         XpThsaNNgHQWo/g7uYr5leM63vdJTX60wcnl4f5Ut18EwEef/t51/B9oArF3ahYf2hLn
         3TWdoThlvLlpEmuBUs/5yoDIkNXoGIPFX+zbJ9BwrxenidQ1qsS7pjc3FXm0YHgSi45F
         9Gvv2TMUBTYl9ETC1sIqb6iQBmZ9Oma8tWQEIlUEQSBSyspMxPm/X0AXOVpnVijilnPo
         JdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M23T+RlbcFsbtA7Sovrhqv9by3/H6FQN5gpwGHKT+78=;
        b=sXSTkjXNrjzIpeyFZrCdLMSx+QnzyNXrO7CfeZF88nEhMYF5plW+IYd6a9n8/F3q5G
         UOBy+ikis83Z7TyLcjN9xLES+c74EsRUfDya2RRVVidTgvSFmous61Aio8tPbAvfM4JW
         iW7ThQ5IS7Bt9jGEbRmD5IOtQjpMdaTN4/dJOrX0BUWhfSMHDqZmWBvzahQinbYKSwYY
         +DmprCwDOyZyoi/RuJ4ZgUqCI4FObJMKM8nGjWuSP9smbHs4Kk7WNSVFwHgYBNhPcqFQ
         5cVtM42Pf4bOIf0N2QjZCpaPF7f4esXXcgbr/oTMNkXdQwMhwj+Xt+31eQR2qMs8Ykqh
         o6Jg==
X-Gm-Message-State: AGi0PubxKkZ2Jvi0T4q4xQUWw6riokI4kvLfNAus27AcKfUWnrgbJUJW
        DYst2LOTfa6TeTL4unXBz/k=
X-Google-Smtp-Source: APiQypKsuE1vepPJTGsxQ9J78O1tFcHjGdH8bdqJjJemQIBm9QadF/6t5K65jeTwjsc02gFh+1JZJg==
X-Received: by 2002:a37:7846:: with SMTP id t67mr20921218qkc.77.1586184895676;
        Mon, 06 Apr 2020 07:54:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id o6sm8349232qkd.113.2020.04.06.07.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:54:55 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2A6AD409A3; Mon,  6 Apr 2020 11:54:53 -0300 (-03)
Date:   Mon, 6 Apr 2020 11:54:53 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <andi@firstfloor.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: perf probe + uprobes missing events
Message-ID: <20200406145453.GB32649@kernel.org>
References: <20200406145356.GA32649@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406145356.GA32649@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 06, 2020 at 11:53:56AM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi Masami,

Sorry, details about the system:

[root@five ~]# uname -a
Linux five 5.5.10-200.fc31.x86_64 #1 SMP Wed Mar 18 14:21:38 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
[root@five ~]# perf -vv
perf version 5.6.gea05cf482862
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                  gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
[root@five ~]# rpm -q elfutils
elfutils-0.178-7.fc31.x86_64
[root@five ~]#
 
> 	I'm trying to use 'perf probe' to debug 'perf test', but I'm not
> getting repeatable results, take a look:
> 
> I'm trying to figure out which expresssions are _really_ being tested
> byu the 'perf test expr' testcase, so I added a probe to the
> expr__parse() routine, asking for the expr string to be printed:
> 
> [root@five ~]# perf probe -x ~/bin/perf -L expr__parse
> <expr__parse@/home/acme/git/perf/tools/perf/util/expr.c:0>
>       0  int expr__parse(double *final_val, struct expr_parse_ctx *ctx, const char *expr, int runtime)
>       1  {
>       2         return __expr__parse(final_val, ctx, expr, EXPR_PARSE, runtime) ? -1 : 0;
>       3  }
> 
>          static bool
>          already_seen(const char *val, const char *one, const char **other,
> 
> [root@five ~]#
> 
> [root@five ~]# perf probe -x ~/bin/perf expr__parse expr:string
> Target program is compiled without optimization. Skipping prologue.
> Probe on address 0x5cb11b to force probing at the function entry.
> 
> Added new event:
>   probe_perf:expr__parse (on expr__parse in /home/acme/bin/perf with expr:string)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe_perf:expr__parse -aR sleep 1
> 
> [root@five ~]#
> 
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
>      0.000 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
>      0.015 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
>      0.018 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
>      0.020 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
>      0.023 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
>      0.026 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
>      0.029 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
>      0.031 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "min(1,2) + 1")
>      0.034 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "max(1,2) + 1")
>      0.036 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1 if 3*4 else 0")
>      0.039 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO/0")
>      0.041 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "BAR/")
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
>      0.000 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
>      0.021 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
>      0.025 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
>      0.029 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
>      0.033 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
>      0.041 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
>      0.044 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
>      0.000 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
>      0.020 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
>      0.025 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
>      0.029 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
>      0.032 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
>      0.037 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
>      0.040 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
>      0.043 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "min(1,2) + 1")
>      0.046 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "max(1,2) + 1")
>      0.049 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1 if 3*4 else 0")
>      0.053 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO/0")
>      0.056 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "BAR/")
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
> [root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
>  7: Simple expression parser                              : Ok
>      0.000 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
>      0.014 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
>      0.017 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
>      0.021 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
>      0.024 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
>      0.030 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
>      0.032 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
>      0.035 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "min(1,2) + 1")
>      0.038 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "max(1,2) + 1")
>      0.040 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1 if 3*4 else 0")
>      0.044 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO/0")
>      0.046 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "BAR/")
> [root@five ~]#
> 
> 
> Do you have any idea why that happens?
> 
> - Arnaldo

-- 

- Arnaldo
