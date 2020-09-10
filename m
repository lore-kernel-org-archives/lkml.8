Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166CBC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE912078B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgIJQ4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:56:11 -0400
Received: from ms.lwn.net ([45.79.88.28]:42262 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgIJQxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:53:09 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4126D35A;
        Thu, 10 Sep 2020 16:53:08 +0000 (UTC)
Date:   Thu, 10 Sep 2020 10:53:07 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/30] .gitignore: docs: ignore sphinx_*/ directories
Message-ID: <20200910105307.0d255bd6@lwn.net>
In-Reply-To: <ac4e23d556c7d95cb11d6d5c605f43e425b2c3c7.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
        <ac4e23d556c7d95cb11d6d5c605f43e425b2c3c7.1599660067.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Sep 2020 16:10:32 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The default way of building documentation is to use
> Sphinx toolchain installed via pip, inside the
> Kernel tree main directory. That's what's recommended by:
> 
> 	scripts/sphinx-pre-install
> 
> As it usually provides a better version of this package
> than the one installed, specially on LTS distros.
> 
> So, add the directories created by running the commands
> suggested by the script.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied, thanks.

Also applied parts 2, 5, 6, 7, 12, 14, 16, 17, 19, 20, and 23.  Many of
the others don't apply at all; they're going to need to go to the relevant
maintainers.

Thanks,

jon
