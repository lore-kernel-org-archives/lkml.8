Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4C3C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92BB20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxXGJFo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCINlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:41:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29167 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726536AbgCINlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583761274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4uy9CPfIqXcf46TOPmKwmRnzrgWZ4Kr2u3iJ+yoWqIA=;
        b=NxXGJFo8VI9/Ku8O63Mr6UyW6xdVS+BDAUblP3K/1wGZ4dh2vZmXwWJigZHJH5SzPtalki
        akN8+9PXB10Fb91NwZRFtLnVSLBlEpnRtBy/nyaqjdG1xA7QoNqGAUx2ZeuGhvv7VJ2Zgu
        1idcQCkka+uTypKiP8PZqTJqJIuIU5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-92_W189bMEeVf_UIchAFGg-1; Mon, 09 Mar 2020 09:41:12 -0400
X-MC-Unique: 92_W189bMEeVf_UIchAFGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D65F1107ACCC;
        Mon,  9 Mar 2020 13:41:10 +0000 (UTC)
Received: from localhost (ovpn-12-179.pek2.redhat.com [10.72.12.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 320C55D9C5;
        Mon,  9 Mar 2020 13:41:07 +0000 (UTC)
Date:   Mon, 9 Mar 2020 21:41:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, osalvador@suse.de, rppt@linux.ibm.com
Subject: Re: [PATCH v3 6/7] mm/sparse.c: move subsection_map related codes
 together
Message-ID: <20200309134104.GE27711@MiWiFi-R3L-srv>
References: <20200307084229.28251-1-bhe@redhat.com>
 <20200307084229.28251-7-bhe@redhat.com>
 <8462ca2b-822f-52c0-5986-93377d252fac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8462ca2b-822f-52c0-5986-93377d252fac@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/20 at 10:08am, David Hildenbrand wrote:
> On 07.03.20 09:42, Baoquan He wrote:
> > No functional change.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/sparse.c | 134 +++++++++++++++++++++++++---------------------------
> >  1 file changed, 65 insertions(+), 69 deletions(-)
 
> 
> IMHO, we don't need this patch - but just my personal opinion. Change
> itself looks good on a quick glance.

I personally like seeing function set operating on one data structure
being put together. To me, I use vi+ctags+cscope to jump to called
funtion easily. When try to get a picture of a data and handling, e.g here
the subsection map and the relevant functions, putting them together is
better to understand code. I am also fine to discard this patch, no
patch has dependency on this one in this series, it's easy to not pick
it if no one like it. 

