Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53639C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1E722B40
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsOk0BX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgHCUfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:35:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45056 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727005AbgHCUfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596486900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w4BJWn0OFbloyNEKW+pvD9R5ezJo0Picl13T+Bha9IM=;
        b=KsOk0BX40WQnG0Ag7VtYGWBIWuCecJFJl2GNBa06faA/v42v6b2VjOp4cHBqADbi5/shy6
        Tty2OmIc+UhVj9N6nWLvpxKQCDeN8VE8MiZK/FRwElKj6PGNI3FpQZpqrRSPf+jCdrXISI
        htjgpHzMx9FkEtmAj7P5PRh23WjK7EE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-KCesHCHGNTmRXY0dt1iUPQ-1; Mon, 03 Aug 2020 16:34:57 -0400
X-MC-Unique: KCesHCHGNTmRXY0dt1iUPQ-1
Received: by mail-qt1-f200.google.com with SMTP id q7so23906484qtd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w4BJWn0OFbloyNEKW+pvD9R5ezJo0Picl13T+Bha9IM=;
        b=pSqC3gQnkSVDL2O1xalmO35EKt70cr1hYJmhmlf9M/BvuISqo6a/l1O6LcvBZUJSv/
         2l77buzYKoHRKGGBviKiybVLlLJ3PKQYXliFlsusr+TPfCQiNSy2WmKVGL/GHOqJ2KDM
         EhPO5aw9HDMP52wH7Jyv9ElEWN7dF9hPjwo9Oa6jvL2lwoyAEuwPrwOQgeyKiv3pDHmR
         qSUmQIBh3J8qSbVGxASe+XtJW+xrr4w5XqsKu/MpNsEmfS5MAlJTYj039i8gCkBcoWZg
         GIPtosmDgn5Et9Tk/rfK5C6D/ldgbPI0m7XWfYWQ6/Loj9cjJzttft4KIxay06LLRyeG
         bMcw==
X-Gm-Message-State: AOAM533ZEdU5+6rVPxjiLOFjG61JFzcdtHXjgVy0j1rbb68RVeTrCtWy
        UsC2XSipVz1gRWDeKQpr7Q5VIUiId+TwDmbKPUUt5N7el7PEA8P2muINqd2mQdnTPs+2cFiA50c
        gx8GDYd2yL7ZPjscemCpUzXL8
X-Received: by 2002:a0c:9b85:: with SMTP id o5mr18907114qve.11.1596486897282;
        Mon, 03 Aug 2020 13:34:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvGy1muSaAsUQEYp2jWmeN6mFZFo5SHwfathQRXjTM8ZraPWxB2MOxfd/RWjT4CwEPQBY29w==
X-Received: by 2002:a0c:9b85:: with SMTP id o5mr18907092qve.11.1596486897049;
        Mon, 03 Aug 2020 13:34:57 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id j16sm20957593qke.87.2020.08.03.13.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:34:55 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:34:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <eli@mellanox.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V3 vhost next 00/10] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200803163235-mutt-send-email-mst@kernel.org>
References: <20200728060539.4163-1-eli@mellanox.com>
 <1dbac14a-5909-ff0a-8e90-534847f93d50@redhat.com>
 <20200728063211.GA229972@mtl-vdi-166.wap.labs.mlnx>
 <ef857921-4b9a-8e48-d5cd-5ef585e8f15c@redhat.com>
 <83eb3fdc-83d5-7f88-bef4-602e60c19662@redhat.com>
 <20200729055452.GA31247@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200729055452.GA31247@mtl-vdi-166.wap.labs.mlnx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 08:54:52AM +0300, Eli Cohen wrote:
> On Tue, Jul 28, 2020 at 02:53:34PM +0800, Jason Wang wrote:
> > 
> > Just notice Michael's vhost branch can not compile due to this commit:
> > 
> > commit fee8fe6bd8ccacd27e963b71b4f943be3721779e
> > Author: Michael S. Tsirkin <mst@redhat.com>
> > Date:   Mon Jul 27 10:51:55 2020 -0400
> > 
> >     vdpa: make sure set_features in invoked for legacy
> > 
> > Let's wait for Michael to clarify the correct branch to use then.
> >
> 
> Michael, are you going to send a path to a git tree that I can rebase my
> series on top of it, or maybe you can just take my v3 and apply them on
> the right tree? If you do, you can take Jason's patches from the series
> he posted here https://lkml.org/lkml/2020/7/1/301 and take my 0003-0010
> patches.
> 
> Let me know.

It's a bit too hard to figure out how to put these pieces together, when
I tried I run into some conflicts, and given I can't test them I'd
rather you did this.  Please also note kbuild test bot reported a build
failure on mips.

A good tree to base your work on is the linux-next branch
in https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git

Thanks!
-- 
MST

