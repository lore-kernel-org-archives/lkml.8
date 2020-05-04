Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF7BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C3D206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588611692;
	bh=mEIMvEeemT9qFPg6WFXv7L2Ou2lEHMX+SClo7n1fkh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LWCjOYlB+DIQ4CMSv24VRsqG3mgJ76A5ff1SWvevGeZ4ChEyBW2l4+GHbm3UxhLzs
	 3wcYF4ucxbGP/Xp+XSStILVBIoJyUfYjDj1SR7BOfp1p6XHiEXWUmuR7RqI0aCGtH+
	 /ZmnRzwDIZAYTJwCAh8htEHITy2jjN5Tjp7r7Uag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgEDRBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbgEDRBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:01:30 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DAFF206D7;
        Mon,  4 May 2020 17:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588611690;
        bh=mEIMvEeemT9qFPg6WFXv7L2Ou2lEHMX+SClo7n1fkh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2BygdSsFh85R9fAHagGynYsW4TX6sYVTu+7YqhxiotGbO13ggVCuL1iUIFm3mCOnr
         Q4cKHGq7/9wKuwY2yz13s+yWWLDes1Vi1SOBQzfWLaI8K0TxcsRf/xxgOvmgyDn7CL
         NQHTTugxIZCjssiCo3oUd3RgmTOp/3O6Dhx0tY7k=
Date:   Mon, 4 May 2020 10:01:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     wu000273@umn.edu
Cc:     davem@davemloft.net, oss-drivers@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kjlu@umn.edu
Subject: Re: [PATCH] nfp: abm: fix a memory leak bug
Message-ID: <20200504100128.06221170@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200502224259.1477-1-wu000273@umn.edu>
References: <20200502224259.1477-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 May 2020 17:42:59 -0500 wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> In function nfp_abm_vnic_set_mac, pointer nsp is allocated by nfp_nsp_open.
> But when nfp_nsp_has_hwinfo_lookup fail, the pointer is not released,
> which can lead to a memory leak bug. Fix this issue by adding
> nfp_nsp_close(nsp) in the error path.
> 
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>

Fixes: f6e71efdf9fb1 ("nfp: abm: look up MAC addresses via management FW")
Acked-by: Jakub Kicinski <kuba@kernel.org>
