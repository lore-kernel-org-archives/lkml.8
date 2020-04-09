Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6889DC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C54F20771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="yAHPtbcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgDISIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:08:35 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39125 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgDISIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:08:35 -0400
Received: by mail-qv1-f68.google.com with SMTP id v38so5970599qvf.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 11:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hVNFV4c+yUnUg1gad2ULWcx32+P02jEWW63/ly1Ye2Q=;
        b=yAHPtbcqZ0FZocy5p9sO42wds+5ncDpNQ08Pm98WaI/o38tmnrBThIuHlxZgPAgKY+
         brM0HKmsBcdT/hJ7pcgoDkh3FgWIc0wXo+Zle+P4WpPDqPlq8cSKoB5wWu/ptjqsMN07
         /StGC6vTnjWXf059I68FRn1pL6qFlfr23WbqwCRSCs8OfhYSzRfIbQKqCDxTV4hb0aY7
         r6KrsqnUpfS84I0jmMJjIdYt8sicNYDptPqhxWzEHGNNfn18BoOEqQnKrN9+xHiIVhqp
         fjFqq5+98wLzvln8594fOywPKHVn0FNijgM8mJAG2HAziQD3JTkCHiBe21AkW9w/Z5NU
         0W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hVNFV4c+yUnUg1gad2ULWcx32+P02jEWW63/ly1Ye2Q=;
        b=s87PLFWwZnWRNb8kLJF31jThQ+fjCGyGnI8eOPXIv6unb98slYyPegblLH4iWJLnIJ
         NHWb2FJQ3fYMs8nEEykB08e4me/hFwShnjR+jm8KhhAyr9CZNrrL3hrJf4fXw6fGZMIH
         KyV7qVsILfE+HFiAZxKQXhcwhMxIH/UhcoJq9obgHzjq/hkcgxSOJypQLXiDW3eQTUQB
         ftu7WJGL53Lc4IlSDC2xRVe/zo4hjKz3IeAARhiTS/UA8HkHfyvrQkUKmoBVklHiPgtM
         RMEC57TUmYtRTtrsDGAGMg+c1q4y7G4FynB+xafSYjnBPvVhR6/Yo8SIyFEXnuWgpFx8
         Bpuw==
X-Gm-Message-State: AGi0Puam97sZoXultdZMQw04aT2A7H3ZbRgX8zowqPVHyxY+ltMFq0Mv
        ApfNAc+YfGOge52vR0oWIcvY0w==
X-Google-Smtp-Source: APiQypIuZjvQnzzXwdqXaYQ8O8sJgQwgZRBRPI7V0r6Lfg8XdMzrBVZq/i86JYoq2C1xUHkebmcv9w==
X-Received: by 2002:ad4:46d4:: with SMTP id g20mr1320558qvw.179.1586455714774;
        Thu, 09 Apr 2020 11:08:34 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a664:2e00:d75:1977:59a2:75ff])
        by smtp.gmail.com with ESMTPSA id u29sm20178455qkm.102.2020.04.09.11.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 11:08:34 -0700 (PDT)
Date:   Thu, 9 Apr 2020 14:08:32 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Jiasen Lin <linjiasen@hygon.cn>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        dan.carpenter@oracle.com, allenbh@gmail.com, dave.jiang@intel.com,
        zhangpanyong@hygon.cn
Subject: Re: [PATCH] NTB: Fix static check warning in perf_clear_test
Message-ID: <20200409180831.GB21666@kudzu.us>
References: <1586416284-3246-1-git-send-email-linjiasen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586416284-3246-1-git-send-email-linjiasen@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 12:11:24AM -0700, Jiasen Lin wrote:
> As pthr->dma_chan can't be NULL in this context, so there is
> no need to check pthr->dma_chan.
> 
> Fixes: 99a06056124d ("NTB: ntb_perf: Fix address err in perf_copy_chunk")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>

Pulled into my ntb branch.

Thanks,
Jon

> ---
>  drivers/ntb/test/ntb_perf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 972f6d9..f73b126 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1010,8 +1010,8 @@ static void perf_clear_test(struct perf_thread *pthr)
>  				   pthr->perf->test_peer->dma_dst_addr,
>  				   pthr->perf->test_peer->outbuf_size,
>  				   DMA_FROM_DEVICE, 0);
> -	if (pthr->dma_chan)
> -		dma_release_channel(pthr->dma_chan);
> +
> +	dma_release_channel(pthr->dma_chan);
>  
>  no_dma_notify:
>  	atomic_dec(&perf->tsync);
> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/1586416284-3246-1-git-send-email-linjiasen%40hygon.cn.
