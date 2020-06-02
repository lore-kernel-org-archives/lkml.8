Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290FBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38E820757
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591114435;
	bh=QAx6VmM1gRvw8ifuanL11pkVOJePyJocfoTt/0wSC6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i7bkcZIS/LBmv68rksEZJQ89Wf6jF4ObVCn/E/w1Xv2gqehqfs1GOHOJaZ67kdq56
	 5i+urkCMVtaG/Oc3QKT4vUnrtwBLna3fg4ZVnoqGJAE9tZMBKMO3/n2gXzHb6haF1m
	 7wnLBzIHlZkvz2gQl5fEhasNEjrlBkAvqBODGVW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgFBQNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgFBQNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:13:53 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D64C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 09:13:53 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id fc4so2044530qvb.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f1SCMGiSvYq/QtT/Ww5PkTW2Sjxad0RJG/18EYoZNnM=;
        b=RdRm5etUCw9UZu96SfmiANn88hWM0ZQ46UWybJr5/qHJRFrwPRL/YbtnD0W6VBaldu
         AqiTdZPjLNv2zTIOS5Qlz+HdmgR8TurLK3HHPon1Ygl5DPjjprw+0zpNjqG3OENz9vhx
         b1z2u8X4eiWcbIH/oLwDMpewHVESzJ8SLEaGJjOcZDBP2n/8xgUKsfFdtErqInVJqjP3
         BCGIW3Bz49N4ja2lc5Pw7bmabEMOihG8Bb875YrdVO/CPp6xSauWSUZ+l6vZZpinuuNw
         1D1XoC2Tgv0gzsmKQK3Pi7c/UhGddCMdXUIx+qH30RQs3DV0PCh0KOXc4XI4YcYS3+5X
         IUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=f1SCMGiSvYq/QtT/Ww5PkTW2Sjxad0RJG/18EYoZNnM=;
        b=E8Q/NyZLh1hsZdXCAAahfer/jeJGuh/WOT/J/ygDl9aoBt5/iPZPHCtsXN/oCrzJ0v
         gHlLOCbPI5dq/a4cuqm6pD9UIbjxqZSPVwfc77HBl8mklXOppIf7RxEsiv/kFHzBRuFX
         ER/1Nd9khopeGth4N0FmjmDGxd7JazRTvw5m0vbvq+VavPH6R2vQIQ1xnTy1ovaOVwUO
         z2RCyhE+qjNz4JL/rpGyH1+bZzYaEQdkNwXMkGaop8X19/T0y+hMcSr9/RjJvGbNXf9W
         HPK/WNffKDUCH++uWA3YKQFKE7T92CSg871vwo5R6/RtgMTfLiSV3ymlTTK82GFLrxLC
         j5BA==
X-Gm-Message-State: AOAM532ihIC/cRNZuS3u7JWf0hIBVPaqlgXazxHmJ3iRy6e5V4lqCxSx
        dPHkeS3TEuHhLmlR4bpA6VsQYVFk
X-Google-Smtp-Source: ABdhPJwzFXMh/6e/by1U7Bdyw3Qwkwiu8338w+/7lotYV0zmbZc+MTbXOj+SLXxKXb5rEpzQ5a5uMA==
X-Received: by 2002:a0c:fa4b:: with SMTP id k11mr9910317qvo.136.1591114432611;
        Tue, 02 Jun 2020 09:13:52 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id z20sm2869924qtn.93.2020.06.02.09.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 09:13:51 -0700 (PDT)
Date:   Tue, 2 Jun 2020 12:13:50 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: ensure all flush_work() completed when being
 destoryed
Message-ID: <20200602161350.GH31548@mtj.thefacebook.com>
References: <20200601060802.3260-1-laijs@linux.alibaba.com>
 <20200602134915.2644-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602134915.2644-1-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Lai.

On Tue, Jun 02, 2020 at 01:49:14PM +0000, Lai Jiangshan wrote:
> +static void dec_nr_in_flight_flush_work(struct workqueue_struct *wq)
> +{
> +	if (atomic_dec_and_test(&wq->nr_flush_work))

Do you think it'd make sense to put this in pwq so that it can be
synchronized with the pool lock instead of using a separate atomic counter?

Makes sense to me otherwise.

Thanks.

-- 
tejun
