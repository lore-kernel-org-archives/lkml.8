Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD2BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E9A207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgFZQiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgFZQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:38:51 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EEBC03E979;
        Fri, 26 Jun 2020 09:38:50 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 648E0374;
        Fri, 26 Jun 2020 16:38:50 +0000 (UTC)
Date:   Fri, 26 Jun 2020 10:38:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shuli Zhang <zhshuli@aliyun.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] Documentation/features: Add KGDB support on RISC-V
Message-ID: <20200626103849.458a84e2@lwn.net>
In-Reply-To: <20200621123016.9289-1-zhshuli@aliyun.com>
References: <20200621123016.9289-1-zhshuli@aliyun.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jun 2020 20:30:16 +0800
Shuli Zhang <zhshuli@aliyun.com> wrote:

> As KGDB has been implemented on RISC-V, update the feature list.
> 
> Signed-off-by: Shuli Zhang <zhshuli@aliyun.com>
> ---
>  Documentation/features/debug/kgdb/arch-support.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
> index 38c40cf..8e5a6c3 100644
> --- a/Documentation/features/debug/kgdb/arch-support.txt
> +++ b/Documentation/features/debug/kgdb/arch-support.txt
> @@ -23,7 +23,7 @@
>      |    openrisc: | TODO |
>      |      parisc: |  ok  |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: | TODO |
>      |          sh: |  ok  |
>      |       sparc: |  ok  |

Applied, thanks.

jon
