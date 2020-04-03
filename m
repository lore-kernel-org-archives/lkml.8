Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF8BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221292073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585921996;
	bh=tA9uodfhlhQ+USoFBUhHPt9qk0mTCZtpb9OLfoH4Kyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TFFUBNVemJZHCy9WsHq6hR8XkuzK4aiMFnd5tm8vS96BS5nEn6kqrDmzJKz2V1LNJ
	 pzx2uHHCppucigLufnFie3MsuEUWHxL8vFM/c8+MG5l6/7M8Jv5kvDRIOLCWwkPoTL
	 ECItqKaK60r++b2yHjR8JiVgCpT/1Lt8ut9CySfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390914AbgDCNxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:53:15 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37649 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgDCNxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:53:14 -0400
Received: by mail-pj1-f66.google.com with SMTP id k3so2968117pjj.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zcFWDvZp9QMrvsFpFtgk+25xUV5lrA0z7Ssc+FVYFi0=;
        b=YvLVoGDwWCLwA5ULlHaWtCkfK7fGcOcu/kRBkrsspztbq1o6YBL9XQoiRlyykmRWfW
         dcY5X9bQjJor8kEANj6x8BJx7jkeGTgNPn7QqElULfq1ACa4FgtRPPay7hq7WBLgKthp
         oEkqA/E2iHm8k0Mq83rzW2hW52fn+BE/s4bYpPIUYZNpJxYKLWqoGp6lPFnY4FKZeN5T
         1vtIe5h00TGsScWqTMho8U0C3Nnox5y0HyZLzD/vVPTjsIBLLcanL5vkYFrpG2Z3K9qr
         hJc0oAwuGDgF0q01qv0WQea+rLFUl6HeTY5xgsr39ypYletfQHTZ1yz9Buxr0lFiK+L0
         DGqA==
X-Gm-Message-State: AGi0PuYXpaSHZSWAiNDrnIDBK+huSeNii1akhqldpbS1h0Y2qirpZ5ol
        4fBg2RuCbeZDFqFNT4q5Rl4=
X-Google-Smtp-Source: APiQypL1UKhsndV9Kh95cqEQaqxHKLo1CI6EKjSKg2A+xTsozvkM/FIGfJweyEfUXr57m5XU29hDng==
X-Received: by 2002:a17:90b:4c0e:: with SMTP id na14mr10146879pjb.73.1585921993186;
        Fri, 03 Apr 2020 06:53:13 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id i4sm5829103pfq.82.2020.04.03.06.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 06:53:11 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1397040297; Fri,  3 Apr 2020 13:53:11 +0000 (UTC)
Date:   Fri, 3 Apr 2020 13:53:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Qiujun Huang <hqjagain@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmod: fix a typo "assuems" -> "assumes"
Message-ID: <20200403135311.GN11244@42.do-not-panic.com>
References: <1585891029-6450-1-git-send-email-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585891029-6450-1-git-send-email-hqjagain@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 01:17:09PM +0800, Qiujun Huang wrote:
> There is a typo in comment. Fix it.
> s/assuems/assumes
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

> ---
>  kernel/kmod.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kmod.c b/kernel/kmod.c
> index bc6addd..8b2b311 100644
> --- a/kernel/kmod.c
> +++ b/kernel/kmod.c
> @@ -35,7 +35,7 @@
>   *		       (u64) THREAD_SIZE * 8UL);
>   *
>   * If you need less than 50 threads would mean we're dealing with systems
> - * smaller than 3200 pages. This assuems you are capable of having ~13M memory,
> + * smaller than 3200 pages. This assumes you are capable of having ~13M memory,
>   * and this would only be an be an upper limit, after which the OOM killer
>   * would take effect. Systems like these are very unlikely if modules are
>   * enabled.
> -- 
> 1.8.3.1
> 
