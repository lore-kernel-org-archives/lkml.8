Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6430C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 21:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5748120672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 21:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmKQ4RFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGIVvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 17:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgGIVvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 17:51:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF20C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 14:51:15 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k5so1684538pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yZE59xCL3eBQXoSAxSBT7tm0J2D29/mHRf5l4hrUISI=;
        b=KmKQ4RFjJZN8heHwcunUI+xmSk3O4O7DS/tcqI/shA4R/8tNWpEFDLOaySPCFZvWp0
         pnmJL8xRUDDhptx9Z3jpLMortBNwszOKdCEwWLmCDClzKmP0PfHJTQouFtl9Gwb3UG2t
         Hj5B/OJ3WQZwUBMCrYVBOZrTSHyNr1a9bsFItVX+rEVahrUtcYOaoRxIsg4zx5WoJrtG
         1FaWdcSiC/eqUjRVwPigfrWqMO0M/6VyqMmMndTJ7g49Rr/O6JGgWtJaO1V+gcLr9x+l
         IeEfHITYzSZFf7BWirupcVcL8NQJwun0thCSKLQ2xnWNLiyyqBjTL8foD9POx5zI7Uqp
         VSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=yZE59xCL3eBQXoSAxSBT7tm0J2D29/mHRf5l4hrUISI=;
        b=Axrg77z1gs8AQemOt0xK4s2QBJdNAvswvZlhE2bcEmhwCBhphdDr5V1kbPX3LNbqm4
         q4iqMLq8U6UCpwfCKA8+gTJtNRCW5O3pm84EpSyFmNMIG5CLygpKX+aEvY34iTzuEINH
         ogppCrCv9Dc30m2aUj/2/KOUqHom/ZiNXLnqbrCFaZ4yXPSy98swu+pOtcxFhQ3FGosn
         3oolpfWi9b0jLuorcGQn3jncgDX0FIUBIm/C7AdDN9LOLSw43RGDJRVrBRku0l0dLrN2
         6bWxkdmdVVVZbJLHObTNyvvlfaOPvSwlavZFYYvzZR7xeLjHZby66GvOSJ8kh7H9oKpG
         5dRA==
X-Gm-Message-State: AOAM531zuczDHJhjx6DOxAIaL526QWNJ79MFxVAwVKyn9wt6vyLslrWQ
        0K8f1pfwGhwMnZnxwsO2DYWsLg==
X-Google-Smtp-Source: ABdhPJw4jj1Ar0xu4SkVS219xhic6hKPDR7al9eAtmxNdCW/w3Vk/zjOX56TAskC31yPRk75GOCl9w==
X-Received: by 2002:a17:90b:283:: with SMTP id az3mr2264678pjb.38.1594331474724;
        Thu, 09 Jul 2020 14:51:14 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id t126sm3841690pfd.214.2020.07.09.14.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:51:14 -0700 (PDT)
Date:   Thu, 9 Jul 2020 14:51:13 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
cc:     hch@lst.de, Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dma-pool: Get rid of dma_in_atomic_pool()
In-Reply-To: <20200709161903.26229-3-nsaenzjulienne@suse.de>
Message-ID: <alpine.DEB.2.23.453.2007091449540.972523@chino.kir.corp.google.com>
References: <20200709161903.26229-1-nsaenzjulienne@suse.de> <20200709161903.26229-3-nsaenzjulienne@suse.de>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jul 2020, Nicolas Saenz Julienne wrote:

> The function is only used once and can be simplified to a one-liner.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

I'll leave this one to Christoph to decide on.  One thing I really liked 
about hacking around in kernel/dma is the coding style, it really follows 
"one function does one thing and does it well" even if there is only one 
caller.  dma_in_atomic_pool() was an attempt to follow in those footsteps.
