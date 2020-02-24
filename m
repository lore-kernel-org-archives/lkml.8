Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB01BC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11732072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="KTnt4RV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgBXMWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:22:35 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:36619 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXMWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1582546951;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=TYqSvUHnKRu+yShrvah+Qsj8w8sJdF2qEWjg9EH8XEI=;
        b=KTnt4RV/JVk3nNkt58WHNTdwKfvnzq+EJ8Sy1hPROU5AFtFTQCApM7YTk4/9ClpUSH
        NtZ1/JJcwXI9JRztXtjD7BMDXRPWVs8TKjBxwubnpK5o5Z+sMTrLTFvi0Xe9eqaTROo3
        rc6Mlgow680OfsWXrAenAaKT+rYXljRekpoQLytiBDgfNtrCAKatvAyF8VTRisDqmnsZ
        PYv8F/Abu3i00cgN1mIGhqc7uuPMeNjG3Wg+cTGl8MigRddXB2xEbgWNe4s3cMMNt61B
        A9o8exNXqKBr3ORD9ibBrP5+wsiKcG7djmrRPO59x2iei0AD0b3k4vHBMrl0m6pYj5w3
        GS1w==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlSbXA0N0JQ="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 46.1.12 DYNA|AUTH)
        with ESMTPSA id U06217w1OCMMojH
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 24 Feb 2020 13:22:22 +0100 (CET)
Subject: Re: [PATCH RFC] regulator: core: fix handling negative voltages e.g. in EPD PMICs
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20200224120512.GG6215@sirena.org.uk>
Date:   Mon, 24 Feb 2020 13:22:21 +0100
Cc:     Andreas Kemnade <andreas@kemnade.info>, j.neuschaefer@gmx.net,
        contact@paulk.fr, GNUtoo@cyberdimension.org, josua.mayer@jm0.eu,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1548203B-9D64-4128-9BED-D3BC30F9DC49@goldelico.com>
References: <20200223153502.15306-1-andreas@kemnade.info> <20200224120512.GG6215@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 24.02.2020 um 13:05 schrieb Mark Brown <broonie@kernel.org>:
>=20
> On Sun, Feb 23, 2020 at 04:35:01PM +0100, Andreas Kemnade wrote:
>=20
>> An alternative would be to handle voltages as absolute values.
>> There are probably no regulators with support both negative
>> and positive output.
>=20
> This is what'd be needed, your approach here is a bit of a hack and
> leaves some values unrepresentable if they overlap with errnos which
> obviously has issues if someone has a need for those values.

Negative ERRNOs have BIT(31) set.

Since voltage integers on a 32 bit architecture represent =C2=B5V this =
would
still allow voltages up to (2^31 - 1) =C2=B5V i.e. 2 kV with BIT(31) not =
set.

Therefore it seems very unlikely that anyone needs to represent voltages
above 2 kV within a Linux system through a regulator.

So I'd say any negative return value got regulator_get_voltage() can be
treated as an error.

And regulators for negative voltages could be represented by
their absolute value (and maybe a _neg component in the regulator
name).

But then it seems to be a little inconsistent that the voltage
parameters of regulator_set_voltage_unlocked() are signed integers
and not unsigned.

So shouldn't that be protected against attempting to set negative =
voltages?

Just my 2 cts.

BR,
Nikolaus=
