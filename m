Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB5BC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3415F21927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCJRcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:32:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:44198 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJRcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:32:24 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E690C537;
        Tue, 10 Mar 2020 17:32:23 +0000 (UTC)
Date:   Tue, 10 Mar 2020 11:32:22 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: dev-tools: kmemleak: Update list of architectures
Message-ID: <20200310113222.2baa64ef@lwn.net>
In-Reply-To: <20200303194215.23756-1-j.neuschaefer@gmx.net>
References: <20200303194215.23756-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Mar 2020 20:42:15 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> * Don't list powerpc twice (once as ppc)
> * Drop tile, which has been removed from the source tree
> * Mention arm64, nds32, arc, and xtensa
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/dev-tools/kmemleak.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
> index 3a289e8a1d12..fce262883984 100644
> --- a/Documentation/dev-tools/kmemleak.rst
> +++ b/Documentation/dev-tools/kmemleak.rst
> @@ -8,7 +8,8 @@ with the difference that the orphan objects are not freed but only
>  reported via /sys/kernel/debug/kmemleak. A similar method is used by the
>  Valgrind tool (``memcheck --leak-check``) to detect the memory leaks in
>  user-space applications.
> -Kmemleak is supported on x86, arm, powerpc, sparc, sh, microblaze, ppc, mips, s390 and tile.
> +Kmemleak is supported on x86, arm, arm64, powerpc, sparc, sh, microblaze, mips,
> +s390, nds32, arc and xtensa.
> 
>  Usage
>  -----
> --
> 2.20.1
> 
Applied, thanks.

jon
