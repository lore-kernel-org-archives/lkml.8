Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2844DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1AC9206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593533567;
	bh=owmaLgZhLsBtFwWqdKpAtQq7cNhD5zxKybF7zSfyAVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=q99+ZuDAJFLRnXfmb18qhDgp1rSsspWsl6se2jUuVpMpJYFj3+wjBYrWg4Kn1tHF7
	 KKMIPUFaCIY67t6Iu5lHyD7Ke8GzYCQH8tawdIbU0f71Sakiw+g4St+q593yQ2CM/9
	 rxI1V0nXTJwSEyIJSEPaHOALp48j9Via9vloO3/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbgF3QMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgF3QMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:12:45 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3C77206A1;
        Tue, 30 Jun 2020 16:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593533565;
        bh=owmaLgZhLsBtFwWqdKpAtQq7cNhD5zxKybF7zSfyAVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PxPvwaOJV4DgQE5vXhGqjfatDncv7xf5K7I9Ksimy5Dnifhpbmm0NVAim0a1Jp4VN
         rnNJRp5a3jN0PZ1fA4MBafFGAwEvS9zD0i8ee589axHp9si4zwB3lsT8JrTx9LQINI
         kNZT28DRdy7g3RhnVh2thCmYHJ0gXPQRcevWOKsM=
Date:   Tue, 30 Jun 2020 09:12:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     <nikolay@cumulusnetworks.com>, <roopa@cumulusnetworks.com>,
        <davem@davemloft.net>, <jiri@mellanox.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bridge@lists.linux-foundation.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next 2/3] bridge: mrp: Add br_mrp_fill_info
Message-ID: <20200630091243.124869e2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200630134424.4114086-3-horatiu.vultur@microchip.com>
References: <20200630134424.4114086-1-horatiu.vultur@microchip.com>
        <20200630134424.4114086-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 15:44:23 +0200 Horatiu Vultur wrote:
> Add the function br_mrp_fill_info which populates the MRP attributes
> regarding the status of each MRP instance.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

This adds warnings when built with W=1 C=1:

net/bridge/br_mrp_netlink.c:316:9: warning: dereference of noderef expression
net/bridge/br_mrp_netlink.c:325:36: warning: dereference of noderef expression
net/bridge/br_mrp_netlink.c:328:36: warning: dereference of noderef expression
net/bridge/br_mrp_netlink.c:316:9: warning: dereference of noderef expression
