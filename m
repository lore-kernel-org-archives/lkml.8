Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33AAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCE4A20888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590627688;
	bh=/lwQt5sScTOku9hoOrEpY8PEqw7NaqilOz/g2szpnDw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=PYXKDpNTAXS0g6rcVIMnL8RBlyff7sDndyKZVVXpNzSbvggbNYGW1CmneDKVLULzy
	 jYIQm1iu3IyMgL2qC/nrrCL+yDBoh5/IBE5BRVpUAAvlGyLPuAXPbNpR/+7fpeZmPT
	 4ZlpztfDTtICngWtgLLLm66TP3NdBbGKc3YQTibo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgE1BB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgE1BBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:01:25 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B69120888;
        Thu, 28 May 2020 01:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590627685;
        bh=/lwQt5sScTOku9hoOrEpY8PEqw7NaqilOz/g2szpnDw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bI87KG6sUzm7IkjFs0dkUsm3KTrMnL36yp98x3Hq2fdv3jybd24/efRNO1qiPN7Mh
         zORSkep/ldt3wTCBnbAORUcAbYdU+HEHlBEAmiMj0Olrwa7mquBI3q4WESkNTekK7T
         kztXJugYN8I8oscJbjpJ+JGk59hvc2CyORtNywEM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200519224151.2074597-9-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk> <20200519224151.2074597-9-lkundrak@v3.sk>
Subject: Re: [PATCH v3 08/13] clk: mmp2: Add the audio clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Wed, 27 May 2020 18:01:24 -0700
Message-ID: <159062768433.69627.13220952420201356980@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-05-19 15:41:46)
> This clocks the Audio block.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-next
