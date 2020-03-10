Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B97C10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 01:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E6F24649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 01:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583802862;
	bh=u9kUqBJzwaMl1xWmNDrHnhfCq3UF0EHAoU/xNxKwn0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vs11BWVYJSZRSGaUv5YJclY+DUIDRFSnlrokKs1sPBRmkJexVimrCzd5FA9D1Sjs4
	 wb1e54jbWOVjJij87anobRqTkIN/EPSxk71iYm2gNnSHWTtXX40nZZouOvCyuBAJNl
	 TVYS6Y9SakwLD04mpwuX+xr8G//tgX0AsB/5wBdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgCJBOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 21:14:21 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35722 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgCJBOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 21:14:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id g4so3114725lfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 18:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCY2IMHfivjHreZOPal2MmhDh1XB1BJ/jVXGh7sofMY=;
        b=dttz1Aai8q2mA5120RQHpU6FQZ0oWB6GoxZWjBIoKe7rJ6/0ECieO/iRN6XUsDDmpY
         P8ZM/s3EiQ2yKP5NbwrdbruCnctvDp6KQ/31+Dn7/6XLJ6IfHlJYcxNGPxHn1UbBU0iV
         LA0J4YsQpHP85wdc4zfWiUV0qC/skOAfeo6iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCY2IMHfivjHreZOPal2MmhDh1XB1BJ/jVXGh7sofMY=;
        b=TOt0+IlF2m7l9nygWuRaB1cXVxKYSP6vawOl66kRQ9mlqEGXY1NWXIpeq0jTpXwx1S
         EdhVYe0eKhRA7CLmRJiOaudPoaYhlUa5ZBeRTWhZh5zGv9XjRaSzEB028ULBrPY0VPgn
         AzmmYX9BO56G4d5dwF2E049N25K/xZ2fVNZYa1nFCCviFwz8+rzog7NAE8Pi8DwehwHQ
         7GPdX5+y5aMz2Iy5539PZ5JiQn5wMBavo052rrSmQ7wRIoNxIThWfe1kpZL6UNt5UDT6
         nrfTvs3U/LQ4IlGn2CnVTT6s8bbg39IXQObRySmNnvw/5fdVgPjrZ+teFy4iQd2dmzSq
         R+sw==
X-Gm-Message-State: ANhLgQ08TfXXrFUS3e4XuIGySY9G9hgOw2PRvX/EXAIxVMYuWFuPIge1
        vf7qfJ8wl/vMtumB/PssDQTbH5+0HO8=
X-Google-Smtp-Source: ADFU+vsi+w3OFM00gCnd4jdQj/e4nrlvcv6aCxsMDyQSToh1Zyl4EnK5R/EYyOq5zIUAd4EFphhOhw==
X-Received: by 2002:a05:6512:3044:: with SMTP id b4mr11228050lfb.10.1583802858152;
        Mon, 09 Mar 2020 18:14:18 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id d9sm22650990lfm.16.2020.03.09.18.14.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 18:14:17 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id j11so9466660lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 18:14:16 -0700 (PDT)
X-Received: by 2002:a19:520a:: with SMTP id m10mr11117505lfb.30.1583802856199;
 Mon, 09 Mar 2020 18:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk> <20200310005549.adrn3yf4mbljc5f6@yavin>
In-Reply-To: <20200310005549.adrn3yf4mbljc5f6@yavin>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Mar 2020 18:14:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
Message-ID: <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Metzmacher <metze@samba.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 5:56 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2020-03-09, David Howells <dhowells@redhat.com> wrote:
> > This is necessary for fsinfo() to use RESOLVE_* flags instead of AT_* flags
> > if the latter are to be considered deprecated for new system calls.
> >
> > Also make openat2() handle RESOLVE_NO_TRAILING_SYMLINKS.

No, please let's not do this.

We have O_NOFOLLOW, and we can't get rid of it.

So adding RESOLVE_NO_TRAILING_SYMLINKS isn't a cleanup. It's just
extra complexity for absolutely zero gain.


> After thinking about what Christian said some more, I reckon we
> shouldn't support both O_NOFOLLOW and RESOLVE_NO_TRAILING_SYMLINKS. But
> that means we'll need to cherry-pick this patch and get it into mainline
> before v5.6.

No.

It simply means that we shouldn't have RESOLVE_NO_TRAILING_SYMLINKS at all.

Adding that flag is a mistake. It causes problems like this, where
subtlenly people say "what if both flags are set".

Just don't do it.

There's no way in hell we can ever get rid of O_NOFOLLOW anyway, since
people will continue to use plain open() and openat().

So adding RESOLVE_NO_TRAILING_SYMLINKS is entirely redundant.

Don't deprecate the old flags that are going to always stay around,
don't add stupid new flags that add no value.

It's that easy.

              Linus
