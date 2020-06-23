Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B0FC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27EF620874
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbgFWCHV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:07:21 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2549 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730845AbgFWCHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:07:20 -0400
Received: from dggemi405-hub.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id D1846DD068501499BC45;
        Tue, 23 Jun 2020 10:07:17 +0800 (CST)
Received: from DGGEMI422-HUB.china.huawei.com (10.1.199.151) by
 dggemi405-hub.china.huawei.com (10.3.17.143) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 23 Jun 2020 10:07:17 +0800
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.126]) by
 dggemi422-hub.china.huawei.com ([10.1.199.151]) with mapi id 14.03.0487.000;
 Tue, 23 Jun 2020 10:07:15 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] mm: cma: Return cma->name directly in cma_get_name
Thread-Topic: [PATCH] mm: cma: Return cma->name directly in cma_get_name
Thread-Index: AQHWSQHe9Q6zYWq9cEyE52thANJ/xKjlcxgA
Date:   Tue, 23 Jun 2020 02:07:15 +0000
Message-ID: <B926444035E5E2439431908E3842AFD2516153@DGGEMI525-MBS.china.huawei.com>
References: <20200623015840.621964-1-natechancellor@gmail.com>
In-Reply-To: <20200623015840.621964-1-natechancellor@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.192]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Nathan Chancellor [mailto:natechancellor@gmail.com]
> Sent: Tuesday, June 23, 2020 1:59 PM
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org;
> clang-built-linux@googlegroups.com; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; Nathan Chancellor
> <natechancellor@gmail.com>
> Subject: [PATCH] mm: cma: Return cma->name directly in cma_get_name
> 
> clang warns:
> 
> mm/cma.c:55:14: warning: address of array 'cma->name' will always
> evaluate to 'true' [-Wpointer-bool-conversion]
>         return cma->name ? cma->name : "(undefined)";
>                ~~~~~^~~~ ~
> 1 warning generated.
> 
> After commit e7f0557d7de9 ("mm: cma: fix the name of CMA areas"),
> cma->name will be an array with some value worth printing so we do not
> need to check for NULL.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1063
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks!

Acked-by: Barry Song <song.bao.hua@hisilicon.com>

> ---
>  mm/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 31a61d410c59..6cf08817bac6 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -52,7 +52,7 @@ unsigned long cma_get_size(const struct cma *cma)
> 
>  const char *cma_get_name(const struct cma *cma)
>  {
> -	return cma->name ? cma->name : "(undefined)";
> +	return cma->name;
>  }
> 
>  static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
> 
> base-commit: 27f11fea33608cbd321a97cbecfa2ef97dcc1821
> --
> 2.27.0

