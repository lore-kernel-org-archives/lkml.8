Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677ADC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30593246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRK8RvuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgB1M35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:29:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60565 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbgB1M34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582892995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/CKKzpFbreU0OMtvAw+wBkJ7+z4oVGyCnkh7UnzzUc=;
        b=aRK8RvuN6+iWq6muLH707J39wys5tayH/zU+13XXaGAuljSo1KER7f3Y7IIb9zT/sr8lCP
        TPEvcFT3GOz3nylWEqJliNEqtbccOQhVjkec12/PZjL0I24qArXJDUHerfAk+mlbehtU8j
        l1wpqcLSKU/1v8Wpv07gVOzXH/gzJ6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-qfCMnb08OkGv40O0IKxkTQ-1; Fri, 28 Feb 2020 07:29:53 -0500
X-MC-Unique: qfCMnb08OkGv40O0IKxkTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 982ED18A6ECC;
        Fri, 28 Feb 2020 12:29:51 +0000 (UTC)
Received: from carbon (ovpn-200-19.brq.redhat.com [10.40.200.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 680E460BE0;
        Fri, 28 Feb 2020 12:29:46 +0000 (UTC)
Date:   Fri, 28 Feb 2020 13:29:41 +0100
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     netdev@vger.kernel.org, toke@redhat.com, davem@davemloft.net,
        hawk@kernel.org, sameehj@amazon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] netdev attribute to control xdpgeneric skb
 linearization
Message-ID: <20200228132941.2c8b8d01@carbon>
In-Reply-To: <20200228105435.75298-1-lrizzo@google.com>
References: <20200228105435.75298-1-lrizzo@google.com>
Organization: Red Hat Inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 02:54:35 -0800
Luigi Rizzo <lrizzo@google.com> wrote:

> diff --git a/net/core/dev.c b/net/core/dev.c
> index dbbfff123196..c539489d3166 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4520,9 +4520,12 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
>  	/* XDP packets must be linear and must have sufficient headroom
>  	 * of XDP_PACKET_HEADROOM bytes. This is the guarantee that also
>  	 * native XDP provides, thus we need to do it here as well.
> +	 * For non shared skbs, xdpgeneric_linearize controls linearization.
>  	 */
> -	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
> -	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> +	if (skb_cloned(skb) ||
> +	    (skb->dev->xdpgeneric_linearize &&
> +	     (skb_is_nonlinear(skb) ||
> +	      skb_headroom(skb) < XDP_PACKET_HEADROOM))) {
>  		int hroom = XDP_PACKET_HEADROOM - skb_headroom(skb);
>  		int troom = skb->tail + skb->data_len - skb->end;
>  

Have you checked that calling bpf_xdp_adjust_tail() is not breaking anything?

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

