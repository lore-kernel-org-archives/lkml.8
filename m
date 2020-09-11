Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F19C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B8220732
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599825935;
	bh=8ld3vCiVF+nY7Iq3wXPKpq2LyOTrnCr36pcsLmRAEa4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1ey9GPY8wkrh5rswFMtXapOoKhl83dJD+CQtfmHF+Wx2PT1HQZQcb9OH6d7Qw8vl+
	 Wc2hPdnYi+bR0XZXUeY+GJ1GCipVJyYp097MHps1Iw2tgqSVmb1df338TEijMuirFs
	 BCWQUtpe5BM1qwu/B2gjOD9R4CrTA/EPabeqSzao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgIKMFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgIKMEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:04:36 -0400
Received: from coco.lan (ip5f5ad5a5.dynamic.kabel-deutschland.de [95.90.213.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C2F221E7;
        Fri, 11 Sep 2020 12:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599825876;
        bh=8ld3vCiVF+nY7Iq3wXPKpq2LyOTrnCr36pcsLmRAEa4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l0DCrrMeMtswPVZKfgtO+RLob8Y2NiBfXbbrclCPWpMp1Sd3QAn+pnZV09Aug427v
         BFpf2RxfdFkqH4HqN/1gxbsfabVEfZ58y01EwzMhoG5qKY0uqjL4PwmaVo/8XbozuA
         PP420E2P1iM8hFDhteuOsDNioqH0YDmMYvhZYiUo=
Date:   Fri, 11 Sep 2020 14:04:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] Add PHY USB3 drivers for Hikey 970
Message-ID: <20200911140430.5281b1c3@coco.lan>
In-Reply-To: <20200911114711.GX77521@vkoul-mobl>
References: <cover.1599716786.git.mchehab+huawei@kernel.org>
        <20200911114711.GX77521@vkoul-mobl>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 11 Sep 2020 17:17:11 +0530
Vinod Koul <vkoul@kernel.org> escreveu:

> On 10-09-20, 07:52, Mauro Carvalho Chehab wrote:
> > This patch series add the PHY layer needed in order to support the USB
> > functionality on Hikey 970 boards.
> > 
> > v3:
> > - split a namespace patch on two (one with code changes and another
> >   one with dt-bindings changes);
> > - placed just the PHY driver on this series. Another series will add the
> >   USB HUB driver and the DTS changes required to enable USB support
> >   for this board.  
> 
> I have only cover in my inbox, no other patches. Even lore doesn't show
> the series, not sure what happened here

Gah, it sounds that my scripts did something really weird there.

I changed it while sending some docs patches, as, by adding
all maintainers and MLs for each patch on that series to the
cover letter would produce around ~100 e-mail addresses,
which would hardly be accepted by most of the email servers.

It sounds that I ended breaking it :-(

I'll re-send this patch series.

Thanks,
Mauro
