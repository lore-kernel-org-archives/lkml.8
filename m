Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0638C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63D1206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUoBBpw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgDTNv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:51:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32730 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728453AbgDTNvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587390714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7gTi1IicJlsSKfDG5naKX5cqpPONHfHCE+Bv1EVj7p4=;
        b=gUoBBpw6NCikbS3zprdf3+h9DSV9fUBYnEjk0fyv1ZGJ+fgBEMHeSxNtRQpCHLPFwWjTtM
        znBsleMobdmCdvT1hsYHbceZoZhiwx+vldo7rM6t9G0AkJofPcC9Q3m8LWFXnppKpz6WJ2
        S+2mueE5Kx/tA/3NNf/8nwffUBmfEys=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-INKShmURNTy5bpxBXC5Pew-1; Mon, 20 Apr 2020 09:51:51 -0400
X-MC-Unique: INKShmURNTy5bpxBXC5Pew-1
Received: by mail-qv1-f69.google.com with SMTP id p12so10239683qvm.21
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7gTi1IicJlsSKfDG5naKX5cqpPONHfHCE+Bv1EVj7p4=;
        b=K8pK4tKBb8RMxoOrp6sNcvec3aX1U6n1jNcoQTERw+JtK7QlaRGzFS84vFdS2UsLBe
         FsP7ouhjIrdhRNreUZdDhBWIagFp/O4Kh27oeC+SPCuJqRcN7rhkCFWSj22YyczxJhxz
         Ybk17/y1Ny3sQJWtoH7rO+1k48NWITj3QS5la7xoyYeXqAEmE5e3zCukrsdMP3YCEeSF
         PioSeN7Flj7mrepY+XFyd3YcYtHvNbIzmlMKlZ8+bJSG44xgIhHUinVnb8fZ5ke2yHdA
         O/+ahpqHWvMvZrTB+EJLfaBVeswCs7Fk60fCnJUcmpcM2b9ymB7lJJljOazf59unZMSz
         p4xg==
X-Gm-Message-State: AGi0PuZbFHcEzbvgwLhdLafF1dXr5DHRJvTF5WsfFrq/2lVCzINTNxRV
        T1N3F+ZNOyIbm1lDIoeeFUhXAS8G0VJlUD2NBXTTgy0PptXJTyd7bi51Ybp3mOXHleUt8n8ySP7
        zI5e2vNfBWekg8BYi3kqSSR+c
X-Received: by 2002:a05:620a:1009:: with SMTP id z9mr15818457qkj.270.1587390711071;
        Mon, 20 Apr 2020 06:51:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypIL/5HvAE8uGB2QeYJcMl1quKM2t1afKsHoOGNm7ioq9h6iVSe8lTD2IPGc1eogwV5ywc6E9A==
X-Received: by 2002:a05:620a:1009:: with SMTP id z9mr15818438qkj.270.1587390710884;
        Mon, 20 Apr 2020 06:51:50 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id y9sm606038qkb.41.2020.04.20.06.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:51:50 -0700 (PDT)
Date:   Mon, 20 Apr 2020 09:51:48 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm/eventfd: remove unneeded conversion to bool
Message-ID: <20200420135148.GK287932@xz-x1>
References: <20200420123805.4494-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200420123805.4494-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 08:38:05PM +0800, Jason Yan wrote:
> The '==' expression itself is bool, no need to convert it to bool again.
> This fixes the following coccicheck warning:
> 
> virt/kvm/eventfd.c:724:38-43: WARNING: conversion to bool not needed
> here
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

