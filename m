Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BD0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 18:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBEB20776
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 18:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U6Wktnat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389892AbgEYSkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 14:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389714AbgEYSkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 14:40:35 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51B0C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 11:40:35 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id o13so14469094otl.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G1Jbxag3vYMxCRlwKX8F3vereBNRVPySTcbvXbszZAI=;
        b=U6WktnatSX0eMuD9yoVKjFvInc4SGDL2hoEbG65zEw/w+FxHose/ikOV6g4t38ePi0
         4oSiNqj6R3/3k9NIVlDbdd8Ua+W3U01BDPPDnRs0oAsKAEymk7oosYmW/4D92zRkMhQF
         oikQWenuVHTY0BwHXYjbzsH8QC/GJ/ZGOmMNHsF1GPtp1ARx7BLZzNv5WDHeYEcTm+gK
         ivwvOMojL7u4q/I4epggCIxCvVgFM+QCDxgJQzlOU81UefdOx2bAHNRIDzOoZAyUOKle
         KUDBBSvE7dfzjCIQ5ZSP0C9DBwLV6HwHfLOQyNVLBh2iI3B2JFx1VIjeHKd0EsgX5Tqt
         5sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1Jbxag3vYMxCRlwKX8F3vereBNRVPySTcbvXbszZAI=;
        b=h5grzRJ6qxY7gct3PTqKIbxDqp8dCPrHwfyb2mVLiK5YKX+IpahCgvaLgmNSFZFcUt
         FI2WRP85Gi2wpYjsw2uV9mf/Yx5OTC14keYWfQUZx9KTQgcWBDma6hf5Q2Ez4zkVbT0r
         yiQcHcrLxgGJJzWkiqDXKye8JcGYXeZ2Fz6BnIzwTEbK5gw1HAi6i8DJTnTU6ZGCkaBW
         tmI69cG52adsHgtTx4ADMHwPmxJ302OkkEuSE5RB4EkY4A8DICcWkUgiT4oJvUaYdbwA
         n8LXVagmUmsblRpUIkJM2fVFqKzz8jz4mSqYoANJLGy+hS+CXoHGnXwXaT/jU5drAJlo
         wLbQ==
X-Gm-Message-State: AOAM530vjBsLIDHWW0zAFR7IX+8Ufqli/PZXCH5S5iia9oqqyyXKkMF3
        alSCCB5imCcf03rNmko/aoU24lk+XNAU3j9aYyw4Tw==
X-Google-Smtp-Source: ABdhPJzam0mG4uOv8MmedvhgJLl9ggYXxYDG8GXq5o99MTJIVmTTjBqXRNh/Yt3dbsn55c+dlNswUhjU9TN8VNjXy6w=
X-Received: by 2002:a9d:66d5:: with SMTP id t21mr20056603otm.231.1590432034497;
 Mon, 25 May 2020 11:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200518080327.GA3126260@kroah.com> <20200519063000.128819-1-saravanak@google.com>
 <20200522204120.3b3c9ed6@apollo> <CAGETcx85trw=rCM1+dmemMGKstFCq=Nn7HR2fyDyV0rTTQYtEQ@mail.gmail.com>
 <41760105c011f9382f4d5fdc9feed017@walle.cc> <86f3036b44941870d12e432948a7cbb6@walle.cc>
In-Reply-To: <86f3036b44941870d12e432948a7cbb6@walle.cc>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 25 May 2020 11:39:58 -0700
Message-ID: <CAGETcx-MbMXz-vw_1+EPKQMdeWXNFvhiP2UAJN=-563Y25VJDw@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Fix SYNC_STATE_ONLY device link implementation
To:     Michael Walle <michael@walle.cc>
Cc:     stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 4:31 AM Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-05-23 00:47, schrieb Michael Walle:
> > Am 2020-05-23 00:21, schrieb Saravana Kannan:
> >> On Fri, May 22, 2020 at 11:41 AM Michael Walle <michael@walle.cc>
> >> wrote:
> >>>
> >>> Am Mon, 18 May 2020 23:30:00 -0700
> >>> schrieb Saravana Kannan <saravanak@google.com>:
> >>>
> >>> > When SYNC_STATE_ONLY support was added in commit 05ef983e0d65 ("driver
> >>> > core: Add device link support for SYNC_STATE_ONLY flag"),
> >>> > device_link_add() incorrectly skipped adding the new SYNC_STATE_ONLY
> >>> > device link to the supplier's and consumer's "device link" list.
> >>> >
> >>> > This causes multiple issues:
> >>> > - The device link is lost forever from driver core if the caller
> >>> >   didn't keep track of it (caller typically isn't expected to). This
> >>> > is a memory leak.
> >>> > - The device link is also never visible to any other code path after
> >>> >   device_link_add() returns.
> >>> >
> >>> > If we fix the "device link" list handling, that exposes a bunch of
> >>> > issues.
> >>> >
> >>> > 1. The device link "status" state management code rightfully doesn't
> >>> > handle the case where a DL_FLAG_MANAGED device link exists between a
> >>> > supplier and consumer, but the consumer manages to probe successfully
> >>> > before the supplier. The addition of DL_FLAG_SYNC_STATE_ONLY links
> >>> > break this assumption. This causes device_links_driver_bound() to
> >>> > throw a warning when this happens.
> >>> >
> >>> > Since DL_FLAG_SYNC_STATE_ONLY device links are mainly used for
> >>> > creating proxy device links for child device dependencies and aren't
> >>> > useful once the consumer device probes successfully, this patch just
> >>> > deletes DL_FLAG_SYNC_STATE_ONLY device links once its consumer device
> >>> > probes. This way, we avoid the warning, free up some memory and avoid
> >>> > complicating the device links "status" state management code.
> >>> >
> >>> > 2. Creating a DL_FLAG_STATELESS device link between two devices that
> >>> > already have a DL_FLAG_SYNC_STATE_ONLY device link will result in the
> >>> > DL_FLAG_STATELESS flag not getting set correctly. This patch also
> >>> > fixes this.
> >>> >
> >>> > Lastly, this patch also fixes minor whitespace issues.
> >>>
> >>> My board triggers the
> >>>   WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
> >>>
> >>> Full bootlog:
> > [..]
> >
> >> Thanks for the log and report. I haven't spent too much time thinking
> >> about this, but can you give this a shot?
> >> https://lore.kernel.org/lkml/20200520043626.181820-1-saravanak@google.com/
> >
> > I've already tried that, as this is already in linux-next. Doesn't fix
> > it,
> > though.
>
> btw. this only happens on linux-next (tested with next-20200522), not on
> 5.7-rc7 (which has the same two patches of yours)

I wouldn't be surprised if the difference is due to
fw_devlink_pause/resume() calls in driver/of/property.c. It chops off
~1s in boot time by changing the order in which device links are
created from DT. So, I think it's just masking the issue.

On linux-next where you see the issue, can you get the logs with this change:
+++ b/drivers/base/core.c
@@ -907,7 +907,10 @@ void device_links_driver_bound(struct device *dev)
                         */
                        device_link_drop_managed(link);
                } else {
-                       WARN_ON(link->status != DL_STATE_CONSUMER_PROBE);
+                       WARN(link->status != DL_STATE_CONSUMER_PROBE,
+                               "sup:%s - con:%s f:%d s:%d\n",
+                               dev_name(supplier), dev_name(link->consumer),
+                               link->flags, link->status);
                        WRITE_ONCE(link->status, DL_STATE_ACTIVE);
                }

My goal is to figure out the order in which the device links between
the supplier and consumers devices are created and how that's changing
the flag and status. Then I can come up with a fix.

Thanks,
Saravana
