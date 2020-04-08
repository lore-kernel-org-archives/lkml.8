Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71181C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399192082D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1vlQtrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgDHOyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:54:13 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38516 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgDHOyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:54:12 -0400
Received: by mail-il1-f196.google.com with SMTP id n13so6971377ilm.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xrn2+iEZGKbu9eVh6NG6/Wn52EOvhn13a9saeycxHlg=;
        b=B1vlQtrjWNR+73PU7ReQU7+KMWGYr4vDc4/Jj5ZpsIQxH9Hs3/BHIACMk2yXMnjcBj
         BYi/R4IpHudZi1tT/8BOX6xH3ymU6rSQE56hmUR0QnBMNelHdMJpbf/9L/7yq+eI5ki2
         qZCQlbbH4eoOKBbuLNyiJTJM+uIrRytxbcq8eBS+TyUd/L6BwlCJPymtfxR1HqysNiCb
         uf/mAiEBlB5ICZlyhknNcjbgYw553OTweJV1xKWdeenOAGfi5gK/uIRPloC2+RaHhPDT
         MsnRWoHfap4vKakp2E/y0QetJeW/LbFJTddSBrSe6HY6FoSF5p0rsOBx/1tMHA/VBGxu
         ei7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xrn2+iEZGKbu9eVh6NG6/Wn52EOvhn13a9saeycxHlg=;
        b=f7TsJ3DyZ9WgjdoBLdMoiHXwzSi8ZGiGVXVMyxF2niEzSolhilv64VxlYV52FImTHY
         WtX6A7Cq/MCKZLDUfqTvhWF5MTzdKqyhQaBIU7lwxatu8p31XrXRb4xxh0jCe+qgRcKp
         bFOIw5mexhIKJtQn3QoIDnsKPAJxjrvFIHGN2jL7zgzQ/8H7sgh6Sz4IBq5qkZt/FeE0
         8Nxmhtr+rfQQ3MEHBM0B1UHHiKvM9jOybKqKC7EsbwZFOQyV3cPVb6+Z9u9m/iqu0eI5
         8uIt4ISj7lyI0Uh2YoX2iPHeiBfrxID0LTfDMIeF8YitEsxV2tN3EiKAPZmhOb2HzfBZ
         Rx/A==
X-Gm-Message-State: AGi0Pualy6jyozagVgvVT35lLOkEHp6x9MVn8IybvO5BRQNEyCpEmSSX
        yATyIdlLOH7knqr1SdsCT40Wu60AoG2yckzA3sA=
X-Google-Smtp-Source: APiQypKeUdcbm7tHk/y33oq9oGLVJlXo99XJVgq7G0Y7uFMjUhWWime2C8bCVddAjvwbSZYSXqhrljXsF+upBNZngEY=
X-Received: by 2002:a05:6e02:c25:: with SMTP id q5mr7378028ilg.97.1586357651643;
 Wed, 08 Apr 2020 07:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <02998bd4-0b82-2f15-2570-f86130304d1e@infradead.org>
In-Reply-To: <02998bd4-0b82-2f15-2570-f86130304d1e@infradead.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 8 Apr 2020 07:54:00 -0700
Message-ID: <CAKgT0UeGiCvcmEwJ1AL7AP8_ZxAbO9CnVwLzmbKQ9FAMSkJ_ag@mail.gmail.com>
Subject: Re: [PATCH -next] mm: page_alloc: fix kernel-doc warning
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 9:30 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Add description of function parameter 'mt' to fix kernel-doc warning:
>
> ../mm/page_alloc.c:3246: warning: Function parameter or member 'mt' not described in '__putback_isolated_page'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for catching this. The fix looks good to me.

Acked-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

> ---
>  mm/page_alloc.c |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20200407.orig/mm/page_alloc.c
> +++ linux-next-20200407/mm/page_alloc.c
> @@ -3238,6 +3238,7 @@ int __isolate_free_page(struct page *pag
>   * __putback_isolated_page - Return a now-isolated page back where we got it
>   * @page: Page that was isolated
>   * @order: Order of the isolated page
> + * @mt: The page's pageblock's migratetype
>   *
>   * This function is meant to return a page pulled from the free lists via
>   * __isolate_free_page back to the free lists they were pulled from.
>
>
