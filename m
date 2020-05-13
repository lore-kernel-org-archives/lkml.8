Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776A9C2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1F320740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T67MZaMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgEMHbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:31:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58570 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728988AbgEMHbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589355110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=6m7I7IJtUTCmFoltb6APz35kPXUNjbtSydOP8CoZp5g=;
        b=T67MZaMeQJCiJSaxy8vJb55W6b5UknsAq7/NTXwamXjBPpoPJZoSq8Gy0JPo5hPnte9azt
        1Hd+2uEZ6Th0dXslPE9Ywl/G1aU1ymcy06QioH1oYI/Ns7KY4D5kn3a6VrDfl8vlIGjX+a
        584Clym9m1hMb+I94tpbWLvZuw8s98o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-6xvGmrXEPpKc472_Ehj9gw-1; Wed, 13 May 2020 03:31:47 -0400
X-MC-Unique: 6xvGmrXEPpKc472_Ehj9gw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 177C4835B41;
        Wed, 13 May 2020 07:31:45 +0000 (UTC)
Received: from [10.36.114.88] (ovpn-114-88.ams2.redhat.com [10.36.114.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E87E762925;
        Wed, 13 May 2020 07:31:42 +0000 (UTC)
Subject: Re: zswap z3fold + memory offline = infinite loop
To:     Qian Cai <cai@lca.pw>, Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>
References: <D90B73BA-22EC-407E-838F-2BA646C60DE0@lca.pw>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <172b4fe4-213e-9830-653d-18f7854f0195@redhat.com>
Date:   Wed, 13 May 2020 09:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <D90B73BA-22EC-407E-838F-2BA646C60DE0@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.05.20 02:36, Qian Cai wrote:
> Put zswap z3fold pages into the memory and then offline those memory would trigger an infinite loop here in
> 
> __offline_pages() --> do_migrate_range() because there is no error handling,

That's usually not the case, that's why we - nowadays - basically never
see endless loops anymore, except when some code is doing something
wrong with movable pages. The TODO below is somewhat misleading.

> 
> 			if (pfn) {
> 				/*
> 				 * TODO: fatal migration failures should bail
> 				 * out
> 				 */
> 				do_migrate_range(pfn, end_pfn);
> 
> There, isolate_movable_page() will always return -EBUSY  because,
> 
> 	if (!mapping->a_ops->isolate_page(page, mode))
> 		goto out_no_isolated;
> 
> i.e., z3fold_page_isolate() will always return false because,
> 
> zhdr->mapped_count == 2

Whenever we have such endless loops when offlining it's either because
1. Somebody puts unmovable data into the movable zone
2. Somebody marks unmovable data as movable
3. Somebody turns movable data into unmovable data although the
pageblock is isolated

After start_isolate_page_range() we are sure that we only have movable
data in the isolated page range. The pageblocks are isolated, so e.g.,
no new allocations can end up on that memory.

Offlining code can therefore assume that all memory is in fact movable
and can be moved eventually. It might not always work on the first
attempt, that's why we retry.

We don't expect permanent migration failure, because that would mean the
page is unmovable.

I can see that mm/z3fold.c uses  __SetPageMovable(). So the question is,
why are these pages permanently unmovable.


> 
> It should be easy to reproduce. Otherwise, use this one,
> 
> https://github.com/cailca/linux-mm/blob/master/random.c
> 
> and then watch the console burning with those,
> 
> [12661.793667][T566417] failed to isolate pfn 1045b2
> [12661.793745][T566417] page:c00c000004116c80 refcount:2 mapcount:0 mapping:00000000999f9672 index:0x0
> [12661.793865][T566417] mapping->a_ops:z3fold_aops
> [12661.793919][T566417] flags: 0x3fffc000000000()
> [12661.793969][T566417] raw: 003fffc000000000 c00c000003cef388 c00c000006b0da08 c000001275b87f6a
> [12661.794071][T566417] raw: 0000000000000000 0000000000000000 00000002ffffffff 0000000000000000
> [12661.794158][T566417] page dumped because: isolation failed
> [12661.794226][T566417] page_owner tracks the page as allocated
> [12661.794292][T566417] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12800(GFP_NOWAIT|__GFP_NOWARN|__GFP_NORETRY)
> [12661.794463][T566417]  prep_new_page+0x3d0/0x450
> [12661.794508][T566417]  get_page_from_freelist+0x1bb8/0x27c0
> [12661.794575][T566417]  __alloc_pages_slowpath.constprop.60+0x240/0x15a0
> [12661.794654][T566417]  __alloc_pages_nodemask+0x520/0x650
> [12661.794715][T566417]  alloc_pages_current+0xbc/0x140
> [12661.794772][T566417]  z3fold_zpool_malloc+0x6cc/0xe20
> [12661.794826][T566417]  zpool_malloc+0x34/0x50
> [12661.794888][T566417]  zswap_frontswap_store+0x60c/0xe20
> [12661.794942][T566417]  __frontswap_store+0x128/0x330
> [12661.794995][T566417]  swap_writepage+0x58/0x110
> [12661.795048][T566417]  pageout+0x16c/0xa40
> [12661.795092][T566417]  shrink_page_list+0x1ab4/0x2490
> [12661.795155][T566417]  shrink_inactive_list+0x25c/0x710
> [12661.795206][T566417]  shrink_lruvec+0x444/0x1260
> [12661.795274][T566417]  shrink_node+0x288/0x9a0
> [12661.795330][T566417]  do_try_to_free_pages+0x158/0x640
> [12661.795383][T566417] page last free stack trace:
> [12661.795437][T566417]  free_pcp_prepare+0x52c/0x590
> [12661.795493][T566417]  free_unref_page+0x38/0xf0
> [12662.156109][T566417]  free_z3fold_page+0x58/0x120
> [12662.156131][T566417]  free_pages_work+0x148/0x1c0
> [12662.156195][T566417]  process_one_work+0x310/0x900
> [12662.156257][T566417]  worker_thread+0x78/0x530
> [12662.156306][T566417]  kthread+0x1c4/0x1d0
> [12662.156354][T566417]  ret_from_kernel_thread+0x5c/0x74
> 


-- 
Thanks,

David / dhildenb

