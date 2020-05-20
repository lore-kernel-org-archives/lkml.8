Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89A0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B845C207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589969710;
	bh=eMxMVy+5ObFSa7X4PkqHTUtOM18qhbQrrWDasUwzbe8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=zG/myksZggFQG0mWp7/15wJ6PZtz0U9N5LVQzaPZyO3Is0QpLXykNF9f5Zv6MyQQP
	 PDVIhuDLUS7iIHD7hTuMflVtUE9dwf9fovCdhoi5xF3iSwwhMs237nzswutZZ3PK6D
	 u0km2rkr9+81iVzCl9oPk75x8kHXDRpo2umqVx00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgETKPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgETKPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:15:07 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF73207D3;
        Wed, 20 May 2020 10:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589969707;
        bh=eMxMVy+5ObFSa7X4PkqHTUtOM18qhbQrrWDasUwzbe8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TtB15Z1E67LS1rghb8AaDiFb+mibHFgh8j8fXQpXD/dxajYz3JKznf4b1kVD0kQD3
         1MD0NQBcLrOIOEIicoNt6hejb00B+7NBHQ65lIpYagezTmYVye9BeEMl6KOPLnYqZv
         cYUqahgKHhBh3t7K8ftJAkkwDxQpuuG/nYvgPsys=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200518113156.25009-2-matthias.bgg@kernel.org>
References: <20200518113156.25009-1-matthias.bgg@kernel.org> <20200518113156.25009-2-matthias.bgg@kernel.org>
Subject: Re: [PATCH 2/4] clk/soc: mediatek: mt6797: Bind clock driver from platform device
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mtk01761 <wendell.lin@mediatek.com>, devicetree@vger.kernel.org,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-mediatek@lists.infradead.org,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Richard Fontana <rfontana@redhat.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, matthias.bgg@kernel.org
Date:   Wed, 20 May 2020 03:15:06 -0700
Message-ID: <158996970679.215346.601357207492478540@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting matthias.bgg@kernel.org (2020-05-18 04:31:54)
> From: Matthias Brugger <matthias.bgg@gmail.com>
>=20
> The mmsys driver is now the top level entry point for the multimedia
> system (mmsys), we bind the clock driver by creating a platform device.
> We also bind the MediaTek DRM driver which is not yet implement and
> therefor will errror out for now.
>=20
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
