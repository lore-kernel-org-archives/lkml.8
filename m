Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2E5C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F92221E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgIJU0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:26:50 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56290 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgIJUZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:25:16 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kGT85-00E8Ic-7o; Thu, 10 Sep 2020 22:25:13 +0200
Date:   Thu, 10 Sep 2020 22:25:13 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, SW_Drivers <SW_Drivers@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 00/15] Adding GAUDI NIC code to habanalabs driver
Message-ID: <20200910202513.GH3354160@lunn.ch>
References: <20200910161126.30948-1-oded.gabbay@gmail.com>
 <20200910130112.1f6bd9e9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAFCwf13SbXqjyu6JHKSTf-EqUxcBZUe4iAfggLhKXOi6DhXYcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf13SbXqjyu6JHKSTf-EqUxcBZUe4iAfggLhKXOi6DhXYcg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you please elaborate on how to do this with a single driver that
> is already in misc ?
> As I mentioned in the cover letter, we are not developing a
> stand-alone NIC. We have a deep-learning accelerator with a NIC
> interface.

This sounds like an MFD.

     Andrew
