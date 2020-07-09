Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02AFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0D12073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="IJ4zxh3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGIOp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:45:27 -0400
Received: from one.firstfloor.org ([193.170.194.197]:36224 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgGIOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:45:27 -0400
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jul 2020 10:45:26 EDT
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 1F20E867DA; Thu,  9 Jul 2020 16:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1594305464;
        bh=xxUNKBrT5+W3Ou+a/E3ro6XLN+oqaa1s44HJ/vlvdBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJ4zxh3w+Tq38/dHIP9kanA5fiNbMVg1gnjueNWa54vaIP6/g5a2DMqJjEOScQYTd
         J26R5ONYpQhZgG238dAftGchgMr/jLtSzXpC79xCaeHU5jx9/HlqyvvFxcW70GwTOf
         M+xO3IiJxC4E1QhXU+Fv1iD+EiiWHspe0pZ0GORo=
Date:   Thu, 9 Jul 2020 07:37:43 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/4] perf-probe: Fix wrong variable warning when the
 probe point is not found
Message-ID: <20200709143743.gux2xsfq4wo2xeo3@two.firstfloor.org>
References: <159428201109.56570.3802208017109058146.stgit@devnote2>
 <159428203219.56570.8289435784233418736.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159428203219.56570.8289435784233418736.stgit@devnote2>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 05:07:12PM +0900, Masami Hiramatsu wrote:
> Fix a wrong "variable not found" warning when the probe point is
> not found in the debuginfo.
> Since the debuginfo__find_probes() can return 0 even if it does not
> find given probe point in the debuginfo, fill_empty_trace_arg() can
> be called with tf.ntevs == 0 and it can warn a wrong warning.
> To fix this, reject ntevs == 0 in fill_empty_trace_arg().
> 
> E.g. without this patch;
> 
>   # perf probe -x /lib64/libc-2.30.so -a "memcpy arg1=%di"
>   Failed to find the location of the '%di' variable at this address.
>    Perhaps it has been optimized out.
>    Use -V with the --range option to show '%di' location range.
>   Added new events:
>     probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)
>     probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)
> 
>   You can now use it in all perf tools, such as:
> 
>   	perf record -e probe_libc:memcpy -aR sleep 1
> 
> With this;
> 
>   # perf probe -x /lib64/libc-2.30.so -a "memcpy arg1=%di"
>   Added new events:
>     probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)
>     probe_libc:memcpy    (on memcpy in /usr/lib64/libc-2.30.so with arg1=%di)
> 
>   You can now use it in all perf tools, such as:
> 
>   	perf record -e probe_libc:memcpy -aR sleep 1
> 
> 
> Reported-by: Andi Kleen <andi@firstfloor.org>
> Fixes: cb4027308570 ("perf probe: Trace a magic number if variable is not found")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Tested-by: Andi Kleen <ak@linux.intel.com>

Except for the minor nit on the message all patches look good to me.

-Andi
