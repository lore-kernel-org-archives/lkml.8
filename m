Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9580C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C061D2078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIe1wGvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgH1Mnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbgH1Mno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:43:44 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9953DC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:43:44 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id v2so710274ilq.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BlGqee6LUFbQlE8A/CJ72Y5d50MDkiMD4t/Odvf7ASU=;
        b=qIe1wGvJCvxhcj68y8/oHRAx47yLHDKofI0vmuim9NR/PWCdH/7RQAHSP2eYFPv8ud
         Pcd0+JHmQwLRL3v3DHWMk9aoLJ2L9XkRfpAAB98r4m47hhcHGSAhi5Xtdyygs/7Ex6uJ
         uR1oLx/IPJ2Wi/Ib3wn9kwhsfwSjY1yrkje290OFqlmLjJjvu7YHbyzk5+rYb1zpzr5k
         8GnLrYnRD7BWOeolsxG6ocrEx7LA0/7TJQSORnWeXYULUyRM8q64gUSKNr9d+co9BLxT
         V3MX1ea7ggCGlvgB26UT2UEvKRY2jDzMwtprUynN19kCIJA/+gdC7PYSp+zf/90IJYPV
         L5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BlGqee6LUFbQlE8A/CJ72Y5d50MDkiMD4t/Odvf7ASU=;
        b=lNmElYpAG8as8FuU9Yrh7vKHtv/8YMbj6vYyNgd+9aQ8o0nwjXCUy9MUr86ImU9yUx
         2O90C+7Tb/8kfymcVBjQDADskxMt39np78p3do8CQ/SIbBvV71y5mjgMvg2zBovZyaqj
         3zPSSorLx+epmbujdLUk9tcxCOOYjD9xJY1qBoGsJ0x4KKTFnSF7sDNfR4f5ETktdxhi
         4G+hwaty2l55xos+23kW4guWABeqwljrADq1bPLwq+KVzg/VzZBFDuP5oaJ/FcSx9ruE
         a4MbsRVpZH+DuROaHFow7jpXxpfwz7txCt2rwL/dJZY3HLUVf9hRWWBBEFyYqPdqMK6F
         +pGg==
X-Gm-Message-State: AOAM533WtM1fcPiIRiKo1lXVvcZQ+M4ZxS4kfrwNPnweF4mM/m2XFt8F
        E8t91BWLKHDmE4bi8SyrhkZ9g54+oWCdDf530TY=
X-Google-Smtp-Source: ABdhPJyXoRYFnAomBCPJy+w+LO23nUTbQyGzwjW5zkTcAeUckUO9HFTvnby7Y0dUx8ShDp0e1k2OiKDKjosctjzgPds=
X-Received: by 2002:a92:8550:: with SMTP id f77mr1215513ilh.129.1598618623906;
 Fri, 28 Aug 2020 05:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200814071431.201400-1-ztong0001@gmail.com> <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4CctYiBe766-OnxAPHJWByyOo1rE7FzW-75ZcOib6niCA@mail.gmail.com>
 <20200814154233.GA3772144@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4CtnNgZDpT-8Wiwvs18-h4fmxv3jPmW4AqWXgT-BqNLYw@mail.gmail.com> <20200827150103.GA2613662@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200827150103.GA2613662@dhcp-10-100-145-180.wdl.wdc.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Fri, 28 Aug 2020 08:43:32 -0400
Message-ID: <CAA5qM4ARCf-28eH6dME6pDc8WBNpMh2jGUfcj-Wp7vfwvVRz8Q@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@fb.com, Christoph Hellwig <hch@lst.de>, sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,
Thanks for the confirmation. I will send another revision according to
your comments.
Best,
- Tong

On Thu, Aug 27, 2020 at 11:01 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Aug 14, 2020 at 12:11:56PM -0400, Tong Zhang wrote:
> > On Fri, Aug 14, 2020 at 11:42 AM Keith Busch <kbusch@kernel.org> wrote:
> > > > > On Fri, Aug 14, 2020 at 03:14:31AM -0400, Tong Zhang wrote:
> > > > > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > > > > index ba725ae47305..c4f1ce0ee1e3 100644
> > > > > > --- a/drivers/nvme/host/pci.c
> > > > > > +++ b/drivers/nvme/host/pci.c
> > > > > > @@ -1249,8 +1249,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> > > > > >               dev_warn_ratelimited(dev->ctrl.device,
> > > > > >                        "I/O %d QID %d timeout, disable controller\n",
> > > > > >                        req->tag, nvmeq->qid);
> > > > > > -             nvme_dev_disable(dev, true);
> > > > > >               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> > > > > > +             nvme_dev_disable(dev, true);
> > > > > >               return BLK_EH_DONE;
> >
> > > anymore. The driver is not reporting   non-response back for all
> > > cancelled requests, and that is probably not what we should be doing.
> >
> > OK, thanks for the explanation. I think the bottom line here is to let the
> > probe function know and stop proceeding when there's an error.
> > I also don't see an obvious reason to set NVME_REQ_CANCELLED
> > after nvme_dev_disable(dev, true).
>
> The flag was set after disabling when it didn't happen to matter: the
> block layer had a complicated timeout scheme that didn't actually
> complete the request until the timeout handler returned, so the flag set
> where it is was 'ok'. That's clearly not the case anymore, so yes, I
> think we do need your patch.
>
> There is one case you are missing, though:
>
> ---
> @@ -1267,10 +1267,10 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>                 dev_warn(dev->ctrl.device,
>                          "I/O %d QID %d timeout, reset controller\n",
>                          req->tag, nvmeq->qid);
> +               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>                 nvme_dev_disable(dev, false);
>                 nvme_reset_ctrl(&dev->ctrl);
>
> -               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>                 return BLK_EH_DONE;
>         }
> --
