Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4ABC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E0220888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590627684;
	bh=ktm4pRzhf1NV+YzaN6U4bH9oGe9Z7m0BKz8OebZtXV4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=LMSHPZzUK7Kp6zvmN3PN9IIXx+3M1y8lbB8oCXlmL3otmabFWTzcjBl4SRszNJIoA
	 CrjLeu3ZSX7THisNbvIyj8u605uPriM9sgr2PWshrZdTn/e/Wsx2YWyru+otJTT7Bk
	 tRZ4hw2if1W20OxnMpI20j8+HIO17oY9APzMzPEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgE1BBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgE1BBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:01:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4A2820888;
        Thu, 28 May 2020 01:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590627673;
        bh=ktm4pRzhf1NV+YzaN6U4bH9oGe9Z7m0BKz8OebZtXV4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bGQAVXnrqqYj5PIC4HmEiIEF1X9H/Ia6ZctYMMYMP9cVlqeuH6/pUCSX/x7WaA+z+
         c6hhnjEfLiycahb1z2jYP9y/P/w0D7ipCE6p/U/rgabHHb2Nk4yQjLScOLI5fenqK9
         X8eBp9NIH0X6E3BkAPwsqlnIHYnSlRXj4etAmzlE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200519224151.2074597-6-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk> <20200519224151.2074597-6-lkundrak@v3.sk>
Subject: Re: [PATCH v3 05/13] clk: mmp2: Move thermal register defines up a bit
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Wed, 27 May 2020 18:01:13 -0700
Message-ID: <159062767309.69627.11783454941191458083@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-05-19 15:41:43)
> A trivial change to keep the sorting sane. The APBC registers are happier
> when they are grouped together, instead of mixed with the APMU ones.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-next
