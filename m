Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1483FC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94F320752
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584753930;
	bh=+p0Klu0jDZrr7ZmPTQbGJqZmG+d/hb3NZuytHTg7YWE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=EKSTzUZX3QehjJUFOmJwqVLNwhpNa6dgFT9ticMJbH3hSawyjouMngxmfN6lWpTfF
	 QC9Ng/Unw0Py9q5eh89EjL5uszFZu2cROBud0x+Mkdc5hvBee2CUUNKrhmWXASOXk8
	 pKDU1JEW2aVCr7YK4bg7aizl0W2u0krJoSdpEsVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgCUBZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 21:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbgCUBZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:25:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD8C420732;
        Sat, 21 Mar 2020 01:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584753928;
        bh=+p0Klu0jDZrr7ZmPTQbGJqZmG+d/hb3NZuytHTg7YWE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CGV32s7GbEbKbk/XRfskUUXN+VoosXWsyt8sLpXova7D+KTVzOLZk3QPQF3oCUyZm
         qMO2VCtrGI5VArFfXE3+8EkVjV5LbtNH94uMl0GABYIxhR7nCvF9YXeJuVsdw+kZ9P
         94u7Wl3UP6Ph3ZlHtxEGQVje/TdUJjwOElQip834=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309194254.29009-16-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk> <20200309194254.29009-16-lkundrak@v3.sk>
Subject: Re: [PATCH v2 15/17] dt-bindings: marvell,mmp2: Add clock id for the fifth SD HCI on MMP3
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Fri, 20 Mar 2020 18:25:27 -0700
Message-ID: <158475392718.125146.10468033951768755643@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-03-09 12:42:52)
> There's one extra SDHCI on MMP3, used by the internal SD card on OLPC
> XO-4. Add a clock for it.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> ---

Applied to clk-next
