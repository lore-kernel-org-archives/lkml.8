Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA620C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C213C2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsaOfT1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgEFUXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728231AbgEFUXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:23:44 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E94C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 13:23:43 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id b1so2851626qtt.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TMfOiyScPI6sXjzue1RK10RLRAGspCu6RHrnOnwDOOA=;
        b=GsaOfT1dKy7+TKNY3uZhlWeFDkDGnb/ccNetSXIMzIu4vpbuSqwquRPW15AMw0mZxN
         DtZVlleBXUYtuQzDVvQ10t6XJLJMZVLjbeyOb0ERtEQ/EyVYO+J33F8l5FRCwmdB3LcI
         JFWdj1Gbx85j+nXt6fKTeVdumL0CU+vjWr0kBTiBAJxMYcS55KRFk+3keNV30VyGS9En
         2LHk5jHgq9+MHSpvG3oxsJkqxCxOf0TJOcyjb0Ps8dfNrIdME9FjOGSiFLo2x2HdAhYf
         qa/O4h3jOT2k1pHgv9r3sFeWDzJzDndKPA2dZ7F7Ac+KXgKo0fqXeumqJHg2SgmQGJxy
         FdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TMfOiyScPI6sXjzue1RK10RLRAGspCu6RHrnOnwDOOA=;
        b=N0E+4khLPihvH52RKbyzmV6K9rF50Gn4SrVuBJMEP0GS/lZGOk6EGPIrO5sZNv4rsm
         LJ7FJ+tMHi0rOFj9eebRw2j13ZdYmeK+Eup+Mo8MDOv5j6zZrWsRev8FfYbKPEKqQLn1
         m1QRT60KlTJzGRhxps9zOdj2xVHLXw/QqzXQCpfOLWYmxw1xHB8zrFnpRh+FtCwYuMbA
         uAUHZTdbmw5XFhqrHYJPGSR2sSWBuLWlKbuCfCRh0AN8BnU5U97vkJpM8cjqtllmszBw
         w+WgkpHaufWgPH6TNBB8s4iF8LpvW9xPBM2TKc8gdeNiOXQdOrVtkliA3j3bzZ/DkmhQ
         O7Vw==
X-Gm-Message-State: AGi0PuYkSLUZ1w8Oq2gZG/E8kYhpYFzkIQG/+1YdZ0XUzFWUxauAmqvh
        CU/ZFOG3h+nEngpDo8wlFlw=
X-Google-Smtp-Source: APiQypKQDCPBZJAx487iYZ1OSLfHaAiC3CwXXlFiHduT8fxRN12FEzIB64LsfZA7lz5jWoyvOQCRgA==
X-Received: by 2002:ac8:6ecd:: with SMTP id f13mr10536169qtv.114.1588796622228;
        Wed, 06 May 2020 13:23:42 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id l8sm2549236qtl.86.2020.05.06.13.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 13:23:41 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6BD93409A3; Wed,  6 May 2020 17:23:39 -0300 (-03)
Date:   Wed, 6 May 2020 17:23:39 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/11] perf record: implement control commands handling
Message-ID: <20200506202339.GH9893@kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
 <db9bb4c3-14d2-aa9f-c281-f81ca698913d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db9bb4c3-14d2-aa9f-c281-f81ca698913d@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 06, 2020 at 09:29:05PM +0300, Alexey Budankov escreveu:
> 
> Implement handling of 'enable' and 'disable' control commands
> coming from control file descriptor.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8a14e68b86ad..2278a3efc747 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1496,6 +1496,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	bool disabled = false, draining = false;
>  	int fd;
>  	float ratio = 0;
> +	enum evlist_ctl_cmd cmd = CTL_CMD_UNSUPPORTED;
>  
>  	atexit(record__sig_exit);
>  	signal(SIGCHLD, sig_handler);
> @@ -1793,8 +1794,23 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  			 * Propagate error, only if there's any. Ignore positive
>  			 * number of returned events and interrupt error.
>  			 */
> -			if (err > 0 || (err < 0 && errno == EINTR))
> +			if (err > 0 || (err < 0 && errno == EINTR)) {
>  				err = 0;
> +				if (perf_evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
> +					switch (cmd) {
> +					case CTL_CMD_ENABLE:
> +						pr_info(PERF_EVLIST__ENABLED_MSG);
> +						break;
> +					case CTL_CMD_DISABLE:
> +						pr_info(PERF_EVLIST__DISABLED_MSG);
> +						break;
> +					case CTL_CMD_ACK:
> +					case CTL_CMD_UNSUPPORTED:

Shouldn't we have a pr_debug() or even pr_err() for the unsupported one?

> +					default:
> +						break;
> +					}
> +				}
> +			}
>  			waking++;
>  
>  			if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
> -- 
> 2.24.1
> 
> 

-- 

- Arnaldo
