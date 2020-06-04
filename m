Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B6CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97C2207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591245649;
	bh=13tLzVtmrPoCVWrBPWoOY0F4+WIdkvFKkcoN1yl+MH0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=s/bSnoG2+mju5Vj2d9Z+iHhedixgkY4vHnxQECLiSV6eGR1q1ZUvtFCbjaKQ/F1d4
	 7i4vh80yB3ZwakOvMbb+rb94iXyAef1CnLzO+TIw0Dq9BYf2/SfHLEJSCyoV+xNQvP
	 +O1xL/2CkWRoqe8WRQwglq+9pnzg4nmo0IlC9FIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgFDEks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 00:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgFDEks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 00:40:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACF4A2072E;
        Thu,  4 Jun 2020 04:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591245647;
        bh=13tLzVtmrPoCVWrBPWoOY0F4+WIdkvFKkcoN1yl+MH0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=frhnRWAKp2lW4rQNOfVFrP4rn96xX6cZ26uWHBlxtGm3C90HY2rneICf/wUkhBuMM
         eZAuEIKKvg2ZG3GZ2GWWot6/CeZQHmF97Bfqmh3z2X6dQjaV7QklQFXIURVesn6QUm
         sRpytvTHD6Vb65AnaVPe0rkOnrqmaaT1JESSYmXI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1591234387-15059-1-git-send-email-Anson.Huang@nxp.com>
References: <1591234387-15059-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH V2] dt-bindings: clock: Convert imx7ulp clock to json-schema
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Wed, 03 Jun 2020 21:40:47 -0700
Message-ID: <159124564701.69627.4748922307258479623@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-06-03 18:33:07)
> Convert the i.MX7ULP clock binding to DT schema format using json-schema,
> the original binding doc is actually for two clock modules(SCG and PCC),
> so split it to two binding docs, and the MPLL(mipi PLL) is NOT supposed
> to be in clock module, so remove it from binding doc as well.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
