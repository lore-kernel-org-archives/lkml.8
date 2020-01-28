Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2734BC33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A1824681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQuxh3Nb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgA1BgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 20:36:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38897 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgA1BgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:36:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id p23so4146637edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 17:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Crjx+5QQrEucO7G7mPXgmMnWuJ0oteWXeZ4JlN/M8ds=;
        b=YQuxh3NbOiJ+dKXmeUU1Z/8VEVIPsnSsHTDZJAjufPbsfkmO0zDnRXF0ifSfj9He4G
         jBGiR66Cn37+5/XyWFlEtwhWQDTmnC4F7/YbLmJ8/6RaOlWn4iVsO+3IGlW4ZjsWaVql
         1bUyIxB9ZZKoeB2XnEvqaPfd+D+9rzYMmoRiSGgeOMOZmaMeeJ8u1Ul970EWbwVXML18
         oHUn3+ruk3TNRCHRpiGQvn8ggab7wE9mDH4/w72NTGDeegdT3NreH9sZnbF2+M2q1z7V
         zbN7raOB40jkg3tQVnU+4gLmL/TFdoKI4i0u3GxgZGWAZbtI0c7K8tEgfRS3FPUB658W
         qgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Crjx+5QQrEucO7G7mPXgmMnWuJ0oteWXeZ4JlN/M8ds=;
        b=a5gdVmqaTcqrfYG2Wf/05neJ1owUzFHrz44TndpeDORM5+xubankqLBvQ1CW7dYWNg
         d6IoyhNmJmDWxvqYHXWBHsWI3ZW8teXpH1Y+xwU32qT7COE7HP4Q3h4HVrygH28sc2G6
         XGWqYERqx7nvxm6i7AbWEmShBSwL8W+XnCZNhqUgu/Y7iqhZu4mCbysBlEYJ5RhwZRCd
         at9V1ulzCifoTb+5dnlCXechu1fGHRR4MbPPhZTYI/8lH5smvQbeCqYdsElA9lBzoVbs
         lKx2tpWafLTImKUofxSt1R08BjCohyavCc8FSbpR2ZHeH7dXtYkQ81Di5SqRIxh/2dqY
         LrDw==
X-Gm-Message-State: APjAAAUn5/S6BD5uPEkP+rVhT88dxtQ2Wg22ndF1F4VpXVVU0W5lG/XX
        N4uq4mQVkNgODYx9UIPs1W15N/n39A3qsrfXasUV+Q==
X-Google-Smtp-Source: APXvYqyV4VLuvnfJLGmY7TZvmrf57n5fPdUEkoVlX8bSQLT0/E1hgAPOBzOsZPbWzr2GZLSCZkLSu+O7SBtsHf0flr8=
X-Received: by 2002:a17:906:4e01:: with SMTP id z1mr1206542eju.46.1580175366815;
 Mon, 27 Jan 2020 17:36:06 -0800 (PST)
MIME-Version: 1.0
References: <20200123014627.71720-1-bgeffon@google.com> <20200124190625.257659-1-bgeffon@google.com>
 <20200126220650.i4lwljpvohpgvsi2@box>
In-Reply-To: <20200126220650.i4lwljpvohpgvsi2@box>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 27 Jan 2020 17:35:40 -0800
Message-ID: <CADyq12xCK_3MhGi88Am5P6DVZvrW8vqtyJMHO0zjNhvhYegm1w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,
Thanks for taking the time to look at this. I'll update the wording to
make it clear that MREMAP_FIXED is required with MREMAP_DONTUNMAP.

Regarding rmap, you're completely right I'm going to roll a new patch
which will call unlink_anon_vmas() to make sure the rmap is correct,
I'll also explicitly check that the vma is anonymous and not shared
returning EINVAL if not, how does that sound?

Brian

On Sun, Jan 26, 2020 at 2:06 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Fri, Jan 24, 2020 at 11:06:25AM -0800, Brian Geffon wrote:
> > When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> > set, the source mapping will not be removed. Instead it will be
> > cleared as if a brand new anonymous, private mapping had been created
> > atomically as part of the mremap() call.  If a userfaultfd was watching
> > the source, it will continue to watch the new mapping.  For a mapping
> > that is shared or not anonymous, MREMAP_DONTUNMAP will cause the
> > mremap() call to fail. MREMAP_DONTUNMAP implies that MREMAP_FIXED is
> > also used.
>
> Implies? From code it looks like it requires MREMAP_FIXED. And
> MREMAP_FIXED requires MREMAP_MAYMOVE. That's strange flag chaining.
> I don't really see need in such dependencies. It maybe indeed implied, not
> requied.
>
> > The final result is two equally sized VMAs where the
> > destination contains the PTEs of the source.
>
> Could you clarify rmap situation here? How the rmap hierarchy will look
> like before and after the operation. Can the new VMA merge with the old
> one? Sounds fishy to me.
>
> > We hope to use this in Chrome OS where with userfaultfd we could write
> > an anonymous mapping to disk without having to STOP the process or worry
> > about VMA permission changes.
> >
> > This feature also has a use case in Android, Lokesh Gidra has said
> > that "As part of using userfaultfd for GC, We'll have to move the physical
> > pages of the java heap to a separate location. For this purpose mremap
> > will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
> > heap, its virtual mapping will be removed as well. Therefore, we'll
> > require performing mmap immediately after. This is not only time consuming
> > but also opens a time window where a native thread may call mmap and
> > reserve the java heap's address range for its own usage. This flag
> > solves the problem."
>
> --
>  Kirill A. Shutemov
