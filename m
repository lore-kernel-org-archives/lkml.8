Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176F7C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E791524685
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgAOVQf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:16:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44396 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729134AbgAOVQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:16:34 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-Pyrg7-VeMv2ESgq_KHQTCQ-1; Wed, 15 Jan 2020 16:16:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C471800D48;
        Wed, 15 Jan 2020 21:16:26 +0000 (UTC)
Received: from bistromath.localdomain (ovpn-116-137.ams2.redhat.com [10.36.116.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 138D160BE0;
        Wed, 15 Jan 2020 21:16:22 +0000 (UTC)
Date:   Wed, 15 Jan 2020 22:16:21 +0100
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Andrea Mayer <andrea.mayer@uniroma2.it>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Petr Machata <petrm@mellanox.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Litao jiao <jiaolitao@raisecom.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Lungaroni <paolo.lungaroni@cnit.it>
Subject: Re: [net] vxlan: fix vxlan6_get_route() adding a call to
 xfrm_lookup_route()
Message-ID: <20200115211621.GA573446@bistromath.localdomain>
References: <20200115192231.3005-1-andrea.mayer@uniroma2.it>
MIME-Version: 1.0
In-Reply-To: <20200115192231.3005-1-andrea.mayer@uniroma2.it>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Pyrg7-VeMv2ESgq_KHQTCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020-01-15, 20:22:31 +0100, Andrea Mayer wrote:
> currently IPSEC cannot be used to encrypt/decrypt IPv6 vxlan traffic.
> The problem is that the vxlan module uses the vxlan6_get_route()
> function to find out the route for transmitting an IPv6 packet, which in
> turn uses ip6_dst_lookup() available in ip6_output.c.
> Unfortunately ip6_dst_lookup() does not perform any xfrm route lookup,
> so the xfrm framework cannot be used with vxlan6.

That's not the case anymore, since commit 6c8991f41546 ("net:
ipv6_stub: use ip6_dst_lookup_flow instead of ip6_dst_lookup").

Can you retest on the latest net tree?

Thanks.

-- 
Sabrina

