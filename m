Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543A8C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0DB208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599419413;
	bh=b2hffITCQLHVhSCzjb+Yhuwv2ukX2lqF/tVgU+8ruBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TyV4eH6RyRzLFjfQ3wzrlk1nx5qWTQh1omPItwdJk1cHnGUxXfyV9KRqI8QSUIULO
	 qboVtqQZUyBnNm7BwQ7jaX78jFGfreHdacmRGJ4RfmpLKE8G5VohwEMKQB3xcp1mwO
	 vQpmStLog6FqTFb0gR4n8XHOJtBkFjtj02kez/8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgIFTKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 15:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgIFTKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:10:10 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90BF32080A;
        Sun,  6 Sep 2020 19:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599419410;
        bh=b2hffITCQLHVhSCzjb+Yhuwv2ukX2lqF/tVgU+8ruBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pr+DXxLfs4uVqqdJ3J2q85QUhBumPL2DGZZl3vnDNBbq1MXqkQObO3/IEmDux7i/X
         zmAI9pq7UfNwQrXFNmCUPL2DZ4LDucdhdk3gqJ9n8QVLGvoiD8BKZbJW6ZQQjnuOph
         uVrGJm3Lw3vMz0Cgs7UfwvanlEgwKBaA2OHKXK1s=
Date:   Sun, 6 Sep 2020 12:10:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <davem@davemloft.net>, <steffen.klassert@secunet.com>,
        <willemb@google.com>, <mstarovoitov@marvell.com>,
        <mchehab+huawei@kernel.org>, <antoine.tenart@bootlin.com>,
        <edumazet@google.com>, <Jason@zx2c4.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: Fix some comments
Message-ID: <20200906121007.60e278e8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200905091448.48165-1-linmiaohe@huawei.com>
References: <20200905091448.48165-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Sep 2020 05:14:48 -0400 Miaohe Lin wrote:
> Since commit 8d7017fd621d ("blackhole_netdev: use blackhole_netdev to
> invalidate dst entries"), we use blackhole_netdev to invalidate dst entries
> instead of loopback device anymore. Also fix broken NETIF_F_HW_CSUM spell.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Well spotted, but these two changes are in no way related, could you
please send two separate patches?
