Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FABC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 01:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C84D2078E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 01:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595984955;
	bh=APvgnHEnCx9cVV1bX5o5XJ7lMUoU4LmVT5mjbqHahw8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=hXFV5g9DeKnEQpz3kyl2HmYg958NRRG1SS2VWVB8Vz2vdrKVzEVyCV7uBSmbz/6hU
	 hIxQdoCJZPV/7y8YFcjGwt5e/JZktXysWABtd2D3VOJdNG0v6H5VUiZ8wxhyNOwSQz
	 DCpmkKg8lq0ftU7hldtYYMtky1nHabLiXgjsTDQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgG2BJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 21:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgG2BJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 21:09:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C762B2078E;
        Wed, 29 Jul 2020 01:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595984953;
        bh=APvgnHEnCx9cVV1bX5o5XJ7lMUoU4LmVT5mjbqHahw8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=2uXTA4OoBJfISTMt2EVeaqZ4ewkBuLublJt+AZfHUa3wx42UHueirkXuaEocbxtpc
         2ttAl0+FOzt6hWaLlaDOlWrY41TyzxdvoQ9/jONHa0Sv2AA15z+1w4sWd6nzZfbVOi
         Hg2bBN8+z/ALOGN9LEn5G1y2r3iDs0dDNnnznI2Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6bb66f529eaab58b3a75eea3386233cbca27f818.1595612650.git.gurus@codeaurora.org>
References: <f22bb151d836f924b09cf80ffd6e58eb286be5d6.1595612650.git.gurus@codeaurora.org> <6bb66f529eaab58b3a75eea3386233cbca27f818.1595612650.git.gurus@codeaurora.org>
Subject: Re: [RESEND PATCH v1 2/2] thermal: qcom-spmi-temp-alarm: Don't suppress negative temp
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Veera Vegivada <vvegivad@codeaurora.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>
To:     Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Date:   Tue, 28 Jul 2020 18:09:12 -0700
Message-ID: <159598495264.1360974.13987140780290180679@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Guru Das Srinagesh (2020-07-24 10:46:11)
> From: Veera Vegivada <vvegivad@codeaurora.org>
>=20
> Currently driver is suppressing the negative temperature
> readings from the vadc. Consumers of the thermal zones need
> to read the negative temperature too. Don't suppress the
> readings.
>=20
> Signed-off-by: Veera Vegivada <vvegivad@codeaurora.org>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---

Probably needs a fixes tag. And why not make it first in the series?

>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
