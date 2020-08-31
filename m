Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17357C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82C4214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dB+PP0hQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgHaPe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgHaPem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:34:42 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82095C061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:34:42 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so5030142qtg.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iAMba//TxGLvi6KI3uMlOLBajkxl3K8BsmpgOVTnGqo=;
        b=dB+PP0hQuSQ4ZE8AxL4ua78XiDhRqJG+WP1QgDTe/7c5TwCAzrVzmTcZGZSf6OldPO
         WhDPMFpalcHqA0Qy776ZtI2GCBleXbcTKWEeg+/P7tf79mIOdsk5KvaH56H6lMdNFH1G
         D+9ObvHehoceRDcgZ2Wet7VH/JvWFMPHflij80ZGdza/uj2fFTmVdwECA4UCfeOB/kMk
         IhyLkwb7T+jZ0oUjKnX/7V4TaRMIT34uyoJ0eclyBj4w5xoCFv2jzuc7R6I/oryZMf8x
         Cquly/geUjK1wp/F6ogLCRFLExLLC45L2AVHs95WZlyrIW7Cn3H8SqyD15vc9KOuN08M
         Ca9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iAMba//TxGLvi6KI3uMlOLBajkxl3K8BsmpgOVTnGqo=;
        b=re7mnbpXF7inaUGwvPRcHEuAs8AOwDMEZVi1UptblJxYOQonmv2r3WtmVSGmBVDnpy
         KkQwh6TnxOrRA390oQSc94muX4mWgIdR1CZU7dEwrmN39LngL5ZpGj8SS99xSZ2NR53s
         Oj+1TrPKjQ2Oy+eP2anMB0gPl62dz8DJUK9Isj06iDmcPqvO5Kwnv6soJIlE2zuMgfBx
         aM9PAI+55bYC6UANjr+1A6A9++fGdgU/FmX7bo9LwEXhY5ImZWXFJztsCY3X8WdIjxn7
         If1+Ff6ndclIu+SOWzLB96v85cC0b5AXDFp/reOZ8UsZWacK7Pa88B4+6y1IigPCfol5
         f8Gw==
X-Gm-Message-State: AOAM533iZpb27kaxgQKvYAq1pr6fp0HQ1Wn66cW13XY5EOfkQmX/7KYM
        ejeI4WTjn3cBB9AoiJnCVP9Mgw==
X-Google-Smtp-Source: ABdhPJxUTXkZenE7cBleXw6w+N0DnPg9wNGzSw1MSkAiXkrts3H3PIrQrcMTQoG+i4ivWGAfZjhflw==
X-Received: by 2002:ac8:72da:: with SMTP id o26mr1887711qtp.266.1598888081636;
        Mon, 31 Aug 2020 08:34:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x13sm10404428qts.23.2020.08.31.08.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 08:34:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kClpQ-002mCz-C7; Mon, 31 Aug 2020 12:34:40 -0300
Date:   Mon, 31 Aug 2020 12:34:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: remove unnecessary fallthrough usage
Message-ID: <20200831153440.GA24045@ziepe.ca>
References: <20200831153033.113952-1-cengiz@kernel.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831153033.113952-1-cengiz@kernel.wtf>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 06:30:34PM +0300, Cengiz Can wrote:
> Since /* fallthrough */ comments are deprecated[1], they are being replaced
> by new 'fallthrough' pseudo-keyword.
> 
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?\
>         highlight=fallthrough#implicit-switch-case-fall-through
> 
> This sometimes leads to unreachable code warnings by static analyzers,
> particularly in this case, Coverity Scanner. (CID 1466512)
> 
> Remove unnecessary 'fallthrough' keywords to prevent dead code
> warnings.
> 
> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> ---
>  drivers/infiniband/hw/qib/qib_mad.c | 2 --
>  1 file changed, 2 deletions(-)

Alex beat you to it:

https://patchwork.kernel.org/patch/11736039/

Thanks,
Jason
