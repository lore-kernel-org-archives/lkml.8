Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB05C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74932206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6A+PSoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgFBUdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:33:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35503 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbgFBUdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591129981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l1JOIh6x8pU16e+KeIxJ3985QnaxQPsUtC1NFDK742A=;
        b=J6A+PSoOMeIDeRum0VyAa7Wt9QGAWXIBv4Q0ueXU0Zl95jVyn28gPDYEdGEyb7yDKjWuX/
        ZyKhOcvxFUkhlV48zaERE8Ux+o6Fb4hInZFmfLM5l7EwuLwC09MkCGhiF3NanTXBVoOpmj
        GNO741J5+z1pMHI5/0EfpmYBJoAXg5I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-4BVKEddIPNS69m6uzp6-2A-1; Tue, 02 Jun 2020 16:32:59 -0400
X-MC-Unique: 4BVKEddIPNS69m6uzp6-2A-1
Received: by mail-wr1-f69.google.com with SMTP id a4so27560wrp.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l1JOIh6x8pU16e+KeIxJ3985QnaxQPsUtC1NFDK742A=;
        b=EV3eGF4P4AYL/JfRLKmQRq/czK0s3ORZHp926NCk0XSOcI6edxn00ofhPm2nyF/MaR
         ZoisgiaCwfQel5JOteKQRjeJb71hhxLU+LZ2iEw/FNbvvMYRXMKRUA/KQqiyNll02uAI
         XzanrllBys7tw9s16e5DrYKtLc/0fe7ejpwwMlZ1tEul6ydzoh6EbCEZjuTjgBjg4nH+
         zhims41HXItw+K/HA8JYOW6AQYbW40vReqz5xej67x7AlGI7xK4HDCLUTkzm5syZPSQI
         y5MMdjPJrXpCsVUEKNffZ0KSFDPLABWU2Xial2GMQ1K8ODl8q4JiR+2f9eRrVgC9oRAY
         jzOQ==
X-Gm-Message-State: AOAM531Fm8oZaiEOPIVW9JbN12lrbo+7hm+QQq7Ji4mU3Ma6Dc/gOOwa
        renJVqkclc+38E/Rzw0TfjtsodUyHHv0UemS1atMwIXEbHW1FRcAfn89/SDSw4HTd30ySt0Uhbp
        xaaZ3BFQKNzpkdijG9jccGYSS
X-Received: by 2002:a5d:4009:: with SMTP id n9mr8335982wrp.97.1591129978167;
        Tue, 02 Jun 2020 13:32:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxta+duSnnM6Sw6TP8Il90bmNxS0TxUdVpTMsswgIhh7OWkM/g/xNw1APhqHm+S8wMt2yCXQ==
X-Received: by 2002:a5d:4009:: with SMTP id n9mr8335971wrp.97.1591129977909;
        Tue, 02 Jun 2020 13:32:57 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id s132sm10118wmf.12.2020.06.02.13.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 13:32:57 -0700 (PDT)
Date:   Tue, 2 Jun 2020 16:32:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jason Wang <jasowang@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
Message-ID: <20200602162931-mutt-send-email-mst@kernel.org>
References: <20200602084257.134555-1-mst@redhat.com>
 <fc204429-7a6e-8214-a66f-bf2676018aae@redhat.com>
 <20200602163306.GM23230@ZenIV.linux.org.uk>
 <CAHk-=wjgg0bpD0qjYF=twJNXmRXYPjXqO1EFLL-mS8qUphe0AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjgg0bpD0qjYF=twJNXmRXYPjXqO1EFLL-mS8qUphe0AQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 10:18:09AM -0700, Linus Torvalds wrote:
> On Tue, Jun 2, 2020 at 9:33 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > >
> > > It's not clear whether we need a new API, I think __uaccess_being() has the
> > > assumption that the address has been validated by access_ok().
> >
> > __uaccess_begin() is a stopgap, not a public API.
> 
> Correct. It's just an x86 implementation detail.
> 
> > The problem is real, but "let's add a public API that would do user_access_begin()
> > with access_ok() already done" is no-go.
> 
> Yeah, it's completely pointless.
> 
> The solution to this is easy: remove the incorrect and useless early
> "access_ok()". Boom, done.

Hmm are you sure we can drop it? access_ok is done in the context
of the process. Access itself in the context of a kernel thread
that borrows the same mm. IIUC if the process can be 32 bit
while the kernel is 64 bit, access_ok in the context of the
kernel thread will not DTRT.


> Then use user_access_begin() and the appropriate unsage_get/put_user()
> sequence, and user_access_end().
> 
> The range test that user-access-begin does is not just part of the
> ABI, it's just required in general. We have almost thirty years of
> history of trying to avoid it, AND IT WAS ALL BOGUS.
> 
> The fact is, the range check is pretty damn cheap, and not doing the
> range check has always been a complete and utter disaster.
> 
> You have exactly two cases:
> 
>  (a) the access_ok() would be right above the code and can't be missed
> 
>  (b) not
> 
> and in (a) the solution is: remove the access_ok() and let
> user_access_begin() do the range check.
> 
> In (b), the solution is literally "DON'T DO THAT!"
> 
> Because EVERY SINGLE TIME people have eventually noticed (possibly
> after code movement) that "oops, we never did the access_ok at all,
> and now we can be fooled into kernel corruption and a security issue".
> 
> And even if that didn't happen, the worry was there.
> 
> End result: use user_access_begin() and stop trying to remove the two
> cycles or whatever of the limit checking cost. The "upside" of
> removing that limit check just isn't. It's a downside.
> 
>                  Linus

That's true. Limit check cost is measureable but very small.
It's the speculation barrier that's costly.

-- 
MST

