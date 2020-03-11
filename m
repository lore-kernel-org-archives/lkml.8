Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FD6C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 04:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820B82071B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 04:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YF5xfMfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgCKEVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 00:21:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32998 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725379AbgCKEVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 00:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583900462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9QRoyoaeYNQzjCfMEswOWDCgRYflsRAo3xvL3LOE1VY=;
        b=YF5xfMfXGksDRLwat1UzFLMNwTg+mrMLiQrsMlp/aPn4jTgXwsC5idgfxVWsF4ogmv7nPD
        +C3sxqk97nUtESusO2CljTBSLDWFqGeHW479ABQZ34yHGrJQ0fhECuoVxMh9EzI23kl5EV
        gsx5f2hv9p1HRrdBtqTrmEqFJRRye2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-MrMI8VG2NNqzBbZ_2nkZXQ-1; Wed, 11 Mar 2020 00:21:00 -0400
X-MC-Unique: MrMI8VG2NNqzBbZ_2nkZXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CDE718A6EC0;
        Wed, 11 Mar 2020 04:20:59 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9744F8B74D;
        Wed, 11 Mar 2020 04:20:55 +0000 (UTC)
Date:   Wed, 11 Mar 2020 12:20:52 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com,
        richardw.yang@linux.intel.com, dan.j.williams@intel.com,
        osalvador@suse.de, rppt@linux.ibm.com
Subject: Re: [PATCH v3 5/7] mm/sparse.c: add note about only VMEMMAP
 supporting sub-section support
Message-ID: <20200311042052.GI27711@MiWiFi-R3L-srv>
References: <20200307084229.28251-1-bhe@redhat.com>
 <20200307084229.28251-6-bhe@redhat.com>
 <20200310144616.GM8447@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310144616.GM8447@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/20 at 03:46pm, Michal Hocko wrote:
> On Sat 07-03-20 16:42:27, Baoquan He wrote:
> > And tell check_pfn_span() gating the porper alignment and size of
> > hot added memory region.
> > 
> > And also move the code comments from inside section_deactivate()
> > to being above it. The code comments are reasonable for the whole
> > function, and the moving makes code cleaner.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> I have glanced through other patches and they seem sane but I do not
> have time to go deeper to give an ack. I like this one though because it
> really makes the intention clearer.

Thanks for your reviewing and providing ack on this patch.

I will post a new version to rebase on the top of patch 1 and its
appended fix, then address those concerns from David.

