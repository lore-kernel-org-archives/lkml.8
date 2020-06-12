Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE24C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF2F206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNROsMZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgFLUUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 16:20:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22991 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726309AbgFLUUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 16:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591993247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7FPq3nO6B1maCulGzahMUgGvOzcx8PXF95wcQrwkyM=;
        b=TNROsMZLjjS2ZWsMVMjr98JFcHjykDwWPgildiUUSTQBwmHxP2IscfAii+RBEa3L+DS5UU
        45DvFoH+fYwPz2fjd75YASvNLsy3AN9+0Okt75jJzTwLRkaOM4xkun3Aqy3VfC5LVOKStd
        qbwZ4HZyry1hJkHwfPAmO/Ly92xZdpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-93I2KMh6Nt-Efum2afEK1g-1; Fri, 12 Jun 2020 16:20:42 -0400
X-MC-Unique: 93I2KMh6Nt-Efum2afEK1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3A5C801504;
        Fri, 12 Jun 2020 20:20:40 +0000 (UTC)
Received: from carbon (unknown [10.40.208.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B6595C660;
        Fri, 12 Jun 2020 20:20:33 +0000 (UTC)
Date:   Fri, 12 Jun 2020 22:20:31 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Gaurav Singh <gaurav1086@gmail.com>
Cc:     brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        netdev@vger.kernel.org (open list:XDP (eXpress Data Path)),
        bpf@vger.kernel.org (open list:XDP (eXpress Data Path)),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] xdp_rxq_info_user: Fix null pointer dereference.
 Replace malloc/memset with calloc.
Message-ID: <20200612222031.515d5338@carbon>
In-Reply-To: <20200612185328.4671-1-gaurav1086@gmail.com>
References: <20200611150221.15665-1-gaurav1086@gmail.com>
        <20200612185328.4671-1-gaurav1086@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 14:53:27 -0400
Gaurav Singh <gaurav1086@gmail.com> wrote:

> Memset on the pointer right after malloc can cause a
> null pointer deference if it failed to allocate memory.
> A simple fix is to replace malloc/memset with a calloc()
> 
> Fixes: 0fca931a6f21 ("samples/bpf: program demonstrating access to xdp_rxq_info")
> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

