Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81312C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E1E82071A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cp8r+1sL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404896AbgE1QKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404887AbgE1QKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:10:03 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E27EC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 09:10:03 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id 18so1093651ooy.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=COfs6qCE8hM8QVaiAzFL6DNp7cNTDmfQQIXgkIZMl/w=;
        b=cp8r+1sLeeFw8G0IzpIBNAfkrRVlgDBX2s0RLF2xI1OSGCJKWiQnp5W2nkCWJPd1vp
         tCQP9fdSOpZq8tUcVtUsQmQVV9MkuVaMgqp4Ci1CGREDLP/dqAinYjBm593K/Zl947BY
         +jOFNTDrgTswwCWMatNlxUUstKyjbQ9EqeGj8lx51OG+TGFnq6XGMMHkiucOefLBXmAb
         4b4brcQH3609QeZt/cMS0fz78HqHetKNWWbOZOoj2SCgg5PbRM14FPNCSLiAQNQeMc5H
         EoxbVg1ikVFWdbN8FcxHgySncNXAFIo4EZ2taMW23olSkXzp/bKBwpOu0GNgllIV6DeZ
         QqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COfs6qCE8hM8QVaiAzFL6DNp7cNTDmfQQIXgkIZMl/w=;
        b=rqDKMz1k0APE6KULyveAKEpJja7uUUEo8P8ohWoOdY++b8DrZm40ww9t6ROtNxwfmJ
         pqI3+XSaHGKLr65197t4IxsSyuwhyvFZMXbWc2mDlFn+VHJ/bPLHuwHsiqH2xMHonap3
         zAbmUDlLDNZ2wrRlEpEy6esATfYeERFhA3oEHicYqZD9swPnFlJOtzQfMR9eEjgHTA/K
         fOgLQUQ5pYjPujSlO9sRtAD1+6bZYCIBqFOhT6YhOVpvrFPERmf7oxFHtgxfP2UR6Gp6
         uSR7HWTf16wywgk21KE2Tks5m+ccRM30RfKysPSpdD5Cyu+XngtFVEXPNGMc95KdYm3a
         FSWA==
X-Gm-Message-State: AOAM5317YQe652UUoXVADF6A7jLvjYuFQxQA8P5gVN7DAjPKCxExRGRV
        uLlfhYjOszAJi/eSBr9+SJYm7oiDKFbSgGCSOfvTpQ==
X-Google-Smtp-Source: ABdhPJzw0SA7Pqgbo/xntKafhIdeFTSXoamjxO2GxCLPaaFW1LFuSDsjxSYmXaw/kRoCf6Eck45wNbm5HRyvM06nHTI=
X-Received: by 2002:a4a:9624:: with SMTP id q33mr3091583ooi.53.1590682197632;
 Thu, 28 May 2020 09:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <6144404cb26d1f797fd7e87b124bcaf8@walle.cc> <20200526220928.49939-1-saravanak@google.com>
 <CAJZ5v0g3Oo82-eUDqgSTGBM-dpaJEfOtvaXRVMmDQvHg72rAJw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g3Oo82-eUDqgSTGBM-dpaJEfOtvaXRVMmDQvHg72rAJw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 28 May 2020 09:09:21 -0700
Message-ID: <CAGETcx_5DPEBOHuknwJYMSAn7pw8UHgeA78Gqxm=ngFghmycxg@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: Update device link status correctly for
 SYNC_STATE_ONLY links
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 1:26 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 12:09 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > When SYNC_STATE_ONLY support was added in commit 05ef983e0d65 ("driver
> > core: Add device link support for SYNC_STATE_ONLY flag"),
> > SYNC_STATE_ONLY links were treated similar to STATELESS links in terms
> > of not blocking consumer probe if the supplier hasn't probed yet.
> >
> > That caused a SYNC_STATE_ONLY device link's status to not get updated.
> > Since SYNC_STATE_ONLY device link is no longer useful once the
> > consumer probes, commit 21c27f06587d ("driver core: Fix
> > SYNC_STATE_ONLY device link implementation") addresses the status
> > update issue by deleting the SYNC_STATE_ONLY device link instead of
> > complicating the status update code.
> >
> > However, there are still some cases where we need to update the status
> > of a SYNC_STATE_ONLY device link. This is because a SYNC_STATE_ONLY
> > device link can later get converted into a normal MANAGED device link
> > when a normal MANAGED device link is created between a supplier and
> > consumer that already have a SYNC_STATE_ONLY device link between them.
> >
> > If a SYNC_STATE_ONLY device link's status isn't maintained correctly
> > till it's converted to a normal MANAGED device link, then the normal
> > MANAGED device link will end up with a wrong link status. This can cause
> > a warning stack trace[1] when the consumer device probes successfully.
> >
> > This commit fixes the SYNC_STATE_ONLY device link status update issue
> > where it wouldn't transition correctly from DL_STATE_DORMANT or
> > DL_STATE_AVAILABLE to DL_STATE_CONSUMER_PROBE. It also resets the status
> > back to DL_STATE_DORMANT or DL_STATE_AVAILABLE if the consumer probe
> > fails.
> >
> > [1] - https://lore.kernel.org/lkml/20200522204120.3b3c9ed6@apollo/
> > Fixes: 05ef983e0d65 ("driver core: Add device link support for SYNC_STATE_ONLY flag")
> > Fixes: 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link implementation")
> > Reported-by: Michael Walle <michael@walle.cc>
> > Tested-by: Michael Walle <michael@walle.cc>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Reviewed-by: Rafael J. Wysocki <rrafael.j.wysocki@intel.com>
>

Thanks Rafael for the review.

And thanks again Michael for all the logs!

-Saravana
