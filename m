Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B539C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2069A206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUuFEUqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404118AbgDCR7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:59:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42786 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgDCR7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:59:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15so9549404wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2EJTMwd5yAFnu/Tn5slB2aVKxhhWasEuV9Nvp1nHtms=;
        b=vUuFEUqHUgr5ANyLeOl+LO/mjA+LzITj2SxcpnJtLNebhU7LwGJsGU0g0Qggb1U9vl
         RqHuK6goVE4isHMsgShYtfSacsi8fWuAuCJxfSX8EkCW8VhOcgOu40673bd4Q6nE+AWP
         GASXazvH9Ng30nFzYGBu497VuNwflQ2PLNxFnNcvyVTQOLAmwoxPBWV5O0kc6ORzZ8Yc
         TmJkRn7Nhe5mSexPNAOKaXiFSE3seS+CZ5ZVp/Wd/e7jw1At9NyCcr9VA4p5vWiTmeeM
         0B2lJ2z27xG5HnOfuWH0HXMDwSBtMytGItKDMRE6EucDmi5JoHhFL3sEyJygZ2Y5NbcX
         aGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2EJTMwd5yAFnu/Tn5slB2aVKxhhWasEuV9Nvp1nHtms=;
        b=s7ARIJG4IUpFmeJy04p/da0kmF2IYmSW9/hgHdAKTJ3R3HCeLvhHf3ENw0h6+Ds8Cl
         xN8f/ILBADZC8mRQuUZZO+69wlzUyqY6gWqRY5Dy0TfDU6QcceKd8yicMljw0Kx+XCvn
         HluENDLITyhMniY2rIRuFfL49PEDsErxuAZO9BQuDtsNVOIwGfbWYshHJi3Cnu4nCCVQ
         eRZA2teapDzcWmOax4V0CiqwA51JVnk13q/BPKlzuRFHkev2JxiVh7xkWq9iDqEIppDF
         LD5wQXnK4LPxeweNOuXyYn5tqK4p4fbqWls/P+2DurDxvUFHIMBnFOEKCTJHhUH/N605
         DbaA==
X-Gm-Message-State: AGi0PuaRAZd9mTvhoARydPNQLXbZvCoXIwQgqCm1kd2ifxXeI3FIub20
        CwLwx3w9ThOiWgbWgJKSL0I=
X-Google-Smtp-Source: APiQypJXwI2YLMLTSzAGoS7S0I9+R99VL5pFUBK43/9LwFHMg9qKO4IOl5UW1seICMuN/0QeYcCMlg==
X-Received: by 2002:adf:e44a:: with SMTP id t10mr10132322wrm.322.1585936748526;
        Fri, 03 Apr 2020 10:59:08 -0700 (PDT)
Received: from 5f9ad775e7f6 ([213.137.85.32])
        by smtp.gmail.com with ESMTPSA id a13sm12766764wrh.80.2020.04.03.10.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 10:59:07 -0700 (PDT)
Date:   Fri, 3 Apr 2020 17:59:04 +0000
From:   Daniel Shaulov <daniel.shaulov@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Daniel Shaulov <daniel.shaulov@granulate.io>,
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
Message-ID: <20200403175902.GA18789@5f9ad775e7f6>
References: <20200401161954.44640-1-daniel.shaulov@granulate.io>
 <20200402184943.GB23243@kernel.org>
 <20200402202523.GA55594@5f9ad775e7f6>
 <20200403130251.GB18559@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403130251.GB18559@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 10:02:51AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 02, 2020 at 08:25:24PM +0000, Daniel Shaulov escreveu:
> > On Thu, Apr 02, 2020 at 03:49:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Daniel, next time please consider providing precise steps to show what
> > > wasn't working and then how the patch solves the problem, i.e. get some
> > > go program, show the command lines used to build, probe, etc.
> > >
> > > - Arnaldo
> > 
> > Sure thing:
> > 
> > ---- contents of example.go ----
> > package main
> > 
> > import "fmt"
> > 
> > func example(param1 int, param2 int) {
> > 	fmt.Println(param1, param2)
> > }
> > 
> > func main() {
> > 	example(111, 222)
> > }
> > ---- end contents of example.go ----
> > 
> > Build with:
> > $ go build example.go
> > 
> > Note that the output file is named after the directory.
> > 
> > Then try to probe it with:
> > $ perf probe -x ./example 'main.example param1 param2'
> > 
> > The result is:
> > > Target program is compiled without optimization. Skipping prologue.
> > > Probe on address 0x4820f0 to force probing at the function entry.
> > >
> > > Sorry, we don't support this variable location yet.
> > >   Error: Failed to add events.
> > 
> > With my changes the event is added successfuly.
> > The reason for the change can be observed in the output of:
> > $ readelf --debug-dump=info ./example
> > 
> > Where we have the following for the main.example function (with go >= 1.10):
> >  <1><63dd2>: Abbrev Number: 2 (DW_TAG_subprogram)
> >     <63dd3>   DW_AT_name        : main.example
> >     <63de0>   DW_AT_low_pc      : 0x4820f0
> >     <63de8>   DW_AT_high_pc     : 0x4821c2
> >     <63df0>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
> >     <63df2>   DW_AT_decl_file   : 0x1
> >     <63df6>   DW_AT_external    : 1
> >  <2><63df7>: Abbrev Number: 14 (DW_TAG_formal_parameter)
> >     <63df8>   DW_AT_name        : param1
> >     <63dff>   DW_AT_variable_parameter: 0
> >     <63e00>   DW_AT_decl_line   : 5
> >     <63e01>   DW_AT_type        : <0x220f>
> >     <63e05>   DW_AT_location    : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
> >  <2><63e07>: Abbrev Number: 14 (DW_TAG_formal_parameter)
> >     <63e08>   DW_AT_name        : param2
> >     <63e0f>   DW_AT_variable_parameter: 0
> >     <63e10>   DW_AT_decl_line   : 5
> >     <63e11>   DW_AT_type        : <0x220f>
> >     <63e15>   DW_AT_location    : 2 byte block: 91 8 	(DW_OP_fbreg: 8)
> >  <2><63e18>: Abbrev Number: 0
>  
> > The go compiler (after 1.10) uses DW_OP_call_frame_cfa for the first parameter and DW_OP_fbreg for the rest.
> > On go versions lower than 1.10, it used DW_OP_call_frame_cfa for all parameters.
> > Here is example output of the readelf on main.example, compiled with go1.9.7:
> >  <1><2634d>: Abbrev Number: 2 (DW_TAG_subprogram)
> >     <2634e>   DW_AT_name        : main.example
> >     <2635b>   DW_AT_low_pc      : 0x487db0
> >     <26363>   DW_AT_high_pc     : 0x487e99
> >     <2636b>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
> >     <2636d>   DW_AT_external    : 1
> >  <2><2636e>: Abbrev Number: 5 (DW_TAG_formal_parameter)
> >     <2636f>   DW_AT_name        : param1
> >     <26376>   DW_AT_location    : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
> >     <26378>   DW_AT_type        : <0x27f1c>
> >  <2><2637c>: Abbrev Number: 5 (DW_TAG_formal_parameter)
> >     <2637d>   DW_AT_name        : param2
> >     <26384>   DW_AT_location    : 4 byte block: 9c 11 8 22 	(DW_OP_call_frame_cfa; DW_OP_consts: 8; DW_OP_plus)
> >     <26389>   DW_AT_type        : <0x27f1c>
> >  <2><2638d>: Abbrev Number: 0
> > 
> > Hope this makes things easier to understand.
> 
> Right, but I tried following your instructions here and got up to this:
> 
>  <0><76ded>: Abbrev Number: 1 (DW_TAG_compile_unit)
>     <76dee>   DW_AT_name        : main
>     <76df3>   DW_AT_language    : 22    (Go)
>     <76df4>   DW_AT_stmt_list   : 0x27a7d
>     <76df8>   DW_AT_low_pc      : 0x48cd90
>     <76e00>   DW_AT_ranges      : 0x2e0
>     <76e04>   DW_AT_comp_dir    : .
>     <76e06>   DW_AT_producer    : Go cmd/compile go1.13.6
>     <76e1e>   Unknown AT value: 2905: main
>  <1><76e23>: Abbrev Number: 4 (DW_TAG_subprogram)
>     <76e24>   DW_AT_name        : main.example
>     <76e31>   DW_AT_inline      : 1     (inlined)
>     <76e32>   DW_AT_external    : 1
>  <2><76e33>: Abbrev Number: 17 (DW_TAG_formal_parameter)
>     <76e34>   DW_AT_name        : param1
>     <76e3b>   DW_AT_variable_parameter: 0
>     <76e3c>   DW_AT_type        : <0x37430>
>  <2><76e40>: Abbrev Number: 17 (DW_TAG_formal_parameter)
>     <76e41>   DW_AT_name        : param2
>     <76e48>   DW_AT_variable_parameter: 0
>     <76e49>   DW_AT_type        : <0x37430>
>  <2><76e4d>: Abbrev Number: 0
> 
> 
> Which, with or without your patch ends with:
> 
> [acme@five daniel.shaulov@gmail.com]$ perf probe -x ./example 'main.example param1 param2'
> Failed to find 'param1' in this function.
> Probe point 'main.example' not found.
>   Error: Failed to add events.
> [acme@five daniel.shaulov@gmail.com]$
> 
> [acme@five perf]$ rpm -q golang-bin
> golang-bin-1.13.6-1.fc31.x86_64
> [acme@five perf]$ cat /etc/fedora-release
> Fedora release 31 (Thirty One)
> [acme@five perf]$
> 
> Has the behaviour changed again in 1.13? Or is this some optimization
> level that fedora sets that ends up auto-inlining that main.example
> routine?
> 
> [acme@five daniel.shaulov@gmail.com]$ readelf --debug-dump=info ./example | grep main\.example -B10 -A13
>  <0><76ded>: Abbrev Number: 1 (DW_TAG_compile_unit)
>     <76dee>   DW_AT_name        : main
>     <76df3>   DW_AT_language    : 22	(Go)
>     <76df4>   DW_AT_stmt_list   : 0x27a7d
>     <76df8>   DW_AT_low_pc      : 0x48cd90
>     <76e00>   DW_AT_ranges      : 0x2e0
>     <76e04>   DW_AT_comp_dir    : .
>     <76e06>   DW_AT_producer    : Go cmd/compile go1.13.6
>     <76e1e>   Unknown AT value: 2905: main
>  <1><76e23>: Abbrev Number: 4 (DW_TAG_subprogram)
>     <76e24>   DW_AT_name        : main.example
>     <76e31>   DW_AT_inline      : 1	(inlined)
>     <76e32>   DW_AT_external    : 1
>  <2><76e33>: Abbrev Number: 17 (DW_TAG_formal_parameter)
>     <76e34>   DW_AT_name        : param1
>     <76e3b>   DW_AT_variable_parameter: 0
>     <76e3c>   DW_AT_type        : <0x37430>
>  <2><76e40>: Abbrev Number: 17 (DW_TAG_formal_parameter)
>     <76e41>   DW_AT_name        : param2
>     <76e48>   DW_AT_variable_parameter: 0
>     <76e49>   DW_AT_type        : <0x37430>
>  <2><76e4d>: Abbrev Number: 0
>  <1><76e4e>: Abbrev Number: 4 (DW_TAG_subprogram)
>     <76e4f>   DW_AT_name        : fmt.Println
> [acme@five daniel.shaulov@gmail.com]$
> 
> - Arnaldo

Ok, so I looked into it a little bit.
I was using go1.10.4 (that's the one in Ubuntu 18.04 repo)

Apperantly they improved inlining in go1.12
https://golang.org/doc/go1.12#compiler
> More functions are now eligible for inlining by default,
> including functions that do nothing but call another function.

I added "//go:noinline" to the example function and it works in go1.12 and go1.13.6
---- contents of example.go ----
package main

import "fmt"

//go:noinline
func example(param1 int, param2 int) {
	fmt.Println(param1, param2)
}

func main() {
	example(111, 222)
}
---- end contents of example.go ----

There were some other changes to the dwarf output and in 1.13.6 with "//go:noinline" it looks like this:
$ readelf --debug-dump=info ./example | grep main\.example -A17
 <1><76e8f>: Abbrev Number: 3 (DW_TAG_subprogram)
    <76e90>   DW_AT_name        : main.example
    <76e9d>   DW_AT_low_pc      : 0x48ce90
    <76ea5>   DW_AT_high_pc     : 0x48cf58
    <76ead>   DW_AT_frame_base  : 1 byte block: 9c      (DW_OP_call_frame_cfa)
    <76eaf>   DW_AT_decl_file   : 0x1
    <76eb3>   DW_AT_external    : 1
 <2><76eb4>: Abbrev Number: 16 (DW_TAG_formal_parameter)
    <76eb5>   DW_AT_name        : param1
    <76ebc>   DW_AT_variable_parameter: 0
    <76ebd>   DW_AT_decl_line   : 6
    <76ebe>   DW_AT_type        : <0x37472>
    <76ec2>   DW_AT_location    : 0x7cd57 (location list)
 <2><76ec6>: Abbrev Number: 16 (DW_TAG_formal_parameter)
    <76ec7>   DW_AT_name        : param2
    <76ece>   DW_AT_variable_parameter: 0
    <76ecf>   DW_AT_decl_line   : 6
    <76ed0>   DW_AT_type        : <0x37472>
    <76ed4>   DW_AT_location    : 0x7cd8a (location list)

The "0x7cd57 (location list)" can be read with another readelf:
$ readelf --debug-dump=loc ./example | grep 7cd57 -A5
    0007cd57 ffffffffffffffff 000000000048ce90 (base address)
    0007cd67 000000000048ce90 000000000048cf58 (DW_OP_call_frame_cfa)
    0007cd7a <End of list>
    0007cd8a ffffffffffffffff 000000000048ce90 (base address)
    0007cd9a 000000000048ce90 000000000048cf58 (DW_OP_fbreg: 8)
    0007cdae <End of list>

So it is basically the same as what I was getting with go1.10, but with a deref in the way.
I guess dwarf_getlocation_addr abstracts the difference away since my code still works.

Note - in go1.11, I think there was some bug, because it shows up like this in readelf:
 <1><72a95>: Abbrev Number: 2 (DW_TAG_subprogram)
    <72a96>   DW_AT_name        : main.example
    <72aa3>   DW_AT_low_pc      : 0x4850b0
    <72aab>   DW_AT_high_pc     : 0x48516e
    <72ab3>   DW_AT_frame_base  : 1 byte block: 9c      (DW_OP_call_frame_cfa)
    <72ab5>   DW_AT_decl_file   : 0x1
    <72ab9>   DW_AT_external    : 1
 <2><72aba>: Abbrev Number: 14 (DW_TAG_formal_parameter)
    <72abb>   DW_AT_name        : param1
    <72ac2>   DW_AT_variable_parameter: 0
    <72ac3>   DW_AT_decl_line   : 6
    <72ac4>   DW_AT_type        : <0x3118>
    <72ac8>   DW_AT_location    : 0 byte block:         ()
 <2><72ac9>: Abbrev Number: 14 (DW_TAG_formal_parameter)
    <72aca>   DW_AT_name        : param2
    <72ad1>   DW_AT_variable_parameter: 0
    <72ad2>   DW_AT_decl_line   : 6
    <72ad3>   DW_AT_type        : <0x3118>
    <72ad7>   DW_AT_location    : 0 byte block:         ()
 <2><72ad8>: Abbrev Number: 0

And perf has no way to find the parameters (DW_AT_location is empty).

