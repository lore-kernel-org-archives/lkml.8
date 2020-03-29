Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F35C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 14:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D9A206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 14:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="moQTc+GE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgC2ORN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 10:17:13 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45075 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgC2ORM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 10:17:12 -0400
Received: by mail-qk1-f196.google.com with SMTP id c145so16184746qke.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J7kwXlsbPgsaF/1H7oDNGC6sTEozUX2jrMBobuQbfQs=;
        b=moQTc+GEUyEhv1/EsHg5b1SaNqXPJ3iUkV1W6PnmiwO0Bwll9aB648ukuvfdi7hoPB
         jlFQz2Z1e7ZUTvGw5hvcKIWprzoEgNtMc2k6qsMsDcScfPB1DlN17k3yzBNzd+kLu4Eq
         QFfG22C/6y0kT3UC6wg7EO5qe4L7pZ2nWFr+BXsEQeJIaSm4HAc2vHZ4qKatg4rMlzW2
         t4LJdjIt7EMNezeXtr0k2JV2C7stxBJArrc/f/gYT61NE0SWTrgZSEvTDHqI9l2ndD9j
         gb87fYC4enERFUO/vwKU+QMABL61xkJMJXGD57NYYjrk40+3+6iSqV02CPWRGLHvQbd7
         MATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J7kwXlsbPgsaF/1H7oDNGC6sTEozUX2jrMBobuQbfQs=;
        b=YiX6KLDwlFspf5GTYtPkBVJKky0A3m6qZjxwJnD9Qoq2n406TsJ7hR9UolxJwsXfWa
         7XO7HkcDWGe2bCT+yM0sB7pRG+/aJWWMTgiHT0snLUD8xM8qST+2TE2Q+FbJ0+ITOODS
         Awy9Cwqn/cZYuDallvndutD3gziVa4wsvlRReNxdYHC+fqNvxylKZAMgmo9m/XvdxN/C
         Qe1KTsh+cz8zuE/dcQ8gCeLh742dmKK96itUFcCjW/W7a1B+1M2sJKzHeo1A74nzuk6K
         AzvxusfrQGGaKBnKOcbgm/nsLRAZYeiDZBizol4zg7KLFQabRy+/GF2WIYDe1a4xdSvI
         6gBA==
X-Gm-Message-State: ANhLgQ3gnkk6SYM8HcrvQdmP5pmEj6h1Cl0/CZnbKLAo1P6WGQZgkYGr
        Z3r1wfNTb9MCFiFGqegDhVRyuA==
X-Google-Smtp-Source: ADFU+vsJOpDt21YEkie2NVYFJBRBjfE5TOFEA2zgyhEUFzbEjULkhVPErB0d/YM8U2/X84FdHF82Qg==
X-Received: by 2002:a37:bc81:: with SMTP id m123mr7567773qkf.319.1585491431782;
        Sun, 29 Mar 2020 07:17:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id q34sm8883588qtb.41.2020.03.29.07.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 07:17:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jIYkQ-0000OJ-IL; Sun, 29 Mar 2020 11:17:10 -0300
Date:   Sun, 29 Mar 2020 11:17:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     George Spelvin <lkml@sdf.org>
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/50] IB/qib: Delete struct qib_ivdev.qp_rnd
Message-ID: <20200329141710.GE20941@ziepe.ca>
References: <202003281643.02SGh6eG002694@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003281643.02SGh6eG002694@sdf.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 12:55:00PM -0400, George Spelvin wrote:
> I was checking the field to see if it needed the full
> get_random_bytes() and discovered it's unused.
> 
> Only compile-tested, as I don't have the hardware, but
> I'm still pretty confident.
> 
> Signed-off-by: George Spelvin <lkml@sdf.org>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: linux-rdma@vger.kernel.org
> ---
>  drivers/infiniband/hw/qib/qib_verbs.c | 2 --
>  drivers/infiniband/hw/qib/qib_verbs.h | 1 -
>  2 files changed, 3 deletions(-)

You need to do a better job sending your patches, this is not
threaded, and not cc'd to linux-rdma, so it doesn't show in the
patchworks.

In general, do not send such large series for things that are not
connected. Send small cleanups like this properly and directly so they
can be applied.

I took care of it this time, so applied to the rdma tree as it is
obviously correct.

Thanks,
Jason
