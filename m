Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DCAC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F952214D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEHPW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:22:58 -0400
Received: from muru.com ([72.249.23.125]:53614 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgEHPW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:22:57 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9DDEB806C;
        Fri,  8 May 2020 15:23:46 +0000 (UTC)
Date:   Fri, 8 May 2020 08:22:54 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     kishon@ti.com, vkoul@kernel.org, pavel@ucw.cz,
        sebastian.reichel@collabora.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] phy: cpcap-usb: Remove some useless code
Message-ID: <20200508152254.GZ37466@atomide.com>
References: <20200507203127.202197-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507203127.202197-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christophe JAILLET <christophe.jaillet@wanadoo.fr> [200507 20:32]:
> Axe a clk that is unused in the driver.

Thanks for fixing it:

Acked-by: Tony Lindgren <tony@atomide.com>
