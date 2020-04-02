Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5D7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9615C206F8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389630AbgDBWOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 18:14:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34952 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389402AbgDBWOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 18:14:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id i19so5517340wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 15:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fPUE5Ux6t1ZmXWbn6Wue8riIBLccyrWYZrJD4d05O54=;
        b=YHfxXZ/YE9EU4X7s6JYTgyhLrfTyBHfxbtnZSWUPHNdkdHqXkwtdghjziXnJmBB9rs
         JIDTR+hNOzCieeL3RyQLhLsFePR04J4rMpOcQSMkDIEZmqvpqTDxevq4YYWsZSBO0l4l
         0c2S39JqfLaQu9rV8NXZHMM1En04RL+0Jx5qcuWBsJfkgxHLYYcyMLZieKb1MFKvQvqu
         neGsqQe8XALRgu50eXjyhQlF2A2PUrdaV8CpjfdenLEy9KFpL2Bw4FuLp0XHrWLgrphr
         a0nruGn4/40FlcuOq1JQEWOg2XSgtQtnisNiCfZWmxyE9NzkCuQCs47sURiBu+bzXMJg
         Z4Ww==
X-Gm-Message-State: AGi0PuakBFXy1OPtbnaenb1+ESo0aJHJBWgMpCDqQxvI5Shm/Y4O2pJO
        Mnha4prgZMuK9qFJdmu2tN0yMxDN
X-Google-Smtp-Source: APiQypI/XnKREPGfpJgJh9NMJG3NsY/n4DXqC18f+gjOyWgDV3yrb3YLGJymAcfZxGyGKJi3hKWQ8A==
X-Received: by 2002:a1c:f213:: with SMTP id s19mr5375822wmc.116.1585865669036;
        Thu, 02 Apr 2020 15:14:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9069:e334:a021:3782? ([2601:647:4802:9070:9069:e334:a021:3782])
        by smtp.gmail.com with ESMTPSA id n2sm9516018wro.25.2020.04.02.15.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 15:14:28 -0700 (PDT)
Subject: Re: [PATCH] nvmet: add revalidation support to bdev and file backed
 namespaces
To:     Anthony Iliopoulos <ailiop@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200402193052.19935-1-ailiop@suse.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d6a3bf25-70c1-2501-2e8f-222135ebe9b8@grimberg.me>
Date:   Thu, 2 Apr 2020 15:14:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200402193052.19935-1-ailiop@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
> +{
> +	loff_t size;
> +
> +	size = i_size_read(ns->bdev->bd_inode);
> +
> +	if (ns->size != size)
> +		ns->size = size;

Why is the if useful?

> +}
> +
>   static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
>   {
>   	u16 status = NVME_SC_SUCCESS;
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index cd5670b83118..c102437db72a 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -80,6 +80,20 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>   	return ret;
>   }
>   
> +void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
> +{
> +	struct kstat stat;
> +
> +	if (!ns->file)
> +		return;

When is !ns->file expected?
