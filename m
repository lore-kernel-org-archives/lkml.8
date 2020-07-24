Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88734C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C3620737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595604838;
	bh=Y8eLGkyIQiJ7cZbqycuw9fsLmUfQI/gMzh0XyGMhXcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fpDczR8YampFP6a1i9RnhN4p/E4Lvz91uTdVmGGz5RMW0SelGqJLgVaU2s3I2lF5D
	 nAq9G3E8paj2kBZb7p50/v5I5Ii86ijmJQJ0mtxDSEoj51sFUHMet2pQjZloxyXWvk
	 zEfAcK/i+dCxKqIu4+ZaYenJxwy61MP0udWseLB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGXPd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgGXPd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:33:56 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D24E92074F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595604836;
        bh=Y8eLGkyIQiJ7cZbqycuw9fsLmUfQI/gMzh0XyGMhXcA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vtJk6agHXlwFILTBY1N62BFkWqf5cBaroggOMWxOhBHWr7PnMM0fnCgJwsDoRRxYv
         4z6SfhjOAfhrnNUgNW1jIOYv2lYU00qv6X7TICKyLkmlO93q7wAqRFRb+dGhdqXiBK
         4/7cq7rS+EXs0EUB7C6/WFv8MZOHEN1D3AnsccuY=
Received: by mail-lj1-f170.google.com with SMTP id q7so10422282ljm.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 08:33:55 -0700 (PDT)
X-Gm-Message-State: AOAM532P3RmndUboSXqnAKF6+qaV08W11vs9x9KJTk59hW8H08e2CGQx
        2k/mL7tk41dfqFknKE+CfNwSrJ8R+AfBD1QqNE4=
X-Google-Smtp-Source: ABdhPJyCEVn2wxzdMRmvBeZbB7OAx6eyGJpXsnb3GognaSnQeZtSBlDKqh69MV1B4pMx4B+uBmo9QtfaWEPljz2bxPw=
X-Received: by 2002:a2e:b6d2:: with SMTP id m18mr4189120ljo.341.1595604834184;
 Fri, 24 Jul 2020 08:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200724145401.2566-1-krzk@kernel.org> <20200724145401.2566-3-krzk@kernel.org>
 <PWBZDQ.D1XCW6N2YMRA@crapouillou.net>
In-Reply-To: <PWBZDQ.D1XCW6N2YMRA@crapouillou.net>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 24 Jul 2020 17:33:42 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
Message-ID: <CAJKOXPc2w0QHQDEwqoeg9Nm361MszM4LRaCoJD2En-fPgPp+4Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mtd: rawnand: ingenic: Limit MTD_NAND_JZ4780 to
 architecture only
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 at 17:19, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Krzysztof,
>
>
> Le ven. 24 juil. 2020 =C3=A0 16:54, Krzysztof Kozlowski <krzk@kernel.org>=
 a
> =C3=A9crit :
> > Enabling the MTD_NAND_JZ4780 driver makes sense only for specific
> > hardware - the Ingenic SoC architecture.  Set it's dependency to
> > MACH_INGENIC so it will not appear on unrelated architectures (easier
> > job for downstream/distro kernel engineers).
>
> Disagreed. It was done this way so that distro kernels can support
> multiple SoCs.

They will still be able to support multiple SoCs. Nothing changed
here. The same we do for all ARM drivers (SoCs are multiplatform)...
Unless you want to say that it is possible to support Ingenic SoC
without MACH_INGENIC?

Best regards,
Krzysztof
