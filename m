Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74398C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AA42074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591025506;
	bh=IP4m3urecyfBNi+mmzSLHQaaaMppHGO2ZLKmwi6PBH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VhKLHO3BdwEN8eILOK8EvlSpraCMrCpOr7OHPPzQkMoO89UX4oVgt1JHwzGUyPj5v
	 +KfygmLwHeRWQ7QUWMXy6uRu3Yg6eZDjplls4CQaqrFpWRbHyBb4JYfiZMFTqZ+hXL
	 8D7P4sfqshXLaOdNe14t19Vl5ipbMS5Kc7DDRjl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgFAPbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:31:45 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D037FC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:31:44 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id i68so7988826qtb.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iyggTbManyrryI0WCsWNJY7+BA++HoViaIXB5WWhWoc=;
        b=NkTEJVdAAED66CTekg0Fui1cRyNFovNHJAFf1zJQEtf+M1HvZV6Aj6+vVvtwf9kwiq
         tb3h2rBKBIVnzuBoYZ4+v4yASo0sB7ME3SbphH4KmNRKL0tdf/XiPjlRROl9zLX0HyU7
         FfatM0m+AsJNCtblVINrIGwtqk7ZVklyMNEtsLSIN1ZjpCQUHJm+M7Qu7XIWsi6fQ7Gh
         8VJkTB38iugpx7Tyg+EcwmxyM00iQNkuovgEOW31zaHKRfW+7nIgHBXs/+OJfR6Nzeqh
         9mfCmy60OzxMGcyzAJviRffODjzmA6Wxj1HtJ0nXMPK6102f4ESqpdCArZvyvI2HtAnR
         NpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=iyggTbManyrryI0WCsWNJY7+BA++HoViaIXB5WWhWoc=;
        b=gv8jIRV3aZ82I0eilOcBGTzsXPJnUvrtzJzRURJvyTseGUW+J9x+g9J0CB2oyBTxoZ
         qOwGKbXCzoKh2LWHMDuV626bMpoYZFE0NIG0exFbbWBDvgAQd8au8fd45AIldOWgGzLn
         bhMgtzvGgVEWwWtrJBSIbGE1Wky81iN6/oSxEhWitUBYRvy9Z0vEQ/7afa+HTXEDZVvf
         /j2CFeO8AtW2XyRet2ApUOdeieVi1yu2mYHgpWTMt5prETR5+V84J5x5BvWkSUYEhYzx
         pK+CshaTbM5khXYWfXkyPMy/qFQC1zHoubFuYOAK9/B2c1X/Bo3qcH+e8R+9pMppsgpi
         rPlQ==
X-Gm-Message-State: AOAM53094zBZcCm+g/Lk3Wp//Vm+5/jKNFgXM1iypRwX9Gi4XB5ibbjD
        ut+TMcR5z+udwr3lmFfoIwM=
X-Google-Smtp-Source: ABdhPJwxXzFZ1rThamfI7ZckxTcdkLOrgrBa45wMH+8+S6wYAPk6LzPpF1b7Ha8LAq1cbNNnyeOTOg==
X-Received: by 2002:ac8:3382:: with SMTP id c2mr22007438qtb.356.1591025503935;
        Mon, 01 Jun 2020 08:31:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:eb8b])
        by smtp.gmail.com with ESMTPSA id x14sm14935199qkb.67.2020.06.01.08.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:31:43 -0700 (PDT)
Date:   Mon, 1 Jun 2020 11:31:42 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: ensure all flush_work() completed when being
 destoryed
Message-ID: <20200601153142.GC31548@mtj.thefacebook.com>
References: <20200601060802.3260-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601060802.3260-1-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Lai.

On Mon, Jun 01, 2020 at 06:08:02AM +0000, Lai Jiangshan wrote:
> +static void flush_no_color(struct workqueue_struct *wq)
> +{
...

I'm not too sure about using the colored flushing system for this. Given
that the requirements are a lot simpler, I'd prefer keep it separate and
dumb rather than intertwining it with regular flushes. e.g. each wq can keep
the number of flush work items in flight and a simple wake up mechanism for
the task doing destroy_workqueue().

Thanks.

-- 
tejun
