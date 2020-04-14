Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD448C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A7A20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883018;
	bh=GJaIbUUUjI+OFO44/xbkZ+o3FRwbTXCmkmmjK/GceGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KzML8bQYOIf0Cs5qfYm1XKzE8TULlrVJKWaL4QGtclxq/zHhd2aXzAC2MImuqGXew
	 m9GWwT9VUFgZB8OjOzVFSoc3+QJFNf6A4BO6PVt/jKeTHwx5i5o91wcH9XFomQ8TtM
	 pm1F0rDjfYVMvwkF0knaxBRuTUEmjfZLSKM0lBj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441010AbgDNQuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440534AbgDNQt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:56 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 973B020656;
        Tue, 14 Apr 2020 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882996;
        bh=GJaIbUUUjI+OFO44/xbkZ+o3FRwbTXCmkmmjK/GceGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hsyRNql75sdYjF/Of/wwowfTuxsY2gG4N8TYkOnebIM9WtohNmmXyBSkPQTOdZCMo
         ntkHcR/kfvEotm0/4M/o+mK6GMBm8rQdlj6NCh9QIp2BktVxcKexyWd9x4ejCwrAbY
         Ur7+Q4t9J92VCgi+DkSiK6OEK64dBJpS0GufHlk0=
Date:   Tue, 14 Apr 2020 18:49:51 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] scripts: documentation-file-ref-check: Add line break
 before exit
Message-ID: <20200414184951.7f3a5564@coco.lan>
In-Reply-To: <1586857308-2040-1-git-send-email-yangtiezhu@loongson.cn>
References: <1586857308-2040-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 14 Apr 2020 17:41:48 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> escreveu:

> If execute ./scripts/documentation-file-ref-check in a directory which is
> not a git tree, it will exit without a line break, fix it.
> 
> Without this patch:
> 
> [loongson@localhost linux-5.7-rc1]$ ./scripts/documentation-file-ref-check
> Warning: can't check if file exists, as this is not a git tree[loongson@localhost linux-5.7-rc1]$
> 
> With this patch:
> 
> [loongson@localhost linux-5.7-rc1]$ ./scripts/documentation-file-ref-check
> Warning: can't check if file exists, as this is not a git tree
> [loongson@localhost linux-5.7-rc1]$
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/documentation-file-ref-check | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
> index 9a8cc10..c71832b 100755
> --- a/scripts/documentation-file-ref-check
> +++ b/scripts/documentation-file-ref-check
> @@ -25,7 +25,7 @@ my $fix = 0;
>  my $warn = 0;
>  
>  if (! -d ".git") {
> -	printf "Warning: can't check if file exists, as this is not a git tree";
> +	printf "Warning: can't check if file exists, as this is not a git tree\n";
>  	exit 0;
>  }
>  



Thanks,
Mauro
