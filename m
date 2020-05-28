Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBACC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1558C20888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590627706;
	bh=04em0Z+lfaonSDeFTgVsJrVmRC09psh3c7hnHoe/2ow=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=hZKFPgMxRAvg4S/d2SiIea0uHJjrzmHcnBUXYlThfVMO2v6tpB/TdrPLzzwdJJbym
	 +r6NTlXRyVM1vOXmtf38NsafoOfGJ35kGZHvUkFBg/sEwTMwJxSErziVVH4v2MSrEk
	 3mvPMUheZz4/VzgylYbLqfTKWmI0yk/X7u/9kRbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgE1BBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:01:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgE1BBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:01:41 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 904E320888;
        Thu, 28 May 2020 01:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590627700;
        bh=04em0Z+lfaonSDeFTgVsJrVmRC09psh3c7hnHoe/2ow=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pfaFbWXXQm4JljWofGAvIYjnj0w5cr3Kr7Kj3VqCfyPDLXfQX0hDQ2TksCuoCZNSU
         s0iHQBw9dapcZKLFmDStFiLe02+o47nesqFyY2oYsuU/+57wdX1r4zk87Z7s5j+jJv
         JLAP4tWAcSPr0KTMju0/MFRGIy6Xj2uKW8XnaYIw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200519224151.2074597-13-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk> <20200519224151.2074597-13-lkundrak@v3.sk>
Subject: Re: [PATCH v3 12/13] dt-bindings: clock: Add Marvell MMP Audio Clock Controller binding
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Wed, 27 May 2020 18:01:39 -0700
Message-ID: <159062769984.69627.5943120062110654972@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-05-19 15:41:50)
> This describes the bindings for a controller that generates master and bit
> clocks for the I2S interface.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> ---

Applied to clk-next
