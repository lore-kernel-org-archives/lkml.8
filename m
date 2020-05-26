Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42481C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102C120C56
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="rFVM4x23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391184AbgEZWBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389442AbgEZWBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:01:00 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F4DC03E96E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:01:00 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w3so16897047qkb.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZwwzxO17+0f92xu+E65BbQScQx/AP5VwvKaIskut9zM=;
        b=rFVM4x23qV4X2fbjmMbDbfW8BE//O63dwEI83+nf9RiCn82u2vgmzBe6uxrjX9diHX
         Xis+D4mIpGZRy+VlXibr+nvav1bnmleWViRSlsBZbD6wO47YqoG+xJKzT0DyENfn2Cf3
         6eH0qeuBR+szG69rgDH9mR+95W9t/Easz1XIfT4+usugiBihB/u2LH+4KhvPlPSr6Pl2
         aJHuPtBN+BCaPr1W1q6XU+kLH6gjPHrEtOY6dFLu/uf9aVt8HRLBgSZGW2/0FvllyUIc
         dOIHqAcLpDPd/13wn4sX0h2UaZVOwpuQqu30SmaFsjuZkRUvfkp8ypGkNZ9dK7vl6fsD
         RWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZwwzxO17+0f92xu+E65BbQScQx/AP5VwvKaIskut9zM=;
        b=JbsegHLaojGJrP0gMzUwV0hUYl7CsJ8P57gMqvXn2Q/H37/NeIN2g8ssVQk+Aefi+e
         GmsGEYYNTyOCtutFpm9W5NHUlWUUAM1YozAX9nHHceH6p65eC/MvqJSfA3ePyJVuHv42
         XSRtMiW+Y0NqMcUsbRtAIyel8gZE05gcJwAjDkO5csrr+BkADBZncuDTlQeBH+zaATDG
         v2KYLP75+Ktr2comkAr9fk56vkqnxohq76khsI9W9/r0wdzdNmi9rKkKJO90ysHbxocy
         wbFWueE65AL4tGR7lP5AnZMmdOsh9jxPPULzwowf2QgZjEb8fY5NkQVBbgpa4vB3hFfj
         H7tA==
X-Gm-Message-State: AOAM5332UWwSnX/Gu4BCLWbZIlqgP5BbsrVMWJSubyoSrI3rtFYioJK/
        YU3LGi7k+2j6+5Q4rPfBEfHkVQ==
X-Google-Smtp-Source: ABdhPJwcs2lIFlebvMOJB532DIwuMysc4GxK7bOpNwv2KuUaNVUQmNah4iqFU4gIgoC9RjiPlBugyw==
X-Received: by 2002:a05:620a:13b0:: with SMTP id m16mr1032459qki.292.1590530459566;
        Tue, 26 May 2020 15:00:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2921])
        by smtp.gmail.com with ESMTPSA id a7sm841053qth.61.2020.05.26.15.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:00:58 -0700 (PDT)
Date:   Tue, 26 May 2020 18:00:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 05/12] mm: support async buffered reads in
 generic_file_buffered_read()
Message-ID: <20200526220035.GD6781@cmpxchg.org>
References: <20200526195123.29053-1-axboe@kernel.dk>
 <20200526195123.29053-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526195123.29053-6-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 01:51:16PM -0600, Jens Axboe wrote:
> Use the async page locking infrastructure, if IOCB_WAITQ is set in the
> passed in iocb. The caller must expect an -EIOCBQUEUED return value,
> which means that IO is started but not done yet. This is similar to how
> O_DIRECT signals the same operation. Once the callback is received by
> the caller for IO completion, the caller must retry the operation.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
