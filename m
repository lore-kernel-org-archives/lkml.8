Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBB9C2D0ED
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4313F20716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VVcMQGZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgC1MkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:40:06 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37795 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgC1MkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 08:40:05 -0400
Received: by mail-qv1-f67.google.com with SMTP id n1so6385154qvz.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 05:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gyT8UFpGVb1UsWUbztnzGfKA/Wy/MFiEoclJbgrK4qI=;
        b=VVcMQGZgyOa+GvJ3OeqZlGQUg3Q5tO04sVFu6Z1wm1UW0Z3KTFMnpTLTI5Yy5fxUGX
         Mo6KvBsJ4j7n3e+qxKpB+lAQ2JJnVF1F1Aci4W+VEjVs5DUbLlyp6XUjVtTR2auSdjWb
         JcYKXfoSgAu0QAtPAVY7nV0yx5lM7ji5al5Bhj5E8wdXj42h4wz1G4kK4Jyn4bOCmLGq
         7w8KAqvI1Qnm1ATxOuH8uryM5EC1eU3ucnqpotpMXHf8YRgRwu/Re5Xkne8if+bT7ETQ
         kH6qYI2FNlXPT+IsKnnt8x9ZnTl2szm4c+v4mv8ad5L8GJRqCw+hyHhDqbm/PQN/1DH3
         rmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gyT8UFpGVb1UsWUbztnzGfKA/Wy/MFiEoclJbgrK4qI=;
        b=JDH2h2ln8vtOiCzj3hQrNe3GGphs9kzelI2aLSn5Uastlut2EfIXsZ9q5tLJXs8511
         AslpBx8RsOGgupnCn+V0En2l8iuqk+YqQZncHhtcBxjyZ+T+RrzMffsZ2VyKe0X8zFUP
         kajlibvrh92MReDVOGXfaJiuADrXzd9MX/zrus3EKqG9aebBIp7sHvFnMDYvS9hZlH/I
         htq6Y4sOzAbRLaOjyMNaNf+djUIX5RNEQODXytIDNGk0zd4Vwyy11unX/vB3Q8O+6SBj
         LbQJZrpQrkgVSRilY0/QDjmKP0ZJop4ExGh+1GMxJPnICflGwxagTepY069RDC5o6kMr
         NUSg==
X-Gm-Message-State: ANhLgQ0rH5+Jh1IqxDGecCTixRh+/VOJRvAlP1YalEXXjJK9s1Zf9mgA
        m79h6Ff+0+1HfYw7fuHHyRhXtw==
X-Google-Smtp-Source: ADFU+vtVpk7Wds9Sr8Z/70SEBNVexp3x5QFsFGP/wcY3iBT0ao9r2FOjzqxZliOmgJfRU1Lqt734Sw==
X-Received: by 2002:a05:6214:70e:: with SMTP id b14mr3634409qvz.246.1585399204187;
        Sat, 28 Mar 2020 05:40:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o81sm5958528qke.24.2020.03.28.05.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 05:40:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jIAks-0006TL-S7; Sat, 28 Mar 2020 09:40:02 -0300
Date:   Sat, 28 Mar 2020 09:40:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     liweihang <liweihang@huawei.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        oulijun <oulijun@huawei.com>,
        "Huwei (Xavier)" <huwei87@hisilicon.com>,
        Doug Ledford <dledford@redhat.com>,
        "wangxi (M)" <wangxi11@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] RDMA/hns: Fix uninitialized variable bug
Message-ID: <20200328124002.GB20941@ziepe.ca>
References: <20200327193142.GA32547@embeddedor>
 <B82435381E3B2943AA4D2826ADEF0B3A022B739C@DGGEML502-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B82435381E3B2943AA4D2826ADEF0B3A022B739C@DGGEML502-MBS.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 02:15:14AM +0000, liweihang wrote:
> On 2020/3/28 3:28, Gustavo A. R. Silva wrote:
> > There is a potential execution path in which variable *ret* is returned
> > without being properly initialized, previously.
> > 
> > Fix this by initializing variable *ret* to -ENODEV.
> > 
> > Addresses-Coverity-ID: 1491917 ("Uninitialized scalar variable")
> > Fixes: 2f49de21f3e9 ("RDMA/hns: Optimize mhop get flow for multi-hop addressing")
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >  drivers/infiniband/hw/hns/hns_roce_hem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
> > index c96378718f88..3fd8100c2b56 100644
> > +++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
> > @@ -603,7 +603,7 @@ static int set_mhop_hem(struct hns_roce_dev *hr_dev,
> >  {
> >  	struct ib_device *ibdev = &hr_dev->ib_dev;
> >  	int step_idx;
> > -	int ret;
> > +	int ret = -ENODEV;
> >  
> >  	if (index->inited & HEM_INDEX_L0) {
> >  		ret = hr_dev->hw->set_hem(hr_dev, table, obj, 0);
> > 
> 
> Hi Gustavo,
> 
> Thanks for your modification. But I check the code and I think "ret"
> should be initialized to 0, which means no need to set hem and it is
> not an error.

Weihang, thank you for checking, I would have taken it without your remarks :)

Jason
