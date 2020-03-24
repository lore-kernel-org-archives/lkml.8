Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73D9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B747A20714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgCXBbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 21:31:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55194 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgCXBbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 21:31:19 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9C02015B47E47;
        Mon, 23 Mar 2020 18:31:18 -0700 (PDT)
Date:   Mon, 23 Mar 2020 18:31:15 -0700 (PDT)
Message-Id: <20200323.183115.1544256233598523357.davem@davemloft.net>
To:     grygorii.strashko@ti.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, dmurphy@ti.com,
        hkallweit1@gmail.com, netdev@vger.kernel.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: dp83867: w/a for fld detect threshold
 bootstrapping issue
From:   David Miller <davem@davemloft.net>
In-Reply-To: <e2f46a8d-b544-e31c-c994-672012bea866@ti.com>
References: <20200317180454.22393-1-grygorii.strashko@ti.com>
        <20200321.201022.719210614219273669.davem@davemloft.net>
        <e2f46a8d-b544-e31c-c994-672012bea866@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 23 Mar 2020 18:31:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Mon, 23 Mar 2020 22:36:32 +0200

> On 22/03/2020 05:10, David Miller wrote:
>> Let me know if I should queue this up for -stable.
>> 
> 
> yes, please, as there are real link instability issues were observed
> without this change.

Ok, done.
