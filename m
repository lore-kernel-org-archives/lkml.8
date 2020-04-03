Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C25C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59886206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585892419;
	bh=QvwTD819lz0XbSap6oH7pSjo7uP65gkShMIyJNk5z28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rzeXEWp5znCJ8z7e0cRIXernV17bQdZpDjWnHr5xXHJ9OQ3oGiiE5K4CdPKYDPmE4
	 lTUdvEqGxahyUjK0tVG0998VCzoEo/dFhG7XHPS3IltLXfJQsMTCHY/8KZoVMBVfci
	 9YZGCDHILf6BTUTMEQO5hZ/JmDf6BPsLU3KIakQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgDCFkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729349AbgDCFkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:40:02 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D28A5206F5;
        Fri,  3 Apr 2020 05:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585892402;
        bh=QvwTD819lz0XbSap6oH7pSjo7uP65gkShMIyJNk5z28=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=avJNCsKEeFL00UUlmA6L9XVCt1colG+S2TRgZ0bQaEVVMVCnZhn8QIcmctCZG1KFY
         KIciRT5zyoPQtnSkc6amNrxYaj3rbdYAOAt8gabT+88qXFJ5GRma4peGZN8D7AVQO+
         0tSwHIb+zjN1Hrh0f/mWzDDIxuWaWkAtHqMaQdSU=
Date:   Fri, 3 Apr 2020 14:39:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
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
Message-Id: <20200403143956.f6d4f7771a55e8fe97afacee@kernel.org>
In-Reply-To: <20200402202523.GA55594@5f9ad775e7f6>
References: <20200401161954.44640-1-daniel.shaulov@granulate.io>
        <20200402184943.GB23243@kernel.org>
        <20200402202523.GA55594@5f9ad775e7f6>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, 2 Apr 2020 20:25:24 +0000
Daniel Shaulov <daniel.shaulov@gmail.com> wrote:

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
> 
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

Thanks for the explanation. That is a useful info to understand what go compiler does on dwarf.
OK, so that is same as "DW_OP_fbreg: 0".

Thank you,

> 
> Daniel.
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
