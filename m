Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3ABC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32A920842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="TUXSASvj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgCCNVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:21:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44173 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgCCNVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:21:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id n7so4252062wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 05:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=004iwmdbvB3c49zXjrxdzcpw0aD2nTC7C1OaBnxuOmY=;
        b=TUXSASvjSfIBM9Dy9JTUzAEfJB9OZ7d4f4352t1W4X7UdGtsAc4AO2Z4nlFVYsuzkU
         swgqWAjr4xCh29U3sBI0gJvYntFxNwiVIBm0Q50W77rzpG++54yEVkoWjTCVoI/punOf
         4ImqxTXDc18CNHFDAn7/M5mEE8dIrGF8p0PmiMBmPBV2Xk68olsPg+7EKVoCeL7cfzJq
         FTWnbXnK37lGqiUL9AKBZaNTKoQOllxWYCIdA0WVqmua4hJGdHqaaGiFi/KyLbZLyPxr
         +RMLiMgqPuXcrUT+BrFqrfsNBBHXZFkOuUo8giIiI20XezZmmK6nviRN6otczLRss85e
         dx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=004iwmdbvB3c49zXjrxdzcpw0aD2nTC7C1OaBnxuOmY=;
        b=YJXYLWsyCyTsWqcNNEzAjMcXVrxiACR75iBiE27pV9pELlvyTvnOKGUSenstDR6JfH
         zlF2QpIntbEKctAozOOPvVuEdDW4HYTbwlmMRPShYXIByyZMai6aMwuY+fVyxXlfyTQX
         iJ6jm4HxkCFW1iZVjeamDF/blLP41WaIomAHcMXnyHlope/L3ggJBmCqIyAl3puZmktr
         phPtkU4tEApkneoK1N67bpB89vrMxXBYaCJu5Nh+X6/LezPjlZlkCzgzsVW6EObZCY+0
         75MUZ9AALJc8mv/AgURG2ZI8hfOImS6q9PqwwI/r1CJmLGSbbjBs7FEoMA5D6FDu5joO
         R6lw==
X-Gm-Message-State: ANhLgQ1UfJYCGt2zF0n7Tq5ii682Oq0Lx5h8zjHGi53nRLMib3Pl79ZX
        QjbDITa1fTuUmeiItjMKOINlIA==
X-Google-Smtp-Source: ADFU+vuhVfHNSWjry1JDUO/1jMvW5w7fMYDPNyLeHxuYRm/PEphlQ2Pg2nHC1t+lxNFcWAiY8xzchQ==
X-Received: by 2002:a5d:6881:: with SMTP id h1mr5370250wru.236.1583241714002;
        Tue, 03 Mar 2020 05:21:54 -0800 (PST)
Received: from localhost ([85.163.43.78])
        by smtp.gmail.com with ESMTPSA id z13sm4551944wrw.88.2020.03.03.05.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 05:21:53 -0800 (PST)
Date:   Tue, 3 Mar 2020 14:21:52 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "mlxsw@mellanox.com David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: mlxfw: Replace zero-length array with
 flexible-array member
Message-ID: <20200303132152.GI2178@nanopsycho>
References: <20200302210437.GA30285@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302210437.GA30285@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 02, 2020 at 10:04:37PM CET, gustavo@embeddedor.com wrote:
>The current codebase makes use of the zero-length array language
>extension to the C90 standard, but the preferred mechanism to declare
>variable-length types such as these ones is a flexible array member[1][2],
>introduced in C99:
>
>struct foo {
>        int stuff;
>        struct boo array[];
>};
>
>By making use of the mechanism above, we will get a compiler warning
>in case the flexible array does not occur last in the structure, which
>will help us prevent some kind of undefined behavior bugs from being
>inadvertently introduced[3] to the codebase from now on.
>
>Also, notice that, dynamic memory allocations won't be affected by
>this change:
>
>"Flexible array members have incomplete type, and so the sizeof operator
>may not be applied. As a quirk of the original implementation of
>zero-length arrays, sizeof evaluates to zero."[1]
>
>This issue was found with the help of Coccinelle.
>
>[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
>[2] https://github.com/KSPP/linux/issues/21
>[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
>Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Jiri Pirko <jiri@mellanox.com>
