Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288EAC35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A7A21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIa7gBFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgBYJHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:07:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26613 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729981AbgBYJHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582621660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J9KNb3WVdOxwxKr6MYNPKvXY1jE7XXYkemzIOMy9lrE=;
        b=VIa7gBFnxsSnb/Eu0UMEy2Af3z7mlZh9CmY4Wxqnhr3aXr2sB0Q+jPsFRCnoDefug/pI67
        fe9x23vNY/hUWGMsMO5IVzbDKIgoUo8cH8qG0Q6GSu5rv58+RQVtiQRSyoePjt3yzaLuEw
        1i81taOFj6qonr4r/Bt5GgwWqeexE+c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-DX25fxXLMJaioJKYoZ2xxw-1; Tue, 25 Feb 2020 04:07:37 -0500
X-MC-Unique: DX25fxXLMJaioJKYoZ2xxw-1
Received: by mail-wr1-f71.google.com with SMTP id u18so6957256wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 01:07:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J9KNb3WVdOxwxKr6MYNPKvXY1jE7XXYkemzIOMy9lrE=;
        b=dfVD9W60nE6lnrQ4bZUMQskhEdnJ4zGdtigB4vKjrRSbm2Ly+meCgKQ3ooFvPeEZ6v
         ulmj7AtNfqcwtkKLspSv38dW+MH5oZO2hc6PFaPMcw4MrF6lswP4lr/Zh/UNME4PEnSn
         Meo8cffUsC+cwI6fP5s11CoMC3KtGKqTvU7b9Jj5GoZRIwyCyfUrzIpDhf7M/LD3KpPh
         qFhyQrnqregWXYGI7HOgCdrt+F6I3U5F34W3EGI+07nGwi3VuKFlflSoMmiHesaaDXMs
         gP4sGKSCqkfbNVnh/H8Y3/2aDKsZcUV4j5VmxvwWR5SPoVjeYwSNpKNCrsQ7lqVIeaag
         3gFQ==
X-Gm-Message-State: APjAAAXrD9sAEpQ/Hs+2M94CDDiQd918Iw8kqAY78Q0hODoIN5quu/j6
        xGO2UKKMPz31memR0a8Pf8A7vlL+SB/iiaVKPEplgF0nGdUA8DY1HCkd1Mac/M/H+sNBXtjpKZr
        fbRIUAdsR2Ms7iGYbJr/TVFs0
X-Received: by 2002:a5d:504e:: with SMTP id h14mr13354437wrt.82.1582621655917;
        Tue, 25 Feb 2020 01:07:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvXTw1dY0/iQ7fl5rVkhMh/4ortONYEYN8tZpl8lKh5OB5cJe57Upw2uu6Y8P8dd7G6t5LXg==
X-Received: by 2002:a5d:504e:: with SMTP id h14mr13354415wrt.82.1582621655699;
        Tue, 25 Feb 2020 01:07:35 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it. [79.27.4.209])
        by smtp.gmail.com with ESMTPSA id s1sm22666564wro.66.2020.02.25.01.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 01:07:35 -0800 (PST)
Date:   Tue, 25 Feb 2020 10:07:32 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        syzbot <syzbot+731710996d79d0d58fbc@syzkaller.appspotmail.com>,
        davem@davemloft.net, kuba@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Subject: Re: INFO: task hung in lock_sock_nested (2)
Message-ID: <20200225090732.kge6bdf46ji6mbb5@steredhat>
References: <0000000000004241ff059f2eb8a4@google.com>
 <20200223075025.9068-1-hdanton@sina.com>
 <20200224134428.12256-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224134428.12256-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 09:44:28PM +0800, Hillf Danton wrote:
> 
> On Mon, 24 Feb 2020 11:08:53 +0100 Stefano Garzarella wrote:
> > On Sun, Feb 23, 2020 at 03:50:25PM +0800, Hillf Danton wrote:
> > > 
> > > Seems like vsock needs a word to track lock owner in an attempt to
> > > avoid trying to lock sock while the current is the lock owner.
> > 
> > Thanks for this possible solution.
> > What about using sock_owned_by_user()?
> > 
> No chance for vsock_locked() if it works.
> 
> > We should fix also hyperv_transport, because it could suffer from the same
> > problem.
> > 
> You're right. My diff is at most for introducing vsk's lock owner.

Sure, thanks for this!

> 
> > At this point, it might be better to call vsk->transport->release(vsk)
> > always with the lock taken and remove it in the transports as in the
> > following patch.
> > 
> > What do you think?
> > 
> Yes and ... please take a look at the output of grep
> 
> 	grep -n lock_sock linux/net/vmw_vsock/af_vsock.c
> 
> as it drove me mad.

:-) I'll go in this direction and I'll check all the cases.

We should avoid to take lock_sock in the transports when it is possible.

Thanks for the help,
Stefano

