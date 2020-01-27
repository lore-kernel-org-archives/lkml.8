Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BF5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F52214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580129781;
	bh=hyktVviQ+zJWRj4vZ5MSqIil5XhHzERacVomvJTG+qo=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=I+EPILwIv4YXkvSuatJMaftkBtDuzCoJQ4QqyuhxJzcABeNiuhkeN6ZDrFiw2AfSC
	 9BaYYLvRVw+sei3ki/932k+L83b7oziftT/SQ8agQ47Al6SNqV0eJDzllJ2RHUo0DP
	 rBwQmrXl4kmoB3DZwjiiLojCphJYoROPWP+bEzwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgA0M4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:56:20 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:63555 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgA0M4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 07:56:20 -0500
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 00RCu2N0019710
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 21:56:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 00RCu2N0019710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1580129763;
        bh=dGCJAhJbUqKnSgxJYoXM3jsc9acDTx2CkDjtkeQlhGU=;
        h=From:Date:Subject:To:Cc:From;
        b=GLhdlobXtHz2mq06vtVXyy12ZSIMD3eIAwNIuHFhH7mp/cJ4wepYqbAJCF8H8onWN
         yVv0pogud67uu92EzzHEyHit4h0uPDsa3inLCSM27aCnRBQXNa/z9JO9cOnpFkgGmb
         5PxdB+d1UFdUMN4b2jJWuOS3GJjN1gWhRRgXnG85SrJzOjW44/nozwNLFvpqjmvMud
         3FrbLNJpkUVijQIst1JnbfYWYSX/oG6roeRiHv+y4TGtTImIiU7fVO0MdgQNiw9Sac
         96AIRBm5mhpEUGZ8quPTgS9U1ToKHWUhX5bAziM5XxWxHUgSoh0zDx4W1fTNEX/sU8
         57FZU4zO3grZw==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id c129so2508529vkh.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 04:56:03 -0800 (PST)
X-Gm-Message-State: APjAAAXh3snJuHySQglzihaO1GEIVyLclLMWkieqMaEl/Xb0Ng+JTkC/
        J2AB9M9Z3aSDgeIbpj2hcRG59cJsxBUAKNHLsuY=
X-Google-Smtp-Source: APXvYqwvFOtz0RrJXzHK0X5fA15DZBprq5KVq/jc9f0H9xTNVNDkQwuKFzXCjMZmCjtSJC5i1PziAy9UPHv6VzZxTwE=
X-Received: by 2002:a1f:1bc3:: with SMTP id b186mr8870779vkb.96.1580129761632;
 Mon, 27 Jan 2020 04:56:01 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 27 Jan 2020 21:55:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR0FemABUg5uN5fhy5LRsOm7n5GhmFVVHE8T57knDM9Ug@mail.gmail.com>
Message-ID: <CAK7LNAR0FemABUg5uN5fhy5LRsOm7n5GhmFVVHE8T57knDM9Ug@mail.gmail.com>
Subject: How to handle write-protect pin of NAND device ?
To:     linux-mtd <linux-mtd@lists.infradead.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have a question about the
WP_n pin of a NAND chip.


As far as I see, the NAND framework does not
handle it.

Instead, it is handled in a driver level.
I see some DT-bindings that handle the WP_n pin.

$ git grep wp -- Documentation/devicetree/bindings/mtd/
Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt:-
brcm,nand-has-wp          : Some versions of this IP include a
write-protect
Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt:-
wp-gpios: GPIO specifier for the write protect pin.
Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt:
         wp-gpios = <&gpf 22 GPIO_ACTIVE_LOW>;
Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt:-
wp-gpios: GPIO specifier for the write protect pin.
Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt:
         wp-gpios = <&gpio TEGRA_GPIO(S, 0) GPIO_ACTIVE_LOW>;



I wrote a patch to avoid read-only issue in some cases:
http://patchwork.ozlabs.org/patch/1229749/

Generally speaking, we expect NAND devices
are writable in Linux. So, I think my patch is OK.


However, I asked this myself:
Is there a useful case to assert the write protect
pin in order to make the NAND chip really read-only?
For example, the system recovery image is stored in
a read-only device, and the write-protect pin is
kept asserted to assure nobody accidentally corrupts it.

But, I am not sure if it should be handled in the
framework level with a more generic DT-binding.


Comments are appreciated.

--
Best Regards
Masahiro Yamada
