Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C79DC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1535206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="AZjh7BQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgD1HwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:52:16 -0400
Received: from smtp1.axis.com ([195.60.68.17]:53181 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgD1HwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=950; q=dns/txt; s=axis-central1;
  t=1588060336; x=1619596336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YYJgrFy01q/iXXRT8jAgJY9sVKaTPwGPeHvj2Hpz2SE=;
  b=AZjh7BQE3WZ8gk5dgzvKTSNtjBOvT7kLRpeQqihFggRwJhWO0nMYvJ/0
   saUneTLzcbi7tlUo5Uzpf6NZEcyyaLbUlR2dIoN06ftCacuemLbrRyrJ5
   FpscGVSgJ9jerPmEoTcl2SK6hco9z6khZIBj+6n5cCLcr36PCdhyqSFNk
   0SPc+UQ8ONui6biQhdGrK3rhW1Xc2FxUL7RUbLQD0yLVOei+Ms7T9uGFW
   L3xWNo18aOrwmLSYDGwCXQaGCIs8Ct4N0we7JhxU8YjpowPz0ROw6LOsX
   bEu9ttrysU5ufg1Etb/WwHQBNw1NAD3I1I+D+fH322/sS20M0+2Xm82xi
   A==;
IronPort-SDR: lYeH8fyYcjDt4AyM/O6xNBIvf0u3r0MUt/tX2KWz8nu7vZ2iSQMCuytyK7qsKHY3thDkbHdmMr
 M+ZhpXNfiLovKcXCHaJrqIj48oeTmdbE3iKPojXIklumrqm65yo2om8XhEN6aEZrbnqn0aVNWs
 0idLfVzR7oP69Lvw0iPAOqqnFKItTi3SILOf0ldyOtexQPPq64DTke22p4DngXvZpwJuEugfBJ
 t3SNL9+bTFkYDlrJYdwlimEXXlHon3QIM+Mt+QbAp1OTkD9GWv02V3F5vmhDBfBk8kiqSB2zVl
 1sM=
X-IronPort-AV: E=Sophos;i="5.73,327,1583190000"; 
   d="scan'208";a="8154008"
Date:   Tue, 28 Apr 2020 09:52:14 +0200
From:   Jesper Nilsson <Jesper.Nilsson@axis.com>
To:     Jason Yan <yanaijie@huawei.com>
CC:     Jesper Nilsson <Jesper.Nilsson@axis.com>,
        Lars Persson <Lars.Persson@axis.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: remove unneeded semicolon in board-artpec6.c
Message-ID: <20200428075214.j5gwldrm5ne337ma@axis.com>
References: <20200428063213.16038-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200428063213.16038-1-yanaijie@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 08:32:13AM +0200, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> arch/arm/mach-artpec/board-artpec6.c:42:2-3: Unneeded semicolon

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  arch/arm/mach-artpec/board-artpec6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-artpec/board-artpec6.c b/arch/arm/mach-artpec/board-artpec6.c
> index d3cf3e8603e8..c27e7bbcd7bc 100644
> --- a/arch/arm/mach-artpec/board-artpec6.c
> +++ b/arch/arm/mach-artpec/board-artpec6.c
> @@ -39,7 +39,7 @@ static void __init artpec6_init_machine(void)
>  		 */
>  		regmap_write(regmap, ARTPEC6_DMACFG_REGNUM,
>  			     ARTPEC6_DMACFG_UARTS_BURST);
> -	};
> +	}
>  }
>  
>  static void artpec6_l2c310_write_sec(unsigned long val, unsigned reg)
> -- 
> 2.21.1
> 

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
