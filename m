Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA1FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6364F206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgFBHsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:48:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48610 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgFBHsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 03:48:31 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 90E452A0A5A;
        Tue,  2 Jun 2020 08:48:29 +0100 (BST)
Date:   Tue, 2 Jun 2020 09:48:25 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Bean Huo <huobean@gmail.com>
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com, s.hauer@pengutronix.de,
        derosier@gmail.com, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH v6 0/5] Micron SLC NAND filling block
Message-ID: <20200602094825.26396b06@collabora.com>
In-Reply-To: <0a4fc94213ca5c2040796a66942f626587483721.camel@gmail.com>
References: <20200525121814.31934-1-huobean@gmail.com>
        <829d76189beff5a50ddc56123d22bff3aa6a3378.camel@gmail.com>
        <0a4fc94213ca5c2040796a66942f626587483721.camel@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean,

On Mon, 01 Jun 2020 23:10:43 +0200
Bean Huo <huobean@gmail.com> wrote:

> Hi Richard 
> would you please help us confirm below question??

Miquel suggested an approach that would allow us to deal with both JFFS2
and UBI/UBIFS without having any FS/wear-leveling specific code at the
NAND level, but you decided to ignore his comments. Sorry but there's
nothing we can do to help you if you don't listen to our
recommendations.

I've been quite disappointed by your behavior in the past, and it
continues. Recently you've taken Miquel's patches and claimed ownership
on them (probably not intentionally, but still) while you were clearly
unable to rework your original series the way I suggested (which Miquel
did after seeing you would never send new versions). And when Miquel
suggested a change to the implementation he had done based on the
discussion we had with Richard, you decided to ignore it and pursue in
the original direction. So, quite frankly, I'm really not convinced you
can conduct such a change.

Regards,

Boris
