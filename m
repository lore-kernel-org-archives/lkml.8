Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748BFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D1A208A7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590541282;
	bh=NtZy5/K3/zCTcG/yP4zAKmzCDT70slJ8ic2T/Pp+kCg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=KNkDLF2Uyy41o+QRqN1guvHSwwB9A4nT8Qug8vY0ZjOcNsqS2fNFhOr328Lm3zxQS
	 Mlb9MG/gtSisUwwdP70UQnx6XwJoG9W8crwAaRuztDdYCJ3zOJhYasqocsB8YOLreI
	 ifodIPSP5fVnMJ2b8Y3DUUdDV+FeRXKHHHAQ/1sA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgE0BBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:32924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbgE0BBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:01:21 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E9B2089D;
        Wed, 27 May 2020 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590541280;
        bh=NtZy5/K3/zCTcG/yP4zAKmzCDT70slJ8ic2T/Pp+kCg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=F/+TmWTl8teuTFMAfcjl519GMYb1JpQU7IFk0YGOjpJzSWNT9tSOh/sqLuXF9qwNZ
         uRXemv0/3ahLWAbpwAjrX98j8AAMFhSPx9ZmBRWCUVuBzuSa5yQITiCfx3lUpkEqTa
         pB5Ig7CDi1s2TVLG0PdGmP4eO2PqgUkABQPIza/E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1583185843-20707-2-git-send-email-jolly.shah@xilinx.com>
References: <1583185843-20707-1-git-send-email-jolly.shah@xilinx.com> <1583185843-20707-2-git-send-email-jolly.shah@xilinx.com>
Subject: Re: [PATCH v2 1/4] drivers: clk: zynqmp: Limit bestdiv with maxdiv
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
To:     Jolly Shah <jolly.shah@xilinx.com>, arm@kernel.org,
        linux-clk@vger.kernel.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, olof@lixom.net
Date:   Tue, 26 May 2020 18:01:20 -0700
Message-ID: <159054128018.88029.11167718877921501862@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jolly Shah (2020-03-02 13:50:40)
> From: Rajan Vaja <rajan.vaja@xilinx.com>
>=20
> Clock divider value should not be greater than maximum divider value.
> So use minimum of best divider or maximum divider value.
>=20
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> ---

Applied to clk-next
