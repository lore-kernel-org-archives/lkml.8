Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12979C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE06C207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXwb/8Xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgHJPsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:48:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44898 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728054AbgHJPsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597074520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y+8H4sunugYTPEP17gYgZeRm0j2x6oBz82Cd5n7+MRU=;
        b=cXwb/8XfaXl1C8FzGwaq+6ld2MOAPgJwUt7ZGwf+vnAa+VoZ/64CU2G1zKngpEV0DatZUm
        DlBZMY1N76OYR8XHm7blA/9y/uasvGGV0X1TyUNYwjDj7diT/sIyFHe6ZVuV/dk4NdUMIg
        3Abe0XLghKsmZ50fhOpjD9B9dw3CjSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-oWSMvl2ROSekPVq1HXnlEA-1; Mon, 10 Aug 2020 11:48:38 -0400
X-MC-Unique: oWSMvl2ROSekPVq1HXnlEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86F08107ACCA;
        Mon, 10 Aug 2020 15:48:37 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.10.115.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C2CF19D7E;
        Mon, 10 Aug 2020 15:48:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9DDAD22036A; Mon, 10 Aug 2020 11:48:30 -0400 (EDT)
Date:   Mon, 10 Aug 2020 11:48:30 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 18/20] fuse: Release file in process context
Message-ID: <20200810154830.GC455528@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-19-vgoyal@redhat.com>
 <CAJfpegs1CtPMaVmbDc__N0Fc3FkNEe=vQOkrr8RKiiS6NqTyHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs1CtPMaVmbDc__N0Fc3FkNEe=vQOkrr8RKiiS6NqTyHA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:29:13AM +0200, Miklos Szeredi wrote:
> On Fri, Aug 7, 2020 at 9:55 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > fuse_file_put(sync) can be called with sync=true/false. If sync=true,
> > it waits for release request response and then calls iput() in the
> > caller's context. If sync=false, it does not wait for release request
> > response, frees the fuse_file struct immediately and req->end function
> > does the iput().
> >
> > iput() can be a problem with DAX if called in req->end context. If this
> > is last reference to inode (VFS has let go its reference already), then
> > iput() will clean DAX mappings as well and send REMOVEMAPPING requests
> > and wait for completion. (All the the worker thread context which is
> > processing fuse replies from daemon on the host).
> >
> > That means it blocks worker thread and it stops processing further
> > replies and system deadlocks.
> 
> Is this reasoning specific to DAX?  Seems to me this is a virtio-fs
> specific issue.

I would think it is virtio-fs + DAX issues. virtio-fs without DAX does
not have this problem.

If making this conditional on DAX an issue, I am wondering, can
we now set args->may_block instead. Now virtiofs will do completion
in a separate worker thread if ->may_block is set. That means, 
worker will block till REMOVEMAPPING completes and then be woken
up.

Do let me know if you like setting args->may_block approach better.
I can give that a try.

Vivek

