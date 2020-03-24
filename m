Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD53C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF6B20769
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjJP9uG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgCXBH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 21:07:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35810 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727032AbgCXBH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 21:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585012047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zdot/UdXY2Q5PE1RqTEozcXrzT2jzktlt007zHYSp+Y=;
        b=fjJP9uG6EDmA+C257USyz9o78V4yeqLAL84gXKYcXFxZVct221EVod4LxRsN44RHLhKfsb
        QbfjTZvppGG8npIdALbGqlIymHA6FPvFlKwFI3BIdWJbRg9QeeMM7EEnjTToIK4EyrTyxA
        sbqPCK623dK+xKAc/PqWRhUTJlpXPOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-QMI76toZOhCaQGSIQMTikQ-1; Mon, 23 Mar 2020 21:07:25 -0400
X-MC-Unique: QMI76toZOhCaQGSIQMTikQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56CE18017CC;
        Tue, 24 Mar 2020 01:07:24 +0000 (UTC)
Received: from localhost (ovpn-12-69.pek2.redhat.com [10.72.12.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2C819496C;
        Tue, 24 Mar 2020 01:07:23 +0000 (UTC)
Date:   Tue, 24 Mar 2020 09:07:21 +0800
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] mm/sparse.c: allocate memmap preferring the given
 node
Message-ID: <20200324010721.GG3039@MiWiFi-R3L-srv>
References: <20200316102150.16487-1-bhe@redhat.com>
 <20200316102150.16487-2-bhe@redhat.com>
 <20200316125625.GH3486@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316125625.GH3486@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 03/16/20 at 08:56pm, Baoquan He wrote:
> When allocating memmap for hot added memory with the classic sparse, the
> specified 'nid' is ignored in populate_section_memmap().
> 
> While in allocating memmap for the classic sparse during boot, the node
> given by 'nid' is preferred. And VMEMMAP prefers the node of 'nid' in
> both boot stage and memory hot adding. So seems no reason to not respect
> the node of 'nid' for the classic sparse when hot adding memory.
> 
> Use kvmalloc_node instead to use the passed in 'nid'.

Just checked linux-next, seems this one is missed. Michal suggested
splitting the old v4 into two patches, this patch is to use the passed
in 'nid' to allocate memmap with !VMEMMAP.

Thanks
Baoquan

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/sparse.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 3fa407d7f70a..31dcdfb55c72 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -719,8 +719,8 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>  struct page * __meminit populate_section_memmap(unsigned long pfn,
>  		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>  {
> -	return kvmalloc(array_size(sizeof(struct page),
> -				   PAGES_PER_SECTION), GFP_KERNEL);
> +	return kvmalloc_node(array_size(sizeof(struct page),
> +					PAGES_PER_SECTION), GFP_KERNEL, nid);
>  }
>  
>  static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
> -- 
> 2.17.2
> 
> 

