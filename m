Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFC1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7C722B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gh+sCAEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgHEUAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:00:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43808 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727077AbgHEQlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596645679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Htm2JdguJ9wMbfUtNGIDXZzv/Zt05ES7M0m8GbVzmRI=;
        b=Gh+sCAEAdGXKIjSuTtiwJB9iB9HPP+PB1SJTOrR/Cgb4GnZWl1whY8PTniAE4jp97YtQwK
        gASuurYHRyWBH8GVqQQ0SbC3E2nZwd5g98OQ7aD2+PABWth2kOfvhfrwXrkiCgFmWZMQ+Q
        Poc4+DhB+daagcCLCcT5ZJE8PGmAAzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-bSMZvbQQPtmbHwA5KYU1wQ-1; Wed, 05 Aug 2020 09:06:35 -0400
X-MC-Unique: bSMZvbQQPtmbHwA5KYU1wQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFAEB80183C;
        Wed,  5 Aug 2020 13:06:33 +0000 (UTC)
Received: from localhost (unknown [10.36.110.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F7537B900;
        Wed,  5 Aug 2020 13:06:31 +0000 (UTC)
Date:   Wed, 5 Aug 2020 15:06:27 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        <heiko.carstens@de.ibm.com>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20200805150627.3351fe24@redhat.com>
In-Reply-To: <20200805223121.7dec86de@canb.auug.org.au>
References: <20200805223121.7dec86de@canb.auug.org.au>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Aug 2020 22:31:21 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the net-next tree, today's linux-next build (s390 defconfig)
> failed like this:
> 
> net/ipv4/ip_tunnel_core.c:335:2: error: implicit declaration of function 'csum_ipv6_magic' [-Werror=implicit-function-declaration]
> 
> Caused by commit
> 
>   4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")

Ouch, sorry for that.

I'm getting a few of them by the way:

---
net/core/skbuff.o: In function `skb_checksum_setup_ipv6':
/home/sbrivio/net-next/net/core/skbuff.c:4980: undefined reference to `csum_ipv6_magic'
net/core/netpoll.o: In function `netpoll_send_udp':
/home/sbrivio/net-next/net/core/netpoll.c:419: undefined reference to `csum_ipv6_magic'
net/netfilter/utils.o: In function `nf_ip6_checksum':
/home/sbrivio/net-next/net/netfilter/utils.c:74: undefined reference to `csum_ipv6_magic'
/home/sbrivio/net-next/net/netfilter/utils.c:84: undefined reference to `csum_ipv6_magic'
net/netfilter/utils.o: In function `nf_ip6_checksum_partial':
/home/sbrivio/net-next/net/netfilter/utils.c:112: undefined reference to `csum_ipv6_magic'
net/ipv4/ip_tunnel_core.o:/home/sbrivio/net-next/net/ipv4/ip_tunnel_core.c:335: more undefined references to `csum_ipv6_magic' follow
---

...checking how it should be fixed now.

Heiko, by the way, do we want to provide a s390 version similar to the
existing csum_partial() implementation in
arch/s390/include/asm/checksum.h right away? Otherwise, I'll just take
care of the ifdeffery.

-- 
Stefano

