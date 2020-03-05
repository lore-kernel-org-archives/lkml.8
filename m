Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEEDC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A69E2070E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag5H5y4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgCEPN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:13:58 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44602 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgCEPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:13:58 -0500
Received: by mail-qk1-f195.google.com with SMTP id f198so5583085qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 07:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i079FHdW8KISYEfSNqvwZXi8uxi2K0CSJomXrBBVIF8=;
        b=ag5H5y4raEmo7MQwfTl587DZPNCMHhl9yiIOXOw9C4F+XB7Ic2rGYKstpuulvLGNeO
         UROljodiq2u6Wwd6LSSrFqTKZ+7q9k/0mQ6OpYpqPhQ3f7MjFwHWBoUv9mtZo0cZkN93
         hGwPhMrp6besSTuXNepv05Iw5/IOhJVGru1Nj/18lQeT6Xr2Z63we7R4bHSPKqryQ6kQ
         5J/nrVVxgC8ohwuJQAGOSXZ7DqN9gPKYJ0qdrb1/xwr3aZ8gP1tirJXvd6wxJ/cESRrT
         D1xdZCTV9Kv8yzYnP96A1PyYT64A1iNTeuIW2UbRaxyYtpK0vE9D5K9uQNR1Dc1l4OyV
         g/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i079FHdW8KISYEfSNqvwZXi8uxi2K0CSJomXrBBVIF8=;
        b=byFN5/FPFpDWjqqa+z/Bp8AYz0J+l6CQNU9G/Z5F1/LnU3Ly/6iHTq3n5VJczZMra7
         OrjyuZ2iA/JxPnlugPdvBN6krXPFzbdSNc+UoK+rlVwxyW9dJHfBiKljHEZ60sK8Zdke
         wMjUj9oiRwvbzkRSFTFYitGHf3HQK7+VZs+w7fUPn6X1Ip9NxJjmeOWMlpA2snQe/v0q
         vzlKGsa/4x32G8QiHbNpPP995Z9iEBsewYyqBgMmvInOg4GdJCkyUzYdOo1QEpLlkmaM
         GT8IYvGDFCGia7XJG9FlFBCLwyEn5IkE3b+EULm7X2ljWN8HK1kRCD0XtkhZa2DttULw
         rDFQ==
X-Gm-Message-State: ANhLgQ3xqNM475DrsCWg3V1Mi/TAkjODEKc21EBcMuzYIZv5Izvt2QKs
        oAf0QF1OCRL9VFrBC05Pumc=
X-Google-Smtp-Source: ADFU+vs2pDOdF3QCIthlqEXMCYPkRNuKuTJVvlvNcq727i4m1KbxDUStToLkHYbkqBXZlZSvi9jlvQ==
X-Received: by 2002:a05:620a:4f7:: with SMTP id b23mr8797198qkh.258.1583421237027;
        Thu, 05 Mar 2020 07:13:57 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id j85sm468070qke.20.2020.03.05.07.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:13:55 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 072BD403AD; Thu,  5 Mar 2020 12:13:52 -0300 (-03)
Date:   Thu, 5 Mar 2020 12:13:52 -0300
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        james.clark@arm.com, qiangqing.zhang@nxp.com
Subject: Re: [PATCH 1/6] perf jevents: Fix leak of mapfile memory
Message-ID: <20200305151352.GD7895@kernel.org>
References: <1583406486-154841-1-git-send-email-john.garry@huawei.com>
 <1583406486-154841-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583406486-154841-2-git-send-email-john.garry@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 05, 2020 at 07:08:01PM +0800, John Garry escreveu:
> The memory for global pointer is never freed during normal program
> execution, so let's do that in the main function exit as a good programming
> practice.
> 
> A stray blank line is also removed.

Thanks, applied to perf/urgent.

- Arnaldo
 
> Reported-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/pmu-events/jevents.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 079c77b6a2fd..27b4da80f751 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -1082,10 +1082,9 @@ static int process_one_file(const char *fpath, const struct stat *sb,
>   */
>  int main(int argc, char *argv[])
>  {
> -	int rc;
> +	int rc, ret = 0;
>  	int maxfds;
>  	char ldirname[PATH_MAX];
> -
>  	const char *arch;
>  	const char *output_file;
>  	const char *start_dirname;
> @@ -1156,7 +1155,8 @@ int main(int argc, char *argv[])
>  		/* Make build fail */
>  		fclose(eventsfp);
>  		free_arch_std_events();
> -		return 1;
> +		ret = 1;
> +		goto out_free_mapfile;
>  	} else if (rc) {
>  		goto empty_map;
>  	}
> @@ -1174,14 +1174,17 @@ int main(int argc, char *argv[])
>  		/* Make build fail */
>  		fclose(eventsfp);
>  		free_arch_std_events();
> -		return 1;
> +		ret = 1;
>  	}
>  
> -	return 0;
> +
> +	goto out_free_mapfile;
>  
>  empty_map:
>  	fclose(eventsfp);
>  	create_empty_mapping(output_file);
>  	free_arch_std_events();
> -	return 0;
> +out_free_mapfile:
> +	free(mapfile);
> +	return ret;
>  }
> -- 
> 2.17.1
> 

-- 

- Arnaldo
