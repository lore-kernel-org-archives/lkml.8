Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B49C2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4151C24682
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xql08UDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgDFOyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:54:03 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:34741 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbgDFOyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:54:03 -0400
Received: by mail-qt1-f169.google.com with SMTP id 14so12782494qtp.1;
        Mon, 06 Apr 2020 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=k1sR3RhCx9KP7HjDFrYA2XfqI0l+13PZ3LpaOvWxQZw=;
        b=Xql08UDVPixU8aZ03bA+wYn1foTzDb9oNxCEr0Et8sWv7mW7WjsB1f1yqK6nEvO8w0
         PFyU8ahEc49eBY+YCrDR46hS1pWxoUQGu3qmD2exyebA8lc5gascFm2KnI6vJnzTYsO0
         PuHdS4XH9Qm3RNoyYiEvgC85btBRLbXCbz+LR2lID2N572SDRn/bATM/gwWX/ZofJH5u
         nHxZhdIZVS9v+gZtTytl660td7E/13PKzovbZYfYqUi3vrqJQn8TCcWJcLudNIKrBlRx
         7shMHGq+5u9l72exLa25nUKvAx34rF3kTYaAZ2Rg8y/pOx9uOkycnAcBW+xXNogNMieB
         HW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=k1sR3RhCx9KP7HjDFrYA2XfqI0l+13PZ3LpaOvWxQZw=;
        b=NXUApNkByKyX0osPwv9zqJFk8WDIJTvkY5hxSoDTZ52GBMu8s1EWLAL9p1xvnuYJN1
         d4nzFxJCfKNFNyHUjhh0VQF2BvpSePop4s2QINLs5y1WSWlmEHY6jGq1mZshYYlInsSo
         pP2b+s++D0thzPyDKTxbElHsp1D2YnZAc+C62syyayodmKEP9tpFAaAblwwF7knhJ8nf
         mAS0Yx9iIwpSV6wZ8hfw4K3m5vcNErkYhFSbe26k078GH/A30qcCazufiEJkKGS817B8
         o+kUzM/VumH69um7Fzxu4c+Cxx6YWx+b+mydptk8yTX4jit0sr2/vrtjadpVenAbV1AH
         6EEA==
X-Gm-Message-State: AGi0PuZuDScbbMgwZnkwnSWM1r6KRpTTkScZ6hoS2JjvNwmDEPJvq/ra
        gxi0+cVdOpvfOEqKyY1FgyWLgbGU4QeBCw==
X-Google-Smtp-Source: APiQypKTuK7HQcJtR77So2Z4AhmNP9+Fby+H5KKh7wS56jWhA0+iUhGmP0sUvVNHfNb/o43guVye4A==
X-Received: by 2002:ac8:749a:: with SMTP id v26mr21752969qtq.182.1586184839527;
        Mon, 06 Apr 2020 07:53:59 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h11sm14603734qtr.38.2020.04.06.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:53:58 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7F71A409A3; Mon,  6 Apr 2020 11:53:56 -0300 (-03)
Date:   Mon, 6 Apr 2020 11:53:56 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <andi@firstfloor.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: perf probe + uprobes missing events
Message-ID: <20200406145356.GA32649@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

	I'm trying to use 'perf probe' to debug 'perf test', but I'm not
getting repeatable results, take a look:

I'm trying to figure out which expresssions are _really_ being tested
byu the 'perf test expr' testcase, so I added a probe to the
expr__parse() routine, asking for the expr string to be printed:

[root@five ~]# perf probe -x ~/bin/perf -L expr__parse
<expr__parse@/home/acme/git/perf/tools/perf/util/expr.c:0>
      0  int expr__parse(double *final_val, struct expr_parse_ctx *ctx, const char *expr, int runtime)
      1  {
      2         return __expr__parse(final_val, ctx, expr, EXPR_PARSE, runtime) ? -1 : 0;
      3  }

         static bool
         already_seen(const char *val, const char *one, const char **other,

[root@five ~]#

[root@five ~]# perf probe -x ~/bin/perf expr__parse expr:string
Target program is compiled without optimization. Skipping prologue.
Probe on address 0x5cb11b to force probing at the function entry.

Added new event:
  probe_perf:expr__parse (on expr__parse in /home/acme/bin/perf with expr:string)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:expr__parse -aR sleep 1

[root@five ~]#

[root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
 7: Simple expression parser                              : Ok
     0.000 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
     0.015 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
     0.018 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
     0.020 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
     0.023 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
     0.026 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
     0.029 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
     0.031 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "min(1,2) + 1")
     0.034 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "max(1,2) + 1")
     0.036 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1 if 3*4 else 0")
     0.039 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO/0")
     0.041 :2994175/2994175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "BAR/")
[root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
 7: Simple expression parser                              : Ok
     0.000 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
     0.021 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
     0.025 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
     0.029 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
     0.033 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
     0.041 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
     0.044 perf/2996042 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
[root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
 7: Simple expression parser                              : Ok
     0.000 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
     0.020 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
     0.025 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
     0.029 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
     0.032 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
     0.037 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
     0.040 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
     0.043 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "min(1,2) + 1")
     0.046 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "max(1,2) + 1")
     0.049 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1 if 3*4 else 0")
     0.053 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO/0")
     0.056 perf/2996416 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "BAR/")
[root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
 7: Simple expression parser                              : Ok
[root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
 7: Simple expression parser                              : Ok
[root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
 7: Simple expression parser                              : Ok
[root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
 7: Simple expression parser                              : Ok
[root@five ~]# perf trace -e probe_perf:expr_* perf test -F expr
 7: Simple expression parser                              : Ok
     0.000 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1")
     0.014 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO+BAR")
     0.017 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(BAR/2)%2")
     0.021 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1 - -4")
     0.024 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "(FOO-1)*2 + (BAR/2)%2 - -4")
     0.030 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 | 1")
     0.032 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1-1 & 1")
     0.035 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "min(1,2) + 1")
     0.038 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "max(1,2) + 1")
     0.040 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "1+1 if 3*4 else 0")
     0.044 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "FOO/0")
     0.046 :2998175/2998175 probe_perf:expr__parse(__probe_ip: 6074674, expr_string: "BAR/")
[root@five ~]#


Do you have any idea why that happens?

- Arnaldo
