Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83AEC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1D220730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="RNwHSh2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBEW6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:58:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36821 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbgBEW6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:58:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id j17so3885045edp.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 14:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUqqVzVv+zHVRjksql7Cab1+TMNFjyRWbvebZrdripg=;
        b=RNwHSh2uWCO9tLjuX2QtbpIaLYOgempdFirtNjAkAtl2Lv53y46dHjKm71oMQgMoAC
         SBO8ofU2YRe0ZOpozTHfBE9dWtCVlTzEnRjLzNUNh+QWq+5N6T0J9Uh9t7t+8hTWoF+9
         jIayozCNbwf0lGc0TDFHk7p+O9scR0Q58bIZ3tHbX9+KdOvZHkGiFUztFcYXe8fPt0/2
         kvLAqsTBAcNWdLk5YDyo+6f1q0KuTCLHc4eVbOY0St5zcriy86UeHDmtEnvx4+TV1sc7
         HJLZosR9LDytBdZEDnKXSj9vpSPq3CMMdFHusYNtVgWh70JO/sAOFoOJpbLerAjTch0Y
         zmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUqqVzVv+zHVRjksql7Cab1+TMNFjyRWbvebZrdripg=;
        b=QNpxp2yNn6qbN49CCwNuAG72Lzj7cCr+J/uB4nGT3rG/n30lx6Yb4O/Bc+disb0gjt
         9HF4BHR8oVHeTIQgaS1GpCod6mNmVzz00EjOe1M1Vc4XcGwLDcwpbnGBixFagZ5v/9ZQ
         QqP8uwxE4L+441snhHWEbiBs0fJ/Qe9kHgCRNqlyRygJdq8A5CobVFZFrh4eK7J7HizQ
         UKsloHM4ZGgpwZWaKSgxLzkz7QoAnAI9vzWTXzUg7dbrqp/inOVhQNL9s+vd2hFsQgu+
         F9yWg3J3nt5eLhOMS033siQwwMRzgwPq+OhOHCSB4rlAzVd1GOu1Q7xOwSQpZj3Wc9gs
         T8OQ==
X-Gm-Message-State: APjAAAX4rynOORarT+76NJldXg15ABxIQijTySxgAo1RFz3BCJnl1q53
        oqOd7GJ0NS71kVrOhi4YzWGopGHXLVdhGz85UDwZ
X-Google-Smtp-Source: APXvYqyqotke6mOUBVhpWeNPdxHTvQmAmbBNNpCHK3jA+gycAlKDCEspfqtGiRIi6zOl8VqQ5CArsS+4qJCbOLGo7NA=
X-Received: by 2002:a17:906:9352:: with SMTP id p18mr292520ejw.95.1580943486402;
 Wed, 05 Feb 2020 14:58:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <3665686.i1MIc9PeWa@x2>
 <CAHC9VhRHfjuv5yyn+nQ2LbHtcezBcjKtOQ69ssYrXOiExuCjBw@mail.gmail.com> <35934535.C1y6eIYgqz@x2>
In-Reply-To: <35934535.C1y6eIYgqz@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Feb 2020 17:57:55 -0500
Message-ID: <CAHC9VhQnNUM8XQpFykx_Rg0zNLCaCWDo=HSY3RPhN3ft-RpyHw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 13/16] audit: track container nesting
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        omosnace@redhat.com, dhowells@redhat.com, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 1:12 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Tuesday, February 4, 2020 10:52:36 AM EST Paul Moore wrote:
> > On Tue, Feb 4, 2020 at 10:47 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > > On Tuesday, February 4, 2020 8:19:44 AM EST Richard Guy Briggs wrote:
> > > > > The established pattern is that we print -1 when its unset and "?"
> > > > > when
> > > > > its totalling missing. So, how could this be invalid? It should be
> > > > > set
> > > > > or not. That is unless its totally missing just like when we do not
> > > > > run
> > > > > with selinux enabled and a context just doesn't exist.
> > > >
> > > > Ok, so in this case it is clearly unset, so should be -1, which will be
> > > > a
> > > > 20-digit number when represented as an unsigned long long int.
> > > >
> > > > Thank you for that clarification Steve.
> > >
> > > It is literally a  -1.  ( 2 characters)
> >
> > Well, not as Richard has currently written the code, it is a "%llu".
> > This was why I asked the question I did; if we want the "-1" here we
> > probably want to special case that as I don't think we want to display
> > audit container IDs as signed numbers in general.
>
> OK, then go with the long number, we'll fix it in the interpretation. I guess
> we do the same thing for auid.

As I said above, I'm okay with a special case handling for unset/"-1"
in this case.

-- 
paul moore
www.paul-moore.com
