Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F165C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77468207C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZTHa8Qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgFJPVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbgFJPVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:21:32 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD29BC03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:21:31 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r77so2638370ior.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDIT6x87ISO3TnYeS6spJXv8ZoQmwNPEKf3Qs0adTWg=;
        b=QZTHa8QrEZjMQuJ9tkWDu1RFvtMyhjk7qROm7omdjC1CgoXYpgUU5UHxQGj31i+io3
         EciL1+PXhuiz+mSUdq21pFbl91WIzCwJ8O8+ZXHF31amgFtErVCEe6W47VqgIfZxb37M
         yk+tj6f2Tl5R4SsaeTXDEG9mKIFX/1x0YfDwrabaDItK0vCjv7SXUecuI1G6VVfbyC6U
         uksWNNTTlhV6b4aalTTbF3l/hD08TfObXvyTGob4r8R8aJfmEVdYE9h5000HMtHKR7xH
         d6F+IX/zGImQ+DJp+eWPl2txEl/XR8kzncK9giayu/3Dz71hka71owx6uDqcupFU1IM/
         kgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDIT6x87ISO3TnYeS6spJXv8ZoQmwNPEKf3Qs0adTWg=;
        b=L11inrzgPRknDJRXeJRVW4DpBocGuwgvK78YYdqhP7CzjFqt/W7lwcIw2vhfcrEvYa
         r3lbz5ty/XjEpJu5aPv4S1RSRi0YWW/p8hd+xqfQGljX7zjs272rTTkJrtKXhfkBfyHe
         CdRTiQm4ZRcH+hvkWFCfcY4n3rovXCdWHo/C8Ng8tvWLROqKuvFsu/WnqJzJkBQ8mvKE
         2GTFBgFYy4IWvpjfRb3X1I/oMoExpEsSNdBQVMIl1xiNRQOJlLoGagnDtUf3ZYIGiEJ8
         cG5tS3QktL5U7IpgDEspW5neRXfa8qPAAqKlJ5Zc4h0n/yyAaRPyM4KmNBTbZNqory4D
         PPog==
X-Gm-Message-State: AOAM5329tfQzfwxxuHibC58y/FMcDbmD4KF+KHUPW++cyesBVDqNPl/C
        +xyzDqxNloJ1JZQJgtmaOU70pk4H0sbISpr2lrJydzqk
X-Google-Smtp-Source: ABdhPJwlpnE1mMDsScFZY6A2ChwqnbMX2Dfb5g5WGluoTGmF82+K/Rsrds1krZpmpZcF4ac0f23skflBlNDgrrwU+Vg=
X-Received: by 2002:a6b:b515:: with SMTP id e21mr3827345iof.53.1591802491079;
 Wed, 10 Jun 2020 08:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200607193023.52344-1-jassisinghbrar@gmail.com> <20200610082315.GB2689@bogus>
In-Reply-To: <20200610082315.GB2689@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 10 Jun 2020 10:21:19 -0500
Message-ID: <CABb+yY1T03YLwiFvBykxsAHQ9Kpu=r1nRTuaP3Emf5dP=Upm0g@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: fix timeout value for send_message
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 3:23 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Sun, Jun 07, 2020 at 02:30:23PM -0500, jassisinghbrar@gmail.com wrote:
> > From: Jassi Brar <jaswinder.singh@linaro.org>
> >
> > Currently scmi_do_xfer() submits a message to mailbox api and waits
> > for an apparently very short time. This works if there are not many
> > messages in the queue already. However, if many clients share a
> > channel and/or each client submits many messages in a row, the
>
> The recommendation in such scenarios is to use multiple channel.
>
If SCMI is to be accepted as a standard (which I hope), it has to
support most kinds of controllers, but currently the implementation is
too myopic. It is only a matter of time, when someone sees value in
reusing firmware implementation (scmi) but does not have a MHU like
controller.

> > timeout value becomes too short and returns error even if the mailbox
> > is working fine according to the load. The timeout occurs when the
> > message is still in the api/queue awaiting its turn to ride the bus.
> >
> >  Fix this by increasing the timeout value enough (500ms?) so that it
> > fails only if there is an actual problem in the transmission (like a
> > lockup or crash).
> >
> > [If we want to capture a situation when the remote didn't
> > respond within expected latency, then the timeout should not
> > start here, but from tx_prepare callback ... just before the
> > message physically gets on the channel]
> >
>
> The bottle neck may not be in the remote. It may be mailbox serialising
> the requests even when it can parallelise.
>
Your logs show (in your test case), using 1 physical channel shows
better transfer (those that complete) rates than virtual channels.
The transfers that fail are purely because of this short timeout.

> >
> >       if (xfer->hdr.poll_completion) {
> > -             ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
> > +             ktime_t stop = ktime_add_ns(ktime_get(), 500 * 1000 * NSEC_PER_USEC);
> >
>
> This is unacceptable delay for schedutil fast_switch. So no for this one.
>
Increasing timeout does not increase latency.
Also scmi_xfer() can not know if it was reached from the fast_switch path.

If a platform has many users over a channel such that it can not
guarantee low enough latency, then it must not set the
fast_switch_possible flag, which is optional for this reason.


> > @@ -313,7 +313,7 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
> >                       ret = -ETIMEDOUT;
> >       } else {
> >               /* And we wait for the response. */
> > -             timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
> > +             timeout = msecs_to_jiffies(500);
>
> In general, this hides issues in the remote.
>
If you want to uncover remote issues, start the timeout in
tx_prepare() because that is when the message is physically sent to
the remote.

> We are trying to move towards
> tops 1ms for a request and with MBOX_QUEUE at 20, I see 20ms is more that
> big enough. We have it set to 30ms now. 500ms is way too large and not
> required IMO.
>
Again, increasing timeout does not slow the system down. It is to
support more variety of platform setups.

Cheers!
