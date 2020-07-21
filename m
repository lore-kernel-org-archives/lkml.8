Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC971C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC5F206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6vVU9Xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgGUB7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGUB7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:59:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDC0C061794;
        Mon, 20 Jul 2020 18:59:04 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a14so4739865wra.5;
        Mon, 20 Jul 2020 18:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3AdpinBar8jETyVImXGpH6Wr1zXFF6+rdd6Lks1U3Ns=;
        b=f6vVU9Xz1UlzuOxQZDfXu2a7CCfo8aIjAPCHfuNfNivztTLOia8vPrpZ5OQQyBOyxw
         rs5t8M5xfemApzlRRYMxXBmy/gEWNponh4jdmcFCAr9p0CsuoByqoZt1a/Tm4+DNUdpU
         WBxTxejrV40DTEqmHBQQCs7SMqcwEq27bcMWds9zPbOj/Caqc26IBC3m0illBXPMzSSN
         vMmSew/85P/nWeaODKWVbCB5ogopq/GB2BIXom8OeOF6hAzQUDiVLLunYyKC29sgLVhD
         gf3HPYED8QhkzhZnOXQZ72vaoZlrb728aHS9yTVcqJ08+zmBxdTDNjKfRdIhgD6ubpHx
         IA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3AdpinBar8jETyVImXGpH6Wr1zXFF6+rdd6Lks1U3Ns=;
        b=GaJ77pjiLdH89u4hOcmqtX9DLJwjm6D0TanVwM4xv0mD7SAiBSNEz5efoskWhCx4w+
         Q6pR1udsKdSQV2LEcd0HKTIQM49YJOAxLmhxp/3PpqzLCttjfOQd2Mz65Q/0aVGKsI6T
         mgkg2gkdPJE9fwhrU0WaSLnyZ+Ak5BwKnAPAYyzS8LjUCyikp0BGva3r1XTL5DMFIM+A
         wFdXOO/bReErDTfhMWwZoH+9m0NpHKdWOfbFAaIBb1+0vFNRqtDeXK09pcnggtHsCzrK
         1EdIfa4Giln9TlGGzv76mLqwTkii2JAVQlxXwVkDHiOBJc7FKso0/ewTUU2/Znzc4ql1
         LjKg==
X-Gm-Message-State: AOAM530OQDHjnbkMAvprZes/1rLcPo6Cjce/ksXwkp29cMKn7C1TvDJu
        MWBn4gfPsrJrPh0MkHTbYiA=
X-Google-Smtp-Source: ABdhPJwRJp23dSroRcW60lmsvBJ47busZ4vu3U0ShSeLjQlmLaitxIRTt3lM/mEufxbm8oBJdmFApg==
X-Received: by 2002:adf:bb83:: with SMTP id q3mr11377722wrg.58.1595296742289;
        Mon, 20 Jul 2020 18:59:02 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id f15sm33997391wrx.91.2020.07.20.18.59.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 18:59:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] arm64: dts: meson: fix mmc0 tuning error on Khadas VIM3
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <7ha6ztakpp.fsf@baylibre.com>
Date:   Tue, 21 Jul 2020 05:58:58 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E704137A-432C-41D8-9B33-9A96E2936ADD@gmail.com>
References: <20200718054040.3996-1-christianshewitt@gmail.com>
 <7ha6ztakpp.fsf@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 21 Jul 2020, at 2:24 am, Kevin Hilman <khilman@baylibre.com> wrote:
>=20
> Christian Hewitt <christianshewitt@gmail.com> writes:
>=20
>> Similar to other G12B devices using the W400 dtsi, I see reports of =
mmc0
>> tuning errors on VIM3 after a few hours uptime:
>>=20
>> [12483.917391] mmc0: tuning execution failed: -5
>> [30535.551221] mmc0: tuning execution failed: -5
>> [35359.953671] mmc0: tuning execution failed: -5
>> [35561.875332] mmc0: tuning execution failed: -5
>> [61733.348709] mmc0: tuning execution failed: -5
>>=20
>> I do not see the same on VIM3L, so remove sd-uhs-sdr50 from the =
common dtsi
>> to silence the error, then (re)add it to the VIM3L dts.
>>=20
>> Signed-off-by: Chrisitan Hewitt <christianshewitt@gmail.com>
>=20
> Fixes?
>=20
> Kevin

I=E2=80=99ll resend v2 with the fixes tag(s). Thanks.

Christian=
