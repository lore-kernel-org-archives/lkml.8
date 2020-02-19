Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5317BC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337CC208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgBSLLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:11:14 -0500
Received: from ms.lwn.net ([45.79.88.28]:33930 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgBSLLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:11:14 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2FBBF2E5;
        Wed, 19 Feb 2020 11:11:09 +0000 (UTC)
Date:   Wed, 19 Feb 2020 04:11:04 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Harald Seiler <hws@denx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] docs: driver-api: edid: Fix list formatting
Message-ID: <20200219041104.7d672841@lwn.net>
In-Reply-To: <20200214174139.16101-1-j.neuschaefer@gmx.net>
References: <20200214174139.16101-1-j.neuschaefer@gmx.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2020 18:41:32 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> Without the empty lines, Sphinx renders the list as part of the running
> text.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

I've applied this (and the rest of the set as well).

Thanks,

jon
