Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA625C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7162074F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389062AbgF3On7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:43:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:58852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgF3On7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:43:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06EF1AB3D;
        Tue, 30 Jun 2020 14:43:57 +0000 (UTC)
Date:   Tue, 30 Jun 2020 16:43:55 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, linux-nvdimm@lists.01.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jan Kara <jack@suse.cz>, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jakub Staron <jstaron@google.com>, linux-kernel@vger.kernel.org
Subject: Re: dm writecache: reject asynchronous pmem.
Message-ID: <20200630144355.GA21462@kitsune.suse.cz>
References: <20200630123528.29660-1-msuchanek@suse.de>
 <alpine.LRH.2.02.2006300929580.4801@file01.intranet.prod.int.rdu2.redhat.com>
 <20200630141022.GZ21462@kitsune.suse.cz>
 <20200630133546.GA20439@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200630133546.GA20439@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 09:36:33AM -0400, Mike Snitzer wrote:
> On Tue, Jun 30 2020 at 10:10am -0400,
> Michal Suchánek <msuchanek@suse.de> wrote:
> 
> > On Tue, Jun 30, 2020 at 09:32:01AM -0400, Mikulas Patocka wrote:
> > > 
> > > 
> > > On Tue, 30 Jun 2020, Michal Suchanek wrote:
> > > 
> > > > The writecache driver does not handle asynchronous pmem. Reject it when
> > > > supplied as cache.
> > > > 
> > > > Link: https://lore.kernel.org/linux-nvdimm/87lfk5hahc.fsf@linux.ibm.com/
> > > > Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> > > > 
> > > > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > > > ---
> > > >  drivers/md/dm-writecache.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> > > > index 30505d70f423..57b0a972f6fd 100644
> > > > --- a/drivers/md/dm-writecache.c
> > > > +++ b/drivers/md/dm-writecache.c
> > > > @@ -2277,6 +2277,12 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
> > > >  
> > > >  		wc->memory_map_size -= (uint64_t)wc->start_sector << SECTOR_SHIFT;
> > > >  
> > > > +		if (!dax_synchronous(wc->ssd_dev->dax_dev)) {
> > > > +			r = -EOPNOTSUPP;
> > > > +			ti->error = "Asynchronous persistent memory not supported as pmem cache";
> > > > +			goto bad;
> > > > +		}
> > > > +
> > > >  		bio_list_init(&wc->flush_list);
> > > >  		wc->flush_thread = kthread_create(writecache_flush_thread, wc, "dm_writecache_flush");
> > > >  		if (IS_ERR(wc->flush_thread)) {
> > > > -- 
> > > 
> > > Hi
> > > 
> > > Shouldn't this be in the "if (WC_MODE_PMEM(wc))" block?
> > That should be always the case at this point.
> > > 
> > > WC_MODE_PMEM(wc) retrurns true if we are using persistent memory as a 
> > > cache device, otherwise we are using generic block device as a cache 
> > > device.
> >
> > This is to prevent the situation where we have WC_MODE_PMEM(wc) but
> > cannot guarantee consistency because the async flush is not handled.
> 
> The writecache operates in 2 modes.  SSD or PMEM.  Mikulas is saying
> your dax_synchronous() check should go within a WC_MODE_PMEM(wc) block
> because it doesn't make sense to do the check when in SSD mode.

Indeed, it's in the wrong if/else branch.

Thanks

Michal
