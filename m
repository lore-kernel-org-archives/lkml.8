Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61F7C43333
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B97020788
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584749159;
	bh=kniQ00n6e7dJMHTG46vlZNMPMQFoOfnU25ohABa0Sqs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=2NXIhXuOlam7ZKRrr3kZ8vrmzLKWkvcXwMLeaxVpBDRxiiS0qbmwmsW14HsiLlkat
	 US+2Fmx0cfupanXr4ueiCXGu7AHLVHkAolZX6MXKClA9fA32EvrPzMQ0EsrFYZbwzB
	 T/pnALLVf8FIZod8B5Y7ZHbrji/ngBOoVfoLXVcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgCUAF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCUAF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:05:58 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8D0D2076E;
        Sat, 21 Mar 2020 00:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584749157;
        bh=kniQ00n6e7dJMHTG46vlZNMPMQFoOfnU25ohABa0Sqs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pz9BKhcOvFXO4B4aS2h067l28uttJYF0tQa2mm1maS0HRuKDf1ZBYa4NrwLx20QQ+
         YsfbJs5KlpxOWZUZIXddXJX0spcigsm60r5uv5u7Zxx+Hyk05q8qHXrLKuxYR68xIQ
         xmCYqLfpYKApDnuA/zUttb4M2ty5IKiRA2ZxCZ0c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200227053529.16479-2-vigneshr@ti.com>
References: <20200227053529.16479-1-vigneshr@ti.com> <20200227053529.16479-2-vigneshr@ti.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: Add binding documentation for TI EHRPWM TBCLK
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Date:   Fri, 20 Mar 2020 17:05:57 -0700
Message-ID: <158474915701.125146.6394913906034947488@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vignesh Raghavendra (2020-02-26 21:35:28)
> Add DT bindings for TI EHRPWM's TimeBase clock (TBCLK) on TI's AM654 SoC.
>=20
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---

Applied to clk-next
