Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A488EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7127E2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="YO/KeKyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgBGGg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 01:36:57 -0500
Received: from forward106p.mail.yandex.net ([77.88.28.109]:47315 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgBGGg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:36:56 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Feb 2020 01:36:53 EST
Received: from forward103q.mail.yandex.net (forward103q.mail.yandex.net [IPv6:2a02:6b8:c0e:50:0:640:b21c:d009])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id B618E1C81750;
        Fri,  7 Feb 2020 09:29:20 +0300 (MSK)
Received: from mxback7q.mail.yandex.net (mxback7q.mail.yandex.net [IPv6:2a02:6b8:c0e:41:0:640:cbbf:d618])
        by forward103q.mail.yandex.net (Yandex) with ESMTP id B338A61E0002;
        Fri,  7 Feb 2020 09:29:20 +0300 (MSK)
Received: from vla3-5ed9a7202853.qloud-c.yandex.net (vla3-5ed9a7202853.qloud-c.yandex.net [2a02:6b8:c15:341d:0:640:5ed9:a720])
        by mxback7q.mail.yandex.net (mxback/Yandex) with ESMTP id 7l5AJaDdHo-TKLmegL5;
        Fri, 07 Feb 2020 09:29:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1581056960;
        bh=fN1p0YF8w6RVvXxIM+isyAEkTDIBckRLo+TQh36LRrI=;
        h=In-Reply-To:Subject:Cc:To:From:References:Date:Message-ID;
        b=YO/KeKyVnPRnxd7vGuzRPl6tKyBDPaQ7IR5SlqlT+cGpVDnQkro006sZEAIDOxbya
         DKuFljblh30XcwPFKmEe9FGMFnRaIRBBEG6jgfkpRDJG0ecAiDq+gj83LepcS/dRAD
         h9N2QzwJI1dF894VoJ7M5YtG8eXI6tKVgIoyFF0k=
Authentication-Results: mxback7q.mail.yandex.net; dkim=pass header.i=@maquefel.me
Received: by vla3-5ed9a7202853.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 9kDLtmxjjA-TJVWclLW;
        Fri, 07 Feb 2020 09:29:19 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Fri, 7 Feb 2020 09:30:15 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Nikita Shubin <NShubin@topcon.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: warn on kick missing
Message-ID: <20200207063015.GA15993@maquefel.me>
References: <20200206055419.15897-1-NShubin@topcon.com>
 <20200206201827.GP2514@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206201827.GP2514@yoga>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 12:18:27PM -0800, Bjorn Andersson wrote:
> On Wed 05 Feb 21:54 PST 2020, Nikita Shubin wrote:
> 
> > .kick method not set in rproc_ops will result in:
> > 
> > 8<--- cut here ---
> > Unable to handle kernel NULL pointer dereference
> > 
> > in rproc_virtio_notify, after firmware loading.
> > 
> > At least a warning needed on attempt to call missing method.
> 
> Is this not a fatal error only happening during development? In which
> case the NULL pointer dereference will come with an oops with sufficient
> information to pinpoint what's going on?

Hello, Bjorn.

This error is happenning if no kick method was defined for struct
rproc_ops, like, for example, in imx_rproc. 

Looks, like if we have a resource table with defined vring's in it, a
virtqueue will be allocated in rp_find_vq, passing rproc_virtio_notify.

But may be it's a better way to refuse calling vring_new_virtqueue if kick
method method is not defined. To avoid explicit load in rproc_virtio_notify.

> 
> Regards,
> Bjorn
> 
> > 
> > Signed-off-by: Nikita Shubin <NShubin@topcon.com>
> > ---
> >  drivers/remoteproc/remoteproc_virtio.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> > index 8c07cb2ca8ba..77a81f331e3f 100644
> > --- a/drivers/remoteproc/remoteproc_virtio.c
> > +++ b/drivers/remoteproc/remoteproc_virtio.c
> > @@ -32,6 +32,12 @@ static bool rproc_virtio_notify(struct virtqueue *vq)
> > 
> >         dev_dbg(&rproc->dev, "kicking vq index: %d\n", notifyid);
> > 
> > +       if (unlikely(rproc->ops->kick == NULL)) {
> > +               WARN_ONCE(rproc->ops->kick == NULL, ".kick method not defined for %s",
> > +                       rproc->name);
> > +               return false;
> > +       }
> > +
> >         rproc->ops->kick(rproc, notifyid);
> >         return true;
> >  }
> > --
> > 2.24.1
> > 
> > Confidentiality Notice: This message (including attachments) is a private communication solely for use of the intended recipient(s). If you are not the intended recipient(s) or believe you received this message in error, notify the sender immediately and then delete this message. Any other use, retention, dissemination or copying is prohibited and may be a violation of law, including the Electronic Communication Privacy Act of 1986.   ??
