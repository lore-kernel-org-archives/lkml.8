Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CC9C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559D920801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q6Gb/+jQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgBTRPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:15:24 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:47076 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgBTRPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:15:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id u124so4232377qkh.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 09:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XGoWjHPgm7tYvm2Vr3vpXC/9J65LRE8w5Rx36wd6wFg=;
        b=Q6Gb/+jQmhOKFHjAFvws2bxaL02WMg+hJvhLUyE3nTmx1ATRS/ZSnlXsIyYcjwY9Ud
         +AsjzyxxMROwa9HzIlQG01ZQ8S6mVEMxzuf7YseS7kdH/r0OzQp9MJJob3E+r1WFy4YD
         IkjGvqK/Qh3tSsHYoA/a0afZHdAcSkF/3DN8e2BPh2wLd+m0qzl9xhTZdWeZ3Fo32Y25
         kXnSGLF0YxXROaZnXOdVu3BYbr1Gw1k3zDV4tpoIuUlpybAzMwHFMvjevusMr5Mvn4p+
         ZYzFsUlKhMusKijEst6nOOou5aF7/4sK3ADGy9UIlA9a3nMi/Gye+hSGcxYaKrKYFeVo
         Eslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XGoWjHPgm7tYvm2Vr3vpXC/9J65LRE8w5Rx36wd6wFg=;
        b=Y9bEplq8Af1NsnkJTvLK3mezB6gSx6HlcQWTkp0MdB0XDCGpZAedpR+rfu4qXzDfIO
         bXJfuTYsCAmzYL32Kp94AWXR3cW9w6adAQFZsy4GoDz+ywhuaDxIAc0gh+xuBkikIxx+
         XP/aN/4hLP0dU0gUsqgMdTxDErZfCDPryeKAnPPDaZsVmSHII0fRmAn1ODCh6JDJOkcU
         7ddvTrhRbIDMH/JOhhoQWsTp8jFqM6mYAM2KmXfiQMLBIR0IqMbFqUDfkxwBMLChr1Z2
         8+hYzy+8GG2KW9JXakrQNZ6X/nIGopvb4+vIDrHrgk5POTVheAqEImQ+ILFDQsJFgIO+
         CUaw==
X-Gm-Message-State: APjAAAUb/vRqLbSAccdSKUlZkvgMA827hD3/bKrryaoeu4tHIguuzuWN
        AHv2f4O098zOazTTlZoix+ltGQ==
X-Google-Smtp-Source: APXvYqwj67jVVxTQzQgtH21G/bluLOMGfigpHMpUuYK8XDtWxEnymK5NBtVn/Nr3pqzVmdR5UGqsCA==
X-Received: by 2002:a37:aa8f:: with SMTP id t137mr28678803qke.61.1582218922935;
        Thu, 20 Feb 2020 09:15:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id y197sm94295qka.65.2020.02.20.09.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 09:15:22 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4pQ1-00065O-Sw; Thu, 20 Feb 2020 13:15:21 -0400
Date:   Thu, 20 Feb 2020 13:15:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/hns: fix spelling mistake: "attatch" ->
 "attach"
Message-ID: <20200220171521.GA23368@ziepe.ca>
References: <20200214003338.6573-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214003338.6573-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 12:33:38AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
