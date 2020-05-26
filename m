Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCEFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F966207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="SK/j8/sB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404089AbgEZUqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403895AbgEZUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:46:18 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907FEC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:46:17 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id f89so10164318qva.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=grxbOYNpOqxM7JP5izyFEjnzTirkS5+MQpdVDhkVv6s=;
        b=SK/j8/sBEAECUReC3/26qb5WYBKgJusmM4Bi0ypDM/Zohzcal6XacR3hCU754mhVtt
         E/5T4evfDsYZZhA9Ukgqn71YcrmQhklo/ouZh7stq4wCar8JR0/8bulocC1KxQxwmqk3
         DDp4qVL9jeoL9CohXbQhdUV/7gnfjQAqnufAqXJl5p1ZSF5aNK8Xc0r/slhNtqDf96z7
         RPlr9aVuPCFMtPtrndIWOuD20FaYhurPZLBbVrBcYvb4pSG0il+Tfmct4CaGWVG06Mc8
         HQMn28HfZJDmqy7v+pNpgsdZwJeG0NcquoKR0QGCX0ZPO54EuyQMmtsgW7QGQr8jRLP1
         hbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=grxbOYNpOqxM7JP5izyFEjnzTirkS5+MQpdVDhkVv6s=;
        b=O2liNjza7n+6xVtU0wUobxJxGVcTBJAeFJaFiY0C/hiUpR0lR0XvEGN9M1F0rg3HGd
         fm5W3Y4uYSRfQz/av4LhdN1ulN+lmaWAklREKBKwp6x/V8Ov0skzP71yJV7hwQjfnBpG
         JOD2iHQAckzADFKts/FV2kFmlDTsX308cDx+UsuxGDWFpvmXFFp0ADFu3x17fyAw4IF8
         bl/uMSikWbggRxZnPBpPBdrdhehbgB2zYK3YWDvarqhVMB1Nflz3RT93xsVikmLV3NNw
         C+aF8MdVSqwsjJPYLZPyIyEBr3STrt6X7m0Xjgb1PLdv2ANWP8ZwGoHMG73lxe/5cvTE
         Th7w==
X-Gm-Message-State: AOAM532xgnHH/xiwY0lpJwoS7PwoQUMcevg1TICjO8JzILJJNVQ3Jo+k
        3STrhxjRf2iKn3UuDgGSTUU4DwbclqE=
X-Google-Smtp-Source: ABdhPJw17yp0oF4CQ8J3+E7IWKM6xulkRGgACyehYTnS6SFzVDCaB8Ziav9WNv6ap066m6W/aJRucA==
X-Received: by 2002:a0c:ffc6:: with SMTP id h6mr8896151qvv.213.1590525976662;
        Tue, 26 May 2020 13:46:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2921])
        by smtp.gmail.com with ESMTPSA id n184sm658331qkf.0.2020.05.26.13.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 13:46:15 -0700 (PDT)
Date:   Tue, 26 May 2020 16:45:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 02/12] mm: allow read-ahead with IOCB_NOWAIT set
Message-ID: <20200526204552.GA6781@cmpxchg.org>
References: <20200526195123.29053-1-axboe@kernel.dk>
 <20200526195123.29053-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526195123.29053-3-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 01:51:13PM -0600, Jens Axboe wrote:
> The read-ahead shouldn't block, so allow it to be done even if
> IOCB_NOWAIT is set in the kiocb.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Looks reasonable. Especially after patch 1 - although it seems that
even before that, IOCB_NOWAIT could have occasionally ended up in
page_cache_async_readahead(), which isn't too different from the sync
variant except for the range calculations, and may have blocked on IO
submission in the past.
