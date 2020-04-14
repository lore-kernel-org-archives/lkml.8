Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCC6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD892072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mea1kmjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392027AbgDNWeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387731AbgDNWeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:34:15 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FACBC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:34:15 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g74so15206275qke.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4PccVqG73oYIgQhV3w0lxzxSPUhCnt+/9GCS7XZiCHY=;
        b=mea1kmjo7TNJbX643hcdHOMQPqYeeALg4oXTOJEtamUQL97Nnqa9/Gizr3PPBU6KxL
         FvCg3rJDbt2DJJhzqyDH9+/Il5aRVeTA0pPZeaxUOWiPfe5kH4eSoTCe/SHgCfIvxjBg
         c2orGf2Fy5NaTQM65xmgT4Wb+oJXAq0n+LXlW3WizHK4oBn6mtK1gl0G4Kq3bmIdboEt
         ufu60oKRK38O4XCMW+LV2v1n4dXd7huW+GrMB8ctSTAe8bhwD/yOqKQtfQ2JFNFCZQjb
         joqpwDp69UXXoEZ5MisKGWSB835zacOY/xC3b/Fv0zzyOTSCXvNBGG/g9PvObggbxZCl
         T9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4PccVqG73oYIgQhV3w0lxzxSPUhCnt+/9GCS7XZiCHY=;
        b=At3xnhU1a6wum7O77VIygZF513S0XXin32bqQ0SQRxb7lOh+/KHjDaKJAvZZQ2MDG9
         KrGgqL+ppX6C3cB5XhsxJBJFMcyTv85Ns/NJabQvzaj0ob57XqekpAeNvjGZyAk3Clju
         XE9oVnN57fdSGczBSibQSIlZRjrGqBuIFg8VrmyUimRTD6OQruNpB8ewnQpl0cOEK9qd
         mTNkNt8a2V39cokDOg8Gm4+TPsLEzHmanuNxfYfvEFNnvFbjey2VmllShWNvWg2NWtd+
         9UkkmWzi6wbmARYWieQE2eYnwz0Vky4xmlCtM/TD9VfjnQRwvY3PcNGAF0PMeFDlRuG/
         F4pg==
X-Gm-Message-State: AGi0PuaZ2pIVdTcQ2wgSec9vaG52SXP9OfAHi51u6W01HO0CaYmLLXLD
        IszRFpdGyUqVKDE8VYfv7WWFtQ==
X-Google-Smtp-Source: APiQypIJn69ONnTFiLaOc5B6fgwS5Hxql8vlVconUDVUEYx87Powy2n0915w3dyyUYMyNIq9r7kVRg==
X-Received: by 2002:a05:620a:670:: with SMTP id a16mr22486428qkh.467.1586903654488;
        Tue, 14 Apr 2020 15:34:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h25sm4075963qto.87.2020.04.14.15.34.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 15:34:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOU8A-0005Jx-Oe; Tue, 14 Apr 2020 19:34:10 -0300
Date:   Tue, 14 Apr 2020 19:34:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     Brian Geffon <bgeffon@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sonny Rao <sonnyrao@google.com>
Subject: Re: Userfaultfd doesn't seem to break out of poll on fd close
Message-ID: <20200414223410.GM5100@ziepe.ca>
References: <CADyq12wPW69ovpW4akDY5PGBbrvnwsLO86=sSKTU4CB3dNwG3Q@mail.gmail.com>
 <20200414214516.GA182757@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414214516.GA182757@xz-x1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:45:16PM -0400, Peter Xu wrote:
> On Sun, Apr 12, 2020 at 01:10:40PM -0700, Brian Geffon wrote:
> > Hi,
> > It seems that userfaultfd isn't woken from a poll when the file
> > descriptor is closed. It seems that it should be from the code in
> > userfault_ctx_release, but it appears that's not actually called
> > immediately. I have a simple standalone example that shows this
> > behavior. It's straight forward: one thread creates a userfaultfd and
> > then closes it after a second thread has entered a poll syscall, some
> > abbreviated strace output is below showing this and the code can be
> > seen here: https://gist.github.com/bgaff/9a8fbbe8af79c0e18502430d416df77e
> > 
> > Given that it's probably very common to have a dedicated thread remain
> > blocked indefinitely in a poll(2) waiting for faults there must be a
> > way to break it out early when it's closed. Am I missing something?
> 
> Hi, Brian,
> 
> I might be wrong below, just to share my understanding...
> 
> IMHO a well-behaved userspace should not close() on a file descriptor
> if it's still in use within another thread.  In this case, the poll()
> thread is still using the userfaultfd handle

I also don't think concurrant close() on a file descriptor that is
under poll() is well defined, or should be relied upon.

> IIUC userfaultfd_release() is only called when the file descriptor
> destructs itself.  But shouldn't the poll() take a refcount of that
> file descriptor too before waiting?  Not sure userfaultfd_release() is
> the place to kick then, because if so, close() will only decrease the
> fd refcount from 2->1, and I'm not sure userfaultfd_release() will be
> triggered.

This is most probably true.

eventfd, epoll and pthread_join is the robust answer to these
problems.

Jason
