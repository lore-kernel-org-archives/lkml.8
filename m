Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA10EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DC020874
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NpTXHg4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbgF3N5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731327AbgF3N5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:57:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E8CC03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:57:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j4so8513103plk.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6WoGClip/9lIMADlW96b66URAMpf8agavloV0J0+6z0=;
        b=NpTXHg4eLKIDB3B017yOQCnwb3dBSkBllVoAHChdp1FGoCyQ19eq1VXevMLSrM/lhD
         bQk0yrTpC1Irq2MNTGh49jfpD7zqgiVbJtqJYeruoqyJ31uUsOmkXd433JMWP+NtSVov
         ZzGBWe4xhNJRj47E5aARYY/9uUmyXWiWjg1l6pljN4nXRLoWQN1OJ6HHzWlN6uNS1Lvc
         bcrSTvkHyH7MDnkYvBu1O0JOQIAWVJgUutILN7WG8Di8qKlewR28Ariy+ojttBxfAl/B
         FxzoT9uIuyEQaP+UAHq4/tgN7PJVGPmfXaxyS6AW/qEEAuiLEhHfUD+LyDQfCVGwqwpj
         3wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6WoGClip/9lIMADlW96b66URAMpf8agavloV0J0+6z0=;
        b=KSVR+sqH/JSjQG+TDlDrfSr+EVhrA4RfnL3nLkTytkwgE7HDYLxPK7R8A5ZfUg5lfd
         vu9M8hqol4rfZDch5AwM9wMMuFiYMyxuRiydDUqZ5Cf8mOIQlcTIOMvF/pg8dY8CklUq
         Ts4rnCJfMnbBM2K+iW7F6G8A6Pl382c0wfSr3XVtjzOQ7E7bdt8EMGtin91yWjTU+cCr
         M61zYyM9+AtTX5p8YybGWRqORxiUtQLMnxGo6sU6Vahj07bxEvVYc069T3XZIgdDKbmk
         VkzaAif07a2vJcsd5k9Q4Nip/ob8ft2kFhPjIngY5UO3PACWx4qoeXwIE9DeSVSjCyhY
         eneg==
X-Gm-Message-State: AOAM5332yqXjJhENs085Sb8N9sBdWoSABz1S/nsYWkPKNx3WyGM5pnde
        dmWGaD7ulVdyla6VNd1k1bd75A==
X-Google-Smtp-Source: ABdhPJxkJrJtaSOyTXzA8zW0V7qLT6cuFQyL+FUGsc5/cLMGVxoMFOJShXuR+F2LWbUj8PAuD022LQ==
X-Received: by 2002:a17:90a:ec13:: with SMTP id l19mr20004827pjy.81.1593525452289;
        Tue, 30 Jun 2020 06:57:32 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:4113:50ea:3eb3:a39b? ([2605:e000:100e:8c61:4113:50ea:3eb3:a39b])
        by smtp.gmail.com with ESMTPSA id m140sm2896019pfd.195.2020.06.30.06.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 06:57:31 -0700 (PDT)
Subject: Re: rename ->make_request_fn and move it to the
 block_device_operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
        drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org
References: <20200629193947.2705954-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd1443c0-be37-115b-1110-df6f0e661a50@kernel.dk>
Date:   Tue, 30 Jun 2020 07:57:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629193947.2705954-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/20 1:39 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series moves the make_request_fn method into block_device_operations
> with the much more descriptive ->submit_bio name.  It then also gives
> generic_make_request a more descriptive name, and further optimize the
> path to issue to blk-mq, removing the need for the direct_make_request
> bypass.

Looks good to me, and it's a nice cleanup as well. Applied.

-- 
Jens Axboe

