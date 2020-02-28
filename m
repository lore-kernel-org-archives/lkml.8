Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA815C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C13520658
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0HdOOIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgB1LUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:20:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37481 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbgB1LUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582888838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JwHjZB5Q4dc3T+wcDE5rzrvHt7xSnx1p8Z0SDiY1kIk=;
        b=c0HdOOIi8e1qJlfHLzO6srhTaV2HhFSHlSO/Wadj6jT7m9LgFxofDgenzOfFC8+BTMSl4D
        16sIiTbzLd+0A9xZ9+j7Q53SSow0kFXSoPQIguepyq/+k2rSsJc3nI5JiOatN2zWnkCnKm
        yQKeeCOjLHHfTr1FGuqVfcfV+d1LcO4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-7kXmr8aZPkqdLpWSOqQyPQ-1; Fri, 28 Feb 2020 06:20:36 -0500
X-MC-Unique: 7kXmr8aZPkqdLpWSOqQyPQ-1
Received: by mail-lj1-f197.google.com with SMTP id s25so812027ljm.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 03:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JwHjZB5Q4dc3T+wcDE5rzrvHt7xSnx1p8Z0SDiY1kIk=;
        b=j/PiTv1CcyhG3LUb+2FDZZNv/snLKauL/FkUNNEc+Otb8urOwfoWtp5PC1UYc8PLWf
         itvsWCduDI75h19NKizgWQBy0azDlfcn5AcJJkHnGqkAzAo7ApdTJ1F+MlmQqBYluPuk
         7aMRFboUhC8hvrBTW4UEuQ71XVW2fT8FvDDQ8O7B7tfa8mIg5ZZhQMFNbAYIr9O5u35v
         T9acAhAflQ3cXrP7s/UwvV47gtoOIIEKr3UcD3yK47YcPa+vRsrjxZQrpd/FGUf4r1v6
         wnwTWEr78lG9CUtLFjKT35JhBlgPaatxaFuYATyTi4sqalB3hgH6PxUWasGSc5N/8I9D
         lRiQ==
X-Gm-Message-State: ANhLgQ0SJJd7cpeli+FqXg4X1ZEtj/3Hqk3C9iNhXbSW6yBdQRiof8Nc
        rKUEGuOkoqWPaRr2+WmgJ+W2oCMtO2XhczGeNln6Hu6zOK1PEpWlXdE14o3FF/FK6qaFIzBYJz6
        LOc8s9JdS+7YDaaXxQR+OOzLh
X-Received: by 2002:a19:3fc7:: with SMTP id m190mr1451726lfa.102.1582888835041;
        Fri, 28 Feb 2020 03:20:35 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtI5wLvOQGFZRXtz+6/xGXuDpaXgvo5ohMGmXLtvABy0daimE/d6cqn/rcnriOUuWqv4Jz45g==
X-Received: by 2002:a19:3fc7:: with SMTP id m190mr1451710lfa.102.1582888834787;
        Fri, 28 Feb 2020 03:20:34 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q16sm4676857lfd.83.2020.02.28.03.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 03:20:34 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2F8EF180362; Fri, 28 Feb 2020 12:20:33 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Luigi Rizzo <lrizzo@google.com>, netdev@vger.kernel.org,
        davem@davemloft.net, hawk@kernel.org, sameehj@amazon.com
Cc:     linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Subject: Re: [PATCH v4] netdev attribute to control xdpgeneric skb linearization
In-Reply-To: <20200228105435.75298-1-lrizzo@google.com>
References: <20200228105435.75298-1-lrizzo@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 28 Feb 2020 12:20:33 +0100
Message-ID: <875zfrufem.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Rizzo <lrizzo@google.com> writes:

> Add a netdevice flag to control skb linearization in generic xdp mode.
>
> The attribute can be modified through
> 	/sys/class/net/<DEVICE>/xdpgeneric_linearize
> The default is 1 (on)
>
> Motivation: xdp expects linear skbs with some minimum headroom, and
> generic xdp calls skb_linearize() if needed. The linearization is
> expensive, and may be unnecessary e.g. when the xdp program does
> not need access to the whole payload.
> This sysfs entry allows users to opt out of linearization on a
> per-device basis (linearization is still performed on cloned skbs).
>
> On a kernel instrumented to grab timestamps around the linearization
> code in netif_receive_generic_xdp, and heavy netperf traffic with 1500b
> mtu, I see the following times (nanoseconds/pkt)
>
> The receiver generally sees larger packets so the difference is more
> significant.
>
> ns/pkt                   RECEIVER                 SENDER
>
>                     p50     p90     p99       p50   p90    p99
>
> LINEARIZATION:    600ns  1090ns  4900ns     149ns 249ns  460ns
> NO LINEARIZATION:  40ns    59ns    90ns      40ns  50ns  100ns
>
> v1 --> v2 : added Documentation
> v2 --> v3 : adjusted for skb_cloned
> v3 --> v4 : renamed to xdpgeneric_linearize, documentation
>
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

