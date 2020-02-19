Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57626C18E00
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A901207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N6NW/wD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgBSUq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:46:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39514 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:46:27 -0500
Received: by mail-qt1-f196.google.com with SMTP id c5so1276449qtj.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 12:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mMv6ZohV9vWAZb5AuOsCpS0uJmYFOu3/CP4E2vVtix4=;
        b=N6NW/wD1u4rOYJ2axf80jZwf6dgLLQtukDs212ABaUwHuneq2HjTofcNZB8Qwe7vMw
         EaQBe9iJKqvcgZHcTlJg1g+7AFYYjV4oNP4u9SLmmGXNrNsSjtdAmiF2O2tNQMVsu5LW
         kpF1xy6winrMdghU4cxYwijY9p2j4HKt9jeQvSbIfTG4TDbXHyN0XDVmivl6GmkKV4yb
         RZ8CLE9PZ99fPZ6a7zmOQOdQem9KRBWCwETJVaauoq3kmY2izRFufyiWfXkYTNYU6tbg
         Qc+57B4WXE6NvXLBRrnSZ4rBKt7jaYbjU/KwN4g026k+yqRIXklYForrGBHIXXbjLKjH
         7JCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mMv6ZohV9vWAZb5AuOsCpS0uJmYFOu3/CP4E2vVtix4=;
        b=cwT65doJPwRyMjwqzrCqCyXyOgfnVmCww3QgvbLhfQSIL6HVP9vNdDeyjE2JQGwXnW
         Fsl1mlDZohcNVHPzskhKi8DinsLf9onMZ/ePyfZUAy9TmbrVUBa0c59jgUo3CRA3Q6t9
         pMQBM3OWMIcwg/EkCAari9FJmmz0axA1UOlfexDhJUgo8dhzN7ce4SmLvMC4rVlayiDH
         p6+N1JSii3g+oknZNrT2mof51OF47DwcuI5JpGzEe5vmRspX1jxG/RqsNyyeAdZdnXfx
         u8lME32WLo7zrIWKDy0RnsQ7rh7LSlDmCv5SvrZGh7SsbR222VcyPMfpW2Mg+35AFi2G
         blYg==
X-Gm-Message-State: APjAAAWKdEjB1++QxHYPHPzqFUz0ga3mMZn1k0o7DSaPM9QEivtMOXZ4
        WHnI1MOL+0Jw466O1TBjp70l8w==
X-Google-Smtp-Source: APXvYqwPkUdYKUhN3C1ThTgi9PBRnyem/7wRKpwkfyPxTs8WwuWIcvbA7vvFmJ/ZXusMp2MS8tHbiQ==
X-Received: by 2002:ac8:3aa6:: with SMTP id x35mr7267344qte.38.1582145186541;
        Wed, 19 Feb 2020 12:46:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h20sm456455qkk.64.2020.02.19.12.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 12:46:26 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4WEj-0003Mn-Lz; Wed, 19 Feb 2020 16:46:25 -0400
Date:   Wed, 19 Feb 2020 16:46:25 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] RDMA/core: Fix use of logical OR in get_new_pps
Message-ID: <20200219204625.GA12915@ziepe.ca>
References: <20200217204318.13609-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217204318.13609-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 01:43:18PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> ../drivers/infiniband/core/security.c:351:41: warning: converting the
> enum constant to a boolean [-Wint-in-bool-context]
>         if (!(qp_attr_mask & (IB_QP_PKEY_INDEX || IB_QP_PORT)) && qp_pps) {
>                                                ^
> 1 warning generated.
> 
> A bitwise OR should have been used instead.
> 
> Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in get_pkey_idx_qp_list")
> Link: https://github.com/ClangBuiltLinux/linux/issues/889
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
