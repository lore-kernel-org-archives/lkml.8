Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AD4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB7FB20757
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591114697;
	bh=GOxWZFW5p0R4Mb6m/Bo6zAMohTrK5btdVpKdH3RUxMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P3OOzl/eDB7ffxxwwp+z1B+XMyuNJBqn/+GDrzL/2N6dVUL4gGK/3UBFja3mIbTSz
	 eOTE/ESuOsbZk+1aEFWtsnK+i9vrY4DeLioXbwzT5DpSutMfts8hTOnobTpMp0V5B7
	 e7JCvUvEITtjJDNIKBiItftkrRL2PRdMGwOUuh8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgFBQSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgFBQSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:18:16 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CC6C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 09:18:16 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id z9so2026792qvi.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 09:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QnnRV7rBYpuwTlzjoMcd++pjDHDWrMhQw3hcrAJQ594=;
        b=WQ4N3HzBq/erSPg6m3Gl82qjtrEH5qF97Lji6xhOP72AObalMv/O288C0sPNfQTocB
         vNB8wtxVDBaAELiXdol6Yzsyw2XpL0AcHLSP9U23UyX+JeZo9q8Xt+vIcBKwAPR8qN/2
         pfy2h7CjmAgjQJvo3OlVrObeAJ47qL9z/YBbTB34icAwtzBD+3Rt0j6rFREReFh6VfFx
         UnMWFWDtMJDUINbmMtTk9lBLa2Jm6OyH0OnlTysovnPKwiroqkZjemCAJoCsZ92MSbZR
         +uCehcEpTpSLUZ+IuLDBhd/OpMe/hd0oF+p5h2HSw2aK98+54J9C1qZEp/kQKWN4krzP
         wDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QnnRV7rBYpuwTlzjoMcd++pjDHDWrMhQw3hcrAJQ594=;
        b=HXxQKc/fvDgkVB1kaxQK/z/2JltYDpAO1s6N1Y5DqLH4ItlLqVX2dU8I91v7cD8tfF
         wgTQRUyMhwLGgX1BSEvwbN7C4FDEPmZlzo1SciHRv3PWAX8yKZetT63d59W3moaD6NFP
         CpLbHb0ag4DSMdieZ2BJxLszgB9TPm9SaLsUHFm1l1opr/V3oFQukq0J8SovEc6sWC6w
         W3aySL3aV8lmN+jeFUDQ9FqspG8UYgc/VlRHMGt+whSEaVPogIkt1eQ02j1oBYDpTevx
         oLyXMF0L7eYqSmyD5+iwY4lQ/CahqIxf7F6hZErHpOwQR2H7n/VBu9xCB6PpyDYt2p2I
         bQrA==
X-Gm-Message-State: AOAM532mGRX2kQ+turrtx6YrpirceY1g80l8PUr9gjGCoHvpQDc/QgrI
        BBDfrnAoatnvXrZUBgriplMl3t6M
X-Google-Smtp-Source: ABdhPJz1tkuCl3kLGoHvwv/meSx/T7pJg17HVSVIPLSMKQYAO9rdqY9DfiZRNnyxu5br9F64kGrJwg==
X-Received: by 2002:a05:6214:9ce:: with SMTP id dp14mr25520546qvb.216.1591114695623;
        Tue, 02 Jun 2020 09:18:15 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id 63sm2726578qkm.82.2020.06.02.09.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 09:18:15 -0700 (PDT)
Date:   Tue, 2 Jun 2020 12:18:14 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] workqueue: slash half memory usage in 32bit system
Message-ID: <20200602161814.GI31548@mtj.thefacebook.com>
References: <20200601084442.8284-1-laijs@linux.alibaba.com>
 <20200601084442.8284-5-laijs@linux.alibaba.com>
 <20200601150723.GA31548@mtj.thefacebook.com>
 <CAJhGHyCn4R-0rv2bDBWuYs1SE0PyJe8GoMEhHo4xwtUy23YpWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyCn4R-0rv2bDBWuYs1SE0PyJe8GoMEhHo4xwtUy23YpWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jun 02, 2020 at 08:08:10AM +0800, Lai Jiangshan wrote:
> It is not noticable from the "free" command.
> By counting the number of allocated pwq (mainly percpu pwq),
> it saves 20k in my simple kvm guest (4cpu).
> I guess it highly various in different boxes with various
> kernel modules loaded.

Hmm... I find it difficult to judge in any direction. 32 bit machines are
smaller and have less of everything - including CPUs and workqueues
themselves, so while changing configuration for 32bit systems would reduce
memory usage the impact isn't gonna be that big either and I have no data
supporting whether the reduction is gonna help or hurt.

Thanks.

-- 
tejun
