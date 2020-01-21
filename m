Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33403C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C742051A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAUNC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 08:02:27 -0500
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:34261 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbgAUNC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 08:02:27 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6FA62838434A;
        Tue, 21 Jan 2020 13:02:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: time50_6c45a5c0ebf2e
X-Filterd-Recvd-Size: 1817
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 Jan 2020 13:02:23 +0000 (UTC)
Message-ID: <aba420a3be9272236795dbc14380991bbf72c657.camel@perches.com>
Subject: Re: [PATCH net 2/9] r8152: reset flow control patch when linking on
 for RTL8153B
From:   Joe Perches <joe@perches.com>
To:     David Miller <davem@davemloft.net>, hayeswang@realtek.com
Cc:     netdev@vger.kernel.org, nic_swsd@realtek.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, grundler@chromium.org
Date:   Tue, 21 Jan 2020 05:01:23 -0800
In-Reply-To: <20200121.135439.1619270282552230019.davem@davemloft.net>
References: <1394712342-15778-338-Taiwan-albertk@realtek.com>
         <1394712342-15778-340-Taiwan-albertk@realtek.com>
         <20200121.135439.1619270282552230019.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-21 at 13:54 +0100, David Miller wrote:
> From: Hayes Wang <hayeswang@realtek.com>
> Date: Tue, 21 Jan 2020 20:40:28 +0800
> 
> > When linking ON, the patch of flow control has to be reset. This
> > makes sure the patch works normally.
[]
> > diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
[]
> > @@ -2857,6 +2857,7 @@ static void r8153_set_rx_early_size(struct r8152 *tp)
> >  
> >  static int rtl8153_enable(struct r8152 *tp)
> >  {
> > +     u32 ocp_data;
> >       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> >               return -ENODEV;
> >  
> 
> Please put an empty line after the local variable declarations.

Local scoping is generally better.

Perhaps declare ocp_data inside the if branch
where it's used.  


