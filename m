Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805A5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6BC206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgDIPjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:39:44 -0400
Received: from ms.lwn.net ([45.79.88.28]:60460 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728167AbgDIPjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:39:44 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8E05C7DF;
        Thu,  9 Apr 2020 15:39:44 +0000 (UTC)
Date:   Thu, 9 Apr 2020 09:39:43 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: linux-next: manual merge of the orangefs tree with Linus' tree
Message-ID: <20200409093943.105eaa33@lwn.net>
In-Reply-To: <CAOg9mSS0Kof75WpiGQtHPG4EZ8n_qK5yKF+h=Me2cD1CuaSe3g@mail.gmail.com>
References: <20200409105253.1c86f4c8@canb.auug.org.au>
        <CAOg9mSS0Kof75WpiGQtHPG4EZ8n_qK5yKF+h=Me2cD1CuaSe3g@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Apr 2020 11:05:19 -0400
Mike Marshall <hubcap@omnibond.com> wrote:

> I see all the other rst files, but no orangefs.rst...
> 
> I did see evidence on fs-devel a few months(?) ago that someone
> was converting txt files to rst and that orangefs.txt
> was one of them... perhaps there was something I should
> have done but didn't? Anywho... what next?

Warn Linus about the conflict when you send in your pull request.
Assuming Stephen's resolution works for you, you can mention that but
there's not much else you really need to worry about.

Merge conflicts are ... not uncommon ... in the documentation tree.

jon
