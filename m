Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31466C352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1452320702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBERYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:24:38 -0500
Received: from ms.lwn.net ([45.79.88.28]:52548 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbgBERYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:24:38 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C36ED6E5;
        Wed,  5 Feb 2020 17:24:37 +0000 (UTC)
Date:   Wed, 5 Feb 2020 10:24:36 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailmap: add entry for Tiezhu Yang
Message-ID: <20200205102436.2305e948@lwn.net>
In-Reply-To: <1580721045-4988-1-git-send-email-yangtiezhu@loongson.cn>
References: <1580721045-4988-1-git-send-email-yangtiezhu@loongson.cn>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Feb 2020 17:10:45 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> Add an entry to connect all my email addresses.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index de36dce..29a74cd 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -261,6 +261,7 @@ Sumit Semwal <sumit.semwal@ti.com>
>  Tejun Heo <htejun@gmail.com>
>  Thomas Graf <tgraf@suug.ch>
>  Thomas Pedersen <twp@codeaurora.org>
> +Tiezhu Yang <yangtiezhu@loongson.cn> <kernelpatch@126.com>
>  Todor Tomov <todor.too@gmail.com> <todor.tomov@linaro.org>
>  Tony Luck <tony.luck@intel.com>
>  TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>

Applied, thanks.

jon
