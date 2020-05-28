Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD61C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445262072D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436719AbgE1VoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436581AbgE1VoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:44:00 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30FFC08C5C6;
        Thu, 28 May 2020 14:43:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4CBEE129654F2;
        Thu, 28 May 2020 14:43:59 -0700 (PDT)
Date:   Thu, 28 May 2020 14:43:58 -0700 (PDT)
Message-Id: <20200528.144358.1981651162176500485.davem@davemloft.net>
To:     doshir@vmware.com
Cc:     netdev@vger.kernel.org, pv-drivers@vmware.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 3/4] vmxnet3: add geneve and vxlan tunnel
 offload support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200528213204.29803-4-doshir@vmware.com>
References: <20200528213204.29803-1-doshir@vmware.com>
        <20200528213204.29803-4-doshir@vmware.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 May 2020 14:43:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronak Doshi <doshir@vmware.com>
Date: Thu, 28 May 2020 14:32:02 -0700

> +			BUG_ON(!(gdesc->rcd.tcp || gdesc->rcd.udp) &&
> +			       !(le32_to_cpu(gdesc->dword[0]) &
> +				 (1UL << VMXNET3_RCD_HDR_INNER_SHIFT)));
> +			BUG_ON(gdesc->rcd.frg &&
> +			       !(le32_to_cpu(gdesc->dword[0]) &
> +				 (1UL << VMXNET3_RCD_HDR_INNER_SHIFT)));
 ...
> +			BUG_ON(!(gdesc->rcd.tcp || gdesc->rcd.udp) &&
> +			       !(le32_to_cpu(gdesc->dword[0]) &
> +				 (1UL << VMXNET3_RCD_HDR_INNER_SHIFT)));
> +			BUG_ON(gdesc->rcd.frg &&
> +			       !(le32_to_cpu(gdesc->dword[0]) &
> +				 (1UL << VMXNET3_RCD_HDR_INNER_SHIFT)));

Just to be clear I'm not applying stuff like this.
