Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BE4C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B18720872
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fy3fdco4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgH0WYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgH0WY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:24:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA93C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:24:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mt12so3375196pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H6QntW38gPEFwHNQYlgwHCDGLyNFBc96nik9uX9BQQc=;
        b=fy3fdco47vqzn6Vp73ftCFSlRR/TwRFupTxfCnAbsTdGR6I9mYuCWryGZO3c80pz4S
         4T806WeyV4cNhDmI6tK4MfMCYDYnJA5Wkf2U6AI3pg3VM+XdhFJXHKvdyquEx+MyeGqv
         F7Qi31R1JgG5wfKBaaIHFSvXJFgYyvgfnfBQNmT5hdL0RCeYZ+aeOdqkgWwjJK2KiD97
         Pc7NnTTJa25gdhOa8bKABjZOweSOToyB+gRBf6ZG4p7qvN8xoiQQIXUkeWQFRPpYf2Ef
         yd5f4yLzws3bafbG9mWqslxyfr67d/ZLzqz/iwwDs8l7FuOJQEvdqLmVWzuoYrmbKiHS
         I1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H6QntW38gPEFwHNQYlgwHCDGLyNFBc96nik9uX9BQQc=;
        b=aoo5NRWTZZT/eFJtgh/UlMdUu1jNoaAYBCNbqnMRWgV9EH7pPYrgQT4wtZCh0o4eVh
         MCeXoIguZrX8nfZBwOYv69ko2Nk1rHrVLQECliCAUDMIjU/cMoL88jJuLf1Mz+3lVuI9
         toc+4cxDNpV3+2zX8MZRpxtRs7i6HzYU7WtLJ7E5n+ZjZ+4FOKkGwbDd9+uq/uD0utaR
         cGs8VStwqG3pNJEWbidRMZ3gHg+qMKX5LQ/xMY4BexAd043ywqolht57mUnFrhlBC3QZ
         YZWEL2BDvO9PSv3kCRibs6PfmYko6nsxfnXyo61FRGm3KyGMq1E4tkjUry1UzIyqjSxf
         9A6g==
X-Gm-Message-State: AOAM532+IeXNqf6ZE7QlClFC7nknoh674KL9NigqVSgXSBrXRrt832Qi
        BaJ3DK361Oy85A6LH7La9XeZ6sXm68bjtZvt
X-Google-Smtp-Source: ABdhPJyex7VX/0Dwiss/Xy5cPP4DMJKk2VdoL+5nqkrPKczwEG4oAtFI8PivgW6H7ExeajXGKD2BmQ==
X-Received: by 2002:a17:90a:c242:: with SMTP id d2mr837790pjx.218.1598567068630;
        Thu, 27 Aug 2020 15:24:28 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id l19sm3724378pff.8.2020.08.27.15.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 15:24:28 -0700 (PDT)
Subject: Re: [PATCH] coccinelle: api: fix kobj_to_dev.cocci warnings
To:     Julia Lawall <julia.lawall@inria.fr>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, kbuild-all@lists.01.org
References: <alpine.DEB.2.22.394.2008272211260.2482@hadrien>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <68701ff1-bff5-c3f9-a970-fb7670ac112e@kernel.dk>
Date:   Thu, 27 Aug 2020 16:24:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2008272211260.2482@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 2:13 PM, Julia Lawall wrote:
> Use kobj_to_dev() instead of container_of()
> 
> Generated by: scripts/coccinelle/api/kobj_to_dev.cocci

Seem to see more of these, these days. I don't really like them, why not
just use container_of? The private bla_to_foo() helpers should go away,
they are actively hurting readability of the code imho.

-- 
Jens Axboe

