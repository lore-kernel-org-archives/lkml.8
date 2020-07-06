Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF20C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714A2206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgGFT1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGFT1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 15:27:49 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBB2C061755;
        Mon,  6 Jul 2020 12:27:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 193CD1277EA61;
        Mon,  6 Jul 2020 12:27:49 -0700 (PDT)
Date:   Mon, 06 Jul 2020 12:27:48 -0700 (PDT)
Message-Id: <20200706.122748.828248704525141203.davem@davemloft.net>
To:     horatiu.vultur@microchip.com
Cc:     nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com,
        kuba@kernel.org, jiri@resnulli.us, ivecera@redhat.com,
        andrew@lunn.ch, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH net-next 02/12] bridge: uapi: mrp: Extend MRP
 attributes for MRP interconnect
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200706091842.3324565-3-horatiu.vultur@microchip.com>
References: <20200706091842.3324565-1-horatiu.vultur@microchip.com>
        <20200706091842.3324565-3-horatiu.vultur@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 06 Jul 2020 12:27:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 6 Jul 2020 11:18:32 +0200

> +struct br_mrp_in_state {
> +	__u16 in_id;
> +	__u32 in_state;
> +};

Put the __u32 first then the __u16.

> +struct br_mrp_in_role {
> +	__u16 in_id;
> +	__u32 ring_id;
> +	__u32 in_role;
> +	__u32 i_ifindex;
> +};

Likewise.

> +struct br_mrp_start_in_test {
> +	__u16 in_id;
> +	__u32 interval;
> +	__u32 max_miss;
> +	__u32 period;
> +};

Likewise.

> +struct br_mrp_in_test_hdr {
> +	__be16 id;
> +	__u8 sa[ETH_ALEN];
> +	__be16 port_role;
> +	__be16 state;
> +	__be16 transitions;
> +	__be32 timestamp;
> +};

Likewise.  Put the larger members first.  There is lots of unnecessary
padding in this structure.

