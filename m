Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD22C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8762074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AX+BiybX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgFMTXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 15:23:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27134 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726616AbgFMTXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 15:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592076185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=27T1DQs71CRwFTLizFiwEF+g4xuZMlaQho4z4MylCV8=;
        b=AX+BiybXlZadQvLqhem7G4YJd4WqHgG/c2FgcQLwni+crsMQd1Tar1gtG6QXHpfJxErcT+
        Ch6qXLVPiXmqBGP7CunMuiWU5l5fVBt1vr4fjmhufPl54aduqzWWjzS1BrCg4AzpMSImLx
        DeMVu64TXOwCy/hcp1dJe0VVXdKtEdk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-q647sZwaM_GRry3v-lG-dA-1; Sat, 13 Jun 2020 15:23:01 -0400
X-MC-Unique: q647sZwaM_GRry3v-lG-dA-1
Received: by mail-qv1-f70.google.com with SMTP id j4so9772686qvt.20
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 12:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27T1DQs71CRwFTLizFiwEF+g4xuZMlaQho4z4MylCV8=;
        b=mG2AoZhAi1BblwJZS1DfGISyLnoRqdGdfAnPq9MNqv+EPI/c418/lVkBPk9FxXRhMH
         43BUFSReg32ObKYYZRhDE9sSCJ/wirp1hyMQxd0bOiuA02Y+VkhMz5Zl02cWdnc2mmTJ
         jNd99bkM8xoxl5qUARWFAWny3uluRk6Mp0HDIyHmGRB2tDni6tK/rPAWMhUj1dUI7FFx
         5fRB8eZ1gUnfvBpiJj9BTI0Rvb5Nyj/DZXdLOyvuBvdcVKXrrDCRNE1Ja6s+2cizbrN1
         5jpg6zYt3E/FpYSmFCDI8s6h7oQ8wYakxg2FG14UndGr58RnAwTw9e9DqY0IClSpwg8X
         lpcw==
X-Gm-Message-State: AOAM533ditLjcGXKmgskqE37DfHXU0XJi4XUl2Rz78pxlYz5jx2nJFRV
        HVru4H/tNK3fI8MG1vzFRM28yuMNfp/TfpHuCKNZ0NiKfvDJJOX0wCPOYrvTYMVQtAUa+98audV
        2NZwZbb5g6I1r0xJk2/UMhUGcvOAo5vPNEDekAial
X-Received: by 2002:ad4:5885:: with SMTP id dz5mr18136130qvb.214.1592076181277;
        Sat, 13 Jun 2020 12:23:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2AyUSZIKPU+GPvC7qMnN6wFefeo/F6GR7zFPc56HC0zQeczkOAZb7SHVsNLhjHjXrltKCPwy8GjfH7OMAAl8=
X-Received: by 2002:ad4:5885:: with SMTP id dz5mr18136109qvb.214.1592076180987;
 Sat, 13 Jun 2020 12:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
 <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com> <3984625.1592053492@warthog.procyon.org.uk>
In-Reply-To: <3984625.1592053492@warthog.procyon.org.uk>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Sat, 13 Jun 2020 21:22:49 +0200
Message-ID: <CAOssrKe2hNU9OfMo5CWiq7L_Mmv_2OStYMgYgeo5yy6ppmhTrQ@mail.gmail.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Karel Zak <kzak@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
        dray@redhat.com, Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 3:05 PM David Howells <dhowells@redhat.com> wrote:

> > I'm so far just reading this thread and the arguments for users, and I
> > haven't yet looked at all the actual details in the pull request - but
> > last time I had objections to things it wasn't the code, it was the
> > lack of any use.
>
> Would you be willing at this point to consider pulling the mount notifications
> and fsinfo() which helps support that?  I could whip up pull reqs for those
> two pieces - or do you want to see more concrete patches that use it?

Well, I had some questions and comments for the mount notifications
last time around[1] and didn't yet get a reply.

And the fsinfo stuff is simply immature, please lets not merge it just
yet.  When we have some uses (most notably systemd) running on top of
the current fsinfo interface, we can sit down and discuss how the API
can be cleaned up.

BTW I had a similar experience with the fsconfig() merge, which was
pushed with some unpolished bits and where my comments were also
largely ignored.  So, before asking to pull, please at least *answer*
reviews.  You don't have to agree, but at least consider and think
about the comments.

Thanks,
Miklos

[1] https://lore.kernel.org/linux-fsdevel/CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com/

