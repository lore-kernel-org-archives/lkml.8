Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7D3C3524F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FE02084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbZjKwym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgBDGCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 01:02:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54861 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725976AbgBDGCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580796120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RjdsRkXe77yTljkA9sXafvBdByUVdvxrTgCwvbrVV0w=;
        b=IbZjKwymJRgcTd3G6CGpLYAAv/ZFkF/CWUlC6k+vRLFkS2YTObk0LNK01tDBooKAUPWT5K
        M384Klin7NjILn5tULnraagONCrQx9R5wNKPiT6m6BmgtQBMB2kRpxVLeD0UKTT+wUp02O
        JRZusD1TMGIr4V9rW38iELK/zhKy2gw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-p_ZlYpiwO1mWy-PPDyk-rw-1; Tue, 04 Feb 2020 01:01:58 -0500
X-MC-Unique: p_ZlYpiwO1mWy-PPDyk-rw-1
Received: by mail-qt1-f200.google.com with SMTP id g26so11623513qts.16
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 22:01:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RjdsRkXe77yTljkA9sXafvBdByUVdvxrTgCwvbrVV0w=;
        b=HhpNm1bpB0IGIzwkA3Z9FqI/k7j41kwxC8/E5YMjJHoUNd/VCivMUPMF9obftvEAHk
         GZFt644vzc+uaXhVMY3xY+ZS5yjbgQNihjERTvXyn6JcwehYrEG6+r5r3mAWzb23klfi
         Z9FMM/XthNNE7ePMl7ODrMIbF6/DvHilCh/dD3h+I4+wF2jq7vLlP+vdWlRI3Ps5DfEX
         2BQlf2iMPHG+lm5T1addToZ44PHlTcIgP2uUaRWTxPxNvnJT1nfshdzLYOcOvrXb+7M1
         Gz4BnSwLJfcHKs2Iz+LblefBmBCWa9rh9yotfgdVt5YkyZLKhPhdt9y/Q5jNbLLOTy/0
         qFLg==
X-Gm-Message-State: APjAAAXhc7TfDjkl6Zw4ljkzVmcRbfguDzRu9guzCeOsh+oL7mDsLz/n
        r7C1fGZ5fbBl13GYb8RyrLRmlzXj+RlBouwQF7c0hBPcEmq6/MyTDxv25MNjusJc533XsF0jsW2
        TaKsM0bKxYynKwwoCaQG3Ozg5
X-Received: by 2002:a05:620a:102c:: with SMTP id a12mr25836903qkk.95.1580796117493;
        Mon, 03 Feb 2020 22:01:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwdvK3Ipy2qMCfUzq1ylzYT9IbitByfrekyORfLE2eptvuEIqJ12IuGLk9Wtkttgxshu+/I4A==
X-Received: by 2002:a05:620a:102c:: with SMTP id a12mr25836873qkk.95.1580796117247;
        Mon, 03 Feb 2020 22:01:57 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
        by smtp.gmail.com with ESMTPSA id u24sm10612793qkm.40.2020.02.03.22.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 22:01:56 -0800 (PST)
Date:   Tue, 4 Feb 2020 01:01:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Tiwei Bie <tiwei.bie@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, shahafs@mellanox.com, jgg@mellanox.com,
        rob.miller@broadcom.com, haotian.wang@sifive.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com,
        rdunlap@infradead.org, hch@infradead.org, jiri@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com,
        maxime.coquelin@redhat.com, lingshan.zhu@intel.com,
        dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Message-ID: <20200204005306-mutt-send-email-mst@kernel.org>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 11:30:11AM +0800, Jason Wang wrote:
> 5) generate diffs of memory table and using IOMMU API to setup the dma
> mapping in this method

Frankly I think that's a bunch of work. Why not a MAP/UNMAP interface?

-- 
MST

