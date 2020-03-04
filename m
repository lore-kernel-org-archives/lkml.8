Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A6DC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183352166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OjnU5uVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgCDSgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:36:39 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40557 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgCDSgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:36:38 -0500
Received: by mail-qk1-f194.google.com with SMTP id m2so2655778qka.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 10:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BTZGkR5oJbEVIGvYgx8yo/76DyQUafIlIN4hqBpP97M=;
        b=OjnU5uVrfIPDZs47K0nAL/eBE/nD5yfzsJrdujAUAEZcfHOxLjR2q5tjKvwGOuyzhL
         rATMCnRPtkUfYzns52w36tXGs6cNTeA1FUh/ZONJjzjtZ+j+VHppGG7UtNyPnksZ2ELF
         gYlNGHqJRU038L7+GoUXabYJbp71QMwWFYjAbDvn9nVuzPWDKp1N4Uc24GYh122RkZEJ
         aoP8icI/jaIPPbHA46okbonqnhBt5f6BkswyYCY6EDpcp6C1Iah2bk0degti+sWoU4Ah
         ut4X96UCj3ZocInP2p11AK+YF9jnpKNeTX1pVnmY/Qw1lXmMYHk4qnaKeAlmhmltptX7
         1+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BTZGkR5oJbEVIGvYgx8yo/76DyQUafIlIN4hqBpP97M=;
        b=QCGZ74iFDhjXIbeTkhOxDJg8nZQ6I+4P/PS5JBeTu5IrZcVWCFvtptPca500dVp3yU
         8Oj4Bw/1gnu1MEV4CXl7m8aUrHHoMyZPqA2ssl9uob71e0W9Nod27hkzMXLvM2KpHQfi
         sUsm/7gj34UZB/IwpjhOqiCLOe4UFWOXm13JI21lfLeZQi9PiUWx32e0qTDmWC77meRT
         92Ub85DS0Eb6DM2HFQ+q3UnhnY35z267NxzHpk3zLlRmk4x965+tEJMNIGrUX4z0unrq
         UxSzyD8/9mYemcqNODSQYRwfET0OqJxlXsms428hobJ5e3E1ZrDYoa6a4p5NQctLbrDX
         pj2w==
X-Gm-Message-State: ANhLgQ1y7yaJHpalngF9Ev2ZfP87qnaB4Ml/nOuCetS2ni71DubAP5Em
        y5ZNqIpuH2zjd0srYjpM8k1NKQ==
X-Google-Smtp-Source: ADFU+vv3IY/dEewbZ3PVzTR22dzcBCye571kokXxK2nB/kL3DOI7LkFGdmEpCqtLU9gFGOacLPQ1ng==
X-Received: by 2002:a05:620a:13a9:: with SMTP id m9mr4368318qki.359.1583346997748;
        Wed, 04 Mar 2020 10:36:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w13sm7822900qtn.83.2020.03.04.10.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 10:36:37 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9Ysm-0003Tw-QC; Wed, 04 Mar 2020 14:36:36 -0400
Date:   Wed, 4 Mar 2020 14:36:36 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/hns: fix spelling mistake "attatch" ->
 "attach"
Message-ID: <20200304183636.GA13359@ziepe.ca>
References: <20200304081045.81164-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304081045.81164-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 09:10:45AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
