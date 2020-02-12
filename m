Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E87C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387B32168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581550389;
	bh=b9wkkGs5vusSYEpW5WxBoVJJlRyrfYZNb33I5l2fp/w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=sGSz1gFGp2b/+xfn2tNs4+pv9VN/8IQ4lod1E1CSf9E4q3ShuvWATcFjgoFaJaN+E
	 CUWaki3wGsxDsu3gTfsU9+pfK0Ne5SYek0nRqSGVzFL8X7wwyfH4E2b9FkzHtSpK9I
	 g/iQME5pX2ywI+mqBwNbrSuuPyUPbYo6nITu9SEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgBLXdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:33:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgBLXdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:33:08 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5D7E20578;
        Wed, 12 Feb 2020 23:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581550388;
        bh=b9wkkGs5vusSYEpW5WxBoVJJlRyrfYZNb33I5l2fp/w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZtLujdCL8r3ejsmysKydkXGKgaeTM1xp1xJ3LIn3rLbWQucq7SoG7tuSInKmwZWX9
         UbX5xS9TtFfvM4O7KZ3F9oFLxua7QEQ/uFzUribxBaqDcfc/oJDr+PFMUW3dOX9ZfD
         XEQHk7r5jv/icTZwcfAokxBOc85KRWId4upWGAPI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200117210529.17490-1-alexandre.belloni@bootlin.com>
References: <20200117210529.17490-1-alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] clk: at91: add at91sam9g45 pmc driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Date:   Wed, 12 Feb 2020 15:33:07 -0800
Message-ID: <158155038715.184098.9864434667513148223@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2020-01-17 13:05:29)
> Add a driver for the PMC clocks of the at91sam9g45 family.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next
