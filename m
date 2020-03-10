Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8516EC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665202146E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCJRNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:13:41 -0400
Received: from ms.lwn.net ([45.79.88.28]:44020 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgCJRNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:13:41 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BF1852E4;
        Tue, 10 Mar 2020 17:13:40 +0000 (UTC)
Date:   Tue, 10 Mar 2020 11:13:39 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: admin-guide: binfmt-misc: Improve the title
Message-ID: <20200310111339.2c5e3152@lwn.net>
In-Reply-To: <20200308210935.7273-1-j.neuschaefer@gmx.net>
References: <20200308210935.7273-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  8 Mar 2020 22:09:34 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> Trim the title a bit, since it's relatively long. Add `binfmt_misc` to
> make it easier to search for the feature by its common name.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/admin-guide/binfmt-misc.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/binfmt-misc.rst b/Documentation/admin-guide/binfmt-misc.rst
> index bcdfbe39976e..82aab71ca783 100644
> --- a/Documentation/admin-guide/binfmt-misc.rst
> +++ b/Documentation/admin-guide/binfmt-misc.rst
> @@ -1,5 +1,5 @@
> -Kernel Support for miscellaneous (your favourite) Binary Formats v1.1
> -=====================================================================
> +Kernel Support for miscellaneous Binary Formats (binfmt_misc)
> +=============================================================
> 
>  This Kernel feature allows you to invoke almost (for restrictions see below)
>  every program by simply typing its name in the shell.

Applied, thanks.

jon
