Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D906C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62201217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bs9Lz2p+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbgBFWRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:17:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45746 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727517AbgBFWRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581027447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dliw2RAM/nP3vDLbquqsu5FLbVnJwrHBsnpHt8MF4Y8=;
        b=Bs9Lz2p+ZXJ0cJFtnPu/BAAhMbvh+j1yvWg144fj50x5xlkBdyoBEr2x8q1HVxOJK2QHhl
        29l4blarwSvcj4vjMulxcihFrrX0oAMlPtF40SASaP5nrL9Ejfry5jZl0q0rQqEJfXqhla
        jc8TW2xr73wHMEjOjScOc/uan276LJQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-WhUwf0KeOQSw9M7616LKgg-1; Thu, 06 Feb 2020 17:17:25 -0500
X-MC-Unique: WhUwf0KeOQSw9M7616LKgg-1
Received: by mail-qv1-f72.google.com with SMTP id n11so4647087qvp.15
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 14:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dliw2RAM/nP3vDLbquqsu5FLbVnJwrHBsnpHt8MF4Y8=;
        b=WFwWlW+ITs1LtmOe35fWvH06efbFJbTA3MVQMB3fuJKioNZPpBKX7Z6ecWXyViJbbG
         6cMq1dSyk2pOuos3JA4ek485XOz/x4nlNbpfiMmHk45cW1McdcyXGQF/xQsCvSalpUyx
         OMz+wbSq/nMd9u482wj46vYHmcOFcmnE7jql3YwfNrE8etCQ2JYRpD2Qy7d8i0MhIa1q
         0fjbSEdmNUkYItkKTLa5LeofhdsBYw5UPhV7p8ok8SXFxxh/W5E1luldd5ME+NjgtjjR
         I7T6ROMZX42IvpysySWx1vSPXUj1yrmKxdnQb/qx6KP/5vFOxMyneevYmpEboEs2WksC
         PXJA==
X-Gm-Message-State: APjAAAWH85PMh0n60GItxAJhp0aduCkEiDJb3lVukOE+ARyE7jcZ8NgF
        lBXDkQp69B5V4NXhIsdr0g7ebALrJvB6XC2IBArWR8YMC3o5foFUV+Ae2G9m+eAkx3rSw9HJ603
        SxXiyNwCmNdAkGoBk2XiuTcx6
X-Received: by 2002:ad4:4c42:: with SMTP id cs2mr4304145qvb.198.1581027445014;
        Thu, 06 Feb 2020 14:17:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqx4aT6nHPT/UCOxB/dIpvh77YFb+ccbCujxO7QlHqlvH0kWVJQHP+Kls/zNpxqC5KRYicsxvQ==
X-Received: by 2002:ad4:4c42:: with SMTP id cs2mr4304120qvb.198.1581027444763;
        Thu, 06 Feb 2020 14:17:24 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id s22sm362089qke.19.2020.02.06.14.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 14:17:23 -0800 (PST)
Date:   Thu, 6 Feb 2020 17:17:19 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     eperezma@redhat.com,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: vhost changes (batched) in linux-next after 12/13 trigger random
 crashes in KVM guests after reboot
Message-ID: <20200206171349-mutt-send-email-mst@kernel.org>
References: <20200106054041-mutt-send-email-mst@kernel.org>
 <08ae8d28-3d8c-04e8-bdeb-0117d06c6dc7@de.ibm.com>
 <20200107042401-mutt-send-email-mst@kernel.org>
 <c6795e53-d12c-0709-c2e9-e35d9af1f693@de.ibm.com>
 <20200107065434-mutt-send-email-mst@kernel.org>
 <fe6e7e90-3004-eb7a-9ed8-b53a7667959f@de.ibm.com>
 <20200120012724-mutt-send-email-mst@kernel.org>
 <2a63b15f-8cf5-5868-550c-42e2cfd92c60@de.ibm.com>
 <b6e32f58e5d85ac5cc3141e9155fb140ae5cd580.camel@redhat.com>
 <1ade56b5-083f-bb6f-d3e0-3ddcf78f4d26@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ade56b5-083f-bb6f-d3e0-3ddcf78f4d26@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 04:12:21PM +0100, Christian Borntraeger wrote:
> 
> 
> On 06.02.20 15:22, eperezma@redhat.com wrote:
> > Hi Christian.
> > 
> > Could you try this patch on top of ("38ced0208491 vhost: use batched version by default")?
> > 
> > It will not solve your first random crash but it should help with the lost of network connectivity.
> > 
> > Please let me know how does it goes.
> 
> 
> 38ced0208491 + this seem to be ok.
> 
> Not sure if you can make out anything of this (and the previous git bisect log)

Yes it does - that this is just bad split-up of patches, and there's
still a real bug that caused worse crashes :)

So I just pushed batch-v4.
I expect that will fail, and bisect to give us
    vhost: batching fetches
Can you try that please?


