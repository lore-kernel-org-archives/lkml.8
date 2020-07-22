Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF56CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C9B20709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595431148;
	bh=/TiSgQ7+mGcBPpF1YXT8hJhda7K3imzWGSSujsDQ3cs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GqKNYQ2ODi2tno7jmn4wsfGPw6UJ0i710VV0wbVwuHxqJ4YlzfvSDz+0KN3blAbHZ
	 soW4ULJ6w+ZRwhf68tCLYCIzg04Ixp+RCgnFQcvSk4Kwr693KFzRa2O6m4buBHhZFi
	 rIU56blvfmQMvuU2YEXcWGhLY2sJTZiDpMkyKZ64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732736AbgGVPTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728046AbgGVPTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:19:06 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1729820717;
        Wed, 22 Jul 2020 15:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595431146;
        bh=/TiSgQ7+mGcBPpF1YXT8hJhda7K3imzWGSSujsDQ3cs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=il+qv/JbMMpP64vydR9x2Cl+6xC/AXVGURVPkCLkNF07YsL742I4Mk4XRIXp4wOgV
         5T4YRH5ffWNjRq2fWBLjStGoxqqoEcFLdw+JYLUmoRGJydh1OWhKykh3ZMoAA7nSsY
         4J20yMuPLBP1lB6yToLY0b3CFZpsZPOn7pKtNMDk=
Date:   Wed, 22 Jul 2020 08:19:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sriram Krishnan <srirakr2@cisco.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, mbumgard@cisco.com,
        ugm@cisco.com, nimm@cisco.com, xe-linux-external@cisco.com,
        "David S. Miller" <davem@davemloft.net>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] hv_netvsc: add support for vlans in AF_PACKET mode
Message-ID: <20200722081904.4a924917@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200722070809.70876-1-srirakr2@cisco.com>
References: <20200722070809.70876-1-srirakr2@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 12:38:07 +0530 Sriram Krishnan wrote:
> +	/* When using AF_PACKET we need to drop VLAN header from
> +	 * the frame and update the SKB to allow the HOST OS
> +	 * to transmit the 802.1Q packet
> +	 */
> +	if (skb->protocol == htons(ETH_P_8021Q)) {
> +		u16 vlan_tci = 0;
> +		skb_reset_mac_header(skb);
> +		if (eth_type_vlan(eth_hdr(skb)->h_proto)) {
> +			if (unlikely(__skb_vlan_pop(skb, &vlan_tci) != 0)) {
> +				++net_device_ctx->eth_stats.vlan_error;
> +				goto drop;
> + 			}
> +
> +			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);
> +			/* Update the NDIS header pkt lengths */
> +			packet->total_data_buflen -= VLAN_HLEN;
> +			packet->total_bytes -= VLAN_HLEN;
> +			rndis_msg->msg_len = packet->total_data_buflen;
> +			rndis_msg->msg.pkt.data_len = packet->total_data_buflen;
> +		}
> +	}

Please run checkpatch on your submissions:

WARNING: Missing a blank line after declarations
#76: FILE: drivers/net/hyperv/netvsc_drv.c:614:
+		u16 vlan_tci = 0;
+		skb_reset_mac_header(skb);

ERROR: code indent should use tabs where possible
#81: FILE: drivers/net/hyperv/netvsc_drv.c:619:
+ ^I^I^I}$
