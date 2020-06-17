Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB482C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CACD21532
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WSLMCKM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFQSY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgFQSYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:24:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ED4C061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:24:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v24so1319957plo.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xvbq06xb8rcHDasNPx3O6hTHbslpfoh+riHjhZc++Ks=;
        b=WSLMCKM9ohtqSjMVQAbj8K1EAqWViQgK5qGsYkx3lqhl4SsxwYlRNFiMWoOk2e/+22
         zbFaMYhRiSmM6eMiCRg8pVMnNvBNXK4RWHAEyeSxi1yul8/hoKqqDvYCbK4MJMaUDIp8
         dPW7u7MTXphGIS/lQQK1TTO+1xUR9WezeUktbJn90euKvKx8q2ojaylC5nuI1hd4V9Vh
         wtgE1cx4svZZDf92ll3QVr+I4cvK9FEfJ17p/5L/qNhvs9lrf33cvYerJdTG+R9G5cGw
         v9PZqBGUocA8ZmLvw+z3PCKOn4YYh3CH80/GsBlNE3wl4MqQ/Wk7DLhl0/f5pMepE3sL
         y2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xvbq06xb8rcHDasNPx3O6hTHbslpfoh+riHjhZc++Ks=;
        b=WKBTKJKsKZbqr5dX4vnLr7/XZ+A1Fct+H3GhzQy0FIZb7NwIVk57NRLmrCtkxud7HP
         hyNFgFUpx29LNw8JwqMbJggT2UwEJd8hjOEgJGBeARAj93yfLH04quY5nlfB9VE/G8wA
         YZsrqjIDmVgYg1csaxbuk22brkVSUs3d566bVBNAYTFgq8jRzeTwt95EE7zrxKRXu5yk
         QTCZfWvrcR/Fxl6yjtMXhepeOHhdC+X79JzEYu05EEhk11fWdBg8pYmFch0l/uXDYO2N
         KPevswV3kCB0FZzGgji2qLzAop+0fmoffYIWePkQHkE2bRl8+Dbnx1rkWBUsGsJLgEtH
         fQug==
X-Gm-Message-State: AOAM532cmpotXuH03o+p7eA2Vf9trxhtLCw/ooqLyS/bwQzfa7fYh/3l
        RMV049qu4WjOKD3dlxrJNEnScA==
X-Google-Smtp-Source: ABdhPJx+VO5TVkCBs3OrjZcmKB/+bOvx9qgai2d0KOQdclTJeyiQZlq7//E9CmjSCqRbW8mzyMdeUA==
X-Received: by 2002:a17:90a:df0c:: with SMTP id gp12mr363670pjb.148.1592418252950;
        Wed, 17 Jun 2020 11:24:12 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id h8sm516409pfo.67.2020.06.17.11.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 11:24:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jlcjK-009iJG-KI; Wed, 17 Jun 2020 15:24:10 -0300
Date:   Wed, 17 Jun 2020 15:24:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Kaike Wan <kaike.wan@intel.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH v3] IB/sa: Resolving use-after-free in ib_nl_send_msg
Message-ID: <20200617182410.GK6578@ziepe.ca>
References: <1591627576-920-1-git-send-email-divya.indi@oracle.com>
 <1591627576-920-2-git-send-email-divya.indi@oracle.com>
 <20200609070026.GJ164174@unreal>
 <ee7139ff-465e-6c43-1b55-eab502044e0f@oracle.com>
 <20200614064156.GB2132762@unreal>
 <09bbe749-7eb2-7caa-71a9-3ead4e51e5ed@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09bbe749-7eb2-7caa-71a9-3ead4e51e5ed@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:56:53AM -0700, Divya Indi wrote:
> The other option might be to use GFP_NOWAIT conditionally ie
> (only use GFP_NOWAIT when GFP_ATOMIC is not specified in gfp_mask else
> use GFP_ATOMIC). Eventual goal being to not have a blocking memory allocation.

This is probably safest for now, unless you can audit all callers and
see if they can switch to GFP_NOWAIT as well

Jason
