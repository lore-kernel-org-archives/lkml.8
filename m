Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2629C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26AB2224D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739622;
	bh=Y0WLyMYc/6bL6sF+tllMOotA+LW00xdgYY/+OD2U6vU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ehfb37uTgBCLQvdYiPgjLzx3ryYLSx3Nqp08kjK9joh2fPLYPD0vY+yy+E6/VFTf8
	 QyfkFqdoccQFWYVbyrxhO/x8RZOP0peLwJ6lkKZc4JCDwcNijxY/1rublxIuyi4fBm
	 K4hVUZh9LHyR5mVUXBKEPve/0lmlcYgmF7JOA07U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgHFSrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgHFSrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:47:00 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0EB520855;
        Thu,  6 Aug 2020 18:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596739620;
        bh=Y0WLyMYc/6bL6sF+tllMOotA+LW00xdgYY/+OD2U6vU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PLgazSnh6Q7APAOQ9R2fEqDg3eJ4DImjX6Wk/9tQpbYrG5For71BgmDQraXcuOZpT
         YlLeFd2JjAqBeXiGVCqAgj2Ti3AKcgE9K3ByGwRJl7SDifQRfAF5aM70EGZHVbs/rp
         y6+jtIYUseHPvJviOSur5eW3dE5xTX2JRH4naccU=
Date:   Thu, 6 Aug 2020 11:46:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/tls: allow MSG_CMSG_COMPAT in sendmsg
Message-ID: <20200806114657.42f1ce8c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200806064906.14421-1-r.czerwinski@pengutronix.de>
References: <20200806064906.14421-1-r.czerwinski@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Aug 2020 08:49:06 +0200 Rouven Czerwinski wrote:
> Trying to use ktls on a system with 32-bit userspace and 64-bit kernel
> results in a EOPNOTSUPP message during sendmsg:
>=20
>   setsockopt(3, SOL_TLS, TLS_TX, =E2=80=A6, 40) =3D 0
>   sendmsg(3, =E2=80=A6, msg_flags=3D0}, 0) =3D -1 EOPNOTSUPP (Operation n=
ot supported)
>=20
> The tls_sw implementation does strict flag checking and does not allow
> the MSG_CMSG_COMPAT flag, which is set if the message comes in through
> the compat syscall.
>=20
> This patch adds MSG_CMSG_COMPAT to the flag check to allow the usage of
> the TLS SW implementation on systems using the compat syscall path.
>=20
> Note that the same check is present in the sendmsg path for the TLS
> device implementation, however the flag hasn't been added there for lack
> of testing hardware.
>=20
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>

I don't know much about the compat stuff, I trust our cmsg handling is
fine?

Just to be sure - did you run tools/testing/selftests/net/tls ?
