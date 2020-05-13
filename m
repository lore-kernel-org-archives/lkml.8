Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19851C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F36206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aUSBikyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390205AbgEMSd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390090AbgEMSdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:33:25 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08321C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:33:25 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o19so644093qtr.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xs1Rbc0sVwF9w3UyHyn8OYWYVAdfi46D0k/6WarHd6s=;
        b=aUSBikyx3ZZZjAUP9xBMafNatt4u2G8oXkqwdomUF8xKAafhttQ5hx67DKwZR8SXtS
         2aMhBA92twz4NIIV0CT4d9OTZc7TKz/n2gQePBu/1Nsqvu7A3ER+xB24NICUz1Z05Y1w
         IkHuUPyNIOWiM0cnXbZR2jd9JXXyrJYBrBUnkBbXHOmv1hTPNByV8WDlWDCgB2qEPc7b
         NG0sNsl8Vjl9ifoAuKQ37Q9lD1PmFOcEwM2gnxZzwZxZc5xZxAAiSRn1qV1M0u/lHa+9
         MObFCoWznNMQIYLk9UtQ6Vh0u92lUctgX87BgCSKuV4on3XUrY/til6dYOM94rBIVGK+
         /Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xs1Rbc0sVwF9w3UyHyn8OYWYVAdfi46D0k/6WarHd6s=;
        b=mwUvPLoflMCBKYtBLM/pyxAbjHg9JtmXrj/r65sG2yJyF5OFYJy+yv1kOAMzyuwuUD
         1Y8ZrsY9gd/+rOHaHcrl2BW1CHtLafRfoAvAwI9vk0NRhlf/SJT6nzzeAhkdrBXFZVSL
         kGD0a4zYeh896SdPUozNGGOFNuFdNx+ReJ79PmNpPFb4nUhTBv4l4oi/d5MhUSdO7t6A
         ZMygwc5OIQt3x639bBDyYHpFqJ06HPVJWoeCyieM9X1EqiPYNDQIMCErWINduS40EJZy
         fO2+YKZsm9YKy3iXR48X+KJVd6Kkt7KxpRxr63X1XTfnGm4v8tXlPmj5495TWn/xDbpR
         kfLA==
X-Gm-Message-State: AOAM533x4RWNLUQwMqcRbtaM5GrWgJb5ML2YDuSRF02/Fh1Ks/WGVgtl
        b/crNbasFWSMGdH7lSl51uMTKA==
X-Google-Smtp-Source: ABdhPJwvNheeU/pOFKHMRfhN3cfzN0FWQmTqevBZUBBvthM90RXdsmP7A6v7lsW4PUWnbG/qsIXUyw==
X-Received: by 2002:ac8:518f:: with SMTP id c15mr495253qtn.142.1589394804216;
        Wed, 13 May 2020 11:33:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d142sm539286qkg.64.2020.05.13.11.33.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 11:33:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYwC3-0007bh-CZ; Wed, 13 May 2020 15:33:23 -0300
Date:   Wed, 13 May 2020 15:33:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/rdmavt: Replace zero-length array with flexible-array
Message-ID: <20200513183323.GA29202@ziepe.ca>
References: <20200507185342.GA14476@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507185342.GA14476@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:53:42PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/rdma/rdmavt_qp.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
