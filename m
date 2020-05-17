Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEF3C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 23:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FDB2070A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 23:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VPQBn9NK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgEQXhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 19:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgEQXhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 19:37:16 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD858C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 16:37:15 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id g20so3897711qvb.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 16:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rhcSID2j+mMPo1eCjHjm9iiZ0d4LAEEpHSI1GPqYg/Y=;
        b=VPQBn9NKgYJao0abn/rmhTzV2pVCRd7KVHo+PXFXelPO8YqmC5Um0O/6vKytmD0FF0
         ir2c2igbnvp7/d0phkK3NqMtZRubXq+Wq1w+UIhEdclCh1mgzAJtqTwKWC5syrWwhtEt
         6kzH2KL3WC9gwow8rKUnppmaUHqx3m0j/MZiwkYRbUlgL5heUwlY7tQr8bF+6upsBbx9
         tssKr8gDqi2alvjGnp7ka2nBYxI76XXAcGWA3zJcl4TmSYWxhryFfkZxxXRZryjnwLxc
         4sqnmxVnAZLpRQSRz6i/LWHjKdaTH53G6zIuqEbQqqS7/vFRwblwGEWE444PLSNTahJ6
         D8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rhcSID2j+mMPo1eCjHjm9iiZ0d4LAEEpHSI1GPqYg/Y=;
        b=OkkCF3wJ4+0nOAwqnyWE4UUYKhwScva8o6fY+TTf25Nx4eEgtS2kGLSMwk8zNJ6Wol
         fqopxCiYPWEh0vv7UETKAHAs71lz+U4Cj2HczIsabdjy87/YjqcrZrxOYYH80FDX//RL
         CKBOs/nOXz+diZIKOCX0ORd2KfSV2oHZFbPVoQr1DjqB/GEDhiOyw+VSmxZ34fjaxeQu
         UGpdD+BqeNmBIjMy+Rl9gZu51Mx7Dm9wIiOpRbCXkH/RgKCTcDmBMA6CZLDOpnvCgvte
         7Fl0vN23/yOF5RCk+AoL5Hqze9P3iQRegN0r/zIdhzI9WKtcUQBqJ+PillPDgkgfesAG
         LvAg==
X-Gm-Message-State: AOAM532Sz8rnSR2UcMybHX+gP2SyH9N4gHkNsqNxq/Q6HAG5CJF5jNkN
        R2Uxy7i6NSR15bjcAuT3urDWfp+WKks=
X-Google-Smtp-Source: ABdhPJw0H2ewSyNDCoxPXBVL5RnbFsD7L6rVwUKivw0FvSstFquyCJKeBw1QgvPuOD1mRaziZuGd1w==
X-Received: by 2002:a0c:8d48:: with SMTP id s8mr13001802qvb.114.1589758635034;
        Sun, 17 May 2020 16:37:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o16sm7213457qko.38.2020.05.17.16.37.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 16:37:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jaSqH-0005Tj-Mb; Sun, 17 May 2020 20:37:13 -0300
Date:   Sun, 17 May 2020 20:37:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Sagi Grimberg <sagi@rimberg.me>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v1 00/10] Enable asynchronous event FD per
 object
Message-ID: <20200517233713.GA20969@ziepe.ca>
References: <20200506082444.14502-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506082444.14502-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 11:24:34AM +0300, Leon Romanovsky wrote:

>   RDMA/core: Consolidate ib_create_srq flows
>   IB/uverbs: Cleanup wq/srq context usage from uverbs layer
>   IB/uverbs: Fix create WQ to use the given user handle

I took these small fixed to for-next, the others need some minor
adjusting

Thanks,
Jason
