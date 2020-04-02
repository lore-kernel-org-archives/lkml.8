Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D20C2BA16
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9727B2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhPOkxvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390092AbgDBSts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:49:48 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44207 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388875AbgDBSts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:49:48 -0400
Received: by mail-qv1-f68.google.com with SMTP id ef12so2252726qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rXwjyGP26101Wo2WQdFwUCHoIS6KXBVoETEpWKnCfK8=;
        b=PhPOkxvfnB+/LyyTLyyYkDJFzSiz58JYMfIQuD27iuBC4Agaqr2Bdgq/LhWUwuHfMU
         BbkiZMFtqahR2A7VCPESi5XOF26AXlZG3K/Tnh7/2ofgd9Sh9Z0qkJxZB1lNyNrcKovH
         9o5x5QbX4SpplFP8gcnjroNsmuMSLj6IGoOzQ5a+sboV4O95pSYIhUmKa8sg4iEWdaAt
         y/oW+F8ntE3stVH4oO6itG3hMKUiPZAybWJBOWVQE7Su2pgSXWLgKNEtQ9rQk8ZqrGly
         pNnP2SjdcYhjj/N/BIaxVoJjrQaMBy7/8ov+DEWHzf/HVRDIOE+9lXiVxV63v9Nii+RI
         OiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rXwjyGP26101Wo2WQdFwUCHoIS6KXBVoETEpWKnCfK8=;
        b=E7V0oupVWxlEUrJsn9Z6IQGRdb8jir0IyuxPJO2Sn7D/a9mesulh4qPUCxxpcTxlhv
         64+PqewRyL5+JKom+WBVYu8Hij7Wa2fMRrTpqE8eohx29jUbwBWx8Y+g6hrovi/3QiZ/
         /y9MkUqL9tt7prlc6nnDU+09L1n/owYBPPD2E/iUbyvwimJ2hft3Wb25wk8Q6NiMxps8
         IG1krQlBBwrqmOKaBG8PCUzfa1LFV+1GcYFohA1ON+177ojRkp8GI43de5bfPc9NiyXL
         6GYkeDu7owJGQQrpHYHXQuxs5PbG4saziVTv+Gs9V3qNAfZONStukSvKewoiiFZriNXD
         HJ1Q==
X-Gm-Message-State: AGi0Pubtz8TsBIQHhRDD5GVoJnU2HgVmYA+HGrIF2ih5volbtKvOhWzv
        aKYuxFa2/RUgvb/61CAMBUY=
X-Google-Smtp-Source: APiQypLg0Xklb0CFHc8Os353L1E5TNDD8P1Y73ggQdvSJC5oXSHHm4XnLJDHRiHXk6c2cWIcjH6N+g==
X-Received: by 2002:a0c:ea42:: with SMTP id u2mr4696263qvp.226.1585853386337;
        Thu, 02 Apr 2020 11:49:46 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id c8sm4268858qke.90.2020.04.02.11.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 11:49:45 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 158CF409A3; Thu,  2 Apr 2020 15:49:43 -0300 (-03)
Date:   Thu, 2 Apr 2020 15:49:43 -0300
To:     Daniel Shaulov <daniel.shaulov@gmail.com>
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
Message-ID: <20200402184943.GB23243@kernel.org>
References: <20200401161954.44640-1-daniel.shaulov@granulate.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401161954.44640-1-daniel.shaulov@granulate.io>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 01, 2020 at 07:19:52PM +0300, Daniel Shaulov escreveu:
> Add support for probes on variables with DW_OP_call_frame_cfa
> as the dwarf operation in the debug info.
> 
> Some compilers (specifically Golang compiler) output
> DW_OP_call_frame_cfa instead of DW_OP_fbreg for variables
> on the stack. If DW_OP_call_frame_cfa is the only expression
> than it is the same as DW_OP_fbreg with an offset of zero.
> In the case of the Golang compiler, DW_OP_call_frame_cfa may
> be followed by DW_OP_consts, with a number and than DW_OP_plus.
> This trio is the same as DW_OP_fbreg with the number from
> DW_OP_consts as the offset.
> 
> With this change, probing on functions in Golang with variables works.

Masami, can I have your Reviewed-by, please?

Daniel, next time please consider providing precise steps to show what
wasn't working and then how the patch solves the problem, i.e. get some
go program, show the command lines used to build, probe, etc.

- Arnaldo
 
> Signed-off-by: Daniel Shaulov <daniel.shaulov@granulate.io>
> ---
>  tools/perf/util/probe-finder.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index e4cff49384f4..866b17aea263 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -240,11 +240,23 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
>  	}
>  
>  	/* If this is based on frame buffer, set the offset */
> -	if (op->atom == DW_OP_fbreg) {
> +	if (op->atom == DW_OP_fbreg || op->atom == DW_OP_call_frame_cfa) {
>  		if (fb_ops == NULL)
>  			return -ENOTSUP;
>  		ref = true;
> -		offs = op->number;
> +		if (op->atom == DW_OP_fbreg) {
> +			offs = op->number;
> +		} else if (nops == 3) {
> +			/*
> +			 * In the case of DW_OP_call_frame_cfa, we either have
> +			 * an offset of 0 or we have two more expressions that
> +			 * add a const
> +			 */
> +			if ((op + 1)->atom != DW_OP_consts ||
> +			    (op + 2)->atom != DW_OP_plus)
> +				return -ENOTSUP;
> +			offs = (op + 1)->number;
> +		}
>  		op = &fb_ops[0];
>  	}
>  
> -- 
> 2.22.0
> 

-- 

- Arnaldo
