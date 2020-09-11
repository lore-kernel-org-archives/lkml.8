Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E685EC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6195221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgIKQKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:10:46 -0400
Received: from ms.lwn.net ([45.79.88.28]:47360 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgIKPk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:40:29 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 23D9A735;
        Fri, 11 Sep 2020 15:40:26 +0000 (UTC)
Date:   Fri, 11 Sep 2020 09:40:25 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 26/30] iio: iio.h: fix a warning at the kernel-doc
 markup
Message-ID: <20200911094025.2ef34af3@lwn.net>
In-Reply-To: <20200911093256.000047e1@Huawei.com>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
        <d8f2275c438c459ede4e6fba03ce719cc6ad898b.1599660067.git.mchehab+huawei@kernel.org>
        <20200911093256.000047e1@Huawei.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 09:32:56 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed,  9 Sep 2020 16:10:57 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > There's a warning at iio.h kernel-doc markup:
> > 
> > 	./include/linux/iio/iio.h:644: WARNING: Unknown target name: "devm".
> > 
> > Because it is using {devm_}foo notation. Well, this is not
> > a valid kernel-doc notation. Also, it prevents creating hyperlinks
> > to other documentation functions.
> > 
> > So, replace it to a better notation.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Not much going on in that file at the moment, so fine if Jon picks this
> up directly.

OK, I've done that.

Thanks,

jon
