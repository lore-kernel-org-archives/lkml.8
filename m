Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F71C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08AF522B45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XO91VMIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgHDJe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgHDJe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:34:28 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBA8C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 02:34:28 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c2so23483019edx.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pv5BPk76i/MoWGs1gw+KWKrHA/vLK3W5JwzOEjOtqbI=;
        b=XO91VMIYWmJJyaLCqDwDI7R+/IhY8Otht/jNSco5h8lhYIS7roedId1R24+PWBV16J
         LGJrXnUSRgNnkCXYNmrxfDAd/fQa45PtQvzrfacRxUq3Htw7n9EcjRgyEZy0FGDPEzsx
         +Kf4QL8FkwyirK30cJnrDCj4Ay+ihET2LbOtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pv5BPk76i/MoWGs1gw+KWKrHA/vLK3W5JwzOEjOtqbI=;
        b=LUJQrz2C6tkEEPgoR6GvVBjdGs+WHrBXHLHQGkU6wXfY+LGD8w7vUpt2Id+PITzUDU
         PsFmoztGMqQH99+SEBe1KK7sD7TC5lRcPhmWDRp28UaPgssgrWwbLlEFs1dD0pcHbiYW
         mYUXKQPlmjcT5mV0G/U6LVY5v7LbDJWoraAg8sOd1qUa6you/S2M5jYimwNpnQUvSC1X
         8ccajLV0ZpJGynz8hqyUWojVyxZOLIytEiI5yVSEMPvQMoAPG3pszzqWKLufG17vwvPC
         XnDLJR+dNNiS61IxfxplGh9WZuXgLlB/0vMdCOL8SIQo2kuHi8zW8jH4QPWuSL8urMfu
         hang==
X-Gm-Message-State: AOAM530Ib8pgg0kkXGFkH53kb54pWpUUekas0uIQpWCi4ZZsYjWao6OM
        6huJLY9p/p4ln+iXRCoXuYy2+afgIuBXFh9suw/K9Q==
X-Google-Smtp-Source: ABdhPJyCVcW919I6oNh7+VZo4I3h9xZy6Vr4Yw7zYMnMeDWnx5DDKuBcJyX6d89ZTqqueg33E4gXqgxVmtE7jo4mugc=
X-Received: by 2002:aa7:c915:: with SMTP id b21mr20325848edt.17.1596533666430;
 Tue, 04 Aug 2020 02:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646179405.1784947.10794350637774567265.stgit@warthog.procyon.org.uk>
In-Reply-To: <159646179405.1784947.10794350637774567265.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 4 Aug 2020 11:34:15 +0200
Message-ID: <CAJfpegvM4K1PhTkDivtzWsE2g8rBUMmzniaW8Op0XY5codvu1w@mail.gmail.com>
Subject: Re: [PATCH 01/18] fsinfo: Introduce a non-repeating system-unique
 superblock ID [ver #21]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 3:37 PM David Howells <dhowells@redhat.com> wrote:
>
> Introduce an (effectively) non-repeating system-unique superblock ID that
> can be used to determine that two objects are in the same superblock
> without needing to worry about the ID changing in the meantime (as is
> possible with device IDs).
>
> The counter could also be used to tag other features, such as mount
> objects.
>
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
