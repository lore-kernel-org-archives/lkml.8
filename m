Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC7BC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 335872192A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="PjTFL8s6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgEHRNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 13:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgEHRNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 13:13:19 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A0CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 10:13:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so1265373pfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=0bbo9yqx2/IuXmKBdRPrbP5cAWNcfhqAl9BM/fU1oqQ=;
        b=PjTFL8s6+I1J9/NZKcqTpcYV5XM/11g94CEXvhvhFY8SvWcpkz+1MhpvPOXChg3oNs
         6GHO9ZHiT+NPS1cJrPXNp1QXnQ/YOjrRximPC5LOYx7z+7dJZgCC9eGdwGLZ1AdP512B
         X9bTTdQUKxs0ZqbWfh6EsA4frwTQ6muuqQQc170KHdTy5/b2iY3SZN8AJGH1y5CwsLPe
         FXIYTBwCNWRAZf68VObcEJIBQOj4J8veOqnic/GWjiaPmTIEu4/vlsR0+PIwoKrsRh3f
         l74V+fI6aD+CENVcbth6cHy6Vs9iT+Dzt8WvxvRMBVfneWXYxI9WBw+xMD+SImy2V0nd
         Zeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=0bbo9yqx2/IuXmKBdRPrbP5cAWNcfhqAl9BM/fU1oqQ=;
        b=LX7qgo/Sz7F+3MvlqV2WF+ysS573nHA57TzCguKK2gimwratklGERHavhcwi2fqaBY
         8KYmZANbGqCyHumZ8S2z3pxmPhoOAWhetadCr5jxQIWOLLLWh67y2DBfIjFxmhDvEEdW
         VwVyRJjsYBajlL9GqJLBvC9vNtXkxVYSQrJSHumHscBcBExwSd6d5T5exXdGt4cQbUXj
         Xh9WTp/yaKhAN7G75OjUAsZ9iJ57/14iTYmtuISCRdO4tHVpu27Dt7fabM6Gxue6jDf9
         PO7d93PZ+wOzBwfaIKDBVzQng99BxGnztVP6H0s2bfrST1nt6ZwjMIOMzGQfb9OHn9nt
         ZcpQ==
X-Gm-Message-State: AGi0PubOO13M5ttcfOO98Bc2MNU4gi1h5g/VDZCGsLY0m+nEUUvYGE8q
        tcKvIALlIA6CxOx6O01Q3qCbnA==
X-Google-Smtp-Source: APiQypLYQ1/Ktlte3epOcpwn4RycsMdaiTx18JHtnN1cRjb5gOaX3mgnrzKNXuxG2/El9D2NYSoZ7w==
X-Received: by 2002:a62:35c1:: with SMTP id c184mr3665454pfa.120.1588957994887;
        Fri, 08 May 2020 10:13:14 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d35sm1725500pgd.29.2020.05.08.10.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 10:13:14 -0700 (PDT)
Date:   Fri, 08 May 2020 10:13:14 -0700 (PDT)
X-Google-Original-Date: Thu, 07 May 2020 10:36:03 PDT (-0700)
Subject:     Re: [PATCH -next] riscv: perf_event: Make some funciton static
In-Reply-To: <20200507150445.174390-1-wangkefeng.wang@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        wangkefeng.wang@huawei.com, alankao@andestech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-158b6408-4023-446d-89b4-b4416ba80718@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What's the "-next" for?  This seems appropriate for an RC to me, as it's a
build fix.

On Thu, 07 May 2020 08:04:44 PDT (-0700), wangkefeng.wang@huawei.com wrote:
> Fixes the following warning detected when running make with W=1,
> ../arch/riscv/kernel/perf_event.c:150:5: warning: no previous prototype for ‘riscv_map_cache_decode’ [-Wmissing-prototypes]
>  int riscv_map_cache_decode(u64 config, unsigned int *type,
>      ^~~~~~~~~~~~~~~~~~~~~~
> ../arch/riscv/kernel/perf_event.c:345:13: warning: no previous prototype for ‘riscv_base_pmu_handle_irq’ [-Wmissing-prototypes]
>  irqreturn_t riscv_base_pmu_handle_irq(int irq_num, void *dev)
>              ^~~~~~~~~~~~~~~~~~~~~~~~~
> ../arch/riscv/kernel/perf_event.c:364:6: warning: no previous prototype for ‘release_pmc_hardware’ [-Wmissing-prototypes]
>  void release_pmc_hardware(void)
>       ^~~~~~~~~~~~~~~~~~~~
> ../arch/riscv/kernel/perf_event.c:467:12: warning: no previous prototype for ‘init_hw_perf_events’ [-Wmissing-prototypes]
>  int __init init_hw_perf_events(void)
>             ^~~~~~~~~~~~~~~~~~~
>
> Cc: Alan Kao <alankao@andestech.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/riscv/kernel/perf_event.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
> index 91626d9ae5f2..c835f0362d94 100644
> --- a/arch/riscv/kernel/perf_event.c
> +++ b/arch/riscv/kernel/perf_event.c
> @@ -147,7 +147,7 @@ static int riscv_map_hw_event(u64 config)
>  	return riscv_pmu->hw_events[config];
>  }
>
> -int riscv_map_cache_decode(u64 config, unsigned int *type,
> +static int riscv_map_cache_decode(u64 config, unsigned int *type,
>  			   unsigned int *op, unsigned int *result)
>  {
>  	return -ENOENT;
> @@ -342,7 +342,7 @@ static void riscv_pmu_del(struct perf_event *event, int flags)
>
>  static DEFINE_MUTEX(pmc_reserve_mutex);
>
> -irqreturn_t riscv_base_pmu_handle_irq(int irq_num, void *dev)
> +static irqreturn_t riscv_base_pmu_handle_irq(int irq_num, void *dev)
>  {
>  	return IRQ_NONE;
>  }
> @@ -361,7 +361,7 @@ static int reserve_pmc_hardware(void)
>  	return err;
>  }
>
> -void release_pmc_hardware(void)
> +static void release_pmc_hardware(void)
>  {
>  	mutex_lock(&pmc_reserve_mutex);
>  	if (riscv_pmu->irq >= 0)
> @@ -464,7 +464,7 @@ static const struct of_device_id riscv_pmu_of_ids[] = {
>  	{ /* sentinel value */ }
>  };
>
> -int __init init_hw_perf_events(void)
> +static int __init init_hw_perf_events(void)
>  {
>  	struct device_node *node = of_find_node_by_type(NULL, "pmu");
>  	const struct of_device_id *of_id;

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
