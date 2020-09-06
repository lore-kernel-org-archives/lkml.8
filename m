Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CACC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC54A208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599422045;
	bh=oBKLczEV77qvBkz0mJGWX9SWJA35KC0/Ff6JsnS75+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cYlLjVEjD+Q9xaHbSbYwNY+Eyr5DmOfsJhK5ePYF/kJlmAGuAxbZXaPG87qFExvbf
	 KSTJ46zUfuQ3mJNwFy5mfRCZC3lVqC4dtRV9+uBJFaWNG1WgHqnBSdW61Qub45BYVh
	 o1L92HXW1u+Aq51F8p+n8O9zGjTe3yPvX81SjHh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIFTyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgIFTyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:54:00 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E6D2208B3;
        Sun,  6 Sep 2020 19:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599422040;
        bh=oBKLczEV77qvBkz0mJGWX9SWJA35KC0/Ff6JsnS75+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IqDexc9OopTiNlPmkyHtBluvxD5NQ3BP9gq8/tpKP+k/YItX1qBcIgPW8Q+99YJa8
         fiw9GOKVDtAMwd+7l+Bmqz21e4gSE/cVI/QQDTN+p1vuHDqgemnNpxsj1YHgMjkXYN
         WQLB6hohGHHlMZ4ioPsoiRr/euBi1oOwPInQVxW0=
Date:   Sun, 6 Sep 2020 12:53:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     benve@cisco.com, govind@gmx.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] enic: switch from 'pci_' to 'dma_' API
Message-ID: <20200906125358.04be09a6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200906124541.309003-1-christophe.jaillet@wanadoo.fr>
References: <20200906124541.309003-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  6 Sep 2020 14:45:41 +0200 Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script below and has been
> hand modified to replace GFP_ with a correct flag.
> It has been compile tested.
> 
> When memory is allocated in 'vnic_dev_classifier()', 'vnic_dev_fw_info()',
> 'vnic_dev_notify_set()' and 'vnic_dev_stats_dump()' (vnic_dev.c) GFP_ATOMIC
> must be used because its callers take a spinlock before calling these
> functions.

Applied, thank you!
