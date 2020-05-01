Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D1DC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 02:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B150B208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 02:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="G0kHx74P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgEACWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 22:22:13 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12477 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgEACWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 22:22:12 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eab87900001>; Thu, 30 Apr 2020 19:21:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 Apr 2020 19:22:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 Apr 2020 19:22:12 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 1 May
 2020 02:22:12 +0000
Received: from [10.2.50.180] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 1 May 2020
 02:22:11 +0000
Subject: Re: [PATCH] mm/gup.c: Corrected document reference path
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <rdunlap@infradead.org>
References: <1588273314-3790-1-git-send-email-jrdr.linux@gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c9975f72-5556-bc36-2559-6b18fea4a203@nvidia.com>
Date:   Thu, 30 Apr 2020 19:22:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588273314-3790-1-git-send-email-jrdr.linux@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588299664; bh=jmEHOkZG+wYNspEbEqci+x9CL6x6hB08PKT1rDg7SrY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=G0kHx74PaLyVttbu+W8rQtRQAXNB5QQB7CEa6aQztdA5IgzgmISmX2O4U4q6R2jho
         zNUjK+3H6i/bmCZtVq5anjGM5JxBCxGdAKeE4FDXYl25OXFR2ZHU7zEBxNBEzmUo9n
         WkHnk0H9ZVhewG0yXrM6A81YypMQ+RmMgUBxqLSclacY54/35AiTTv1VmMrJJPmzTi
         ah0QKid0FLFD6lyaIWGJm1Yc/WtnvoG2k42KwRG0XEYsa/xRe9SMxL+B4Tk1k0ooKU
         ULDBujCDZZWd2u6leMitlkgr+C3vBcWlSIG7ew/hDdcz1G9WuN9U6AaMQEw+Xd9v4i
         p6oKI5h9p/c2A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-30 12:01, Souptick Joarder wrote:
> Document path Documentation/vm/pin_user_pages.rst is not a correct
> reference and it should be Documentation/core-api/pin_user_pages.rst.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>   mm/gup.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)


Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 7ce796c..4952f12 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2864,10 +2864,10 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>    * the arguments here are identical.
>    *
>    * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> - * see Documentation/vm/pin_user_pages.rst for further details.
> + * see Documentation/core-api/pin_user_pages.rst for further details.
>    *
> - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
> - * is NOT intended for Case 2 (RDMA: long-term pins).
> + * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pages.rst.
> + * It is NOT intended for Case 2 (RDMA: long-term pins).
>    */
>   int pin_user_pages_fast(unsigned long start, int nr_pages,
>   			unsigned int gup_flags, struct page **pages)
> @@ -2904,10 +2904,10 @@ int pin_user_pages_fast(unsigned long start, int nr_pages,
>    * the arguments here are identical.
>    *
>    * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> - * see Documentation/vm/pin_user_pages.rst for details.
> + * see Documentation/core-api/pin_user_pages.rst for details.
>    *
> - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
> - * is NOT intended for Case 2 (RDMA: long-term pins).
> + * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pages.rst.
> + * It is NOT intended for Case 2 (RDMA: long-term pins).
>    */
>   long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>   			   unsigned long start, unsigned long nr_pages,
> @@ -2940,10 +2940,10 @@ long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>    * FOLL_PIN is set.
>    *
>    * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> - * see Documentation/vm/pin_user_pages.rst for details.
> + * see Documentation/core-api/pin_user_pages.rst for details.
>    *
> - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
> - * is NOT intended for Case 2 (RDMA: long-term pins).
> + * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pages.rst.
> + * It is NOT intended for Case 2 (RDMA: long-term pins).
>    */
>   long pin_user_pages(unsigned long start, unsigned long nr_pages,
>   		    unsigned int gup_flags, struct page **pages,
> 
