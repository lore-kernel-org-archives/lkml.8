Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF34DC2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C143F206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVB9MaL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390254AbgDBUZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:25:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55125 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbgDBUZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:25:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id c81so4820588wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0R+Zb4Bn66vFsZizGJzx0NCiSitSXH3XAYXfHz+ebXo=;
        b=UVB9MaL1O9chhvoFLjpgg5KF/B7YEqi0IjJKZlSuzDxVkcdPoN6lgvDtXGNY1szS3B
         eASbnD5dMdxixd+YijjubvjbiexHbZex7QRtOQec2rQrUXx9qlshYIwxX/7utHMbp/Ox
         86V41avD6Q0m+0cKAHuOa08ZwcpcFkiTiiKS/tPk9KoGyBiBx9kr9SRPQgyIrotiP9se
         DEaoEDZwvrVSlHab0ZfzdaTWHjNEhSpJ98oFBsHTangL1Btkcrn5kd6zlUw+pkXWf1To
         2AaxxOZ3iNgE09yFWyLqcM+0GzamGRZn2H2vmNGREA8uU5j3ns1UWvcpaqJvAwo9VcgO
         lN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0R+Zb4Bn66vFsZizGJzx0NCiSitSXH3XAYXfHz+ebXo=;
        b=hM3TEvnR3EdivKPjkmuIZhnUqa3IzpvxV7z/V4hNEgesCIAllpz6jqWskHTtCHmw3A
         CaV7CCns1IbaJ8okXwX7+5MltcB29w2B31Wy3Al+9vZGFXgpvtdedQzX1iCMyJVNzoGY
         +yFMedQZ55aPFyh6xBrnxLcRd+6DisEwyPJ2A3XhgDaJ1hsBI8+hjQmULzU8rjcrJHob
         afq3BRIoyC1M74iWqv01EYT1QVU5N1FB2tOBDDxJ0yt1h0lBbgn3lzvyZcWum9ZIGBmz
         RCXE8Ma+p4Uo0MEZOvIrDTaOzEgvQ7ceLRcB2BEazTno9PAbCL8nEFIQul4G+1R5CXhR
         iCCg==
X-Gm-Message-State: AGi0PuYeZpRE+haCjVdtURefhPx9G5KDXpT8oPjG0biRVRNeODOuwJ2w
        1VR3SonEJiKOtm77ALF8xgs=
X-Google-Smtp-Source: APiQypISLNuqVS01PWZev9lb3aevpwhA/0jCPUeAUvuQyk8PM3zT2RKjdOn37ddArpGrF+zi9Ki1XA==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr4912304wmj.61.1585859128291;
        Thu, 02 Apr 2020 13:25:28 -0700 (PDT)
Received: from 5f9ad775e7f6 ([213.137.85.32])
        by smtp.gmail.com with ESMTPSA id t126sm8853865wmb.27.2020.04.02.13.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Apr 2020 13:25:27 -0700 (PDT)
Date:   Thu, 2 Apr 2020 20:25:24 +0000
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
Message-ID: <20200402202523.GA55594@5f9ad775e7f6>
References: <20200401161954.44640-1-daniel.shaulov@granulate.io>
 <20200402184943.GB23243@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402184943.GB23243@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 03:49:43PM -0300, Arnaldo Carvalho de Melo wrote:
> Daniel, next time please consider providing precise steps to show what
> wasn't working and then how the patch solves the problem, i.e. get some
> go program, show the command lines used to build, probe, etc.
>
> - Arnaldo

Sure thing:

---- contents of example.go ----
package main

import "fmt"

func example(param1 int, param2 int) {
	fmt.Println(param1, param2)
}

func main() {
	example(111, 222)
}
---- end contents of example.go ----

Build with:
$ go build example.go

Note that the output file is named after the directory.

Then try to probe it with:
$ perf probe -x ./example 'main.example param1 param2'

The result is:
> Target program is compiled without optimization. Skipping prologue.
> Probe on address 0x4820f0 to force probing at the function entry.
>
> Sorry, we don't support this variable location yet.
>   Error: Failed to add events.

With my changes the event is added successfuly.
The reason for the change can be observed in the output of:
$ readelf --debug-dump=info ./example

Where we have the following for the main.example function (with go >= 1.10):
 <1><63dd2>: Abbrev Number: 2 (DW_TAG_subprogram)
    <63dd3>   DW_AT_name        : main.example
    <63de0>   DW_AT_low_pc      : 0x4820f0
    <63de8>   DW_AT_high_pc     : 0x4821c2
    <63df0>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
    <63df2>   DW_AT_decl_file   : 0x1
    <63df6>   DW_AT_external    : 1
 <2><63df7>: Abbrev Number: 14 (DW_TAG_formal_parameter)
    <63df8>   DW_AT_name        : param1
    <63dff>   DW_AT_variable_parameter: 0
    <63e00>   DW_AT_decl_line   : 5
    <63e01>   DW_AT_type        : <0x220f>
    <63e05>   DW_AT_location    : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
 <2><63e07>: Abbrev Number: 14 (DW_TAG_formal_parameter)
    <63e08>   DW_AT_name        : param2
    <63e0f>   DW_AT_variable_parameter: 0
    <63e10>   DW_AT_decl_line   : 5
    <63e11>   DW_AT_type        : <0x220f>
    <63e15>   DW_AT_location    : 2 byte block: 91 8 	(DW_OP_fbreg: 8)
 <2><63e18>: Abbrev Number: 0

The go compiler (after 1.10) uses DW_OP_call_frame_cfa for the first parameter and DW_OP_fbreg for the rest.
On go versions lower than 1.10, it used DW_OP_call_frame_cfa for all parameters.
Here is example output of the readelf on main.example, compiled with go1.9.7:
 <1><2634d>: Abbrev Number: 2 (DW_TAG_subprogram)
    <2634e>   DW_AT_name        : main.example
    <2635b>   DW_AT_low_pc      : 0x487db0
    <26363>   DW_AT_high_pc     : 0x487e99
    <2636b>   DW_AT_frame_base  : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
    <2636d>   DW_AT_external    : 1
 <2><2636e>: Abbrev Number: 5 (DW_TAG_formal_parameter)
    <2636f>   DW_AT_name        : param1
    <26376>   DW_AT_location    : 1 byte block: 9c 	(DW_OP_call_frame_cfa)
    <26378>   DW_AT_type        : <0x27f1c>
 <2><2637c>: Abbrev Number: 5 (DW_TAG_formal_parameter)
    <2637d>   DW_AT_name        : param2
    <26384>   DW_AT_location    : 4 byte block: 9c 11 8 22 	(DW_OP_call_frame_cfa; DW_OP_consts: 8; DW_OP_plus)
    <26389>   DW_AT_type        : <0x27f1c>
 <2><2638d>: Abbrev Number: 0

Hope this makes things easier to understand.

Daniel.

