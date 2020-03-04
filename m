Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92561C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7454D21739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388059AbgCDUKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:10:37 -0500
Received: from ms.lwn.net ([45.79.88.28]:47028 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729175AbgCDUKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 15:10:36 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 11F68537;
        Wed,  4 Mar 2020 20:10:36 +0000 (UTC)
Date:   Wed, 4 Mar 2020 13:10:35 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
Message-ID: <20200304131035.731a3947@lwn.net>
In-Reply-To: <20200304072950.10532-1-lukas.bulwahn@gmail.com>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Mar 2020 08:29:50 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Mauro's patch series <cover.1581955849.git.mchehab+huawei@kernel.org>
> ("[PATCH 00/44] Manually convert filesystem FS documents to ReST")
> converts many Documentation/filesystems/ files to ReST.
> 
> Since then, ./scripts/get_maintainer.pl --self-test complains with 27
> warnings on Documentation/filesystems/ of this kind:
> 
>   warning: no file matches F: Documentation/filesystems/...
> 
> Adjust MAINTAINERS entries to all files converted from .txt to .rst in the
> patch series and address the 27 warnings.
> 
> Link: https://lore.kernel.org/linux-erofs/cover.1581955849.git.mchehab+huawei@kernel.org
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Mauro, please ack.
> Jonathan, pick pick this patch for doc-next.

Sigh, I need to work a MAINTAINERS check into my workflow...

Thanks for fixing these, but ... what tree did you generate the patch
against?  I doesn't come close to applying to docs-next.

Thanks,

jon
