Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7527CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FA20221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596823485;
	bh=RSMl2ntL1d76/kc9CXYy5VSQyaNgn/6MPpZbXP7P/XA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IAIRkow3kHAHS1/+56sNltb0pFWXGcj9WeU+m/Fu+tjbghkO21tzsOI1b3u9NMea0
	 MXSG8+z/tLe9SE1D3rHzM53vPro8+XXD3N5PwwImaYvB1dZx2eeAB0OZzuYs/BS0b1
	 MAPTn4o+E0/k0m3GnuBpHHxTtpMXIMpZ0ax/ibeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgHGSEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 14:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbgHGSEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 14:04:43 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 042592075D;
        Fri,  7 Aug 2020 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596823483;
        bh=RSMl2ntL1d76/kc9CXYy5VSQyaNgn/6MPpZbXP7P/XA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xQI9JWhQeMl9te6tCLjVG1xmKiJmpQPyZq6saJBGt2Xpe6QETkpNJ1fz/Drv4Vzq4
         crvt1UdI/qDBy/SC9igWTltdlstoOHfKHAxzU//IY+wREgETK3e/0gwVDSI8gTaPN/
         iEmyxIu4CY0Wp+dxWE9fVB9z4G9s2YRUF2XXdKGY=
Date:   Fri, 7 Aug 2020 11:04:41 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     Pooja Trivedi <poojatrivedi@gmail.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 net-next] net/tls: allow MSG_CMSG_COMPAT in sendmsg
Message-ID: <20200807110441.6df98445@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <f088c78e335653c8e07d6f304b5995602ee7398f.camel@pengutronix.de>
References: <20200806064906.14421-1-r.czerwinski@pengutronix.de>
        <20200806114657.42f1ce8c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <b55718ad4e675ed9a9c3eb1c5d952945f8b20c7a.camel@pengutronix.de>
        <f088c78e335653c8e07d6f304b5995602ee7398f.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Aug 2020 14:27:48 +0200 Rouven Czerwinski wrote:
> I just tested on my x86_64 workstation and these specific tests fail
> there too, do they only work on 5.8? They were added in 5.8, but I am
> running 5.7.11 here. It looks like these failures are not
> MSG_CMSG_COMPAT related.
>=20
> Pooja Trivedi do you have an idea?

=F0=9F=98=AF

We need this:

https://lore.kernel.org/netdev/1591392508-14592-1-git-send-email-pooja.triv=
edi@stackpath.com/

Looks like it never ended up getting applied to any tree.

Pooja is that the case? Could you please resend without the RFC tag?
