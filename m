Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C56C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1104206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582329454;
	bh=lcNJ4N2cNdsfaAhCE0btC66qSo+qzJsDMEfe43gVqUs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=UJtaacnpHxhYzMQ3i3Kl3xDr5ALiKjBvCFtomSQusEY0zvZksOOfZPnm6TjbfnlRO
	 muqEKncJ+EyclwjHK1+6a+kC/r7oPYKwmlDA0KlRnszvfqqhxpwqMbT8AcSRce5GGB
	 M9AXchhnJjWZC9gbckGLktaFr2HuasoFWM2zJz0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgBUX5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:57:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:34950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgBUX5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:57:33 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EDC92068F;
        Fri, 21 Feb 2020 23:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582329452;
        bh=lcNJ4N2cNdsfaAhCE0btC66qSo+qzJsDMEfe43gVqUs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=W+HysxCObViod/QRMGereEr4TyfFwvortsYBGG0TujR7rAUuIScNbRtgW0W2UDFm+
         n5isUNsA+YGoqqbquxCRFcqpyybhNtPRwPGO3W3mwkGmHrVyOl3eCZyJT708GW5vrJ
         bqxPfr2TeGHlJkn1TKrm8UigSVgqW6XvNUzcsYHs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582268376-1672-1-git-send-email-Anson.Huang@nxp.com>
References: <1582268376-1672-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH] clk: imx: clk-sscg-pll: Drop unnecessary initialization
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        festevam@gmail.com, heiko@sntech.de, john@phrozen.org,
        jonas.gorski@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Fri, 21 Feb 2020 15:57:31 -0800
Message-ID: <158232945185.258574.18038079737425200654@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-02-20 22:59:36)
> No need to initialize 'ret' in many functions, as it will get
> the return value from function call, so remove the initializtion
> of 'ret'.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
