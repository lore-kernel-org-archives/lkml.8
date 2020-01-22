Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF83C47409
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 04:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE0724656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 04:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IEZCSVXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgAVEi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 23:38:56 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41574 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgAVEi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 23:38:56 -0500
Received: by mail-io1-f66.google.com with SMTP id m25so5332795ioo.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 20:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ycX70yNonSao18/YakIgQAyLjBjICvcKUYrrU7H7J6w=;
        b=IEZCSVXM1E6TtaDZHO/2X7nEvnXrThhZ40UygbwaaKpGcDDoInitSjT5Y3u0Opa3Tq
         /2U6r7Y8jxbFu02bMd+MKo4+stMUb1H87MWFMIS4gIvR8wEdi7oTX99lqfYKWNzv9WTx
         4o+bmu41ZeoCmABxa02KYX9Lgkw851us8KTrzY9HF3kAV2PZlrAuryK7OckINcS3BD8N
         AzCcGHL0x7qKGW/rODXP7lP6qGpDWOkQOKkOyWit+kcdz5cJTaiE1h+YXztRq51LvbBD
         45idZQ7puuNNGBabiAUTidGsxbHL+aSThb1NHKpWxca4OADoxsMsiFrHhKknFzmJIDpx
         Km4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ycX70yNonSao18/YakIgQAyLjBjICvcKUYrrU7H7J6w=;
        b=nFSR6DZ082WuVGpVMSkX71aEnXm31vc6duk8i/t7FSWv3fzIz8+K7yyUVoibBRmXe+
         k86L0aF8qwR3ioy1Mbc3e1RZXq2iVnYJXDWkQtKSMuuZHLMcf471dH3fA83ufma9SuhM
         f0lPshxokwWah7g73k35LR/VXQQC5KOVgWaSmzoRiv0kN8+Sbq4ZTr4DfYRk3faSU4np
         nwb1C9iF0IGD8K3mhooFnBJjq0Ef5jxUApEhVlShEfBFr6r5FyGqsT/QBwWCZlRb+BJl
         R+CZKV+vLVtAcLAStdCJN6OYhj2G+7PMX8sPHwxbl7nJVxXj5mIqEhqHlaJPI/IhY/Zj
         vFLg==
X-Gm-Message-State: APjAAAV0OAq0cebv2lUZTi5zIQlmp1drSYgi7d7raBBb3fP3iLzqgwzZ
        9UccEJfCC2HlDfnm0Ra1qFgA+g==
X-Google-Smtp-Source: APXvYqzTz/u6iVvRctYBjKgBamETXpThqY24AhB/KyHkW8ZO8wu1gqUi6FXdoBtfBZkohptub96wlQ==
X-Received: by 2002:a6b:fc02:: with SMTP id r2mr5383665ioh.183.1579667934939;
        Tue, 21 Jan 2020 20:38:54 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id j69sm13970785ilg.67.2020.01.21.20.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 20:38:54 -0800 (PST)
Date:   Tue, 21 Jan 2020 20:38:51 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Zong Li <zong.li@sifive.com>
cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: mm: add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <20200102031240.44484-2-zong.li@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.2001212037460.248939@viisi.sifive.com>
References: <20200102031240.44484-1-zong.li@sifive.com> <20200102031240.44484-2-zong.li@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2020, Zong Li wrote:

> This patch implements CONFIG_DEBUG_VIRTUAL to do additional checks on
> virt_to_phys and __pa_symbol calls. virt_to_phys used for linear mapping
> check, and __pa_symbol used for kernel symbol check. In current RISC-V,
> kernel image maps to linear mapping area. If CONFIG_DEBUG_VIRTUAL is
> disable, these two functions calculate the offset on the address feded
> directly without any checks.

Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
Tested-by: Paul Walmsley <paul.walmsley@sifive.com>


- Paul
