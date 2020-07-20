Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53156C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F502070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="kiYQdB66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387894AbgGTReg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbgGTReg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 13:34:36 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C3CC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 10:34:35 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m22so10582178pgv.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3j4oTHrOQZFqNUKygQYhUKPDy9BXvra1dSUQfhhnXXY=;
        b=kiYQdB66t89992BS5/3S9zupYvM9r4MMFbvkwh/BwIde6d1+Nm7rLriJMEYYgMEiPt
         KHARR+/kPm4txUgdOZB6Xgk2PrMunoQHuQkmL4WfRiaecPnLNiw84I5QsxXefK/yGn+k
         YJpsLsa0nZCy8fFXPiIqZECdXLSarRTTcDMjbdnEJsnq4k7/Zxm3EeNwC0ShcH/1aSUM
         j/rf2W5h8v1/UlhU9NA3KkELQ/8J3w+pNgD3jYv4HoD5B+cJbm7gsXd69YK4X599RO3S
         9d2crLPc6DssvDlGUkCAUwo2ojDdvcBJZ/cf5zT2eLGAZCwCviUTJxfYh8HfcRaQyrz/
         VrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3j4oTHrOQZFqNUKygQYhUKPDy9BXvra1dSUQfhhnXXY=;
        b=WbtnLpbFZUQ84b5OH9Zn94mASlliPfIsxlWGSq/3exsiUoUwbP0uqGz81uMml04e4m
         lUhf3xjA9077Q4KB+krZFJFpyDcY4s9GqoY9nMK0TFM2mn+YXCeAonwF32lxuvg3bKHs
         +fKLe7oOv8nPaNk6cwM/yc5duiw2upcaFx75wCLrWr33M65Zw++7N9FlHy9kGWX1wu9F
         7xVV3SyrQAiLJuTvCQ5PcLknzMqWTWUX2EPnSQP0J9p20H7b+6yVOKnlUYy/sdIa7iHX
         AJpONYj4bX/gfkRNz4TyLPT2TbBL2fmv11lZOtYxNNtI24ISlKAaiD3KfXoh41XtKkeY
         wAYg==
X-Gm-Message-State: AOAM532JJ0U9r//ds+vjGL1yc4wfjvDDPMWMBzwZglGls23oFJ6oUk5g
        sErl3Z2emlMGKXg5MBquC8s1Kg==
X-Google-Smtp-Source: ABdhPJwqGvI6Z0Nhi8vxXNKPmGnXcK131taD73JvVDDzYMIa4O6e1nUPDjgBxRkPDoQbBuL7kKglcA==
X-Received: by 2002:a65:5c43:: with SMTP id v3mr19096111pgr.214.1595266475402;
        Mon, 20 Jul 2020 10:34:35 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id o129sm18190152pfg.14.2020.07.20.10.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 10:34:34 -0700 (PDT)
Date:   Mon, 20 Jul 2020 10:34:25 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Sriram Krishnan <srirakr2@cisco.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, mbumgard@cisco.com,
        ugm@cisco.com, nimm@cisco.com, xe-linux-external@cisco.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: hyperv: add support for vlans in netvsc driver
Message-ID: <20200720103425.03a05912@hermes.lan>
In-Reply-To: <20200720164551.14153-1-srirakr2@cisco.com>
References: <20200720164551.14153-1-srirakr2@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 22:15:51 +0530
Sriram Krishnan <srirakr2@cisco.com> wrote:

>  
> +	/* When using AF_PACKET we need to remove VLAN from frame
> +	 * and indicate VLAN information in SKB so HOST OS will
> +	 * transmit the VLAN frame
> +	 */
> +	if (skb->protocol == htons(ETH_P_8021Q)) {
> +		u16 vlan_tci = 0;
> +		skb_reset_mac_header(skb);
> +		if (eth_type_vlan(eth_hdr(skb)->h_proto)) {
> +			int pop_err;
> +			pop_err = __skb_vlan_pop(skb, &vlan_tci);
> +			if (likely(pop_err == 0)) {
> +				__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);
> +
> +				/* Update the NDIS header pkt lengths */
> +				packet->total_data_buflen -= VLAN_HLEN;
> +				rndis_msg->msg_len = packet->total_data_buflen;
> +				rndis_msg->msg.pkt.data_len = packet->total_data_buflen;
> +
> +			} else {
> +				netdev_err(net,"Pop vlan err %x\n",pop_err);
> +			}
> +		}
> +	}

Minor comments.

1. Blank line between declaration and code.
2. Error handling is different than other parts of this code.
   probably just need a goto drop on error.

It seems like you are putting into message, then driver is putting
it into meta-data in next code block. Maybe it should be combined?
