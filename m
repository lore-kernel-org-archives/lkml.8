Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DE7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D650820774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592897549;
	bh=+oUvBnNw2wqYcDyCEiyKhDedkPbV15SlmZ8Y8J+muK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PifoXtSSEMtRu8ie9IZEPzHQ1QgrtDn5Opyi5ynQRF71aVpen18CUcV2KbFVUED9o
	 D16MbMLw+sfQpU4A7LJStaRjD1ElRM2HuMquv0B/3oY5LmbdXhDyqRF1lwBLXhkOjK
	 Nflia3fiQ82xEhJxmxuC/YtXe2Yw/mTdKkDANG8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbgFWHc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbgFWHc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:32:27 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC6302072E;
        Tue, 23 Jun 2020 07:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592897546;
        bh=+oUvBnNw2wqYcDyCEiyKhDedkPbV15SlmZ8Y8J+muK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwCqEyJR/qcFe0/ooT/oJxzTKpNBhytUxS1afF7Ktk/RmjxARz02ReoqygdhnJ0Hi
         OIfovm1wUpXMpI1v2M9tSbShvMHI9Tx7VdXuZCoM/u9aLu+xItMLaK5+dD7lGYd0Gv
         ZHdezpHQnpi/lhMCMsm/ipDW36cd2/R1cXhgPANA=
Date:   Tue, 23 Jun 2020 15:32:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Yu Kuai <yukuai3@huawei.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Yi Zhang <yi.zhang@huawei.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ARM: imx6: add missing put_device() call in imx6q_suspend_init()
Message-ID: <20200623073220.GV30139@dragon>
References: <cf810c93-297c-c02c-9bba-8c3d097b8e31@web.de>
 <2ab2cc9f-c720-75ca-e20c-0e4236ff45fd@huawei.com>
 <1542979d-f7f6-bcf1-53c3-22b7c076ddc7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1542979d-f7f6-bcf1-53c3-22b7c076ddc7@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 12:15:32PM +0200, Markus Elfring wrote:
> >> Do you find a previous update suggestion useful?
> >>
> >> ARM: imx6: Add missing put_device() call in imx6q_suspend_init()
> >> https://lore.kernel.org/linux-arm-kernel/5acd7308-f6e1-4b1e-c744-bb2e5fdca1be@web.de/
> >> https://lore.kernel.org/patchwork/patch/1151158/
> >> https://lkml.org/lkml/2019/11/9/125
> …
> > It is useful indeed.
> 
> Thanks for your positive feedback.
> 
> 
> > Although I didn't run cocci script, since it can produce too many false result
> > which is hard to filter out.
> 
> Would you like to clarify any corresponding software analysis options?
> 
> 
> > BTW, I see you haver done the work already, I guess I won't send any patches
> > related to 'missing put_device after of_find_device_by_node()'.
> 
> You may continue also with contributions in such a direction.
> I would like to point out that other developers occasionally got into the mood
> to improve implementation details in similar ways already.
> 
> 
> > Any idea why these pathes didn't get applied ?
> 
> I can make assumptions about the reasons for the possibly questionable handling
> of such patches.

Markus,

Could you resend it to my kernel.org address?

Shawn
