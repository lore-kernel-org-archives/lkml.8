Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22857C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02AA620739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgGEUHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgGEUHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:07:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892BCC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 13:07:37 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BC0302E4;
        Sun,  5 Jul 2020 20:07:35 +0000 (UTC)
Date:   Sun, 5 Jul 2020 14:07:34 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mailmap: add entry for obsolete email address
Message-ID: <20200705140734.2a0d765f@lwn.net>
In-Reply-To: <159360469186.24918.10108157093572183535.stgit@zurg>
References: <159360469186.24918.10108157093572183535.stgit@zurg>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jul 2020 14:58:11 +0300
Konstantin Khlebnikov <koct9i@gmail.com> wrote:

> Map old corporate email address @yandex-team.ru to stable private address.
> 
> Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>
> ---
>  .mailmap |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index c69d9c734fb5..b15c836ea7fe 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -146,6 +146,7 @@ Kamil Konieczny <k.konieczny@samsung.com> <k.konieczny@partner.samsung.com>
>  Kay Sievers <kay.sievers@vrfy.org>
>  Kenneth W Chen <kenneth.w.chen@intel.com>
>  Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
> +Konstantin Khlebnikov <koct9i@gmail.com> <khlebnikov@yandex-team.ru>

Applied, thanks.

jon
