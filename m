Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1002CC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 23:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA402070A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 23:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XjhPGZRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgEQXjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 19:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgEQXjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 19:39:35 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF1FC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 16:39:35 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id l1so6719283qtp.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uyEuxRNFXxTHy3jGi0sWbeje0rtWktiI61ku1YR5XQM=;
        b=XjhPGZRo0hy8lSmN30iv1FoYoHjLrpvvcHo2ygtee9JGSbbc23mYomHH8Z86s2tlCX
         gnqc2lLavwzbflQSUEgeR0JQ6AsJHCUplyGvNtfeCAEUoNY009++TEHuN2WdzM5d+FO9
         g7ahM11TlktabGO9d5LIGR3Rob5zJaeP4GICBIBjYyDxvVdMrkk0yheOmhFnAgWVy0x3
         iVRXrugQ4lAyw+MIKA3ccFfqbZI61v5/idR6NHYVq0uAcJ5ZGTd7PfCjj9+SK6zeJpBd
         rpeTm1mqNIgKMC3U+Mu/KfxUhILzYwZEgY2/4u76ovdTYjffdFJVBEo6KZThyEmnuSLD
         DqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uyEuxRNFXxTHy3jGi0sWbeje0rtWktiI61ku1YR5XQM=;
        b=HtAiJqjv4cveMyrCZP6fAN0KVBIaM+ExAxwA9c1Vtgh6Vdi+hqtFvDgetcnRC9fQc0
         pZAite9+q4m8R3wnJVv3r+BP+H3Y+2bhI/LcMSaDtI5z4JA1spYJypRj0u9cl2ur1yeS
         eX6GnjRJ841AEIJ3yFjlRyHQ0QUsKovjgxjYlVMURzEJj1QuWUwR2HI71aKN4tqJyKRr
         TtaV6b/dE5KEGPpGu2hapdXfxBJXH+oIZkqtpvcgkk/agokdhGr4bbRc2h2dj/qvR3TJ
         SrnSIwPuMWx1LT0FSQ2KQqIKgTOG/GWvq+/8OFEELDNUUNYh19JYEGg4xIEXz5/LTF+v
         ZIFA==
X-Gm-Message-State: AOAM531JBj30H8gGkxyvpxEF1s02bvvxE/rOaQeQnnLbvJ9pewWbWWy6
        p8lYufMfqSeG/rlMpKaiQhAtcw==
X-Google-Smtp-Source: ABdhPJywRpZiu8hlsjiCj7AHdvyj1Pqr2ufHjq9Exhw35hVjtBlDgjnAeGfjnWQZjfBVBC7HAqbrAg==
X-Received: by 2002:ac8:518f:: with SMTP id c15mr13340000qtn.142.1589758774534;
        Sun, 17 May 2020 16:39:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j45sm8412885qtk.14.2020.05.17.16.39.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 16:39:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jaSsX-0005YA-Ll; Sun, 17 May 2020 20:39:33 -0300
Date:   Sun, 17 May 2020 20:39:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     bvanassche@acm.org, dledford@redhat.com,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/srpt: Add a newline when printing parameter
 'srpt_service_guid' by sysfs
Message-ID: <20200517233933.GA21233@ziepe.ca>
References: <1589182629-27743-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589182629-27743-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 03:37:09PM +0800, Xiongfeng Wang wrote:
> When I cat module parameter 'srpt_service_guid', it displays as follows.
> It is better to add a newline for easy reading.
> 
> [root@hulk-202 ~]# cat /sys/module/ib_srpt/parameters/srpt_service_guid
> 0x0205cdfffe8346b9[root@hulk-202 ~]#
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
