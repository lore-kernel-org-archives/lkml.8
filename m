Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCC7C2BBC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D68F2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="OTU6wspY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437737AbgDNJq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgDNJqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:46:25 -0400
X-Greylist: delayed 173 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Apr 2020 02:46:24 PDT
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5301::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20C2C0A3BD0;
        Tue, 14 Apr 2020 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1586857583;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=wffEAJzLw5r0Krn8zuK2Pz6LtbsEFk3IEtvF5z6tdE0=;
        b=OTU6wspYXuBjm1dcx+QStTAVoXJDAOeN+cvXm3Hr9L25TPRj5mR4rUDDl8XKzBhpyD
        jsekrKKXz3D1zTRp1YGjMo0DrQ3+s1idXv4Muiswa9yZx/SCqoMbilqpsHj/cBfwde33
        +f8Gi9k1QGBgu5eG94qUMxJnNXZChx0wHHOwFb+Crqm2AGgCqjkXAzBmQ9gwjY7fAQdj
        hzgVc9hEt9UQZ6UmKXyyIxqopmPKZmXK6bL4otPlMUs2ofr5skNsupogxIEd6pZyAXie
        oRpX7qdzqaLl8MkhDM0grel6MNDHoN9YXBA5HPRMEBMwypViyj9BIEcMupEzPvqGhgmc
        Yafw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7Ic/CaIo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id u043b8w3E9hNd2c
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 14 Apr 2020 11:43:23 +0200 (CEST)
Date:   Tue, 14 Apr 2020 11:43:17 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/2] ARM: defconfig: u8500: Enable CONFIG_GP2AP002
Message-ID: <20200414094317.GA5896@gerhold.net>
References: <20200405173252.67614-1-stephan@gerhold.net>
 <20200405173252.67614-2-stephan@gerhold.net>
 <CACRpkdYW930B-riUi5OnmsDCJD_piJ+321rgB40bq93ndzSp5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYW930B-riUi5OnmsDCJD_piJ+321rgB40bq93ndzSp5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:08:38AM +0200, Linus Walleij wrote:
> On Sun, Apr 5, 2020 at 7:34 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > sharp,gp2ap002s00f is used as a proximity sensor in
> > samsung-golden and samsung-skomer.
> >
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> 
> Ooops I saw now that I already had this in my "Skomer and misc"
> enablement patch. (rebasing my trees today).
> 
> I can put this in front of that patch and take it out of mine if you
> prefer stepwise enablement.
> 

Do you mean the "ARM: defconfig: u8500: Enable new drivers for ux500"
patch? It doesn't matter which commit/patch adds it, as long as it ends
up in the u8500_defconfig :)

Thanks,
Stephan
