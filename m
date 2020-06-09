Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8A5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9591B20737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUfa4wkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbgFIQhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:37:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20739 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728388AbgFIQhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591720634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+II8osbiFfoX/L1u4six/WCUHiqDeOz+O5rD4LfoR2M=;
        b=CUfa4wkdqm1TJmH4WNtBHZYoBhxhlTnjJIAtAoO/IFzlkokVK83c67Xswg5Dxq+/F65bpL
        YsBOyPWXl00CM1YLjjcuCj9J81/mVSx5NwcNKJ+ERV1h+aTagPKahXnsDHCe+3DU5tUW+M
        OpLof0u3pkJ4Qrupcu0WFTZrqBkI9sU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-z5kDnc5UMjaWF1Q9EsvRlA-1; Tue, 09 Jun 2020 12:37:10 -0400
X-MC-Unique: z5kDnc5UMjaWF1Q9EsvRlA-1
Received: by mail-wr1-f69.google.com with SMTP id a4so8808434wrp.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 09:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+II8osbiFfoX/L1u4six/WCUHiqDeOz+O5rD4LfoR2M=;
        b=mlIXpAyQ8qwFBrECXQVmfyubT2GAOrhs8b/o0X9g2fEFxFVNQpLLbaF1AjN515qf8O
         fidPq+DpbKA3XEERfZQbwWc50i0FPFnqH+Hm0d4rVzUQrwGWxOyA0aymFktfOMlGid3K
         PP5trXbqnoAMFTrK5Lf6doOUXllj0+wmiqhGj/0eD47ntxrCimODPvEI51Vv+2Mfyr9l
         Ku4/UpV5JPQZfYi3k5lA2XIWPvk613qDn9fi8OXTHoJmTlLP7BQG4vbnx267I48rJsmi
         Rbgfr+Yj1WKsORIVVZccHYn+kUKWxKPujDpDKMlMPsNwSreUs4c+9CnUmITXLXPJRQaq
         gNOg==
X-Gm-Message-State: AOAM530Sirhw2y0l/ojTrcKx9o8P0790K/zvMWi13hUGngtJ0LWjOAeh
        QbZ15Xbhw2TrXsWFXJxiA4D2CcMiIhf1VoRo7rqX7hWOP3baRO+Cc2MCIJUEFTiri1Qu4SXA+L/
        mo7wlYbgqoLlLau/RxD591aMb
X-Received: by 2002:a1c:dd44:: with SMTP id u65mr5269012wmg.180.1591720629586;
        Tue, 09 Jun 2020 09:37:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz93L1cNiCH3xWCKNeXmWCa9GZNaquxVlfU7TmLWNCwG1IA511CFoLPu9aXLiiVBHF4IpYnIg==
X-Received: by 2002:a1c:dd44:: with SMTP id u65mr5268995wmg.180.1591720629341;
        Tue, 09 Jun 2020 09:37:09 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
        by smtp.gmail.com with ESMTPSA id a1sm3383430wmj.29.2020.06.09.09.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:37:08 -0700 (PDT)
Date:   Tue, 9 Jun 2020 12:37:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        David Hildenbrand <david@redhat.com>,
        linux-renesas-soc@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Kosina <trivial@kernel.org>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/balloon_compaction: Fix trivial spelling
Message-ID: <20200609123652-mutt-send-email-mst@kernel.org>
References: <20200609124610.3445662-16-kieran.bingham+renesas@ideasonboard.com>
 <20200609143412.3456484-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609143412.3456484-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 03:34:12PM +0100, Kieran Bingham wrote:
> The word 'descriptor' is misspelled throughout the tree.
> 
> Fix it up accordingly:
>     decriptors -> descriptors
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Trivial tree pls.

> ---
>  mm/balloon_compaction.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index 26de020aae7b..907fefde2572 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
>  /**
>   * balloon_page_list_dequeue() - removes pages from balloon's page list and
>   *				 returns a list of the pages.
> - * @b_dev_info: balloon device decriptor where we will grab a page from.
> + * @b_dev_info: balloon device descriptor where we will grab a page from.
>   * @pages: pointer to the list of pages that would be returned to the caller.
>   * @n_req_pages: number of requested pages.
>   *
> @@ -157,7 +157,7 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
>  /*
>   * balloon_page_dequeue - removes a page from balloon's page list and returns
>   *			  its address to allow the driver to release the page.
> - * @b_dev_info: balloon device decriptor where we will grab a page from.
> + * @b_dev_info: balloon device descriptor where we will grab a page from.
>   *
>   * Driver must call this function to properly dequeue a previously enqueued page
>   * before definitively releasing it back to the guest system.
> -- 
> 2.25.1

