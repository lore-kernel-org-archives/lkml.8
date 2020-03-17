Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E595EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B192820735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584454580;
	bh=kQeMODH2g1jF52fgfITFeXn4GVeNONcypwuYlT0Rr/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dBzn4AEyYF9wgyTaOhdHDd4uaMO6sGearOlvDIWCLA7pYKmYVcP7IcvT28GuglyVB
	 UEh76dGpzeRmz91N3AWiKAS+IxWcp19ulhlAAxo2obVVuXx4Vw65EMG2VNXHoKlMWN
	 G0fduQMi5HeXZmtEvgDIBIb2eYadmKxdrlKJbXxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgCQOQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgCQOQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:16:19 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70EC82051A;
        Tue, 17 Mar 2020 14:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584454578;
        bh=kQeMODH2g1jF52fgfITFeXn4GVeNONcypwuYlT0Rr/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XdeJU8IV8STjPf+I5baHlba0R4EaaGU92lYOb+Dobc1OKj7iH41ibGNBzH6xP6LM4
         hJf5IIFBfZ8iJA410jYcxVfLjO0mbrrIKPMGyj2HOUw5M7PZviBSiWGrLijXFlnYMl
         YFEyypR51RuteNSEbVl1enj4E9ipcctwevdqXCfA=
Date:   Tue, 17 Mar 2020 23:16:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, allison@lohutok.net,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf probe: Fix an error handling path in
 'parse_perf_probe_command()'
Message-Id: <20200317231613.af181e378e7c09ea97097314@kernel.org>
In-Reply-To: <20200315201259.29190-1-christophe.jaillet@wanadoo.fr>
References: <20200315201259.29190-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Mar 2020 21:12:59 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> If a memory allocation fail, we should branch to the error handling path in
> order to free some resources allocated a few lines above.
> 

Good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Fixes: 15354d546986 ("perf probe: Generate event name with line number")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  tools/perf/util/probe-event.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index eea132f512b0..65a615ee4b4c 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -1683,8 +1683,10 @@ int parse_perf_probe_command(const char *cmd, struct perf_probe_event *pev)
>  	if (!pev->event && pev->point.function && pev->point.line
>  			&& !pev->point.lazy_line && !pev->point.offset) {
>  		if (asprintf(&pev->event, "%s_L%d", pev->point.function,
> -			pev->point.line) < 0)
> -			return -ENOMEM;
> +			pev->point.line) < 0) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
>  	}
>  
>  	/* Copy arguments and ensure return probe has no C argument */
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
