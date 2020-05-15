Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B53C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F8320758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589557683;
	bh=fY7QOXGBh0lpGAIxCDNmsPeDdy5A2yrYmjB29nGWprQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=BxjLXmVWKZindkudpYvJcZtfIW7h35YtJFe4kUe6w2zClMr8GFxPSNvXBApUlZyWJ
	 7+YmsCqYLTotfjuWFYHGwV5MGO9oxvuCSiLRz8rWCUV7VMMx2m+7O15ADw3BF6T/tW
	 picNxZoy6Hz32EFJzdYVc/I4qeHwZwpPFRNZ314I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgEOPsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgEOPsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:48:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CE3C061A0C;
        Fri, 15 May 2020 08:48:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so2758202ljg.5;
        Fri, 15 May 2020 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=fY7QOXGBh0lpGAIxCDNmsPeDdy5A2yrYmjB29nGWprQ=;
        b=CzAwOlmtrTHtfOLwXGDNH5mdDHhccw59oErotMjJWD63gA06itD516Lis1jro+RomX
         rWSuJCMxcBDxPWHz7qreT9kpqMXF8kKog0eBUJMb0gh+2XcxW2PoKlC8K/SlS0In1xMX
         VeUKn6PfTd2RqrZsZ/tfAIRyQ8MA2ekL2dpbQNECN/FWTByzmQzHy5eDWcMMs4cQBi6K
         n7zp28LSe085flkXj1CFfxnGLFfDge8y+dMpMh0EUNMYCnKPlF0pDIcua1ipmZ07/cgX
         xgJw8W6DxA2qU+O99Vqh54qemuGtqwiLVJ90AYmykxQ/LC7SPrwGpZLlbBNEVHqzjEmQ
         2wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=fY7QOXGBh0lpGAIxCDNmsPeDdy5A2yrYmjB29nGWprQ=;
        b=PT2V+Smrf9jacCdN2QFIrDIPTa/wLnju4yg3N2lFVWRC/xtoc1ppdjLxM7D/Q5qr6C
         wlAJtPG/lUkzecaSApMKBTrroMAdvq1PYfzDrRC8b0WdQw5C1GJdQv86QG+9ZSrdThxO
         pRP3K4rgWS1OQ73CPAGpR29207LeYluQ5TLTs78Cww/i24ag0YPaDQfrFFBS0HMiKpKg
         EtZb5kMWowaVIUVTmGr4w9htxRk5lpD9SexNFIdNRqLCzl4j6VuXut1r9uVkJ1/MoiBR
         T5enRe01jwe4q9qo3v9xD32u+OKRj/08Mozmx0XvYBoKqy01U46LVqr1r9O6bxLLUjNB
         dIew==
X-Gm-Message-State: AOAM532H5LOzvfYg3qYwc+irbfqOwcUOu2EmRZJZZRxG7kbyMh5YWykv
        yRCZfT0v8CHLQunZwRJyIEBQCboRqnw=
X-Google-Smtp-Source: ABdhPJz/P6sVSzkBIRzmjJBZsgaxl0KCNezmjR0txnFFdP+igtkidAQc14vrHt6s01x5lNq9mKCAPg==
X-Received: by 2002:a2e:7807:: with SMTP id t7mr2735173ljc.151.1589557680369;
        Fri, 15 May 2020 08:48:00 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id b8sm1519077lfq.70.2020.05.15.08.47.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 May 2020 08:47:59 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     cristian.birsan@microchip.com, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 1/7] usb: gadget: udc: atmel: use of_find_matching_node_and_match
In-Reply-To: <20200515111631.31210-2-cristian.birsan@microchip.com>
References: <20200515111631.31210-1-cristian.birsan@microchip.com> <20200515111631.31210-2-cristian.birsan@microchip.com>
Date:   Fri, 15 May 2020 18:47:54 +0300
Message-ID: <87a7292o9h.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

<cristian.birsan@microchip.com> writes:

> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>
> Instead of trying to match every possible compatible use
> of_find_matching_node_and_match() and pass the compatible array.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

please rebase on my testing/next

checking file drivers/usb/gadget/udc/atmel_usba_udc.c
Hunk #1 succeeded at 2098 (offset 46 lines).
Hunk #2 FAILED at 2074.
1 out of 2 hunks FAILED

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6+uaoACgkQzL64meEa
mQaUtRAA3SxQzSLjX4nXtqmtPbL5JtWzIl4VGUcv1DxNrv3yVahSwJtl5VTvyDVC
41lnQFiq10ZqUaaf7GTDcBsVJmLVsBcNLy8dPkL+5Y+HK5bkCIi9l3fVV4JAg12q
J1QtMxXrIUuiGUGsq8S2LIQBVxfMyZh6yf7KYGqS8mMAS79KxQEs05aRLyFRWbih
Z5PCYoR0K76PP7lkomrbeOepvLxjD939KHXV9cqMVZHTfmzcbVGDIFreomtktQjt
Y5VvjaXsANuQIf+14nUPcGB9qkO8GPOJ9ftbXQahRgHm9l4BDbAcHPZaubS2hY04
Ww9dBOH89s7mrbqlXfcWNNrcv9EmfmqM+Ayy3yTA5eAt4Ot94WRX1vsTa1uTtr1Q
FJs/z3JY8IIt+wsV9k0xzC1ZKJmm/L7DGliisdEZpZiTV1kLLshVMEuZCEiR025c
usbBr4iPJHU0pOJL4B6KLuF9beI23QtlRtu+1gGUkCpaIFfNHiyGs8MsQ9RKcpp1
6l0VnHnqEJtRWgfG2OvwMlJIGzXSrLw0owSpbMNfnOeuFTScahj9pPaaAfeG5+qb
HpaO52O+OPB0sQYC7LZUDuz7x0u3wegNcUIXl+bsbJRfbG7c8ceQeNSGtoZKe73Q
0GHb3F6rgaRDGW2hyI+l9V7hDREY8lgR9hRa/4SKngpKdcFcnls=
=T2cw
-----END PGP SIGNATURE-----
--=-=-=--
