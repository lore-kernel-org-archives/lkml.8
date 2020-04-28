Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98084C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC6820757
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJDZC7ym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgD1Rt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgD1Rt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:49:58 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A936C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:49:58 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id w29so18041004qtv.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P9SGNve9BRU4Qt+yhcMoM8KnTVJiczxu3YkmbhPflaQ=;
        b=BJDZC7ym7lr8pVLtHwcmEGsQgs04fJFUejXAVeTMchhIasmnMPv206CZ/jx/7K5Wru
         0htUL07ziD2xsnwtflpUOdtk8J/CGKQGuwxdXq3uy6AXjDsppchxHt3BVdvvVp3v0YPH
         rk5XwWROvF+uW6pfwXeRKfCG/46bp21Ky+Ot5QlhM21UAgzwagQAhxzFvY8qE+VJ2IdG
         I9sBKBwmLgG2zZRBoMfTNhJZWXMSwVhDI93lhiCAEpXRBsA7GfZLFuD6P2GQmsRpESrN
         Tls08vHxszFJSnWRru8G8H/tqAUV6cDu7PVVPO6Yy0WxfOzLEDr3RODZwVh58CrQyAt5
         aoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P9SGNve9BRU4Qt+yhcMoM8KnTVJiczxu3YkmbhPflaQ=;
        b=YROt5tEYjo/8TzbobPCSWOvZkB3eCzC/pjicI32HvcuhdHopVcTOkSGw6DD7isA2tK
         gUhFjhtSA0gSZrQEIPE7ivBVOWUBUI/hfdiTvCNcyc5KrIMDTvfj7qtcpysGHKGRSR6t
         H4g4u3UOJW57HiEYLY/97suaa5q52VClsIJeoNzl9FHvIvVkk8oNAowN5Wwe8jISVNZ8
         ETby1v5oa1JnfB8rIHFyBMJf7OfSNxoCLurbaToz1oJzCOY9vvNBl75VbHmRieo4ZrL3
         eHlLmS5SiQRfxB6EMnndNObOkuyRxMbQX/jiW9xAbxQDh9dJ9dyPBy1RT3ZcbvDSQrqI
         HOCg==
X-Gm-Message-State: AGi0PuYELnChTPAeFxmmAdUV+gYnJ2PDCeHgLWoEGvAJY0BIMyNhWUkU
        Gk+Ey6fYQvtChPCYN2mm1uQ=
X-Google-Smtp-Source: APiQypJCUNyzyzmf7tdWyxaNwTkuWAGHKTuxv2+Fdfj4yRHnQmFEwsfO5kD8aFLzwxMnygf2Alilyw==
X-Received: by 2002:ac8:4b4c:: with SMTP id e12mr30352335qts.78.1588096197189;
        Tue, 28 Apr 2020 10:49:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id v27sm14795427qtb.35.2020.04.28.10.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 10:49:56 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9C83E409A3; Tue, 28 Apr 2020 14:49:53 -0300 (-03)
Date:   Tue, 28 Apr 2020 14:49:53 -0300
To:     Zou Wei <zou_wei@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] perf c2c: Remove unneeded semicolon
Message-ID: <20200428174953.GB5460@kernel.org>
References: <1588064336-70456-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588064336-70456-1-git-send-email-zou_wei@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 28, 2020 at 04:58:56PM +0800, Zou Wei escreveu:
> Fixes coccicheck warnings:
> 
>  tools/perf/builtin-c2c.c:1712:2-3: Unneeded semicolon
>  tools/perf/builtin-c2c.c:1928:2-3: Unneeded semicolon
>  tools/perf/builtin-c2c.c:2962:2-3: Unneeded semicolon

Thanks, applied.

- Arnaldo
 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  tools/perf/builtin-c2c.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 0d544c4..0e14c18 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -1709,7 +1709,7 @@ static struct c2c_dimension *get_dimension(const char *name)
>  
>  		if (!strcmp(dim->name, name))
>  			return dim;
> -	};
> +	}
>  
>  	return NULL;
>  }
> @@ -1925,7 +1925,7 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
>  		FILTER_HITM(tot_hitm);
>  	default:
>  		break;
> -	};
> +	}
>  
>  #undef FILTER_HITM
>  
> @@ -2959,7 +2959,7 @@ static int perf_c2c__record(int argc, const char **argv)
>  
>  		rec_argv[i++] = "-e";
>  		rec_argv[i++] = perf_mem_events__name(j);
> -	};
> +	}
>  
>  	if (all_user)
>  		rec_argv[i++] = "--all-user";
> -- 
> 2.6.2
> 

-- 

- Arnaldo
