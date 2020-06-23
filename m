Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8EEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 453AB20768
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592910152;
	bh=RPNK/pzqOU74G6k8hebrnlpAWV7QilbzH+uEcOtIS3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ayt333fa4GRu3Plaq6vcUnxmXGnqcPeJ6fG4tjflcQwTDGCv9PT/Ie9a4PXNSbXGz
	 CPQt7QRPz3n99ZiUDbDSxuIf7/OY0prJSleoiPemH6+g195DdM/3yRw5EywWGbYBh6
	 4aeor5xOp7MRXLmqDtOTvGXK+TNu9tJc2l7poQfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbgFWLCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732227AbgFWLC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:02:29 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C49520738;
        Tue, 23 Jun 2020 11:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592910149;
        bh=RPNK/pzqOU74G6k8hebrnlpAWV7QilbzH+uEcOtIS3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7zdTo/GgQBAMTJOkNJ1+nr/EnxggnpFyNnS43WzzjScGNWygXeN4TQyWah4e2BAO
         WSsqfLjxVLGFrqCx0zdKfBovGUM7Kj/dCyj6r9jR9oSXPLOE0dv9XxTO0fISRqLBQz
         tOYYpg/oDqF5SAbJGOIJw5+1k5cDjHXRmx9tzWOE=
Date:   Tue, 23 Jun 2020 19:02:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, Yu Kuai <yukuai3@huawei.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Yi Zhang <yi.zhang@huawei.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ARM: imx6: add missing put_device() call in imx6q_suspend_init()
Message-ID: <20200623110222.GX30139@dragon>
References: <cf810c93-297c-c02c-9bba-8c3d097b8e31@web.de>
 <2ab2cc9f-c720-75ca-e20c-0e4236ff45fd@huawei.com>
 <1542979d-f7f6-bcf1-53c3-22b7c076ddc7@web.de>
 <20200623073220.GV30139@dragon>
 <5300cb30-2243-9bfe-125c-96e720cd1f29@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5300cb30-2243-9bfe-125c-96e720cd1f29@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:48:52AM +0200, Markus Elfring wrote:
> >>>> Do you find a previous update suggestion useful?
> >>>>
> >>>> ARM: imx6: Add missing put_device() call in imx6q_suspend_init()
> >>>> https://lore.kernel.org/linux-arm-kernel/5acd7308-f6e1-4b1e-c744-bb2e5fdca1be@web.de/
> >>>> https://lore.kernel.org/patchwork/patch/1151158/
> >>>> https://lkml.org/lkml/2019/11/9/125
> >> …
> >>> It is useful indeed.
> …
> >>> Any idea why these pathes didn't get applied ?
> >>
> >> I can make assumptions about the reasons for the possibly questionable handling
> >> of such patches.
> >
> > Markus,
> >
> > Could you resend it to my kernel.org address?
> 
> You can get relevant information from the referenced message archive interfaces,
> can't you?

Well, I'm asking you to resend to make sure the following:

 - Use correct maintainer mailbox address.
 - You still care about the patch.
 - The patch applies to v5.8-rc.

Shawn
