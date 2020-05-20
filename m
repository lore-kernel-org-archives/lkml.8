Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77E6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D86E207FB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589969699;
	bh=dGUj99gzXY06Ph2uQbINIui/Po2hcUJT7cvDYVsUmes=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=vSKf28hw5RoF0d5IcaJXr9WIWGuvjt8ZOqX/NMwawoq1dajXerfVf96z5WegCppPo
	 u3TuJrQRaFG7HPohEN42TLKTk98zcJypNXmsRhHwbdOERnIPOSx3n28+qcicZeFg4L
	 Lq1km5S01WWGgXgDigUqC2+oUGfY7VMGF7Eg5sHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgETKO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbgETKO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:14:58 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BDDB207D3;
        Wed, 20 May 2020 10:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589969698;
        bh=dGUj99gzXY06Ph2uQbINIui/Po2hcUJT7cvDYVsUmes=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dePu7an5ZSMVnviDA4Y84qjHZMHl+rGi1sTamWoGHFNkcAybuBac6819EU6iFPapE
         qdMJ6DJDGDlPPaI1PxUsPapHOUOgOLujLBcGk9D6lif2U6u6fEljeKYT9axg6PSuWl
         FGw7bLCiOCdPTwBaILQusl4OzR/fF0WyoET7rZQE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200518113156.25009-1-matthias.bgg@kernel.org>
References: <20200518113156.25009-1-matthias.bgg@kernel.org>
Subject: Re: [PATCH 1/4] clk/soc: mediatek: mt8183: Bind clock driver from platform device
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mtk01761 <wendell.lin@mediatek.com>, devicetree@vger.kernel.org,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-mediatek@lists.infradead.org,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, matthias.bgg@kernel.org
Date:   Wed, 20 May 2020 03:14:57 -0700
Message-ID: <158996969738.215346.5933135216459465754@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting matthias.bgg@kernel.org (2020-05-18 04:31:53)
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
