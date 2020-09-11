Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE93C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D7820758
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599839135;
	bh=1TJNDk0xAOMjFGiWY1ZuK/p0447AYGrttVbGr6hFLps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cFbJTOIl0ZicdQ+1o65UUQWb21oBdxpZ3BAWlH8GQt7qgH76MQLM7UaYbSMUxthrF
	 hWWhmBbd1sfdHV1wn/cCO+NHg3BbMFbMojfjBrp4Biviw/mwdRqci8wBAEFNk76k82
	 TlqbzrgVbqBBmNaDdsllFB9Pp6oLGi31vJ8B1ktU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgIKPpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgIKPi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:38:27 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78C8A2073E;
        Fri, 11 Sep 2020 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599838706;
        bh=1TJNDk0xAOMjFGiWY1ZuK/p0447AYGrttVbGr6hFLps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aMPq+EsPCqlwrEfENy02pSgs7cfmRMdwr//SfLBwWggO37sXei//myacnHRM70l38
         jOyCJGCTlbx8zre1H1varU1wNLs8e/LTu607QUBU5oNqsrM//QpBgsTLRV0+5rbqSt
         3fDMfRTPqS3hvQB8FqQtAi/DaUbrxVRSZrNA3ov4=
Date:   Fri, 11 Sep 2020 08:38:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo Jiaxing <luojiaxing@huawei.com>, <mcoquelin.stm32@gmail.com>
Cc:     <peppe.cavallaro@st.com>, <alexandre.torgue@st.com>,
        <joabreu@synopsys.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH net-next] net: stmmac: set get_rx_header_len() as void
 for it didn't have any error code to return
Message-ID: <20200911083825.55eb2f49@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1599796558-45818-1-git-send-email-luojiaxing@huawei.com>
References: <1599796558-45818-1-git-send-email-luojiaxing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 11:55:58 +0800 Luo Jiaxing wrote:
> We found the following warning when using W=3D1 to build kernel:
>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:3634:6: warning: variab=
le =E2=80=98ret=E2=80=99 set but not used [-Wunused-but-set-variable]
> int ret, coe =3D priv->hw->rx_csum;
>=20
> When digging stmmac_get_rx_header_len(), dwmac4_get_rx_header_len() and
> dwxgmac2_get_rx_header_len() return 0 only, without any error code to
> report. Therefore, it's better to define get_rx_header_len() as void.
>=20
> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
