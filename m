Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE9CC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66230206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Plbwo/PE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgEFMI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:08:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35766 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726516AbgEFMI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588766934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAmivG5aDvvl7e+GYdcGOegOdLibFaOeKZvY0VQjVvw=;
        b=Plbwo/PE2+V4u6YvfBr1uAWPQoOVp/i7AUUJYYmDt0zGGJR/7kVy7fYyo51ZH1gwt6RINM
        b9uMqjIpz35Ll6Z3VqSFpbYK1YVh2VrfMVDsTwS7EdYQLptV8nfRe856ViWAxOs66iESCb
        5wJ549L9/cs56FSDsmvhJr8l6ipJQFU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-dim5yPweMjihhTdXp0GEZQ-1; Wed, 06 May 2020 08:08:53 -0400
X-MC-Unique: dim5yPweMjihhTdXp0GEZQ-1
Received: by mail-wr1-f70.google.com with SMTP id h12so1197160wrr.19
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 05:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hAmivG5aDvvl7e+GYdcGOegOdLibFaOeKZvY0VQjVvw=;
        b=kWNyo9bUO9X52nADJPU2uQTnAKpI2XQpRSIZpa3arzBYkVCPQdw7hP+u+iXAxFRThf
         PCgNi768jC73OqT8bDW6uR0J7BGtcbZesQ5QIvv5BpJt1e/D4k/q+8kptrMtGAU6S7Yn
         EEW1GSMV0M+GSD/LzTzWQ5tsRA5hsh/H6ceYPsXL6/anmYdHy2M6rnpedgDV3ufrzJqa
         zLHhlNTbuB2poTAnJxPYsSspTOWbfnsA1jef3djIkZSTziSbW+Ygu82HMDwVjejDsu8+
         LhONXAFWY8w0ZPZFZES2b6jqQ/sixoBWDgKmNIdgs8yv2aAvU6ghB8wO/3pnv4dwhsJS
         h1fw==
X-Gm-Message-State: AGi0PuaPrg4y32L/DbIeuwpuo3xEQGHJpVXsA9Fuwg0GXHrkIMEytcI1
        CYVg141AbgWpxPQLexGU00g624mbbxzwYtollEhQtQEJZxZ8mZaIq37TNykPZL8KOSH3az4f4Tl
        N1DJwAk9xS3BINvuSzkyHPzuj
X-Received: by 2002:a1c:f416:: with SMTP id z22mr4204002wma.32.1588766931875;
        Wed, 06 May 2020 05:08:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypJBsIQXXLBh7+polD0/FRHAo1jIr0FLeGcQ49ZR50oVFkk3bBSfh+noTe2EUmUQ7wGzC4gACg==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr4203979wma.32.1588766931683;
        Wed, 06 May 2020 05:08:51 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id s17sm2634468wmc.48.2020.05.06.05.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 05:08:51 -0700 (PDT)
Date:   Wed, 6 May 2020 08:08:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net-next 2/2] virtio-net: fix the XDP truesize
 calculation for mergeable buffers
Message-ID: <20200506075807-mutt-send-email-mst@kernel.org>
References: <20200506061633.16327-1-jasowang@redhat.com>
 <20200506061633.16327-2-jasowang@redhat.com>
 <20200506033259-mutt-send-email-mst@kernel.org>
 <789fc6e6-9667-a609-c777-a9b1fed72f41@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <789fc6e6-9667-a609-c777-a9b1fed72f41@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 04:21:15PM +0800, Jason Wang wrote:
> 
> On 2020/5/6 下午3:37, Michael S. Tsirkin wrote:
> > On Wed, May 06, 2020 at 02:16:33PM +0800, Jason Wang wrote:
> > > We should not exclude headroom and tailroom when XDP is set. So this
> > > patch fixes this by initializing the truesize from PAGE_SIZE when XDP
> > > is set.
> > > 
> > > Cc: Jesper Dangaard Brouer<brouer@redhat.com>
> > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > Seems too aggressive, we do not use up the whole page for the size.
> > 
> > 
> > 
> 
> For XDP yes, we do:
> 
> static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
>                       struct ewma_pkt_len *avg_pkt_len,
>                       unsigned int room)
> {
>     const size_t hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
>     unsigned int len;
> 
>     if (room)
>         return PAGE_SIZE - room;
> 
> ...
> 
> Thanks

Hmm. But that's only for new buffers. Buffers that were outstanding
before xdp was attached don't use the whole page, do they?




Also, with TCP smallqueues blocking the queue like that might be a problem.
Could you try and check performance impact of this?
I looked at what other drivers do and I see they tend to copy the skb
in XDP_PASS case. ATM we don't normally - but should we?

-- 
MST

