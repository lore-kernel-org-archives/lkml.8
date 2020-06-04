Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86549C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED3B206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7oQr88H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgFDH70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgFDH70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 03:59:26 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1204BC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 00:59:26 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s10so3157888pgm.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 00:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VX+yGAffSeajwf7uN6dwW7IpTMshFF/QkNyfthZYOH4=;
        b=a7oQr88HgpJ+c8tpkiiO7Vqmf7hNy663uXVB0eFDMvkPVJjrx8LbG3zZSfC+cQ4vWi
         TKGCuLdwGG0fOsmbd4gGB2xZH9OrQjwL61xv/+FbVKnYD0vpJOg7T81t7zReUr0D0aKN
         XjU9hb09HKBHMzFKzH6odlMRSQpKjlJw6/CBP9YSxazTAbSsLasWI+nXacfTySV3mdYt
         Irt8c20yRlUxyIoSEiydY5AiPYMp71c88/LZ0Ggx9S3CdY2j3AaWKCYVkF68Z8DJ6UQV
         sPYdy+oea9ZoVuvLdZ28w4ZmWKfMqPOjDz2v8EhB7kn0A53CWl0cVgXrf9mcPQLHBo3H
         HyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VX+yGAffSeajwf7uN6dwW7IpTMshFF/QkNyfthZYOH4=;
        b=BfMk/D9G4Yu6/4ngcKJwPSkz2k+LVEjn1qh6gZWeitdewW4VrEtzVJRzav9B1ZNbwz
         Zs1neqoHgU7XOt/rXVR2Do2YGjcXl1/PSfjJDKpJPEvsCWGVrRT+FX4bKcWMqGWFU83Y
         0qiwDvaB6drz4vXfrzAzLCosCN+HJizlEqEb8pWNXNdWDRTYtqlcAdRye8e/YIPE58HI
         tDU0tt+Dm7Bi2F2nFZd1FjDsamiZWGyAiv7c/rTXIS31cniGmdTdEhgRudladOLthKbV
         aCKm/HL59UQyzom7cabZdDYiQSTQ0Y5xCoXvHLOA5/YpTmaAAZD9Gbc6yLZcMGenlqf/
         KRFg==
X-Gm-Message-State: AOAM531ogvI9GY1NKkn27mxxF11vZaqyTUoej4juW3M8dpiZI4kJaf3n
        eZpIjnSze5mYSwm+fRkT4Nc=
X-Google-Smtp-Source: ABdhPJzHSwkU8Jr60yIaVJyCvsyyRXl67tIPyGy60cXqtHMYMlUMEdn/5Cjy/F5HaK89Z2AUL9y7iA==
X-Received: by 2002:a63:6604:: with SMTP id a4mr3344000pgc.12.1591257565526;
        Thu, 04 Jun 2020 00:59:25 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id m12sm4580285pjs.41.2020.06.04.00.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 00:59:24 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 4 Jun 2020 16:59:22 +0900
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     linux-kernel@vger.kernel.org, chenwandun@huawei.com,
        xiexiuqi@huawei.com, bobo.shaobowang@huawei.com,
        huawei.libin@huawei.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Subject: Re: [RFC PATCH] panic: fix deadlock in panic()
Message-ID: <20200604075922.GA143696@jagdpanzerIV.localdomain>
References: <20200603141915.38739-1-cj.chengjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603141915.38739-1-cj.chengjian@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/06/03 14:19), Cheng Jian wrote:
>  A deadlock caused by logbuf_lock occurs when panic:
> 
> 	a) Panic CPU is running in non-NMI context
> 	b) Panic CPU sends out shutdown IPI via NMI vector
> 	c) One of the CPUs that we bring down via NMI vector holded logbuf_lock
> 	d) Panic CPU try to hold logbuf_lock, then deadlock occurs.
> 
> we try to re-init the logbuf_lock in printk_safe_flush_on_panic()
> to avoid deadlock, but it does not work here, because :
> 
> Firstly, it is inappropriate to check num_online_cpus() here.
> When the CPU bring down via NMI vector, the panic CPU willn't
> wait too long for other cores to stop, so when this problem
> occurs, num_online_cpus() may be greater than 1.
> 
> Secondly, printk_safe_flush_on_panic() is called after panic
> notifier callback, so if printk() is called in panic notifier
> callback, deadlock will still occurs. Eg, if ftrace_dump_on_oops
> is set, we print some debug information, it will try to hold the
> logbuf_lock.
> 
> To avoid this deadlock, drop the num_online_cpus() check and call
> the printk_safe_flush_on_panic() before panic_notifier_list callback,
> attempt to re-init logbuf_lock from panic CPU.

We hopefully will get rid of some of these locks (around 5.9 kernel
maybe), so the deadlocks (at least in the printk-code) should become
less common.

	-ss
