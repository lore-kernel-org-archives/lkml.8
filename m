Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F56EC43333
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE95C20753
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584751878;
	bh=/X4IyP+E38WVsHXgZMdfX7uFKgdBDPBpd/iwdy0faCk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=DFAInQyJ+HGGa9HkrKk8grpIdBRR6n35bUQpOEZR+/WJsTNm9GsODwI8CICF9mz0I
	 2/vJN8X8KSZY8JCUYwiSKOaEtbBluC7xGEaBacPEdBWfFQiQ2W83tMQUoLw0mgW0W3
	 YG+ylLee0CR8wFAxaQJenJ3duFvBstVsD4eC7Y2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgCUAvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgCUAvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:51:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 032432072D;
        Sat, 21 Mar 2020 00:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584751877;
        bh=/X4IyP+E38WVsHXgZMdfX7uFKgdBDPBpd/iwdy0faCk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BdPC3BMmEkyGL67czhOd3nliW9rEy8Y4yr5x/2ugrLWd1UImDuX+5cn7ABzBLR1h2
         goh8K4r0TC8fzLllHoUBfhYJ8iG+uPPVmhMbrJy0ezNtt06a7Hji8VU0Mj1irvxip8
         GS4g0lodOp846JO2LE+RErB3yKzr83N9LuD3ogRc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1583226206-19758-8-git-send-email-abel.vesa@nxp.com>
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com> <1583226206-19758-8-git-send-email-abel.vesa@nxp.com>
Subject: Re: [RFC 07/11] dt-bindings: clocks: imx8mp: Add ids for audiomix clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Lee Jones <lee.jones@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Fri, 20 Mar 2020 17:51:16 -0700
Message-ID: <158475187625.125146.13295001565504238093@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2020-03-03 01:03:22)
> Add all the clock ids for the audiomix clocks.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
