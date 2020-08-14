Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEBCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3922078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMGpp3Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgHNQMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgHNQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:12:10 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE645C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 09:12:09 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q14so8885745ilj.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gRQztR56iu3aM7IPkfJ9L3Boyqvrwwaj0DJy4n3MiCE=;
        b=UMGpp3Q/qPHvVuL6uaJjaSEdhIz3jC/WbLrrgJGe5DhLnMP2ZpiMuRnI5GyTGS79Yz
         RlflnIt7ZgWY9kMX1lvqjl6uy19GbzRrVvnn4uPQkvplYmr53tZqXxNlP88wAWQVh4Rf
         Zd+rCnQ/rjwSQIx7KMcKTIkX9XVayS4q2Y+QdNZggMzBTFlWK+JCiXdG4LFW63gUlWKi
         1blFBNsmh7mlYgL1aY3WjOo8YIEffbMxIQXOLbwXc/qPUwoks/Fdl/FtNuWDPPE7J3F1
         8MScQLNczXCzU5nSeLfUzo/9t9HpsZFIU8Zp7ssST8H8YSLQq4G37Q22QIqvLoq5xSwJ
         UOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gRQztR56iu3aM7IPkfJ9L3Boyqvrwwaj0DJy4n3MiCE=;
        b=RQUBe0EM5fPUYA1uNWbpdNSBBvlPRK8O5eyYS9YFJY0vXRKxhoZSRa/Obqobg4rI7+
         ooFGp4exbejKqzpTdorkxWjP0lvXeklwU6j4RdwTGeNONY1G2+HZBxuFF0vfDfOkhleK
         tjUhmBVcw9OBH1nKCShzIohNkgyoWJV6b0Q8e0FGDjFNH5v+XuWGOS9Yc0pVAJxXn2vf
         Cvcc0EKzLyPMVKGGsdM5v1w/gpDXLRGdc/yYZ5R5UMD0jYJvXgQClsIxajqUCMKeFjM8
         wLSUU6l6Z1o/6ucjDqZ8JEGRMHyaOXl25ltMhiE71pLXyjWnqf+eeM48plkvWcgVe22N
         W3Ww==
X-Gm-Message-State: AOAM5307yRgCMNjudOpAGwznRAQOA0eH8j/cAd598KIAqb7+Eo/mCO8k
        C/yKaeSnifq72kMHC5hv3dXl6lMT8Bp90XNS8Sl/1MELRNPKXqft
X-Google-Smtp-Source: ABdhPJzUHPJH7IZhco2y/VyghwJqsaIiBDeryQlRsIEB6CIoj/XJJXMd6IswCHBxvtEreYF7+XAIc9PMNoZTvhyg7NI=
X-Received: by 2002:a92:ad01:: with SMTP id w1mr3264199ilh.301.1597421527773;
 Fri, 14 Aug 2020 09:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200814071431.201400-1-ztong0001@gmail.com> <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4CctYiBe766-OnxAPHJWByyOo1rE7FzW-75ZcOib6niCA@mail.gmail.com> <20200814154233.GA3772144@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200814154233.GA3772144@dhcp-10-100-145-180.wdl.wdc.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Fri, 14 Aug 2020 12:11:56 -0400
Message-ID: <CAA5qM4CtnNgZDpT-8Wiwvs18-h4fmxv3jPmW4AqWXgT-BqNLYw@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@fb.com, Christoph Hellwig <hch@lst.de>, sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 11:42 AM Keith Busch <kbusch@kernel.org> wrote:
> > > On Fri, Aug 14, 2020 at 03:14:31AM -0400, Tong Zhang wrote:
> > > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > > index ba725ae47305..c4f1ce0ee1e3 100644
> > > > --- a/drivers/nvme/host/pci.c
> > > > +++ b/drivers/nvme/host/pci.c
> > > > @@ -1249,8 +1249,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> > > >               dev_warn_ratelimited(dev->ctrl.device,
> > > >                        "I/O %d QID %d timeout, disable controller\n",
> > > >                        req->tag, nvmeq->qid);
> > > > -             nvme_dev_disable(dev, true);
> > > >               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> > > > +             nvme_dev_disable(dev, true);
> > > >               return BLK_EH_DONE;

> anymore. The driver is not reporting   non-response back for all
> cancelled requests, and that is probably not what we should be doing.

OK, thanks for the explanation. I think the bottom line here is to let the
probe function know and stop proceeding when there's an error.
I also don't see an obvious reason to set NVME_REQ_CANCELLED
after nvme_dev_disable(dev, true).
