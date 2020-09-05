Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40147C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0446B2083B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599346797;
	bh=Hyn/t8Td/dn+tJWjaQTL38yIL7zH8Bh0ooGJafQjPnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=H0XgdxNcG8LyL5NeZXBZ/Bc7usnsF1/ybwNFOycCPeG3mx9HvyzqFtVugYp0hNOiX
	 fPiaHWPrqqyz+BAr4Rk3vZ5Xc/qnziXqkmwqAfahnUkOrEziGRbzZkOK7+N+NjFhy9
	 /z3ciAR5YOBoJ9lBP6Qd+BVJNAnYLXE7YIiDN7RI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgIEW7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 18:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbgIEW7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 18:59:53 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 230E320760;
        Sat,  5 Sep 2020 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599346793;
        bh=Hyn/t8Td/dn+tJWjaQTL38yIL7zH8Bh0ooGJafQjPnk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CzIEdCUpDzyvPxI6jxnw/dud0iGUGfQRTESw3wtxSKvEHL8wMaPIZIyPNQpqLPmZr
         VeaP4+ZVZdXZyBK0XEMeUfcqq6Z5Efhm7AlwpSuBnpMPqgVy4BX+Il+PwPOUX4bBmV
         Oh5Oh+jMPA+65wx+zlWdjpAvCZGwsgDD7lqAgurA=
Date:   Sat, 5 Sep 2020 15:59:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] caif: Remove duplicate macro
 SRVL_CTRL_PKT_SIZE
Message-ID: <20200905155951.523cb682@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200904125858.16204-1-wanghai38@huawei.com>
References: <20200904125858.16204-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020 20:58:58 +0800 Wang Hai wrote:
> Remove SRVL_CTRL_PKT_SIZE which is defined more than once.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Applied, thanks.
