Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B27C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47A920853
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592370872;
	bh=4RC/DvxLHx87nlYMECwxb5uBAMKIO7v3A/WfAL5PBCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N4BafosYA4eljzLJCYJw743Hx5C0eSaOanpm/SSChxlDBdpYRmIeFHjay66/nhPLi
	 mQCuQE0g2gZIAj24k4uRUarsWy4qL6ss7RuL8W6HbuqAl/wjaRHotC2DtKGqZEE0ne
	 eNAxRWK/TnRU2Rt1SIIEbUM+OLq4/AZyxIm8dC4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgFQFOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 01:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgFQFOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 01:14:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 106092082F;
        Wed, 17 Jun 2020 05:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592370870;
        bh=4RC/DvxLHx87nlYMECwxb5uBAMKIO7v3A/WfAL5PBCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YErZksz0VYampTxWJdKuowSC+ReHO1RudkP9FrchHYS6Yh9N3LGVdZvflUqj8fNVz
         Koo7nEAU92bNrPGW3HRg+wuttpu8rfAwIkXXN2tgFNO1ZoNezk+eUfGYXqKeaSpett
         ezmBuDCFceFPfl5n9MgqcOj6K4hXh5r3k9hkXwXw=
Date:   Wed, 17 Jun 2020 07:14:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: Re: [PATCH v2] usb: gadget: u_serial: improve performance for large
 data
Message-ID: <20200617051422.GA1331778@kroah.com>
References: <1592310884-4307-1-git-send-email-macpaul.lin@mediatek.com>
 <1592362007-7120-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592362007-7120-1-git-send-email-macpaul.lin@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 10:46:47AM +0800, Macpaul Lin wrote:
> Nowadays some embedded systems use VCOM to transfer large log and data.
> Take LTE MODEM as an example, during the long debugging stage, large
> log and data were transfer through VCOM when doing field try or in
> operator's lab. Here we suggest slightly increase the transfer buffer
> in u_serial.c for performance improving.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  drivers/usb/gadget/function/u_serial.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

What changed from v1?  Always put that below the --- line as the
documentation asks for.

v3?
