Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA5CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5010206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585892592;
	bh=EPMzpII7/HwSeyJwSal2UxKUKZ6EW3P5U9uvw0HqO9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QVphvQO3ZB/nAB8e5epVS6DL8pBobeDrzFHUkDNKX6pdRI/wCOv/H5ElgC4z1EpmJ
	 vAHB23ua98UyA66gEGBxktEu5Edx8vhxTFosjOMPyuQ8+unHt0Z9+mVgGrJ4Jj/G+0
	 rzr4cw/IJYtJ6NJq7p9E/Xd2eJcW/Nb/paPgvWLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbgDCFnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:43:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730025AbgDCFnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:43:10 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D179F20719;
        Fri,  3 Apr 2020 05:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585892589;
        bh=EPMzpII7/HwSeyJwSal2UxKUKZ6EW3P5U9uvw0HqO9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c6n6NOUS8u3CDZcAKRl+a1XNR4gZmAbLfUs4/8WKSa+1qRa22LKy2nUeu02X5c5eH
         AYivyCOezu8P0caPL8ptxJDUJgtNR8sOuuy0b3ym8Z7yIW9kvyyNkWRRcethyPV2wg
         djtQuQZ9PvJaUztCU08+Qx5lGti359M0IwwcaFVo=
Date:   Fri, 3 Apr 2020 14:43:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Daniel Shaulov <daniel.shaulov@gmail.com>
Cc:     Daniel Shaulov <daniel.shaulov@granulate.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-Id: <20200403144304.1e1656c94f831b10d9aa682e@kernel.org>
In-Reply-To: <20200401161954.44640-1-daniel.shaulov@granulate.io>
References: <20200401161954.44640-1-daniel.shaulov@granulate.io>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed,  1 Apr 2020 19:19:52 +0300
Daniel Shaulov <daniel.shaulov@gmail.com> wrote:

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
> 

This looks good to me:)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

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
Masami Hiramatsu <mhiramat@kernel.org>
