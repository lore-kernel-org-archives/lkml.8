Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFEBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCDFD206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vs8KGi9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHQDpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 23:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgHQDpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 23:45:52 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E7EC061389
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 20:45:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f5so6827540plr.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 20:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MA/9gHI0V+yftTzDrDx3504zFpgx5aUeDq1OIejihpQ=;
        b=vs8KGi9WejCWcKWcxD6bsXKCrIcM0+m4Bw8FfFf3Og83i3+KSRNNLWCD4ty/tof3Nr
         4iKnYwHGhQzW/DLjCAlrjRt/VjAL+bRx0t7QGSPZMmnAXHZOjye2Zh5oghknrvL2Juco
         gLVkZFd1cJAMCWC0w9qW8GeKTVfXiaxcIGi98sOYGm5cyiAGdgVeSkRwWjbVZjQsubmy
         yheIf4xhYRDJCIa8y8TNxAB6L0U8GwS+VMZV2+VtMq95iBnPmBxmt91jPbSaizfLN4uY
         Guo9phQx+7+J6PPgpTaUcKFvTetyfEm652SAIY3I5MsWNCtyDZDR4wIPrnloFWg9Y8gS
         xnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MA/9gHI0V+yftTzDrDx3504zFpgx5aUeDq1OIejihpQ=;
        b=HdOQULKAk9xX+OKIzOE0cPZ9k/xrXIOu30IvC4jU7OF8ZzYUhMogvjv/j0knrCeG7F
         a8eD4FJwOKndtYg0IYAv3lQDHoedoWR1sMmvkQJECthDJSBTPQ3tHKpyvt6pZAELlnvC
         b9jORsDiCq9pCqkpod2KdOyUFzoo4wGIi4eXeLYPRUEhnH9K1SKc5paa/fc19SIoHOFo
         5QySulGlA9QRr4qDMF5AiXK96xgRMTuBIIir4BF5DoM4ueylp/NcZvn6iwXwggvDeqTb
         /3WywxnAZTaGpIcoLB8EXUOQZ4IrLBfstaxJjr79uuO4eVSs/iQnde2FcI0qVrkKsCrJ
         TBaQ==
X-Gm-Message-State: AOAM530w/WLiY2T3s6hMBXRsKCmbLnrx2U/7WuDOWKyf1DE77ZYday37
        PtlkZr1oOo4Moov3H1vfDTs/YWneVQNWlQ==
X-Google-Smtp-Source: ABdhPJziFq7DHhuHPYkQ5rKF4HfMbh/cUrsPSHGpavzCqwuHvA591aVIa0+v1ku33lFfVV8TOVUIXQ==
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr11493068pjb.170.1597635951325;
        Sun, 16 Aug 2020 20:45:51 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ea1b:63b0:364:3a3b? ([2605:e000:100e:8c61:ea1b:63b0:364:3a3b])
        by smtp.gmail.com with ESMTPSA id s24sm15332095pjp.1.2020.08.16.20.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2020 20:45:50 -0700 (PDT)
Subject: Re: [PATCH] ata: ahci: use ata_link_info() instead of
 ata_link_printk()
To:     Xu Wang <vulab@iscas.ac.cn>, linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200817032913.10173-1-vulab@iscas.ac.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <de66f1e7-9ac6-b8be-a243-0fe68419bc24@kernel.dk>
Date:   Sun, 16 Aug 2020 20:45:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817032913.10173-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/20 8:29 PM, Xu Wang wrote:
> Using ata_link_info() instead of ata_link_printk().

Applied, thanks.

-- 
Jens Axboe

