Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E135C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 04:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F8620714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 04:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+Hs/R5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgCZECi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 00:02:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48423 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbgCZECi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 00:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585195357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nCZVOAI+we4AXCG4GcEDrDdIAY2DXRRQnsZBhAj73FU=;
        b=F+Hs/R5eJSi1Ks5iF077Ru5kywAvO3iBI9xraQIGkK+HKMZTie1/VLLZqYyt4ms2JnotF6
        YV12H+cJUjPZ+dymI/sUbI2/FsdEWoFFktLEYqbRTWQ8CkrStrRPpJEgBaKDuRE2eWikoP
        7ZeLBhZ69malbGqo6vvrT7s8A9guHqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-98MdUwv3MVCtVendpOe4DA-1; Thu, 26 Mar 2020 00:02:33 -0400
X-MC-Unique: 98MdUwv3MVCtVendpOe4DA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94B111005509;
        Thu, 26 Mar 2020 04:02:31 +0000 (UTC)
Received: from localhost (ovpn-12-117.pek2.redhat.com [10.72.12.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C4F9A0A80;
        Thu, 26 Mar 2020 04:02:27 +0000 (UTC)
Date:   Thu, 26 Mar 2020 12:02:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH] mm: Remove dummy struct bootmem_data/bootmem_data_t
Message-ID: <20200326040224.GK3039@MiWiFi-R3L-srv>
References: <20200326022617.26208-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326022617.26208-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/20 at 10:26pm, Waiman Long wrote:
> Both bootmem_data and bootmem_data_t structures are no longer defined.
> Remove the dummy forward declarations.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/alpha/include/asm/mmzone.h | 2 --
>  include/linux/mmzone.h          | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/mmzone.h b/arch/alpha/include/asm/mmzone.h
> index 7ee144f484f1..9b521c857436 100644
> --- a/arch/alpha/include/asm/mmzone.h
> +++ b/arch/alpha/include/asm/mmzone.h
> @@ -8,8 +8,6 @@
>  
>  #include <asm/smp.h>
>  
> -struct bootmem_data_t; /* stupid forward decl. */
> -
>  /*
>   * Following are macros that are specific to this numa platform.
>   */
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 462f6873905a..5c388eced889 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -706,7 +706,6 @@ struct deferred_split {
>   * Memory statistics and page replacement data structures are maintained on a
>   * per-zone basis.
>   */
> -struct bootmem_data;
>  typedef struct pglist_data {
>  	struct zone node_zones[MAX_NR_ZONES];
>  	struct zonelist node_zonelists[MAX_ZONELISTS];

Looks good to me.

Reviewed-by: Baoquan He <bhe@redhat.com>

