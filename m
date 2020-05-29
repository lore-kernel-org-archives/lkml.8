Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9ADC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C011320707
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590725086;
	bh=icN1xVoNEquqsO3vPZMG0OwkUxZhilB7z8RIYLsMN2c=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=sajk8DMOmNTf1P/BL2aJV3yPCsa/HHbVtHKg8KKkFNcYbxj9aKv16Z/PtjPbE8IyM
	 cD1fqncrpLhOzSeY+p9iP0k7oCY9dUh/dvri7lNnV7TxTJ+m3D2II+BN0GdNKacOEp
	 SjiHfOJdhi4/QbKF8zKZeBhWz9nZM0SQOqdpeaX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbgE2EEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgE2EEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:04:39 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F2F020707;
        Fri, 29 May 2020 04:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590725078;
        bh=icN1xVoNEquqsO3vPZMG0OwkUxZhilB7z8RIYLsMN2c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CBJ3hX+KqttD/4zMUwhKYaErxOWrG3gsiTyRSRKV8bY2yHG00I3G3oESxlQiS5q3j
         SJHeI7XpCIIuVy3d9pEAWarm2oIOScOxmhGkN5G/h65CUSGk296LeYfEwevl9qO83P
         v4LUQx7vVT1tA6fGcXBTQk67/mDA1LOfd1W1e8r8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200404161537.2312297-1-aford173@gmail.com>
References: <20200404161537.2312297-1-aford173@gmail.com>
Subject: Re: [PATCH 1/2] clk: vc5: Add support for IDT VersaClock 5P49V6965
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     aford@beaconembedded.com, charles.stevens@logicpd.com,
        Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Date:   Thu, 28 May 2020 21:04:37 -0700
Message-ID: <159072507794.69627.14228374738181598965@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adam Ford (2020-04-04 09:15:35)
> Update IDT VersaClock 5 driver to support 5P49V6965.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
>=20
> diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
>=20
> index 24fef51fbcb5..fa96659f8023
> --- a/drivers/clk/clk-versaclock5.c

Applied to clk-next
