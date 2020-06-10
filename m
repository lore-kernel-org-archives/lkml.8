Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844C0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1B62063A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="SMyYraGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgFJJAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgFJJAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:00:35 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179ECC03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:00:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x18so1514552lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Xy5FYp2soFgJF6nnVbxCLrmBCUlrALdR15rY+pn3PI=;
        b=SMyYraGTdLcKtomGzhcja//vZGyqisk3nY+VV/zD14VFCWQtumfekcnhuBq+Rv2DDt
         nFICH03bVssMzSGyGbf05DOm//tpS8Hurs0XAF2lMvyYu5WPKaa7WUTqrilGqi+pAQdU
         VFW/Chfsh0+typdG8SUEUu7gI9n+TX7IHDJY5FstpvVyLIuD89NAJnjWTtOWFBY5dtAh
         MMN7ayo5RHYBrPjght1o1WBlylykrjlQLxoNrWOGfqaBrdrDxpoueaO377sDDKhh8uyv
         LSj0YV6xbJJ0cto3U8F6QHdyH9+8g7+MaQKd4WKbADnPeWT3afL1ExkGSKfYL9H6HfK2
         6NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Xy5FYp2soFgJF6nnVbxCLrmBCUlrALdR15rY+pn3PI=;
        b=U6GW7HioPVi/bPsrsKYt3ZRJxibjXdnEwAXU6Pg/l8W8Z0Uc57ofvLO52aC3W5H155
         F/Q/rZDqStWTILXRi5M14Frz6lex1D1GVLa9i5NnDRLk0g2QAjFfC0m+CIRKVTWmLaUO
         5HbrbUYL1FrhMBbCY9ueCmMJ2SrugKqP/2Ul7Wc93r1innI4CX9Lf6NjqHrWBmFauIRz
         er1Bc2ZlG7AcLMMXFjwKm7U+kDfV13zfm+5dIFRCEnwIymZ030wSqQGifDjAH8uBntC5
         iAqwd8vND9pikV+RHPYH8zHwSNbYR+X4P1Sy2yRrxK18telYtxHutiUKfpa8Y7GA6DLM
         pzcA==
X-Gm-Message-State: AOAM531+wP2iwGS0icIJGFehX79JfDNjQHDVss2RifKZ9sK2A7GCOENs
        m3etD3TqA8z4+DxvjIzGemHeLO5FYza6yw==
X-Google-Smtp-Source: ABdhPJz5MjnnfWmDVh/izTf6DzFOxa3aA+p/p4WuULzzaQDFaso47AUKpZw51XA/g+2bfjZ7YAvxtw==
X-Received: by 2002:a05:651c:508:: with SMTP id o8mr1177157ljp.112.1591779633288;
        Wed, 10 Jun 2020 02:00:33 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:8b6:350a:b96f:7066:1c4d:ff8d? ([2a00:1fa0:8b6:350a:b96f:7066:1c4d:ff8d])
        by smtp.gmail.com with ESMTPSA id o4sm5666802lff.78.2020.06.10.02.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 02:00:32 -0700 (PDT)
Subject: Re: [PATCH v2] mm/balloon_compaction: Fix trivial spelling
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Kosina <trivial@kernel.org>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200609124610.3445662-16-kieran.bingham+renesas@ideasonboard.com>
 <20200609143412.3456484-1-kieran.bingham+renesas@ideasonboard.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <6b13243c-db22-ef33-8aed-9b385cc10b58@cogentembedded.com>
Date:   Wed, 10 Jun 2020 12:00:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609143412.3456484-1-kieran.bingham+renesas@ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 09.06.2020 17:34, Kieran Bingham wrote:

> The word 'descriptor' is misspelled throughout the tree.
> 
> Fix it up accordingly:
>      decriptors -> descriptors

       decriptor -> descriptor really. ;-)

> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/balloon_compaction.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index 26de020aae7b..907fefde2572 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
>   /**
>    * balloon_page_list_dequeue() - removes pages from balloon's page list and
>    *				 returns a list of the pages.
> - * @b_dev_info: balloon device decriptor where we will grab a page from.
> + * @b_dev_info: balloon device descriptor where we will grab a page from.
>    * @pages: pointer to the list of pages that would be returned to the caller.
>    * @n_req_pages: number of requested pages.
>    *
> @@ -157,7 +157,7 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
>   /*
>    * balloon_page_dequeue - removes a page from balloon's page list and returns
>    *			  its address to allow the driver to release the page.
> - * @b_dev_info: balloon device decriptor where we will grab a page from.
> + * @b_dev_info: balloon device descriptor where we will grab a page from.
>    *
>    * Driver must call this function to properly dequeue a previously enqueued page
>    * before definitively releasing it back to the guest system.

MBR, Sergei
