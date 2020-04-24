Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D524C55196
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F4F214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587759055;
	bh=AE2Q0b5UUB0QXYXSOS641Q6jKRpDgXg0kY25aAD2ZNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fjVDA1yFEK6aVE3hrXZrMz9WUJSx3QRf06//v9Nx7J/A0Xdhky94PxdoOZEIy9hGB
	 J9/sb1fAmld+W7mH+MHwkMUR46KOWr16fa3TUMhIBNwIMtsl8OGMaZh6mYXQDV5JCn
	 LC2kCkFB/gio5OIQPJPIi2uwmCwre/oD/XG2CGc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgDXUKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXUKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:10:53 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60261C09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:10:53 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x23so8772329lfq.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=us5X4azLjqT5LS7IyRZRPdJayxqObn6u8xzpAkfnwDc=;
        b=A5AthDZQNsd/qaWi9a+AaUpSV7lp1t+8zpiQR1H5sACnEyGZGyTH4e/qwyOvh++pW4
         S9TJ5QXcQSjexXy9a96AUfqiizRvDtAlGo9lHDJmjNJU1k5LKp8JrCBXulrQvfXSPm1Y
         yh+HTwV/c1L69ePMr7sr9Q8ydvhDLtCVvfRWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=us5X4azLjqT5LS7IyRZRPdJayxqObn6u8xzpAkfnwDc=;
        b=kugOc/Fn46Uk1E5cL56FtKpsLm0pUrc0yStkirLxZhDrd4oqC7e4dZwPltLJNNAkg3
         xGGgXd3N7fccw0m+9VNvDmmunptSXQoWGZhLPgV4ptTFHrnZk5FsRBszGcKatEdxp1V9
         QCa6KgD4IK987DRK0D0QQ2P7BE1Y1DmocdDyzvCvtmMNLSz1/9T9gSZfCGMDLqrcQNct
         pArsAndGK8HuplFDoqXbwfFv2QlqxS+4L+wqQnUZxRCYTG4FUFQH4AK4mfRMy/x1OWGk
         aQqhVH1KxNvitfKa0lgi00sfi3D0DX2djIOzQN5XSvR6Jc9YNvyqUdqxd/WZG1cDLOBa
         vNiQ==
X-Gm-Message-State: AGi0PuYjgTQR15i6cIdWdKiN6i5MY2JF5EeWKhI6rnsqWkePM9o0X3gp
        FNyr0y7JkQcCciv49lTTYv24BlGSk5c=
X-Google-Smtp-Source: APiQypJ1UZfChz+Qw4Ayv6IRwjhuKNlGsmOoOtau3qvXqAinhFvfNBZQLO7gpo/AZOd+EWvAUl9+ew==
X-Received: by 2002:a05:6512:1c5:: with SMTP id f5mr7304731lfp.138.1587759051179;
        Fri, 24 Apr 2020 13:10:51 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id j19sm5460530lfe.17.2020.04.24.13.10.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 13:10:49 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id u6so11263750ljl.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:10:49 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr5169817ljj.265.1587759049344;
 Fri, 24 Apr 2020 13:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wgXEJdkgGzZQzBDGk7ijjVdAVXe=G-mkFSVng_Hpwd4tQ@mail.gmail.com>
 <87tv19tv65.fsf@x220.int.ebiederm.org> <CAHk-=wj-K3fqdMr-r8WgS8RKPuZOuFbPXCEUe9APrdShn99xsA@mail.gmail.com>
 <87mu70psqq.fsf@x220.int.ebiederm.org>
In-Reply-To: <87mu70psqq.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Apr 2020 13:10:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgE3JpLqKdwEzce6PyfqT3DVKccuK0H7ixY28CwOUNdmg@mail.gmail.com>
Message-ID: <CAHk-=wgE3JpLqKdwEzce6PyfqT3DVKccuK0H7ixY28CwOUNdmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] proc: Ensure we see the exit of each process tid exactly
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 12:54 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> The problem with
>
> remove
> remove
> add
> add
> is:
>
> A lookup that hit between the remove and the add could return nothing.

Argh. Because that thing doesn't actually _search_ the list, it just
wants to pick any (first) entry. So it doesn't actually care what it
gets, just that it gets something.

Ok, I see.

> For PIDTYPE_PID and PIDTYPE_TGID these practically aren't lists but
> pointers to the appropriate task.  Only for PIDTYPE_PGID and PIDTYPE_SID
> do these become lists in practice.

Yeah, that's what confused me. Ok, please add a comment about the
"single-entry list" issue, and I'm happy.

            Linus
