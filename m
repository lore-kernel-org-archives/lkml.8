Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97CBC2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899BF20769
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589319978;
	bh=ulLHlolQRXsWXYiTML1BrCYngQd1LDZaMS96rMIfDoI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=t/wRzmgDF9QX9n7Mc/diJX2hbQiTnOZTT87AkSrNvOsQ0lG3gKmgx0MoqTDE3VvDZ
	 Dit9I0Jd3V0ECWy1fmhXYlJuX+3+JBOgb3akSWUDKVT0W/+0/nrXpI14Stf7ttMS+O
	 YbTw7gmvNEmNeCbF63G2Hv6wMrZ1dfv+ODMTXhZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbgELVqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731065AbgELVqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:46:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B883620731;
        Tue, 12 May 2020 21:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589319976;
        bh=ulLHlolQRXsWXYiTML1BrCYngQd1LDZaMS96rMIfDoI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=W+OUlqzrI5Ge8FBittf7LcuviYyZbh7RW04rzXj0LXbJmBI7zFX31BvgYAIo1XAQM
         XL8YFWUp3Nkbad2exsH3fZKlopfu4Zg7IUCUf1Q0UnAw/lmuhbuuVc7STGue7Ix1Pc
         C1xok6HYkI+k+YIz7N4plBlZmqeamDeYPfz3+OZc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200512204543.22090-5-robh@kernel.org>
References: <20200512204543.22090-1-robh@kernel.org> <20200512204543.22090-5-robh@kernel.org>
Subject: Re: [PATCH 5/5] dt-bindings: Fix incorrect 'reg' property sizes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Date:   Tue, 12 May 2020 14:46:16 -0700
Message-ID: <158931997603.215346.13048447179585746005@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2020-05-12 13:45:43)
> The examples template is a 'simple-bus' with a size of 1 cell for
> #address-cells and #size-cells. The schema was only checking the entries
> had between 2 and 4 cells which really only errors on I2C or SPI type
> devices with a single cell.
>=20
> The easiest fix in most cases is to change the 'reg' property to for 1 ce=
ll
> address and size. In some cases with child devices having 2 cells, that
> doesn't make sense so a bus node is needed.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org> # clk
