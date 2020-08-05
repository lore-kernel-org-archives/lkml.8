Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C47FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208C922B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLdpXk/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgHEUMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:12:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56892 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgHEQZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596644702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RDiNTwaajX9EstP2+rkOoaOqP4Sp0ty/xDldPk1nRuY=;
        b=ZLdpXk/HNS+AUi3ROo21rtg5Qv/XEfMrWtwgHBP6n1uUNof4vHLTDb87x3rxT0koc07SI1
        KTy/QnlzYkehHheLsKET1MfkI4cCZ3DuAAVbypP255ovHcsjVT2UagoKVgj5mgELRtEPhL
        jo0xtTQdhi26UO7nuMhsfxoSWEsvsFk=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-8-SHZBO5PKyIvv0gCClUaA-1; Wed, 05 Aug 2020 11:54:43 -0400
X-MC-Unique: 8-SHZBO5PKyIvv0gCClUaA-1
Received: by mail-oi1-f199.google.com with SMTP id r62so24674299oif.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 08:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDiNTwaajX9EstP2+rkOoaOqP4Sp0ty/xDldPk1nRuY=;
        b=IthWmMS8xZQSDvwSqscmjk5bY4HJHr+GJonXaZ01m59jUARBBPpCT+zZaCaQbVRiiz
         TQVOggI5eBwZH0vyvC1M5yn2gxzCzKBedHfA9Ny6V01a4kt4N16JCluyUr3g0iIUDEpZ
         HBPai90yR7WMcUK6P2acZaxmCt09l0spEdicr7V7rlyTBzZXNpc4QYU4DMCkSAeNRncv
         VGCARDjcyTCzRxYJjivciC3ADCLzwfMTf3xPm9ONkg0PkmNCX8xeKUJ4iLa/nj31BHHe
         m6NkCCHYv7XBmdKlBW73qIj0q/jdKHuPf3IRYoa1dblK/vlYgLtEXqGa4fYvJh5FKFQO
         wo9w==
X-Gm-Message-State: AOAM530gmFnzVJ9Q3DN2PGLte/1WHF8ThkYeJ/5Nros5U82yYjwZ8Nep
        1JD8x7jaiKJ1Rlvmr1N9trNQ5AfMgjYf6quprJNcW/3xwpGgOebDZr3S7LwsQj2jZxXLZ+nEDZD
        cq4U6PfmYPzfodGDVujmt78AmXJIupWZ6sFmnan7E
X-Received: by 2002:a9d:3784:: with SMTP id x4mr3040060otb.95.1596642882737;
        Wed, 05 Aug 2020 08:54:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFNuf696slwlPSZJynKjLvYPlN0RCiKIOzOVmS4vUbpxiRMAJuurwOtGRZDzCz52Sm2DXwT3decGCiphYpc3o=
X-Received: by 2002:a9d:3784:: with SMTP id x4mr3040047otb.95.1596642882501;
 Wed, 05 Aug 2020 08:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200805153214.GA6090@magnolia>
In-Reply-To: <20200805153214.GA6090@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 5 Aug 2020 17:54:31 +0200
Message-ID: <CAHc6FU6yMnuKdVsAXkWgwr2ViMSXJdBXksrQDvHwaaw4p8u0rQ@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.9-rc1
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darrick,

On Wed, Aug 5, 2020 at 5:40 PM Darrick J. Wong <djwong@kernel.org> wrote:
> ----------------------------------------------------------------
> Andreas Gruenbacher (1):
>       iomap: Make sure iomap_end is called after iomap_begin

that commit (d1b4f507d71de) contains the following garbage in the
commit message:

    The message from this sender included one or more files
    which could not be scanned for virus detection; do not
    open these files unless you are certain of the sender's intent.

    ----------------------------------------------------------------------

How did it come to that?

Thanks,
Andreas

