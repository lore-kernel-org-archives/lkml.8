Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41A0C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08142074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVGEdp2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgHNPhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgHNPhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:37:33 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDACC061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 08:37:32 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q14so8787480ilj.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vedeg1TU63CF1kJq07P08JkbOKRTBMhiE4Lkx4pw3ww=;
        b=dVGEdp2G0bpJ2M3oeuYgPNh2qgAVGLuQhqA51LK0XANheAGq0fQvyAd/vO257KcvKC
         Rs0LhdFT12NIrcsZ+1iE50AmgtR6ko8REmEB9QQQsz7XsGxj21N8r9w/NJTdfc5fcGf9
         s1w6AiegnLwWuH6FPJptx/vpYSwXRcUEtlIZW2M5MtcaqJCPk7KxUdzfwQH4gGxSmbf9
         /xUQ/8dJ6IKObPccSeR9Lzaboytvr82HCHaxymIOaB9QrqT3tSIOv7BwIweUsw5yO3LH
         /Yl2RPCYw8bidP6FtFtnWgqdwl2J0nohGVmszV/kOJmZKidB3uWS0Q4EH5nQzK9XE85r
         axdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vedeg1TU63CF1kJq07P08JkbOKRTBMhiE4Lkx4pw3ww=;
        b=CxHhj3nKBYEw/Jsvii6pX4qQIqzVfb40qYYnJ+a6K41oH7WfW/TTnzdJNdSP5rRl/2
         7wW5S64XUj1wtWohcm75rYYjj3C3hg1w9DgbCpgOI2zJm8+iE9plrKiEFwK+ctuP4Ia5
         zILIIj6nPmc/Jw0fqX3VlxLBplIGmGcF4Wry4kYx87hV0U1LfMvpT8m1Cvg2FGeL8UQB
         6PUzrratDoiwWSpTmPRLpNJMkgq6RMlA8Vb6zinlfyf2F1Rwc821V2GwXBDgQE1Ksk2v
         boekiy4by7vh6ZfN2V5xIZpn3QWUR1QtxC2Bn1kkCpdkJwxmNhyfvCPO3tXYS+QhTu7p
         7wqg==
X-Gm-Message-State: AOAM5327lfSnrMesJhWm0FckLh4objCDNyIJajZcYvqCxRZrUHs7R8IH
        EzYxASGh8uMBULP1XRRikCGmqBhzB8G0YbF/9RsUVH+w15AeAeiB
X-Google-Smtp-Source: ABdhPJzr8YoG2sJ/oGlkT9eL1HVlhZ78Dq8uWzSBloF+h0eLPkcr9aOKHLL2us1cqzw7LbDsBozTCeioYS4Sijl0C58=
X-Received: by 2002:a92:c524:: with SMTP id m4mr2864709ili.306.1597419451648;
 Fri, 14 Aug 2020 08:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200814071431.201400-1-ztong0001@gmail.com> <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Fri, 14 Aug 2020 11:37:20 -0400
Message-ID: <CAA5qM4CctYiBe766-OnxAPHJWByyOo1rE7FzW-75ZcOib6niCA@mail.gmail.com>
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

On Fri, Aug 14, 2020 at 11:04 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Aug 14, 2020 at 03:14:31AM -0400, Tong Zhang wrote:
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index ba725ae47305..c4f1ce0ee1e3 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -1249,8 +1249,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> >               dev_warn_ratelimited(dev->ctrl.device,
> >                        "I/O %d QID %d timeout, disable controller\n",
> >                        req->tag, nvmeq->qid);
> > -             nvme_dev_disable(dev, true);
> >               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> > +             nvme_dev_disable(dev, true);
> >               return BLK_EH_DONE;
>
> Shouldn't this flag have been set in nvme_cancel_request()?

nvme_cancel_request() is not setting this flag to cancelled and this is causing
__nvme_submit_sync_cmd() to return a positive number and eventually
this will allow nvme_init_identify() proceed with a timeout error where the
problematic nvme device has already been disabled by nvme_dev_disable(dev,true).
The reset of the logic in nvme_init_identify() is not going to check
those already
released resources. -- in fact this is UAF --

> like the timeout out command is the only command to have been cancelled
> by this action, nor is it guaranteed that getting here will mean the
> request was in fact cancelled. The controller could still provide a real
> completion.

what would you like to suggest here?
