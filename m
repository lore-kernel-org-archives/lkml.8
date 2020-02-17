Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C522C34024
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B92F20801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIvzAmLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgBQQHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:07:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48107 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726420AbgBQQHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581955670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kbx9I3JxwrUQZkW+ffvblVzm+qjbx3whOPslU+AU5xI=;
        b=WIvzAmLzC8bZFgCKNVqpG1nYchkIwwuvZQMKHYEmyJ0NWgKc4p+AgdAiDp0FjRmYm8LCKX
        vH4kIUi+J4Tf+xZXNNHs3tz1+6xwSKY6sUOwX+rSr9dSHrUuEBBbSNz3KUNu3dIXbwSjcM
        lQH10KivcHs62QCPZnqOjP0F53ivb6c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-pL5prqWANX6AmsPpPcw9jw-1; Mon, 17 Feb 2020 11:07:42 -0500
X-MC-Unique: pL5prqWANX6AmsPpPcw9jw-1
Received: by mail-qv1-f71.google.com with SMTP id z9so10539649qvo.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 08:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kbx9I3JxwrUQZkW+ffvblVzm+qjbx3whOPslU+AU5xI=;
        b=dFUHzSS5P0Dxt/U7w9iwmKmnmbyAjDDrs1wnth6aon9P2X5ERQ0LPKzw2t+hblznGY
         AS0/KHF5GnvrMwMlgwHnhGwqE7bdvmDl5oRY/j9uuoRKOS2sQpu1sDznLO2rkFAkkbj4
         ZLN4HzZANOh5YC6W8sjyxIahooeWQPxg3qi8qHU/xD5N/FzrQLsyRDH0IYjOAJBhzJkx
         Qi5HkYnwefCKR6vPDO5SLWQpXHyzl8v0o645X+yvy/T7aJt6jkDhehNfBlywvtofdJar
         hyzP2zaiWHM6J7LbSzMlUSUX85Oe2wYKhkmNLEO499AxKrpUo1XzJP5mBbJjoOtVaHR2
         c3gg==
X-Gm-Message-State: APjAAAUIthw7M/ibRUIertfhrELg6Kj68a9tSwIMujbSZiy1Tj3rqsw0
        3MKWyxKwptFW0gCBzWQGeDrgXlYochDBt1rZPnGuU1Puy1SaYh1sMHq57O88uYDAxwBDCA5mgJA
        Wq7wpuqItjqTSu4mfk5ydJfOF
X-Received: by 2002:a05:620a:247:: with SMTP id q7mr14627040qkn.199.1581955661923;
        Mon, 17 Feb 2020 08:07:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqx2VRNMX8abWk3f0ggJhIMzMa5PLM2pRAIizOOJFe1xnKGfAwZMSeV2nnkRkbwQMMhdEA/y6A==
X-Received: by 2002:a05:620a:247:: with SMTP id q7mr14627018qkn.199.1581955661687;
        Mon, 17 Feb 2020 08:07:41 -0800 (PST)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id z6sm436668qka.34.2020.02.17.08.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 08:07:41 -0800 (PST)
Date:   Mon, 17 Feb 2020 11:07:39 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Sonny Rao <sonnyrao@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC PATCH] userfaultfd: Address race after fault.
Message-ID: <20200217160739.GB1309280@xz-x1>
References: <20200214225849.108108-1-bgeffon@google.com>
 <20200214231954.GA29849@redhat.com>
 <CADyq12w3tBO5NfZ33R__B3jvF=ed7ys+o4horGwyUO3bNevObg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADyq12w3tBO5NfZ33R__B3jvF=ed7ys+o4horGwyUO3bNevObg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2020 at 09:29:46AM -0500, Brian Geffon wrote:
> Hi Andrea,
> Thanks for the quick reply. That's great to hear that Peter has been
> working on those improvements. I didn't try the entire patchset but I
> did confirm that patch 13, not surprisingly, also resolves that issue
> on at least on x86:
>   https://lkml.org/lkml/2019/9/26/179
> 
> Given that seems pretty low risk and it definitely resolves a pretty
> big issue for the non-cooperative userfaultfd case, any chance it
> could be landed ahead of the rest of the series?

Thanks Andrea & Brian!  Yes it would be great if the series (or some
of the patches) could be moved forward.  Please just let me know if
there's still anything I can do from my side.

Thanks,

> 
> Thanks,
> Brian
> 
> On Fri, Feb 14, 2020 at 6:20 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
> >
> > Hello,
> >
> > this and other enhancements have already implemented by Peter (CC'ed)
> > and in the right way, by altering the retry logic in the page fault
> > code. This is a requirement for other kind of usages too, notably the
> > UFFD_WRITEPROTECT ioctl after which multiple consecutive faults can
> > happen and must be handled.
> >
> > IIRC Kirill asked at last LSF-MM uffd-wp talk if there's any
> > particular reason the fault couldn't be retried currently. I had no
> > sure answer other than there's apparently no strong reason why
> > VM_FAULT_RETRY is only allowed 1 time currently, so there should be no
> > issue in lifting that artificial restriction.
> >
> > I'm running with this patchset applied in my systems since Nov with no
> > regression at all. I got sidetracked by various other issues, so
> > unfortunately I didn' post a proper reviewed-by on the last submit yet
> > (pending), but I did at least test it and it was rock solid so far.
> >
> > https://lore.kernel.org/lkml/20190926093904.5090-1-peterx@redhat.com/
> >
> > Can you test and verify it too if it solves your use case?
> >
> > Also note the complete uffd-WP support submit also from Peter:
> >
> > https://lore.kernel.org/lkml/20190620022008.19172-1-peterx@redhat.com/
> >
> > https://github.com/xzpeter/linux/tree/uffd-wp-merged
> >
> > Thanks,
> > Andrea
> >
> 

-- 
Peter Xu

