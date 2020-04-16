Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D5DC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13AE12078B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/bM1xr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391023AbgDPACx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:02:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53812 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729647AbgDPACn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586995357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ps9/dNn16oHNeGiINVoqPKfCACcgsF/ho6TjzNXBShg=;
        b=G/bM1xr1yfL6bZ9JnkEla3TxhBiD9ftqEWo/P+FXq8lw9o6EzXantSqo37DKejb5vPRyYx
        oyJEmdiNhQpT7qL8FbceIrpOUOaYKHfBM1cLynlRR2RiAECn7NohunoLmKixOP+ZxxYZQS
        fPpxU2HmlWbL+wvCXSA/Daae/sXn5Oc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-p986kzuxOE2rvxO8AY3uhw-1; Wed, 15 Apr 2020 20:02:35 -0400
X-MC-Unique: p986kzuxOE2rvxO8AY3uhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9271107ACC9;
        Thu, 16 Apr 2020 00:02:33 +0000 (UTC)
Received: from mail (ovpn-112-243.rdu2.redhat.com [10.10.112.243])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85E3E99E03;
        Thu, 16 Apr 2020 00:02:30 +0000 (UTC)
Date:   Wed, 15 Apr 2020 20:02:29 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hillf Danton <hdanton@sina.com>, Peter Xu <peterx@redhat.com>,
        Brian Geffon <bgeffon@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sonny Rao <sonnyrao@google.com>
Subject: Re: Userfaultfd doesn't seem to break out of poll on fd close
Message-ID: <20200416000229.GA9922@redhat.com>
References: <CADyq12wPW69ovpW4akDY5PGBbrvnwsLO86=sSKTU4CB3dNwG3Q@mail.gmail.com>
 <20200414214516.GA182757@xz-x1>
 <20200415031602.22348-1-hdanton@sina.com>
 <20200415142546.GO5100@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415142546.GO5100@ziepe.ca>
User-Agent: Mutt/1.13.5 (2020-03-28)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

On Wed, Apr 15, 2020 at 11:25:46AM -0300, Jason Gunthorpe wrote:
>           CPU1                            CPU2                  CPU3
>  fds[i]->fd = userfaultfd;
>  while()
>                                        close(userfaultfd)
>                                        pthread_join()
>                                                             someother_fd = open()
>                                                             userfaultfd == someother_fd
>      poll(fds)   // <- Still sleeps
> 
> The kernel should not be trying to wake poll from fd release, and
> userspace should not close a FD that is currently under poll.
> 
> Besides, it really does look like poll holds the fget while doing its
> work (see poll_freewait), so fops release() won't be called anyhow..

Agreed, poll does fdget (not userfaultfd_poll) so there's no way
->release will be called when the fd is closed in the other thread.

The simple way to fix this is to implement a ->flush operation
(userfaultfd_flush), perhaps something like this would work (untested):

static int userfaultfd_flush(struct file *file, fl_owner_t id)
{
	struct userfaultfd_ctx *ctx = file->private_data;
	wake_up_poll(&ctx->fd_wqh, EPOLLHUP);
}

If eventfd and pipes all behave identical to uffd (they should as they
don't seem to implement flush) I'm not sure if there's good enough
justification to deviate from the default VFS behavior here.

The file flush operation is usually meaningful when the fd represent
data stored remotely, like with nfs, for uffd close() has no special
semantics.

With threads, you can get the wakeup by other means as Peter
suggested. Then you can close the uffd in the parent after poll
returns.

Alternatively if you want to rely on uffd to send the poll wakeup you
could use UFFDIO_WAKE instead of closing the fd, and still close the fd
after poll returns.

Overall the more normal thing to do is to close the uffd after poll
returns, if you can't do that (or if it's less efficient doing that)
it'd be interesting to know why to better evaluate this. By just
looking the testcase there's no way to tell if you gain something
meaningful by closing the fd during poll..

Thanks,
Andrea

