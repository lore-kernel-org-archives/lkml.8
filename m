Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04449C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3290120855
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dVps9L/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgHFS4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:56:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:49101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgHFS4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596740190;
        bh=O7v18ExidfkwJC6p34t30rewB3wUcTv/9gRo5304iiI=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=dVps9L/lW17kPLwPVODDzPnOWmy2BFbLqE6Mvr228WmwIukZl74RdQds+V+Wi++Ih
         YpS+PL9k7txNrkvkJ17EjFPEE35+t8unMC+bq8UfoSmhJwiqYZwjupjZT7xLt8Qh9z
         +vaV7eSEZ8IIXLSvswzU8y6HciGlp1L4weap+K+c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([82.19.195.159]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MTiPv-1k9VoZ1YKL-00U5fp; Thu, 06 Aug 2020 20:56:30 +0200
From:   Alex Dewar <alex.dewar@gmx.co.uk>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Alex Dewar <alex.dewar@gmx.co.uk>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa/mlx5: Fix uninitialised variable in core/mr.c
Date:   Thu,  6 Aug 2020 19:56:15 +0100
Message-Id: <20200806185625.67344-1-alex.dewar@gmx.co.uk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0uJxosol6/FoMK5KDsqDZ5rimjr7lf6kRU2xNc+U9+4nqEeTbGN
 FcImhdy1q29bJXvqBPZ5ByLNvQ0qKlRwh+erHhPdGiZbSPrzQowWTrfAhX/3DBbRZZaa+LO
 0/xn6XMVsBgatSjfiRFbl5FaFBsyFPntJW4nAXpuK6Df/8jBBmbcnwJHAnsx9faYUhsJUww
 Y6ochxXEdmJASY2ykMP+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xg4rK1+aOZw=:ebkDZlzoeQFyzbfKmBAo/X
 kMFxmf5DUZfRh0bKT/300Vwmxur+sHO0vF1RlUhxN4n3K/QjZZOMSMLFREuYTgeJtUF/P100O
 l0IW5hek82pQQUWIMxC0XeqcvEli/kSmlqxvyWuJK7AvrlaZiS2SawnzdNX8sNc6srCQSR/nQ
 0FpFk9W4nAvitjJVawqUdYQR0x5wP3J5CifYlO2S/RYALa4VnwwQDhjiRWS6QTw3aavdv6nKY
 MWjK6H7VPAK0PhIYZ8NC0/t8yAii+Oz2QSGSCom7nQ4iPrmODThDu3EdR5KntZk7FpSZ6XmT3
 ELo0ofyvKwHLuoqw27nWNPPIdMyafdnQCb3/d6rDo8VQ3q6JHhMV0/eWAIlBiNqbSl+Layqp0
 9dLrXpMaaGw+aAj6HPNnhsJRVxZW9gFnFTNV8ikYCsVd9m3xrwp3pKUX0ldNNSpgIqV+8V5uQ
 btUq0d74Pu43K/ZqWgR9WMOYHlqvbVQWUidz9p31n7KYfgItsaiovW0EkzYa7YobNmTkNzaai
 mvwyfcxC9cYka40eSBSVlN3ECa2RrrZEWF9Kduh1i6ki9YBZaHiOJwznSUQ42G3psE1uCUXEU
 p78oI77VlHALVQpOS7B35+ccSwZXQ7VgbSFlt9XQI2DvsKjhuZH1izIVBYZ6EIAIO8C4ZX84s
 jvMCUdQeFdvYoi4kLjEiwR5fXHmNEbTP50u5MlmUNyCtPbTxGAmpkOh1BR0BxsFz+TFo7w9Uu
 5f+c2ngeL2vCD60LAyzuQ05gRfNwQGsmOaZwn4NMTYKynywQwDdt03thqjcIziPiQr63nbd6Z
 NbDYWlmGNAA//S2Jl6FoFtCcMowTovwtcREMRX4AVOAGuir4Pu1pCVguAqJoqBj/Ztj2zARSJ
 N0vk+TWqowB36G8jwIZUYmCb3+3qiP5+GmUUcovqvGDFUlPDlKJp5+9crKIXxJ1uo2U9DJS2P
 v1GwqsYmwaGn8aZ1IVXtWqwCJOUl5IJh4phbc+WleHPyN0FDi+K5wuyV19oRaDb20LtOIljXP
 XMd40EQ9Ghoahu5iWRMur4sMfa7N2B4KHXpQAlC4RP5C6Urd83HSzc2T/28jBtzA7Xk+G04pt
 NUmXVhBMwHJKLq+LaCaFBcvRUC+Wbwl//HWmZaSOoWJtvxQrvf8YeBgpCZ4t245Dudxx2Esj+
 egXHEOszLUNXv7kNDy3QcqW5sbxE2ScW1gOIG7ci3tkuf6guJ4x2f77z4KaZZbFqDFpL0WZZt
 KFWUHglwksgyBTimep1XMRSkyrhwozxiAR1sHWg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel is unable to allocate memory for the variable dmr then
err will be returned without being set. Set err to -ENOMEM in this
case.

Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
Addresses-Coverity: ("Uninitialized variables")
Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
=2D--
 drivers/vdpa/mlx5/core/mr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index f5dec0274133..ef1c550f8266 100644
=2D-- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -319,8 +319,10 @@ static int add_direct_chain(struct mlx5_vdpa_dev *mvd=
ev, u64 start, u64 size, u8
 	while (size) {
 		sz =3D (u32)min_t(u64, MAX_KLM_SIZE, size);
 		dmr =3D kzalloc(sizeof(*dmr), GFP_KERNEL);
-		if (!dmr)
+		if (!dmr) {
+			err =3D -ENOMEM;
 			goto err_alloc;
+		}

 		dmr->start =3D st;
 		dmr->end =3D st + sz;
=2D-
2.28.0

