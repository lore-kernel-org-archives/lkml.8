Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3FAC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62FA217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581541716;
	bh=IFeZMSn0zSIFVIqHVNN5jlR1XJu5xsQmT3t1ylHvcKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MS44RBq0COI+6gPC+bQQkcmCw7axDiC4M2vS/ZaQ97JZmNLUU0m9Qo0cIUIKDwuTh
	 FJNwoPBvcTBmqhDlBmcq8Kb5ELm0H+/eP1avFk+hz/PO17XtyrHpV9YQn0ZtlrAS2L
	 ff7WRhl6cw4zvKUgSwlCWeKJl/RSej0sWoLJm7iI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgBLVIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:08:35 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36948 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgBLVIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:08:35 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so2750829qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 13:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kirnMEopAGm2Q4j7ps8MR/znuUTE0Q7gX2zrd0pfJ00=;
        b=qhDemixKTgJiXJhIruZk1Xco/NVfT6J1GxZoIYn+qaYLxJCUgL0/F09+uEMkYEaifq
         FHHers3zAegKj5VTy0/uheDqTpvlgyF4pYSrhKCmYK2F53lXpwvdE1YaqAVtNnxQ41ZL
         fJ8HzlqTFZfmCkOSMPTbWp+C1USH7g4vhl6ccXeIlKxqZ96GhynaTM58NAKkH+vfz7J/
         NhtX4J2RSSMAcch51zU2Q9xZzPYYKg4wm1+eU26DK2MTk3phb+6Cv1v64V6a9lFHZ85l
         qFuc7y13gqQPOkEsk0mV74wPpi4GNhr3O/X19DXL9L2olJS7+FE/tjsvkX9FJCyhRj9L
         /gNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kirnMEopAGm2Q4j7ps8MR/znuUTE0Q7gX2zrd0pfJ00=;
        b=BgMhvOJk0spPhaGysy08K2ueev8CgyX/NQIZEcbbw43f/6UUvWxYm0wuctvKgqxFcY
         72g5b16OjFf+IckzlSl9069uNFRJuxelHMetb8EcfdhE8G6es372c9VUW6V2bxHPRnzA
         /4UnE0Cr0wTQiR4Q4HkHAE4Wx1w0ta+KYaJADgPBf4UQdjn8vUAxE2SIBXFVCmCZu4Jm
         no3ztxRGEfnyWkIyS4NfScI4tD3PhaGIcYjSpwYE9qAsEOOuLgOAzm+NTtKWrGVi2E2K
         gno/6GS6rR45VXNZUIAUkrethkFgyL5SCVxUG7bsM7VNn6WblYiKLxNTH6oOkFaXuBtO
         5LGQ==
X-Gm-Message-State: APjAAAXsiZJJjrWEOCII/eCcJG8MqR6r8wCVSVgYWNIgmIEyRG6/nquW
        oPy2wMVmO12xStsnpkr2TIyK2ivDA2A=
X-Google-Smtp-Source: APXvYqzRsNI8Lj1vsIvAu9tqMR5JeNGd2qDvvPoSVt01zf44iYgKCDEAHUpoCfwAtEJbJrdpWC4evQ==
X-Received: by 2002:ac8:6605:: with SMTP id c5mr20323527qtp.316.1581541713824;
        Wed, 12 Feb 2020 13:08:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:985a])
        by smtp.gmail.com with ESMTPSA id g84sm36443qke.129.2020.02.12.13.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:08:32 -0800 (PST)
Date:   Wed, 12 Feb 2020 16:08:32 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: don't use wq_select_unbound_cpu() for bound
 works
Message-ID: <20200212210832.GB80993@mtj.thefacebook.com>
References: <20200125011445.983252-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125011445.983252-1-daniel.m.jordan@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 08:14:45PM -0500, Daniel Jordan wrote:
> From: Hillf Danton <hdanton@sina.com>
> 
> wq_select_unbound_cpu() is designed for unbound workqueues only, but
> it's wrongly called when using a bound workqueue too.
> 
> Fixing this ensures work queued to a bound workqueue with
> cpu=WORK_CPU_UNBOUND always runs on the local CPU.
> 
> Before, that would happen only if wq_unbound_cpumask happened to include
> it (likely almost always the case), or was empty, or we got lucky with
> forced round-robin placement.  So restricting
> /sys/devices/virtual/workqueue/cpumask to a small subset of a machine's
> CPUs would cause some bound work items to run unexpectedly there.
> 
> Fixes: ef557180447f ("workqueue: schedule WORK_CPU_UNBOUND work on wq_unbound_cpumask CPUs")
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> [dj: massage changelog]
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: linux-kernel@vger.kernel.org

Applied to wq/for-5.6-fixes.

Thanks.

-- 
tejun
