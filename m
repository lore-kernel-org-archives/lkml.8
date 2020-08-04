Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D563C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E6F2206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596529918;
	bh=Mti/7aZFLcM2eMh2GD15qvO2ln1JYo2FO4GQKxBYbTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ke7OM50HfAXjNtbW/wGAaTk1mm/JTKS7aG91R+Af7VjCnoHpsww/+aVjKpqjJOyD2
	 BgW0zmCRpBWbazU9/CwrSTB7rQTCWv5d/8I6PrYV9oQuYCFygmKXjd5TXvIdKPBfVY
	 vWSnZvbq4q0wsWV4fUquiPkfqAtE2DTI0anwepIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgHDIb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:31:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44776 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHDIb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:31:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id l23so15501824edv.11;
        Tue, 04 Aug 2020 01:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E8OBarjLqjjgivNZT3rXljirLxP8pq8m7D6nGSrYCpM=;
        b=kdYZyLc9XQ/bPeEsWZl6RbKgriJ37M3ZiJU2no25o9mou5Pngm+ktDxj3jMORRaTLT
         t1zJOG/p+bN+qHWIo6vabN7hK5YOqZ+nPGY28M74DeDIZlpbJmGSqBQ8R4gJaFKyAD8A
         Mc7Bt3oYCYEu+QhWzGemkt3qcJsjJf3/6VE+8g+3VebrhNMLTY9aJXc8hIKMFqSdPO5M
         j5cu/ETsmulwg4jmgQwXgNR/IKHaGI41P+IQ3GS87urbtt90+OadAQWM/acVhp3PcS0M
         AI6Wsn+WDFgPIo9PLbXyjYVreE97APvUKTpjKRNrSHJB+V2pksjelGklm58lAKS5q+9f
         sRPA==
X-Gm-Message-State: AOAM5311TNFsBdKcY6UiVf0Y/5TaElbT+C0Q3Lc043nFmyNVNOd7o/8f
        lKv/HqgIYYOj9DVVjPq3Rbo=
X-Google-Smtp-Source: ABdhPJyKKgMB8aC8EF/PoUwW/9sPZSH5aZsosMxkY+PRMbWqoxonOx4ezAlmSY2+BFODp+VODFUFyg==
X-Received: by 2002:a50:da04:: with SMTP id z4mr18999648edj.375.1596529915221;
        Tue, 04 Aug 2020 01:31:55 -0700 (PDT)
Received: from kozik-lap ([194.230.155.117])
        by smtp.googlemail.com with ESMTPSA id by3sm18075154ejb.9.2020.08.04.01.31.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Aug 2020 01:31:54 -0700 (PDT)
Date:   Tue, 4 Aug 2020 10:31:52 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] memory: jz4780-nemc: Fix return value check in
 jz4780_nemc_probe()
Message-ID: <20200804083152.GA26771@kozik-lap>
References: <20200804082403.76297-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200804082403.76297-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 08:24:03AM +0000, Wei Yongjun wrote:
> In case of error, the function devm_ioremap() returns NULL pointer not
> ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.
> 
> Fixes: f046e4a3f0b9 ("memory: jz4780_nemc: Only request IO memory the driver will use")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/memory/jz4780-nemc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for the patch. The fix was already posted by Dan:
https://lore.kernel.org/lkml/20200803143607.GC346925@mwanda/

Best regards,
Krzysztof
