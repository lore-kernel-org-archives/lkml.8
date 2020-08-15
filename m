Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6B1C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE4E20657
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529574;
	bh=p9Uh66ovclGtSaOL7rnm9s19mpJBhHaFsJcGtCuvF1w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=aNT5m6RSqyJu/zVtjsWyTfHsmT3oAOZ/Yd0z4RoG9SadPX7aKhbvjh5IbwGZbfpo2
	 qKS5kAlRrqx3DX/sr2YIk59Lml8pNBkCf5tfFjz0K9LKOT9zonI56ak89HrO/6J6lA
	 DwYCiSZNcDiIuwSpf1TCIUSNwO8mt8V9V6cCLPUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgHOWMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbgHOWK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:27 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29FFF23100;
        Sat, 15 Aug 2020 08:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597481736;
        bh=p9Uh66ovclGtSaOL7rnm9s19mpJBhHaFsJcGtCuvF1w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=znm2OHPlHUDSZLVe2MaWYZjKe+WDUywDrXyKoUS9Z4MFSrLSTusNKVpXhcTbOQJeJ
         gtXXDsnD/WHApxS0aHkRn/zrYWdVAeTPV0P92Xr4BiBKLeEyhyJQ80WQnkt1DApSAY
         wUyFruf1TLDQ0oJT5/SbJ1+3rRKOur7UPK6ID2gs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2736eaf03a5b8bf3aa4566198a98f3d2073d0070.1597236805.git.mchehab+huawei@kernel.org>
References: <2736eaf03a5b8bf3aa4566198a98f3d2073d0070.1597236805.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH] spmi: fix some coding style issues at the spmi core
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Sat, 15 Aug 2020 01:55:35 -0700
Message-ID: <159748173501.2276320.8306877664488819502@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mauro Carvalho Chehab (2020-08-12 05:53:27)
> While preparing to port the HiSilicon 6421v600 SPMI driver,
> I noticed some coding style issues at the SPMI core.
>=20
> Address them.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
