Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6870AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A5C2177B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599512351;
	bh=XXdJdrXSDXXRuKqiD07l3whQ+kMfrHo1hVSzCvy3FBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KG28VIdzemixuk23aAwqWC8rZ8DKDQFvJ0BtOqGD3+t2GMLxIeOfHMUkWTixZFrji
	 4kVGw0Dc+vViF1B3scq1GE2zykn3QsAl/NMuYbWVSI1gDJ8GT7qfsq9fO03qEYOob0
	 BHdzVbFODik2Xpr99cO//n5qBiv+cG+9TFM7goOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgIGU6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 16:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgIGU6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:58:45 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 561CA215A4;
        Mon,  7 Sep 2020 20:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599512324;
        bh=XXdJdrXSDXXRuKqiD07l3whQ+kMfrHo1hVSzCvy3FBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f6w0qWtwCnfg0gdQDKslSFNp8X6yyTJYQ0jJMUW7IVqQp+HyMVb+7MHVpr6tZgfFu
         530Ri/dV1aaN2AuwAX8veEqNb975usJT5jVm5bPMRHqQye6Q8zy6/P5APn6e/aRgVg
         QEpRYUxy8eRfCoIkG8vBbLqfNWrr+fJBg/wpMN+k=
Date:   Mon, 7 Sep 2020 13:58:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     <davem@davemloft.net>, <f.fainelli@gmail.com>, <timur@kernel.org>,
        <zhengdejin5@gmail.com>, <hkallweit1@gmail.com>, <leon@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ethernet: dnet: Remove set but unused
 variable 'len'
Message-ID: <20200907135842.38f0c211@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200907141207.11778-1-wanghai38@huawei.com>
References: <20200907141207.11778-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Sep 2020 22:12:07 +0800 Wang Hai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/net/ethernet/dnet.c: In function dnet_start_xmit
> drivers/net/ethernet/dnet.c:511:15: warning: variable =E2=80=98len=E2=80=
=99 set but not used [-Wunused-but-set-variable]
>=20
> commit 4796417417a6 ("dnet: Dave DNET ethernet controller driver (updated=
)")
> involved this unused variable, remove it.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

tx_status is also not used. But I guess one change per commit,=20
so applied. Thanks!
