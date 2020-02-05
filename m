Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA35C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB03921741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWs189ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgBEM2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:28:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36479 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727355AbgBEM2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580905696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N0JE7+6oGrDAm+xyYIpRKWHwm3P7rCoF8PvZvVL+Ao0=;
        b=UWs189maj8n7Puq3vFR1FwQ85hzsTHsSbUWQnxA+DxLYhqI55t9ZeaAIFun6Gt/T6/h9zD
        zZA7M5wr726u6+juoEX48vRv0nKsTG3gYZ/Y5HRG3j+4DPU6iZqNHb16AQhSuUuxNelN6t
        3FDL/ZQ+p23gHgPn1jZh7kHaf9Jj3aE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-crE4rwpNMyezPs1TrhCfyw-1; Wed, 05 Feb 2020 07:28:14 -0500
X-MC-Unique: crE4rwpNMyezPs1TrhCfyw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C49C9801A08;
        Wed,  5 Feb 2020 12:28:13 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00F9F5C1B5;
        Wed,  5 Feb 2020 12:27:58 +0000 (UTC)
Date:   Wed, 5 Feb 2020 20:27:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched/isolation: Allow "isolcpus=" to skip unknown
 sub-parameters
Message-ID: <20200205122754.GA28748@ming.t460p>
References: <20200204161639.267026-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204161639.267026-1-peterx@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 11:16:39AM -0500, Peter Xu wrote:
> The "isolcpus=" parameter allows sub-parameters to exist before the
> cpulist is specified, and if it sees unknown sub-parameters the whole
> parameter will be ignored.  This design is incompatible with itself
> when we add more sub-parameters to "isolcpus=", because the old
> kernels will not recognize the new "isolcpus=" sub-parameters, then it
> will invalidate the whole parameter so the CPU isolation will not
> really take effect if we start to use the new sub-parameters while
> later we reboot into an old kernel. Instead we will see this when
> booting the old kernel:
> 
>     isolcpus: Error, unknown flag
> 
> The better and compatible way is to allow "isolcpus=" to skip unknown
> sub-parameters, so that even if we add new sub-parameters to it the
> old kernel will still be able to behave as usual even if with the new
> sub-parameter is specified.
> 
> Ideally this patch should be there when we introduce the first
> sub-parameter for "isolcpus=", so it's already a bit late.  However
> late is better than nothing.
> 
> CC: Ming Lei <ming.lei@redhat.com>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Juri Lelli <juri.lelli@redhat.com>
> CC: Luiz Capitulino <lcapitulino@redhat.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  kernel/sched/isolation.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 008d6ac2342b..d5defb667bbc 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -169,8 +169,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
>  			continue;
>  		}
>  
> -		pr_warn("isolcpus: Error, unknown flag\n");
> -		return 0;
> +		str = strchr(str, ',');
> +		if (str)
> +			/* Skip unknown sub-parameter */
> +			str++;
> +		else
> +			return 0;

Looks fine, even though the 'old' kernel has to apply this patch. 

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming

