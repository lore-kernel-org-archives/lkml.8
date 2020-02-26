Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D16C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3371820658
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 23:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgBZXeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 18:34:01 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42950 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZXeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:34:00 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so1163848otd.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:33:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E9CsIeVCqDRp047URh32XSYQmYRUen+22sX2IooW5EM=;
        b=peQl7KYCk5KXyZKaoVdXm9L6355mFgI4gG676D+QMOf3YBJPeqDs/74eNuzjiuj0HR
         7EJO+uG/eUUuja2K8+H8boOq8SxxKS2YWnzWdJnGU1VPX0xdoZg/BVbO5GQZfJ63QA3g
         Zwim5FWHb4v/Dy03uQU74dwiDR1ei9c5WhTkjy6oQGnvHkEmBk2jALqWwVHkaOmikuvg
         rmQ2FkOP1Hvla1PeSmhLdNhyRmvf0UBWIgvMbW1OxtVnvxwjhP2GxO6r0GoyWPuZ2DXc
         3Ikh0kneCX2wtnpTX3QTQXPPXQMsHlcO07V1NxQSnNk5luEEwrdhw25R46UXLpGP9gyY
         adDQ==
X-Gm-Message-State: APjAAAWTXDLln4jnqnMnqwvL+H3J27P08r6+1jrLCcm74NtrYxZRusIj
        8b1Cg1qQe1EQ2QzOY4vca+U=
X-Google-Smtp-Source: APXvYqy6gtVO8C9So5Lp6miPMAu8Syj4Y8v6QvC1U1iT1SAhjKYksxQym5vUPzUKa2ZvbAm6L0C8Zw==
X-Received: by 2002:a9d:7a96:: with SMTP id l22mr1017139otn.217.1582760038567;
        Wed, 26 Feb 2020 15:33:58 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id v14sm1309886oto.16.2020.02.26.15.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 15:33:57 -0800 (PST)
Subject: Re: [PATCH v11 8/9] nvmet-passthru: Add enable/disable helpers
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-9-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <96234649-fbc1-fb56-54d8-2f73dc455ffd@grimberg.me>
Date:   Wed, 26 Feb 2020 15:33:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200220203652.26734-9-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +	if (subsys->ver < NVME_VS(1, 2, 1)) {
> +		pr_warn("nvme controller version is too old: %d.%d.%d, advertising 1.2.1\n",
> +			(int)NVME_MAJOR(subsys->ver),
> +			(int)NVME_MINOR(subsys->ver),
> +			(int)NVME_TERTIARY(subsys->ver));
> +		subsys->ver = NVME_VS(1, 2, 1);

Umm.. is this OK? do we implement the mandatory 1.2.1 features on behalf
of the passthru device?

> +	}
> +
> +	mutex_unlock(&subsys->lock);
> +	return 0;
> +
> +out_put_ctrl:
> +	nvme_put_ctrl(ctrl);
> +out_unlock:
> +	mutex_unlock(&subsys->lock);
> +	return ret;
> +}
> +
> +static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
> +{
> +	if (subsys->passthru_ctrl) {
> +		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
> +		nvme_put_ctrl(subsys->passthru_ctrl);
> +	}
> +	subsys->passthru_ctrl = NULL;
> +	subsys->ver = NVMET_DEFAULT_VS;
> +}

Isn't it strange that a subsystem changes its version in its lifetime?

> +
> +void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
> +{
> +	mutex_lock(&subsys->lock);
> +	__nvmet_passthru_ctrl_disable(subsys);
> +	mutex_unlock(&subsys->lock);
> +}
> +
> +void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
> +{
> +	mutex_lock(&subsys->lock);
> +	__nvmet_passthru_ctrl_disable(subsys);
> +	kfree(subsys->passthru_ctrl_path);
> +	mutex_unlock(&subsys->lock);

Nit, any reason why the free is in the mutex?
