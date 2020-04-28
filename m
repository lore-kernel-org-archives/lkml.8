Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4207C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2C9206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIaKxGUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgD1J4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:56:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46167 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726971AbgD1J4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588067774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G/W9aZ+NrlbasjS1nCPVX9FlfhgpXwkP8D2tIF11REs=;
        b=DIaKxGUyfEFwff/wQLHU/SyLoxGSXTuxg7LyGndqMt3NLFkL4zE1r784mBne0/k0/VJUM9
        WSIvpJLF2IGx3zg96bZbrAzGujJ3ieIkOPRV4MUEPLD7GaB6YCwzFrh1SxDvna43p3YcaH
        KZWOQW0ikBS0SlKbaIi+BszVNSzr4Fs=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-3QbeTpypM7qHfFvRno3P4Q-1; Tue, 28 Apr 2020 05:56:12 -0400
X-MC-Unique: 3QbeTpypM7qHfFvRno3P4Q-1
Received: by mail-oo1-f70.google.com with SMTP id h26so19114027oos.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/W9aZ+NrlbasjS1nCPVX9FlfhgpXwkP8D2tIF11REs=;
        b=pS3YA3rKJH/mC+JvH+ngrW6qF+GQfuWE1p63QRWjukbZTGB2FCKLSfNxYIPS34QUv2
         hAE3RkdYB60pu1IbK9PLdWYrIBWOAubXZneQ5h4Fl4IgU4xu3qZ+ujDC6WVC4JTMP8jO
         q23S5frwAu7Mnadi4IZYo7Jb/krlgS7lHKRx5j2tFDC7rWl9MLTcgVnVaYfu7jqNE2Hw
         WW838Plf9UKBaJCvjEzoyj6h0du8ylhigDA5pmBxw5nJhxvhvWYafONSEFcrvAJJ6B9b
         89NQ22wJLT4/TwXE6V/F66avSFrtY7NyyfnwEp9aPOr6Cp0iDR4yXSlLObDmEOUi2AOc
         NLOg==
X-Gm-Message-State: AGi0PuazJvFAmHzhQRzzrSuLYFNK5wjyB/0zI83NuG4oUj0I/bqtP3j+
        xP2YmYI3k5PmE45X6EIwo96JekphCeS9nSGA2AUeQTE2dSld8R4o1sNUlZCxekVCg+rr1iSHDoB
        1OT5ZL8AxE0gRN3kYub1Vdxri0f2NRMs5OPa5zKLP
X-Received: by 2002:a05:6830:1da1:: with SMTP id z1mr21876594oti.58.1588067772161;
        Tue, 28 Apr 2020 02:56:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ2WfSLY+cPebgDYSk5t7c4BeA88b88ywtduzupD2vPxfItD+aL07MPiY980Fzsw+i0tHeg8+TXgc4/c659yZg=
X-Received: by 2002:a05:6830:1da1:: with SMTP id z1mr21876580oti.58.1588067771926;
 Tue, 28 Apr 2020 02:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <1588044545-59405-1-git-send-email-wubo40@huawei.com>
In-Reply-To: <1588044545-59405-1-git-send-email-wubo40@huawei.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 28 Apr 2020 11:56:00 +0200
Message-ID: <CAHc6FU5PHELD9N4tdfn663ao1RqyiByGLb8JOfEJGJdyNUwpQw@mail.gmail.com>
Subject: Re: [PATCH] fs/gfs2:lock a spinlock always before returning from do_xmote()
To:     Wu Bo <wubo40@huawei.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 28, 2020 at 5:30 AM Wu Bo <wubo40@huawei.com> wrote:
> The call stack is as follows:
> finish_xmote()
>         ...
>         spin_lock(&gl->gl_lockref.lock);
>         ...
>         --> do_xmote()
>             spin_unlock(&gl->gl_lockref.lock);
>             ...
>             return;
>         ...
>         spin_unlock(&gl->gl_lockref.lock);
>
> do_xmote function needs to be locked before returning,
> Otherwise, there will be a double release lock in finish_xmote() function.
>
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>  fs/gfs2/glock.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 29f9b66..7129d10 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -613,6 +613,7 @@ static void do_xmote(struct gfs2_glock *gl, struct gfs2_holder *gh, unsigned int
>                                 fs_err(sdp, "Error %d syncing glock \n", ret);
>                                 gfs2_dump_glock(NULL, gl, true);
>                         }
> +                       spin_lock(&gl->gl_lockref.lock);
>                         return;
>                 }
>         }
> --
> 1.8.3.1

this patch looks correct. We've independently discovered this bug as
well in the meantime, and we'll send the fix upstream.

Thanks,
Andreas

