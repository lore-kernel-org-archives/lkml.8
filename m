Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FBBC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE74221741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580930623;
	bh=ktriyZSNaJk0LPZkbijLldVFqkClsDP2Z2k22uVPmQc=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=RmKCmyM+2YaZv8PWf86eChpHP+7whAnL1HkZyy0ApuabhSGzKFQDAvgXO4hPgkHn1
	 9uihtq6iEDiDeag5124qDptXu4an+pOf9NKdN9DASUahK11jRYQNI/CFgDhEKfuB9C
	 5UTnsNVQ0TVKxni0dtedaW9MtDxRjJq5jxyIUIkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgBETXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:23:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbgBETXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:23:42 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4E482072B;
        Wed,  5 Feb 2020 19:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580930622;
        bh=ktriyZSNaJk0LPZkbijLldVFqkClsDP2Z2k22uVPmQc=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=L0ugEpXrdMs+tNELmbCfoExJ+gFCTqDLBwPSsgW5bja5h2t3fvi8igAu+ZEZlRljj
         grJ0eEFaru6XT6A0CUbLHWUAeiWBCJVzgXDhpNyA0Rot90HCz7N44YwL5Xi+5rnhI4
         bnz96kPeegP3WXd4SwEGhFbl1HkPouTLTgUqjYt0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1580235801-4129-3-git-send-email-skomatineni@nvidia.com>
References: <1580235801-4129-1-git-send-email-skomatineni@nvidia.com> <1580235801-4129-3-git-send-email-skomatineni@nvidia.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH v1 2/5] clk: tegra: Add Tegra210 CSI TPG clock gate
To:     frankc@nvidia.com, hverkuil@xs4all.nl, jonathanh@nvidia.com,
        skomatineni@nvidia.com, thierry.reding@gmail.com
User-Agent: alot/0.8.1
Date:   Wed, 05 Feb 2020 11:23:41 -0800
Message-Id: <20200205192341.E4E482072B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sowjanya Komatineni (2020-01-28 10:23:18)
> Tegra210 CSI hardware internally uses PLLD for internal test pattern
> generator logic.
>=20
> PLLD_BASE register in CAR has a bit CSI_CLK_SOURCE to enable PLLD
> out to CSI during TPG mode.
>=20
> This patch adds this CSI TPG clock gate to Tegra210 clock driver
> to allow Tegra video driver to ungate CSI TPG clock during TPG mode
> and gate during non TPG mode.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

