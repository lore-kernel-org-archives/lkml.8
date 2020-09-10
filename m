Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94268C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CD8220639
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599768342;
	bh=WS19ZBo0ef+CGLGrHmxodx5pBqJ8vMkf9RgKcGYwaKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZfzudJZYfynazl7r+JvCSiANOb+yHh159Xp+hbkbZgeLSKblH9QJ8TNgfDRMc7E+x
	 UYwBMDUgoo7CXV94SfDyNYTVc47s5mWtzTh9ZUf1en0/G9CHwZzkZso7+RCnq265eX
	 5XtMphS0LSBx8W1zCNXwdBkWIzv33qOFpOnBLOKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgIJUFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgIJUCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:02:12 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B642D221E2;
        Thu, 10 Sep 2020 20:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599768075;
        bh=WS19ZBo0ef+CGLGrHmxodx5pBqJ8vMkf9RgKcGYwaKo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=drqevlSGw8/2zSQ4kUDRh9JhcYW397iJT2Mz1J8WZUcJOFOUasV4QrD/vY3nN/SdS
         gf7jmJbqZnupvyDjZoCwi4p3amL/jUvCRt+/dwuQ9OGoYk8Z8GOdxiIlN1wBbDDAWe
         U+/RitedG089zCmQXSVpbc3YmHQt5HFRXt+Z1hFg=
Date:   Thu, 10 Sep 2020 13:01:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        SW_Drivers@habana.ai, gregkh@linuxfoundation.org,
        davem@davemloft.net
Subject: Re: [PATCH 00/15] Adding GAUDI NIC code to habanalabs driver
Message-ID: <20200910130112.1f6bd9e9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200910161126.30948-1-oded.gabbay@gmail.com>
References: <20200910161126.30948-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 19:11:11 +0300 Oded Gabbay wrote:
>  create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_nic.c
>  create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_nic.h
>  create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_nic_dcbnl.c
>  create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_nic_debugfs.c
>  create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_nic_ethtool.c
>  create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_phy.c
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_masks.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm1_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qpc0_masks.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qpc0_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qpc1_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_rxb_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_rxe0_masks.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_rxe0_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_rxe1_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_stat_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_tmr_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_txe0_masks.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_txe0_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_txe1_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_txs0_masks.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_txs0_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_txs1_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm0_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm1_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm0_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm1_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm0_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm1_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm0_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm1_regs.h
>  create mode 100644 drivers/misc/habanalabs/include/hw_ip/nic/nic_general.h

The relevant code needs to live under drivers/net/(ethernet/).
For one thing our automation won't trigger for drivers in random
(/misc) part of the tree.
