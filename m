Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373BDC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF9C20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuaQJMbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgCYFxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:53:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45990 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbgCYFxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585115623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KTYHVugK6vWwq8zeRLq4u+jYHxge4eUDyuR1229kPv8=;
        b=CuaQJMbkkYjqwuEwgCALv7oU/M0dDrpK4068pbbskihPHUJWpE/fWkteNbPgEPBNh3b8hK
        mP/yQrnrCq2SAh3okgZ8JAKmQG0v6fDtiL+nzzUqPHI24VvuAqlMluoDR9fuNsEiykn2dY
        yfN7j2+O7LISOWttEkMMVi59oaNNsug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-wuIoQrabPEGCtYJEamQXuA-1; Wed, 25 Mar 2020 01:53:39 -0400
X-MC-Unique: wuIoQrabPEGCtYJEamQXuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25E05801E66;
        Wed, 25 Mar 2020 05:53:37 +0000 (UTC)
Received: from localhost (ovpn-12-88.pek2.redhat.com [10.72.12.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EEB294B43;
        Wed, 25 Mar 2020 05:53:33 +0000 (UTC)
Date:   Wed, 25 Mar 2020 13:53:31 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Rientjes <rientjes@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        hannes@cmpxchg.org, mhocko@kernel.org, vbabka@suse.cz
Subject: Re: [PATCH 4/5] mm/vmstat.c: move the per-node stats to the front of
 /proc/zoneinfo
Message-ID: <20200325055331.GB9942@MiWiFi-R3L-srv>
References: <20200324142229.12028-1-bhe@redhat.com>
 <20200324142229.12028-5-bhe@redhat.com>
 <alpine.DEB.2.21.2003241220360.34058@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003241220360.34058@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/24/20 at 12:25pm, David Rientjes wrote:
> On Tue, 24 Mar 2020, Baoquan He wrote:
> 
> > This moving makes the layout of /proc/zoneinfo more sensible. And there
> > are 4 zones at most currently, it doesn't need to scroll down much to get
> > to the 1st populated zone, even though the 1st populated zone is MOVABLE
> > zone.
> > 
> 
> Doesn't this introduce risk that it will break existing parsers of 
> /proc/zoneinfo in subtle ways?
> 
> In some cases /proc/zoneinfo is a tricky file to correctly parse because 
> you have to rely on the existing order in which it is printed to determine 
> which zone is being described.  We need to print zones even with unmanaged 
> pages, for instance, otherwise userspace may be unaware of which zones are 
> supported and what order they are in.  That's important to be able to 
> construct the proper string to use when writing vm.lowmem_reserve_ratio.
> 
> I'd prefer not changing the order of /proc/zoneinfo if it can be avoided 
> just because the risk outweighs the reward that we may break some 
> initscript parsers.

Oh, I may not describe the change and result clearly. This patch doesn't
change zone order at all.  I only move the per-node stats to the front of
each node, the zone order is completely kept the same, still DMA, DMA32,
NORMAL, MOVABLE.

Before this patch, per-node stats are printed inside the first populated
zone of each node. E.g in this node 2 which only has movable zone, the
per-node stats is embedded in the last zone. In fact, this per-node stats
are made for the whole node, but not for one zone. 

Node 2, zone      DMA
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        protection: (0, 0, 0, 1024, 1024)
Node 2, zone    DMA32
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        protection: (0, 0, 0, 1024, 1024)
Node 2, zone   Normal
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        protection: (0, 0, 0, 8192, 8192)
Node 2, zone  Movable
  per-node stats              --------------------------->> start of per-node stats
      nr_inactive_anon 42
      nr_active_anon 11787
      nr_inactive_file 32222
      nr_active_file 6081
      nr_unevictable 0
      nr_slab_reclaimable 0
      nr_slab_unreclaimable 0
      ......                  --------- (mid items are omitted)
      nr_anon_transparent_hugepages 0
      nr_unstable  0
      nr_vmscan_write 0
      nr_vmscan_immediate_reclaim 0
      nr_dirtied   25523
      nr_written   25113
      nr_kernel_misc_reclaimable 0  ------------------------->> end of per-node stats
  pages free     211331             ------------------------->> start printing data of zone Movable
        min      3524
        low      4405
        high     5286
        spanned  262144
        present  262144
        managed  262144
        protection: (0, 0, 0, 0, 0)
      nr_free_pages 211331
      nr_zone_inactive_anon 42
      nr_zone_active_anon 11787
      nr_zone_inactive_file 32222
      nr_zone_active_file 6081
      nr_zone_unevictable 0
      nr_zone_write_pending 2

With this patch applied, only the per-node stats part is moved to the
front of each node.

Node 2, per-node stats             --------------------------->> start of per-node stats
      nr_inactive_anon 42
      nr_active_anon 12358
      nr_inactive_file 33139
      nr_active_file 10088
      nr_unevictable 0
      nr_slab_reclaimable 0
      ......                  --------- (mid items are omitted)
      nr_vmscan_write 0
      nr_vmscan_immediate_reclaim 0
      nr_dirtied   9082
      nr_written   8844
      nr_kernel_misc_reclaimable 0
      nr_foll_pin_acquired 0
      nr_foll_pin_released 0     ------------------------->> end of per-node stats
Node 2, zone      DMA
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
Node 2, zone    DMA32
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
Node 2, zone   Normal
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
Node 2, zone  Movable
  pages free     205601     ------------------------->> start printing data of zone Movable
        min      3525
        low      4406
        high     5287
        spanned  262144
        present  262144
        managed  262144
        protection: (0, 0, 0, 0)
      nr_free_pages 205601
      nr_zone_inactive_anon 42
      nr_zone_active_anon 12358
      ........

