Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22460C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC36D207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eutxv2Pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgFRRtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgFRRtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:49:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9B4C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:49:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d8so2720342plo.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gxk0mpNa0zDp1a6ZbGOjifp1sPgDInqSNRsdHtC1Hro=;
        b=eutxv2PiYY3Hf7kIcg35ZVWehj2QRs6NISrkXqJnBcO94eFIIVNhzMmYT/KvasEv/7
         Dg6yWieF5fjiNuTwsTlEcQTv67pMIt2tUtBgW2ivWgeFKOiU86ydlDXiQ7myVBSdjmVs
         oZMjfJI21sdpnTEgfOMzh5iU1XLpr+ltfBd+WQE2hlaakXSoS/M/AwwQAIac0glLq+VB
         EbsFJ0PB7xPqGSLemiArDV6EcbSQZfZTPsu4Hqc1f5tkVGA3VNvFrddyWMijSyYCNPoU
         aPnbeTJWsDX3rmbvw85AggJa1YQLV0rNwwGgjQE92KVT7h6oNxHRKbT4pMQf/kHUwMVO
         U+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gxk0mpNa0zDp1a6ZbGOjifp1sPgDInqSNRsdHtC1Hro=;
        b=JG7ffxzWBPyWLTePnzNJQ3YCLsy5fE79un/uJmg9SIgkQW8h8fzXVPp7EC+aZa0F+C
         9oPA8flIkXHnLkp+6wTvvo/VTr1p1LKnXiT8izl3G/x9m8Cw8CVzPrPR9XttphfhhY7o
         h5gcFsUrkRQDjRY7cwC3v/gEPmAFgczde+NYwb1hEmONW3lnVoaMemOTq4qGN/9M6Dol
         xa/gEqtelgghbEbO5SWwJCHQ1ujF96/GXJ47xA/m4cirTYxxvyH1gAYnGezK+ztkjmKa
         MGxqVgK9vYT/VsHBHM3XaPcIPeik5npVNlTtqu19RPY2StCxJjnKF6SNerIfaGTekTBG
         noGg==
X-Gm-Message-State: AOAM530FHz1YnmMLFrUFhDaQMpCqh3FZJrvP0gBfr+BNGAFafVRpf/Xd
        tu+PXQdbxMk3L/OaPfo3BYr/dA==
X-Google-Smtp-Source: ABdhPJwePPoyJKKty49/kFzWmOuIwz4LoRXlzrUor1Yd1A7Fb6F2+E5Hzyy+9kCNkRpMU8WU3GMsvQ==
X-Received: by 2002:a17:90a:e7cd:: with SMTP id kb13mr5312238pjb.138.1592502555536;
        Thu, 18 Jun 2020 10:49:15 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j184sm3447763pfg.131.2020.06.18.10.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 10:49:14 -0700 (PDT)
Date:   Thu, 18 Jun 2020 10:49:14 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dma-mapping: DMA_COHERENT_POOL should select
 GENERIC_ALLOCATOR
In-Reply-To: <20200618152506.116057-1-hch@lst.de>
Message-ID: <alpine.DEB.2.22.394.2006181047350.246344@chino.kir.corp.google.com>
References: <20200618152506.116057-1-hch@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020, Christoph Hellwig wrote:

> The dma coherent pool code needs genalloc.  Move the select over
> from DMA_REMAP, which doesn't actually need it.
> 
> Fixes: dbed452a078d ("dma-pool: decouple DMA_REMAP from DMA_COHERENT_POOL")
> Reported-by: kernel test robot <lkp@intel.com>

Acked-by: David Rientjes <rientjes@google.com>

Thanks Christoph.  In the initial bug report from Alex Xu, his .config set 
CONFIG_GENERIC_ALLOCATOR already so I think there is very little risk with 
this patch.
