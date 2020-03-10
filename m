Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7671C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B313A21927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCJRcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:32:45 -0400
Received: from ms.lwn.net ([45.79.88.28]:44208 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgCJRcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:32:45 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1DD1E537;
        Tue, 10 Mar 2020 17:32:45 +0000 (UTC)
Date:   Tue, 10 Mar 2020 11:32:44 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: management-style: Fix formatting of
 emphsized word
Message-ID: <20200310113244.527067de@lwn.net>
In-Reply-To: <20200303192113.20761-1-j.neuschaefer@gmx.net>
References: <20200303192113.20761-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Mar 2020 20:21:12 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> Commit 7f2b3c65b9a1 ("Documentation/ManagementStyle: convert it to ReST
> markup") converted _underlined_ to *emphasized* words, but forgot about
> an underscore in this case.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/process/management-style.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/management-style.rst b/Documentation/process/management-style.rst
> index 186753ff3d2d..dfbc69bf49d4 100644
> --- a/Documentation/process/management-style.rst
> +++ b/Documentation/process/management-style.rst
> @@ -227,7 +227,7 @@ incompetence will grudgingly admit that you at least didn't try to weasel
>  out of it.
> 
>  Then make the developer who really screwed up (if you can find them) know
> -**in_private** that they screwed up.  Not just so they can avoid it in the
> +**in private** that they screwed up.  Not just so they can avoid it in the
>  future, but so that they know they owe you one.  And, perhaps even more
>  importantly, they're also likely the person who can fix it.  Because, let's
>  face it, it sure ain't you.
> --
> 2.20.1
> 
Applied, thanks.

jon
