Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983C8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7343120734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGQNkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:40:11 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:40986 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgGQNkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:40:10 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jwQau-005bxl-El; Fri, 17 Jul 2020 15:40:08 +0200
Date:   Fri, 17 Jul 2020 15:40:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mark Einon <mark.einon@gmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: et131x: Remove redundant register read
Message-ID: <20200717134008.GB1336433@lunn.ch>
References: <20200717132135.361267-1-mark.einon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717132135.361267-1-mark.einon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 02:21:35PM +0100, Mark Einon wrote:
> Following the removal of an unused variable assignment (remove
> unused variable 'pm_csr') the associated register read can also go,
> as the read also occurs in the subsequent et1310_in_phy_coma()
> call.

Hi Mark

Do you have any hardware documentation which indicates these read are
not required? Have you looked back through the git history to see if
there are any comments about these read?

Hardware reads which appear pointless are sometimes very important to
actually make the hardware work.

	 Andrew
