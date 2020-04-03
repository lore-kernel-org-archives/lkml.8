Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2730C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881742073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmIfs+8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgDCNC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:02:58 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:32920 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgDCNC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:02:58 -0400
Received: by mail-qv1-f68.google.com with SMTP id p19so3515375qve.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=krGLlta/aQjm86ctavg/bbvN6kU6ZKvE8Q6fvRKONgM=;
        b=HmIfs+8GxOZL7ySKCQboldTzZZ3qbpIMS+IZzxe8LkVPcFW5eCh09esIuvXnvXlWUX
         QcSlq6uJAQgAxh9WY3H+8vf45Um32kLLmfbE6FeRwuw6+auQ5wj2Z7Ex84Xz4VQlIY40
         w03NlPq+wcCW4//gfG81sNHiKxzS8G2bHfRG9SDIDDSCqD6KR7QoTaisKgfSDRqQaXqY
         cgTueG/3nDU3hVBqdpQ2Kbljs6Fq/s5my7mBha7NN7yx1MANNHZt1XIFxOLgiWsvreLK
         DbIhQ6b/Wb6+LTZNCAvNfeVn3mk5CvWvdh0NWKoYoUcSsbpR3NuZfXNqAEq1gvsQfHqq
         beAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=krGLlta/aQjm86ctavg/bbvN6kU6ZKvE8Q6fvRKONgM=;
        b=gx2NgM58tTzMw6R0SfrcB2RnAogIsbJgz1RSHdr3+wK2IQiBt+9IPejRRoK4pxNxfe
         0UvVXuzDoSyVfGEyVzOjF4xdmFa5SJjfGDUe2BmoLmXsj9ViShyNuaUIec9nulEbv48H
         ejlc0ht4ED5nhxVacQDvMRO1MPFQcq3kxqpsXzEnwv3xidnmwKLHhuDuvbzunw41ECvq
         2K+t+JmcF0muny4Amld5dwUFhckCh2gOaHyAHD3yvCoeCnfL5pwmTZINgMrcAcFQu/0t
         cqQxGKw3xSxtifb3TLfXZd/OjAQXGYrqTPE+lwHaG916yZlfeF5SPJ4vYduO03zTybUW
         xGAg==
X-Gm-Message-State: AGi0PuaI4SIRvEKsxpHU9SO0aN82QRlJuUcDeyerqCdjCiZr4mqgScu6
        ho7clxXnYh/GXJpWLAfIU+Q=
X-Google-Smtp-Source: APiQypIJjrreM/wS8flHyyjMpngfo/QY/XZHhtMUVXxXr0y34kpXc4jFmBe6hUxnApQvv0jxzsxYzQ==
X-Received: by 2002:a0c:b61e:: with SMTP id f30mr8326701qve.25.1585918976303;
        Fri, 03 Apr 2020 06:02:56 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id f1sm5818669qkl.72.2020.04.03.06.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 06:02:55 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C6F78409A3; Fri,  3 Apr 2020 10:02:51 -0300 (-03)
Date:   Fri, 3 Apr 2020 10:02:51 -0300
To:     Daniel Shaulov <daniel.shaulov@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Daniel Shaulov <daniel.shaulov@granulate.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: Add support for DW_OP_call_frame_cfa vars
Message-ID: <20200403130251.GB18559@kernel.org>
References: <20200401161954.44640-1-daniel.shaulov@granulate.io>
 <20200402184943.GB23243@kernel.org>
 <20200402202523.GA55594@5f9ad775e7f6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402202523.GA55594@5f9ad775e7f6>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 02, 2020 at 08:25:24PM +0000, Daniel Shaulov escreveu:
> On Thu, Apr 02, 2020 at 03:49:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > Daniel, next time please consider providing precise steps to show what
> > wasn't working and then how the patch solves the problem, i.e. get some
> > go program, show the command lines used to build, probe, etc.
> >
> > - Arnaldo
> 
> Sure thing:
> 
> ---- contents of example.go ----
> package main
> 
> import "fmt"
> 
> func example(param1 int, param2 int) {
> 	fmt.Println(param1, param2)
> }
> 
> func main() {
> 	example(111, 222)
> }
> ---- end contents of example.go ----
> 
> Build with:
> $ go build example.go
> 
> Note that the output file is named after the directory.
> 
> Then try to probe it with:
> $ perf probe -x ./example 'main.example param1 param2'
> 
> The result is:
> > Target program is compiled without optimization. Skipping prologue.
> > Probe on address 0x4820f0 to force probing at the function entry.
> >
> > Sorry, we don't support this variable location yet.
> >   Error: Failed to add events.
> 
> With my changes the event is added successfuly.
> The reason for the change can be observed in the output of:
> $ readelf --debug-dump=info ./example
> 
> Where we have the following for the main.example function (with go >= 1.10):
>  <1><63dd2>: Abbrev Number: 2 (DW_TAG_subprogram)
>     <63dd3>   DW_AT_name        : main.example
>     <63de0>   DW_AT_low_pc      : 0x4820f0
>     <63de8>   DW_AT_high_pc     : 0x4821c2
>     <63df0>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
>     <63df2>   DW_AT_decl_file   : 0x1
>     <63df6>   DW_AT_external    : 1
>  <2><63df7>: Abbrev Number: 14 (DW_TAG_formal_parameter)
>     <63df8>   DW_AT_name        : param1
>     <63dff>   DW_AT_variable_parameter: 0
>     <63e00>   DW_AT_decl_line   : 5
>     <63e01>   DW_AT_type        : <0x220f>
>     <63e05>   DW_AT_location    : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
>  <2><63e07>: Abbrev Number: 14 (DW_TAG_formal_parameter)
>     <63e08>   DW_AT_name        : param2
>     <63e0f>   DW_AT_variable_parameter: 0
>     <63e10>   DW_AT_decl_line   : 5
>     <63e11>   DW_AT_type        : <0x220f>
>     <63e15>   DW_AT_location    : 2 byte block: 91 8 	(DW_OP_fbreg: 8)
>  <2><63e18>: Abbrev Number: 0
 
> The go compiler (after 1.10) uses DW_OP_call_frame_cfa for the first parameter and DW_OP_fbreg for the rest.
> On go versions lower than 1.10, it used DW_OP_call_frame_cfa for all parameters.
> Here is example output of the readelf on main.example, compiled with go1.9.7:
>  <1><2634d>: Abbrev Number: 2 (DW_TAG_subprogram)
>     <2634e>   DW_AT_name        : main.example
>     <2635b>   DW_AT_low_pc      : 0x487db0
>     <26363>   DW_AT_high_pc     : 0x487e99
>     <2636b>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
>     <2636d>   DW_AT_external    : 1
>  <2><2636e>: Abbrev Number: 5 (DW_TAG_formal_parameter)
>     <2636f>   DW_AT_name        : param1
>     <26376>   DW_AT_location    : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
>     <26378>   DW_AT_type        : <0x27f1c>
>  <2><2637c>: Abbrev Number: 5 (DW_TAG_formal_parameter)
>     <2637d>   DW_AT_name        : param2
>     <26384>   DW_AT_location    : 4 byte block: 9c 11 8 22 	(DW_OP_call_frame_cfa; DW_OP_consts: 8; DW_OP_plus)
>     <26389>   DW_AT_type        : <0x27f1c>
>  <2><2638d>: Abbrev Number: 0
> 
> Hope this makes things easier to understand.

Right, but I tried following your instructions here and got up to this:

 <0><76ded>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <76dee>   DW_AT_name        : main
    <76df3>   DW_AT_language    : 22    (Go)
    <76df4>   DW_AT_stmt_list   : 0x27a7d
    <76df8>   DW_AT_low_pc      : 0x48cd90
    <76e00>   DW_AT_ranges      : 0x2e0
    <76e04>   DW_AT_comp_dir    : .
    <76e06>   DW_AT_producer    : Go cmd/compile go1.13.6
    <76e1e>   Unknown AT value: 2905: main
 <1><76e23>: Abbrev Number: 4 (DW_TAG_subprogram)
    <76e24>   DW_AT_name        : main.example
    <76e31>   DW_AT_inline      : 1     (inlined)
    <76e32>   DW_AT_external    : 1
 <2><76e33>: Abbrev Number: 17 (DW_TAG_formal_parameter)
    <76e34>   DW_AT_name        : param1
    <76e3b>   DW_AT_variable_parameter: 0
    <76e3c>   DW_AT_type        : <0x37430>
 <2><76e40>: Abbrev Number: 17 (DW_TAG_formal_parameter)
    <76e41>   DW_AT_name        : param2
    <76e48>   DW_AT_variable_parameter: 0
    <76e49>   DW_AT_type        : <0x37430>
 <2><76e4d>: Abbrev Number: 0


Which, with or without your patch ends with:

[acme@five daniel.shaulov@gmail.com]$ perf probe -x ./example 'main.example param1 param2'
Failed to find 'param1' in this function.
Probe point 'main.example' not found.
  Error: Failed to add events.
[acme@five daniel.shaulov@gmail.com]$

[acme@five perf]$ rpm -q golang-bin
golang-bin-1.13.6-1.fc31.x86_64
[acme@five perf]$ cat /etc/fedora-release
Fedora release 31 (Thirty One)
[acme@five perf]$

Has the behaviour changed again in 1.13? Or is this some optimization
level that fedora sets that ends up auto-inlining that main.example
routine?

[acme@five daniel.shaulov@gmail.com]$ readelf --debug-dump=info ./example | grep main\.example -B10 -A13
 <0><76ded>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <76dee>   DW_AT_name        : main
    <76df3>   DW_AT_language    : 22	(Go)
    <76df4>   DW_AT_stmt_list   : 0x27a7d
    <76df8>   DW_AT_low_pc      : 0x48cd90
    <76e00>   DW_AT_ranges      : 0x2e0
    <76e04>   DW_AT_comp_dir    : .
    <76e06>   DW_AT_producer    : Go cmd/compile go1.13.6
    <76e1e>   Unknown AT value: 2905: main
 <1><76e23>: Abbrev Number: 4 (DW_TAG_subprogram)
    <76e24>   DW_AT_name        : main.example
    <76e31>   DW_AT_inline      : 1	(inlined)
    <76e32>   DW_AT_external    : 1
 <2><76e33>: Abbrev Number: 17 (DW_TAG_formal_parameter)
    <76e34>   DW_AT_name        : param1
    <76e3b>   DW_AT_variable_parameter: 0
    <76e3c>   DW_AT_type        : <0x37430>
 <2><76e40>: Abbrev Number: 17 (DW_TAG_formal_parameter)
    <76e41>   DW_AT_name        : param2
    <76e48>   DW_AT_variable_parameter: 0
    <76e49>   DW_AT_type        : <0x37430>
 <2><76e4d>: Abbrev Number: 0
 <1><76e4e>: Abbrev Number: 4 (DW_TAG_subprogram)
    <76e4f>   DW_AT_name        : fmt.Println
[acme@five daniel.shaulov@gmail.com]$

- Arnaldo
