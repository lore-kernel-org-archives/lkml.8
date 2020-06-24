Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A19C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031A9207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592978094;
	bh=fi5u9aMvlKH07vhAcC1hkBbHgbpEaMzTgcjbknU+CZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ppnKAwGlQCoz7QfJi1qQ96din7D+uamh7KBZbHdLSZ4pK0zBpIVKdkvE0qCEiItKD
	 Uc7wR4W93qUYNqzTA9F1P7YYbSge7aKuYau+PCdk4VK+cJcsaR8jOPHUee7KOJoI1C
	 eo2PyUMpunMOBvwETd9x1udNid3mx6vE/TXV3AtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388933AbgFXFyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388280AbgFXFyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:54:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 793772073E;
        Wed, 24 Jun 2020 05:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592978092;
        bh=fi5u9aMvlKH07vhAcC1hkBbHgbpEaMzTgcjbknU+CZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJ8qcPDqq987anzYXrt3biVr8KWhyWjzVv7iiJt0W2uysrHjVkAjZlFGggSV+bh7i
         Pz4q6vtMTj8zmeYAdveIpuUC2ytVRRPiI0S7J6ec+X7hvqt2Oco5Bh9s4pFPNvKatu
         wYkY/9d4gPQSeXX2HY1QjyDnLh/83l3IMJBzZStU=
Date:   Wed, 24 Jun 2020 07:54:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.7 318/477] pinctrl: freescale: imx: Use devm_of_iomap()
 to avoid a resource leak in case of error in imx_pinctrl_probe()
Message-ID: <20200624055451.GA684295@kroah.com>
References: <20200623195407.572062007@linuxfoundation.org>
 <20200623195422.561156018@linuxfoundation.org>
 <154ad406-02a0-8f37-4a47-a49b6c90da5d@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154ad406-02a0-8f37-4a47-a49b6c90da5d@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 07:05:05AM +0200, Marion & Christophe JAILLET wrote:
> Hi,
> 
> This one must NOT be included. It generates a regression.
> This should be removed from 5.4 as well.
> 
> See 13f2d25b951f139064ec2dd53c0c7ebdf8d8007e.
> 
> There is also a thread on ML about it. I couldn't find it right away, but
> I'm sure that Dan will be quicker than me for finding it, if needed ;-).

Now dropped, thanks!

greg k-h
