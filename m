Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEFEC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8030020678
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598540699;
	bh=+jRn5/x2Cn9B+Uaw6OdWSzuUG6h+1XhekMjRvXwB/A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0Hj6fWYHe03Mczx3BH3GMsC567DvyQpxAfNZZBW3TH5Pj29d+XqJARr14rOLVhPmM
	 whv80847MqtAWft2x3tb+QFMqybpfq1WU6rJGjOEREA8+RWnqAT6k9XMMrYBNQTBgx
	 N9LIldMdCsJgozFamHnbsGk4uort91PgTyWa0JuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgH0PE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbgH0PBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:01:06 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 795FF20678;
        Thu, 27 Aug 2020 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598540465;
        bh=+jRn5/x2Cn9B+Uaw6OdWSzuUG6h+1XhekMjRvXwB/A8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhJ18CJrnJ/EmIyJpAKkfxLSGytmtwE8i/Dy00KjqNwutiVCjU8cWA5ZgGb67DqFL
         MRxkUOzM/nNTaQwSDU813rHNnEa3IzGGihph/X0nLvOc+Ik+iVuH58Vh7eH8R/I+YP
         pCiZqrMF6RKnCK4KnNjSBytesfTocPeEEQpnzO+4=
Date:   Thu, 27 Aug 2020 08:01:03 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@fb.com, Christoph Hellwig <hch@lst.de>, sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
Message-ID: <20200827150103.GA2613662@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200814071431.201400-1-ztong0001@gmail.com>
 <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4CctYiBe766-OnxAPHJWByyOo1rE7FzW-75ZcOib6niCA@mail.gmail.com>
 <20200814154233.GA3772144@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4CtnNgZDpT-8Wiwvs18-h4fmxv3jPmW4AqWXgT-BqNLYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4CtnNgZDpT-8Wiwvs18-h4fmxv3jPmW4AqWXgT-BqNLYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 12:11:56PM -0400, Tong Zhang wrote:
> On Fri, Aug 14, 2020 at 11:42 AM Keith Busch <kbusch@kernel.org> wrote:
> > > > On Fri, Aug 14, 2020 at 03:14:31AM -0400, Tong Zhang wrote:
> > > > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > > > index ba725ae47305..c4f1ce0ee1e3 100644
> > > > > --- a/drivers/nvme/host/pci.c
> > > > > +++ b/drivers/nvme/host/pci.c
> > > > > @@ -1249,8 +1249,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> > > > >               dev_warn_ratelimited(dev->ctrl.device,
> > > > >                        "I/O %d QID %d timeout, disable controller\n",
> > > > >                        req->tag, nvmeq->qid);
> > > > > -             nvme_dev_disable(dev, true);
> > > > >               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> > > > > +             nvme_dev_disable(dev, true);
> > > > >               return BLK_EH_DONE;
> 
> > anymore. The driver is not reporting   non-response back for all
> > cancelled requests, and that is probably not what we should be doing.
> 
> OK, thanks for the explanation. I think the bottom line here is to let the
> probe function know and stop proceeding when there's an error.
> I also don't see an obvious reason to set NVME_REQ_CANCELLED
> after nvme_dev_disable(dev, true).

The flag was set after disabling when it didn't happen to matter: the
block layer had a complicated timeout scheme that didn't actually
complete the request until the timeout handler returned, so the flag set
where it is was 'ok'. That's clearly not the case anymore, so yes, I
think we do need your patch.

There is one case you are missing, though:

---
@@ -1267,10 +1267,10 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
+		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		nvme_dev_disable(dev, false);
 		nvme_reset_ctrl(&dev->ctrl);
 
-		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_DONE;
 	}
--
