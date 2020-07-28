Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4306FC433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182DB2065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595963734;
	bh=Qd59wd3izmmkxlJvLgZuIyOO6hBZW915rmrytim7/ms=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=WgMMltG7FywOysLkb3KpFB6NlTJOzh2wroRt68B0/hQcB632/6Gy7GYhuprEABKUz
	 l1DvCw3w2Xa6XVVyCzQDJFa6I2p9TbHmHL5ydAmH3vMDOwgztybH5hmvs0EL62sghK
	 1wek+E0WR5HRu7IMgFJoE8E8vA7t208QIMls7wUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbgG1TPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732631AbgG1TP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:15:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC99C2065C;
        Tue, 28 Jul 2020 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595963728;
        bh=Qd59wd3izmmkxlJvLgZuIyOO6hBZW915rmrytim7/ms=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dRlhxuGafyckGjq+tLKrbmQN4gTbtBZJygDY4sJJNi8TllUwi1qfodRS5NQ91S1ff
         8+RF3F9bF8lRvEe7cg5yzijPV9vnW4v73MXEXVKYn+yNivLocm1iFN7F0nObrffWJX
         kqp+UvTlKoTkHW2+msPAGlLTEVBKUVH91yenF/LY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595926999-14934-2-git-send-email-peng.fan@nxp.com>
References: <1595926999-14934-1-git-send-email-peng.fan@nxp.com> <1595926999-14934-2-git-send-email-peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/2] clk: imx: imx8m: use devm_of_clk_add_hw_provider()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
To:     abel.vesa@nxp.com, festevam@gmail.com, peng.fan@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Tue, 28 Jul 2020 12:15:26 -0700
Message-ID: <159596372694.1360974.17715148016737584628@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting peng.fan@nxp.com (2020-07-28 02:03:19)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Use devm_of_clk_add_hw_provider() to simplify code.
> To i.MX8MP, also add err handling.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
