Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A310C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373652083E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oHHYVEc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgG0O7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgG0O67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:58:59 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03EBC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:58:59 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id h7so15464237qkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TkvFuceN5jtaSzIFRaFmMTmsAfPlIWdDO7sdSoKaSpw=;
        b=oHHYVEc5gtscdX6oNEqwGKJG71QcSo0Wh3LdkVEHmkW/JhR2KSGRrVQR3lciUpmSHa
         v0Vwe8Zww3VELryrRRUhxZw8CIuBi1dqVQKBWhzwOWdakmgLkHTr3MPIf2grpGg8D1MS
         6HpaR11uS9JC0rXDm+RDhqY++zWpcCC558aFPJdBAmeImhDoEIEPpRWFlFyqjzGyQFK2
         FDxLPsvTR/dqRoWxTHaXzzBqJXudlj4Ss2aRnqY2RwlnyHChjMwWiqsZSFIAQNNs+y9X
         qdlOoDgCXwP+pgOsXWkBkRuI9YdxRiTDOvL9/vpvKswnsCXZCKoxfa2xuL9asF3wBz13
         pyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TkvFuceN5jtaSzIFRaFmMTmsAfPlIWdDO7sdSoKaSpw=;
        b=mrnJobN/YO1iUnC6e+tS+KGhDrhShv/uF2DUfcoilBMt8ssCAb1pIPCrKT3UARba6Q
         zXNg32ntAVlOWkKVM9oQoOQCE2mDq6fE9xoToeoRAk9mSe3HvRADj3e+siRded/0lpup
         VpJZbFHk0oew6J3hcVxk7z2+IkykrZn541xogJ6GKG6XsrIqKXHCeUmuwUyEDQ92C4Nh
         V0XhLDDfQiW4jE2CJr92kwrf9QJMnmBiW1VAjN6gYWcufSax1z7wyQzKIfVbQ1lfxLit
         E+UKtbQHk8TaOCycP2iWDi/3NvokaUTH4p6Z7E9lMJzNim0bgJ5Y7FLF59IaEhIcNpxR
         349A==
X-Gm-Message-State: AOAM530gHrX7CDq/y/+fzjNuoscPF9xHmauaOcpZuKguN+nz0PzgLcxp
        8wmVOW9BMD3VOgKrcJdzdpk+Xw==
X-Google-Smtp-Source: ABdhPJxmJKGTk9LAqszhQ5uIMsZwDdgfTOhelOUomNZVFWhdcCDjxAJHzaA+yfpoXRafzi6fjCqj2g==
X-Received: by 2002:a05:620a:142:: with SMTP id e2mr22636849qkn.418.1595861938755;
        Mon, 27 Jul 2020 07:58:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g21sm7306628qts.18.2020.07.27.07.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 07:58:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k04ae-000Cmh-Vl; Mon, 27 Jul 2020 11:58:56 -0300
Date:   Mon, 27 Jul 2020 11:58:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH v2] infiniband: Prevent
 uninit-value in ucma_accept()
Message-ID: <20200727145856.GA24045@ziepe.ca>
References: <20200725220203.624557-1-yepeilin.cs@gmail.com>
 <20200726022716.635727-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726022716.635727-1-yepeilin.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 10:27:16PM -0400, Peilin Ye wrote:
> ucma_accept() is reading uninitialized memory when `in_len` is
> less than `offsetof(struct rdma_ucm_accept, ece)`. Fix it.
> 
> Reported-and-tested-by: syzbot+086ab5ca9eafd2379aa6@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=0bce3bb68cb383fce92f78444e3ef77c764b60ad
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
> Change in v2:
>     - syzbot has reported this bug as "KMSAN: uninit-value in xa_load".
>       Add "Reported-and-tested-by:" and "Link:" tags for it.
> 
>  drivers/infiniband/core/ucma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Already fixed:

https://lore.kernel.org/r/0-v1-d5b86dab17dc+28c25-ucma_syz_min_jgg@nvidia.com

Jason
