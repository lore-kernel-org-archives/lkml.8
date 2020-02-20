Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF18C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BB424656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LH7AWsRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgBTI4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:56:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59032 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726759AbgBTI4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582188970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AHNF0+BtSxUWfLlE/zC/mUonO4VvK5YNXg2/wPJef2I=;
        b=LH7AWsRwnKyQOG8JEWlJttd/LhBFh9z9iqCWh/dHnGl3Su5umMeNqZcdLvdII96a+APz4I
        xifOlKqJOw6w8C0cluj16a2/Q1Pec9J/E2zKV9DdD+LbNnE4VaYakMDNSlTceerB2zMtaV
        F34/9Xbw3zvrOz5SHkJ20InwsJ3q09I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-g8c2rMgZOQOSCSUVJyMXxw-1; Thu, 20 Feb 2020 03:56:07 -0500
X-MC-Unique: g8c2rMgZOQOSCSUVJyMXxw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46D868010F6;
        Thu, 20 Feb 2020 08:56:05 +0000 (UTC)
Received: from localhost (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8069790D6;
        Thu, 20 Feb 2020 08:56:01 +0000 (UTC)
Date:   Thu, 20 Feb 2020 16:55:59 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, mhocko@suse.com, rppt@linux.ibm.com,
        robin.murphy@arm.com
Subject: Re: [PATCH v2 6/7] mm/sparse.c: move subsection_map related codes
 together
Message-ID: <20200220085559.GE4937@MiWiFi-R3L-srv>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-7-bhe@redhat.com>
 <20200220061832.GE32521@richard>
 <20200220070420.GD4937@MiWiFi-R3L-srv>
 <20200220071233.GA592@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220071233.GA592@richard>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/20 at 03:12pm, Wei Yang wrote:
> On Thu, Feb 20, 2020 at 03:04:20PM +0800, Baoquan He wrote:
> >On 02/20/20 at 02:18pm, Wei Yang wrote:
> >> On Thu, Feb 20, 2020 at 12:33:15PM +0800, Baoquan He wrote:
> >> >No functional change.
> >> >
> >> 
> >> Those functions are introduced in your previous patches.
> >> 
> >> Is it possible to define them close to each other at the very beginning?
> >
> >Thanks for reviewing.
> >
> >Do you mean to discard this patch and keep it as they are in the patch 4/7?
> >If yes, it's fine to me to drop it as you suggested. To me, I prefer to put
> >all subsection map handling codes together.
> >
> 
> I mean when you introduce clear_subsection_map() in patch 3, is it possible to
> move close to the definition of fill_subsection_map()?
> 
> Since finally you are will to move them together.

Oh, got it. Yeah, I just put them close to their callers separately. I
think it's also good to put them together as you suggested, but it
doesn't matter much, right? I will consider this and see if I can adjust
it if v3 is needed. Thanks.

