Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EA6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ACD1206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaK676B0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbgF3OiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:38:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24377 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgF3OiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593527882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VM53FIbl2A/0M0Rm8pcUNmxr8EzWR7FcO9KwzPs/7X0=;
        b=FaK676B0NvsavQdXtVGdeVAzfC7hke+/FR4OxLv5Nvd3eyUlrSj235ang4kwWcLmJwH544
        gO2RKSLs29WavxNSay0u4zkqr03QZVn3l3KLj03tkVh+dTQwekeBHD9IoYPS73FyNzCN3u
        hvzqDAox3g/fo8s5W4az14lZCw5dOrg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-MC3MYsXGOoqGuodmnJV90A-1; Tue, 30 Jun 2020 10:38:00 -0400
X-MC-Unique: MC3MYsXGOoqGuodmnJV90A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 941FB100CCC0;
        Tue, 30 Jun 2020 14:37:58 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E33DE7169B;
        Tue, 30 Jun 2020 14:37:52 +0000 (UTC)
Date:   Tue, 30 Jun 2020 09:36:33 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, linux-nvdimm@lists.01.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jan Kara <jack@suse.cz>, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jakub Staron <jstaron@google.com>, linux-kernel@vger.kernel.org
Subject: Re: dm writecache: reject asynchronous pmem.
Message-ID: <20200630133546.GA20439@redhat.com>
References: <20200630123528.29660-1-msuchanek@suse.de>
 <alpine.LRH.2.02.2006300929580.4801@file01.intranet.prod.int.rdu2.redhat.com>
 <20200630141022.GZ21462@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200630141022.GZ21462@kitsune.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30 2020 at 10:10am -0400,
Michal Suchánek <msuchanek@suse.de> wrote:

> On Tue, Jun 30, 2020 at 09:32:01AM -0400, Mikulas Patocka wrote:
> > 
> > 
> > On Tue, 30 Jun 2020, Michal Suchanek wrote:
> > 
> > > The writecache driver does not handle asynchronous pmem. Reject it when
> > > supplied as cache.
> > > 
> > > Link: https://lore.kernel.org/linux-nvdimm/87lfk5hahc.fsf@linux.ibm.com/
> > > Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> > > 
> > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > ---
> > >  drivers/md/dm-writecache.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> > > index 30505d70f423..57b0a972f6fd 100644
> > > --- a/drivers/md/dm-writecache.c
> > > +++ b/drivers/md/dm-writecache.c
> > > @@ -2277,6 +2277,12 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
> > >  
> > >  		wc->memory_map_size -= (uint64_t)wc->start_sector << SECTOR_SHIFT;
> > >  
> > > +		if (!dax_synchronous(wc->ssd_dev->dax_dev)) {
> > > +			r = -EOPNOTSUPP;
> > > +			ti->error = "Asynchronous persistent memory not supported as pmem cache";
> > > +			goto bad;
> > > +		}
> > > +
> > >  		bio_list_init(&wc->flush_list);
> > >  		wc->flush_thread = kthread_create(writecache_flush_thread, wc, "dm_writecache_flush");
> > >  		if (IS_ERR(wc->flush_thread)) {
> > > -- 
> > 
> > Hi
> > 
> > Shouldn't this be in the "if (WC_MODE_PMEM(wc))" block?
> That should be always the case at this point.
> > 
> > WC_MODE_PMEM(wc) retrurns true if we are using persistent memory as a 
> > cache device, otherwise we are using generic block device as a cache 
> > device.
>
> This is to prevent the situation where we have WC_MODE_PMEM(wc) but
> cannot guarantee consistency because the async flush is not handled.

The writecache operates in 2 modes.  SSD or PMEM.  Mikulas is saying
your dax_synchronous() check should go within a WC_MODE_PMEM(wc) block
because it doesn't make sense to do the check when in SSD mode.

Mike

