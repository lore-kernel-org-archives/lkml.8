Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77832C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D752073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590762365;
	bh=m0X1JkMnm2cl93zjx/SjTTQi6vID8b+zBL+F7ePTAxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vkK7FrDoQsKgHlNERUeasCLIUTug13tQk1g4hKn0UVfl3S30d8Wli4t7DNlPQ87QL
	 3uLcaqBf6H/mXZ+Jn8GgrtbkSLWvzLIyuMjeXWe/XCPvR/PmLCaG/xQ/CeZR/VWkeI
	 FLx6WrIU+pVukusHwbr62b05+lGG6QtDUY/VoDGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgE2O0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgE2O0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:26:04 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39C0C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:26:03 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n11so2304541qkn.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tkyU6uA+DUqBQqvnyDG7siShluEZWqBphmet2GW41To=;
        b=BxlppAfuW6r3rSxJUGDPKBPfPU1011lk847ULNTeWlccPRciXnGw9K3nfMlSVGA8N6
         L6wloXQOAuRcAb5kNc0v2V/Cyw+s54/bIMhRnq9yeNugK8g+nnwJbAA+QHXA8pT5hWqo
         Gm6Hv+uhPwZqz/a+0O5meL5QsorB9DbHaJ42i/2G+7oB3Tal1zTa0QdqYWst3SoEZDWY
         KtrrSlO4epHB1yLjRr2tmEbsxmE1bt0B1xzs02Lsa9QW5WDgj4buaBYoOtrBMJncUqxa
         WeuacL2d6eQnDlt8QPOLt6MNRVroqTkhIEkhKE3lZmoYQGSshSbZAB2VpLGx/OniBJCE
         EOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tkyU6uA+DUqBQqvnyDG7siShluEZWqBphmet2GW41To=;
        b=O9IqFGQbcYwuO05/+CxC0mARsrNcDI05xlAFR4u+Pl+fRxTzznzRaW4SPKjkZ6cpav
         e6SIToZLb26jOaBLidwOnXM6iVzkg0go3VYjBT20ZUUaq/ZeFuSH6r2lKtEB9exz6U9d
         wQIpSbLj5XK6CQ4TSg9oof21Q130XtHP5Ch58dk8UVtmXixUg6s6XRdy0FiKKgFwu3jh
         T0Y68LqdvixPlREOc1Q8G448HE7e2/wKvaygu1hBHj2IjicpTkiFW+htl/G1TMVCtFUZ
         qLgpVrPXHmY7ZpYI3vELQtbtrL6ywLD2Yy3JEJLVcyehVVQgCw0TQmsK9e1GBXXHNwe+
         /EFg==
X-Gm-Message-State: AOAM530ApJbhn5fnTHjfo6evD/w/nhpmWTlEVZKnoHHTRqGmvzbm+F2J
        m6R91PLff+Eh2dnpAN75plo=
X-Google-Smtp-Source: ABdhPJxUPDfQ1lBfLmJXGBNQOUOe4P4uBvZLv5aJL8YYGA4TfnRV3vh/qdcTzORfgmrPU3YtlkxsQA==
X-Received: by 2002:a37:64d8:: with SMTP id y207mr8144137qkb.2.1590762363036;
        Fri, 29 May 2020 07:26:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:5493])
        by smtp.gmail.com with ESMTPSA id p17sm7015087qkg.78.2020.05.29.07.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 07:26:02 -0700 (PDT)
Date:   Fri, 29 May 2020 10:26:00 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 4/4] workqueue: remove useless unlock() and lock() in
 series
Message-ID: <20200529142600.GE3530656@mtj.duckdns.org>
References: <20200529065903.1758-1-laijs@linux.alibaba.com>
 <20200529065903.1758-5-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529065903.1758-5-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 06:59:02AM +0000, Lai Jiangshan wrote:
> This is no point to unlock() and then lock() the same mutex
> back to back.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

Applied to wq/for-5.8.

Thanks.

-- 
tejun
