Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1B0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1082067D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="E5LkGHz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHCJ3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 05:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgHCJ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 05:29:42 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AFDC06179E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 02:29:40 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o10so17035641edh.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owNLFqTMe1SU5EaKmrLtcVAQ4KDndakWi4Xb0Cu0Z7c=;
        b=E5LkGHz5hRcvvUwxDdXSDeNZX1oJy9nnYaDR4Qa2WN7LPbOyqMkQToA2KaIosRDx2l
         /vAExylwGECGrMNjwVPDmYo7pNQ2YqGjS2ohu2O6bKfvmdR8zsidyAa/NkbgnEMDSLHI
         4UqRBKbGyq8XWb5T0s7zheGCNIklGnT6FDvMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owNLFqTMe1SU5EaKmrLtcVAQ4KDndakWi4Xb0Cu0Z7c=;
        b=ZAi2qcQ/cEF1rkQVyIPAz/x6twKH5gun1JamXBrueyUyvBl84VjFoT1sGAYSS/lkIE
         IbfsmML/qDUQyjLtmFWS179jKSDPtBZ4+NfiG0RjHY9wihD4cySG7pjUUZbn+m67azPG
         zH8X2WEbodIheXe142hxaqRGuZLvUQa7hZGXhnYHx9lZjEbg+TowNnynTm4E17mQByk0
         7mzY6Fyw/oydfCvasnSTNFdJKm1roOetWsxa3UCUDfcmEQrteypvhJhJB5bapNKQaC0g
         75hLTPj5HR7HP1Qykp6AOgTrapH4qU3KqRrNgfqOdFciZzlL1XYwDFto1ZsfxJ/CnNx9
         OIMg==
X-Gm-Message-State: AOAM530uvcsbfQx1Z/mxeQNCYveNEdn9kCblPjRgTOO1HmTWQ7d83cKc
        gZgfvtRvKfiB/ddQpZrBkZhO4zG1yiCrnS1yCeiaCA==
X-Google-Smtp-Source: ABdhPJwwRwE/z9+48aOsHKHN045IllUewS+ZVaDKVLXEbNVYV6u3PqSbaJ4L7LCc7hyeEJUAG7ii5G7P1/+cTZ4bZsc=
X-Received: by 2002:aa7:c915:: with SMTP id b21mr15388861edt.17.1596446978906;
 Mon, 03 Aug 2020 02:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
 <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
 <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com> <1293241.1595501326@warthog.procyon.org.uk>
In-Reply-To: <1293241.1595501326@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 3 Aug 2020 11:29:27 +0200
Message-ID: <CAJfpeguvLMCw1H8+DPsfZE_k0sEiRtA17pD9HjnceSsAvqqAZw@mail.gmail.com>
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute
 change notifications [ver #5]
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 12:48 PM David Howells <dhowells@redhat.com> wrote:

>
> > >                 __u32   topology_changes;
> > >                 __u32   attr_changes;
> > >                 __u32   aux_topology_changes;
> >
> > Being 32bit this introduces wraparound effects.  Is that really worth it?
>
> You'd have to make 2 billion changes without whoever's monitoring getting a
> chance to update their counters.  But maybe it's not worth it putting them
> here.  If you'd prefer, I can make the counters all 64-bit and just retrieve
> them with fsinfo().

Yes, I think that would be preferable.

> > >         n->watch.info & NOTIFY_MOUNT_IS_RECURSIVE if true indicates that
> > >         the notifcation was generated by an event (eg. SETATTR) that was
> > >         applied recursively.  The notification is only generated for the
> > >         object that initially triggered it.
> >
> > Unused in this patchset.  Please don't add things to the API which are not
> > used.
>
> Christian Brauner has patches for mount_setattr() that will need to use this.

Fine, then that patch can add the flag.

Thanks,
Miklos
