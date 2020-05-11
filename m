Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875B9C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5772078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="MgX3Ya4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbgEKVHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731712AbgEKVHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:07:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4603C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 14:07:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s20so4444300plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=62TnuSeM6CTM78jj+qZBkEPwT+WLk/r5wwHVDIphFcM=;
        b=MgX3Ya4fLNyARY7Yx1xdi9X2dktvm/fspFbV0uiE50XxdfPZ+KyFMtkL46MrcTqmIT
         3lnVn/X/cWTcl5MPH1fIsMe2wX/Vg7wz/q49hj2/y6wKYWCeQxER8ggsKTMny+umwBc8
         x2Uxe3YePBvsA1gLkuH5vlJLLnwe332JLJch7TSt9NJzZW20d8rXvLv+GXlFHNIyVUjQ
         Hp+ZEqQVyVLHhY0IaZBxuRnbz1gpvtt8NVXPtilxjGz1wxxObEDkNly8wyvOq/4UyThd
         SsmuEx8r+R3n+BR9F57p+jgQeKEiDjQM/UjEgSQKeYyOlglEjwbdsRes2Mt7B6+ktVWt
         fhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=62TnuSeM6CTM78jj+qZBkEPwT+WLk/r5wwHVDIphFcM=;
        b=B+m01fZqO//LtOpngrgtqCIY5L4LNuJ+cUhoBqQEqMt5mT5jFoXOQ/4fpWL/kfrMtZ
         bExKwk0QbPy5o+GndlZ5wcCnu+tez/wCm6jtFuKydulm+xP7Y/sxvXXK3onbm6H9wK6J
         gT7aip1VYi0LsB8jA82/AjGyGDTxbPDSRxNK6DBGWVPA9TrOJKaNoaB7B0tRb13zCYxn
         bxLIKlFC/GTK+MF4tU0lkZt2OMM9ZZgIW8G7PPhN8CuaHkzpM6/SySuMNTyRGomJRHrP
         uxNgQf/P4MBenHSH55bLoJLf++FCwXvbpyLmboAavQT1c8JAv6UTJTWWlLG6IxPp4ebf
         zZ9Q==
X-Gm-Message-State: AGi0PubmJZjEndeJnrxPYGpe+H1DFXw21m9oE3lo9Zpe2QCvDElhFmnO
        3Siq8pcaoJYjP2DWHKxsu5gRXw==
X-Google-Smtp-Source: APiQypIzhPmQGVU30ePlDnpJ2VRSQ2Yvamj+NUnEu6Vtr1qonDQOZ0HZAWnxx9BbV4hVOmQEfol9Gw==
X-Received: by 2002:a17:90a:fe9:: with SMTP id 96mr25813358pjz.13.1589231223000;
        Mon, 11 May 2020 14:07:03 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k7sm121629pga.87.2020.05.11.14.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 14:07:02 -0700 (PDT)
Date:   Mon, 11 May 2020 14:07:02 -0700 (PDT)
X-Google-Original-Date: Mon, 11 May 2020 13:49:17 PDT (-0700)
Subject:     Re: [PATCH -next] riscv: perf_event: Make some funciton static
In-Reply-To: <b5635dbb-5bd6-ca01-ca3b-4932941fd19a@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        alankao@andestech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-eeb74520-7724-4947-b2ec-1a13744b3e63@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 May 2020 18:30:36 PDT (-0700), wangkefeng.wang@huawei.com wrote:
>
> On 2020/5/9 1:13, Palmer Dabbelt wrote:
>> What's the "-next" for?  This seems appropriate for an RC to me, as
>> it's a
>> build fix.
>
> Thanks for your review, this patch and "[PATCH -next] riscv: perf:
> RISCV_BASE_PMU
>
> should be closeable", I fix the issue based on linux-next, so add the
> next prefix ; )

OK, makes sense.  I've put it on fixes.

>
> and we also found some another build issue when add RISCV arch to huawei
> build robot,
>
> will send out the patches later.

Thanks!

>>
>> On Thu, 07 May 2020 08:04:44 PDT (-0700), wangkefeng.wang@huawei.com
>> wrote:
>>> Fixes the following warning detected when running make with W=1,
>>> ../arch/riscv/kernel/perf_event.c:150:5: warning: no previous
>>> prototype for ‘riscv_map_cache_decode’ [-Wmissing-prototypes]
>>>  int riscv_map_cache_decode(u64 config, unsigned int *type,
>>>      ^~~~~~~~~~~~~~~~~~~~~~
>>> ../arch/riscv/kernel/perf_event.c:345:13: warning: no previous
>>> prototype for ‘riscv_base_pmu_handle_irq’ [-Wmissing-prototypes]
>>>  irqreturn_t riscv_base_pmu_handle_irq(int irq_num, void *dev)
>>>              ^~~~~~~~~~~~~~~~~~~~~~~~~
>>> ../arch/riscv/kernel/perf_event.c:364:6: warning: no previous
>>> prototype for ‘release_pmc_hardware’ [-Wmissing-prototypes]
>>>  void release_pmc_hardware(void)
>>>       ^~~~~~~~~~~~~~~~~~~~
>>> ../arch/riscv/kernel/perf_event.c:467:12: warning: no previous
>>> prototype for ‘init_hw_perf_events’ [-Wmissing-prototypes]
>>>  int __init init_hw_perf_events(void)
>>>             ^~~~~~~~~~~~~~~~~~~
>>>
>>> Cc: Alan Kao <alankao@andestech.com>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>  arch/riscv/kernel/perf_event.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/riscv/kernel/perf_event.c
>>> b/arch/riscv/kernel/perf_event.c
>>> index 91626d9ae5f2..c835f0362d94 100644
>>> --- a/arch/riscv/kernel/perf_event.c
>>> +++ b/arch/riscv/kernel/perf_event.c
>>> @@ -147,7 +147,7 @@ static int riscv_map_hw_event(u64 config)
>>>      return riscv_pmu->hw_events[config];
>>>  }
>>>
>>> -int riscv_map_cache_decode(u64 config, unsigned int *type,
>>> +static int riscv_map_cache_decode(u64 config, unsigned int *type,
>>>                 unsigned int *op, unsigned int *result)
>>>  {
>>>      return -ENOENT;
>>> @@ -342,7 +342,7 @@ static void riscv_pmu_del(struct perf_event
>>> *event, int flags)
>>>
>>>  static DEFINE_MUTEX(pmc_reserve_mutex);
>>>
>>> -irqreturn_t riscv_base_pmu_handle_irq(int irq_num, void *dev)
>>> +static irqreturn_t riscv_base_pmu_handle_irq(int irq_num, void *dev)
>>>  {
>>>      return IRQ_NONE;
>>>  }
>>> @@ -361,7 +361,7 @@ static int reserve_pmc_hardware(void)
>>>      return err;
>>>  }
>>>
>>> -void release_pmc_hardware(void)
>>> +static void release_pmc_hardware(void)
>>>  {
>>>      mutex_lock(&pmc_reserve_mutex);
>>>      if (riscv_pmu->irq >= 0)
>>> @@ -464,7 +464,7 @@ static const struct of_device_id
>>> riscv_pmu_of_ids[] = {
>>>      { /* sentinel value */ }
>>>  };
>>>
>>> -int __init init_hw_perf_events(void)
>>> +static int __init init_hw_perf_events(void)
>>>  {
>>>      struct device_node *node = of_find_node_by_type(NULL, "pmu");
>>>      const struct of_device_id *of_id;
>>
>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> .
>>
