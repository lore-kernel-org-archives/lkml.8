Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AE0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C3C20792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFZyF6cd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgHEWbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:31:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33029 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726005AbgHEWbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 18:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596666668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ta8W4lWYHuibGb7VenSY+ZFBUsjZkLeP1z3XiFNvHH0=;
        b=BFZyF6cdedbYLC/e8ATDFwN4J3w1yOnHGyjWgTyy4MAfS1pYDRb0BrvLbhgUHna7hSdXMk
        mGKDiL5Y88njsZuOmTkO8o9LEbvPJ1+jULrKEVlrL4n24lZ/Fx/8CewHeNNKsyh4I8M/kk
        kVdNZ7keawujCxyQOo4K2OXIZujgxtA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-pkwOLtYMPPmhFg_uehD0fQ-1; Wed, 05 Aug 2020 18:31:06 -0400
X-MC-Unique: pkwOLtYMPPmhFg_uehD0fQ-1
Received: by mail-wm1-f69.google.com with SMTP id h6so2942858wml.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 15:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ta8W4lWYHuibGb7VenSY+ZFBUsjZkLeP1z3XiFNvHH0=;
        b=Kd0S+3cSUm8lwRqvhjI3N57BQylQbk1WWTA24qppsAFiKk2oqlN1XKmDlMQn4RHIDK
         EpDgONXml9V/g2dAfZwFp5I7xymjFDQkog3gguM+qU56gQMm0MLShhK004txUE+QenkB
         04cBFbj8UMduq9Nf/PFZwc88wmWBtvKtaGIY7veA8K9Mi+N87NIUn+kiGooaYLmV+vfH
         O7Zo4C/90a1elhEkIhHOPXB98UbTll+gGPv2Xeiyb/LUevEqN6C4JiVDUGLulTCKPLwQ
         27+sx9KNk1ARDxcDKpROvpzpLJ8hZT1PZr/3tQUAN9hB7RlpSqVihYr/AvqV4+abJXcI
         Dgjg==
X-Gm-Message-State: AOAM532OBRqRCARto/sJ9cpKoF8S4utA1NYhoZvqsz+ZumCCCzgyaVjt
        AZV37wt5o46phkkCV4wlPmfwfRtQdFtCELwIJeOcbf7kDKQ8zPgpI1Uy5SvtFVu7K49J+A65rlM
        ypOaG6h8liqCyEtHVxJmhsPBT
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr4895345wrs.132.1596666665632;
        Wed, 05 Aug 2020 15:31:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweYLLE6b8uo1XP/9+STMEkV5LbdOvdlrtunNKnBmO4rNYW4xagyblCQIRFcf+KM51Wo/Qexw==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr4895324wrs.132.1596666665385;
        Wed, 05 Aug 2020 15:31:05 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id 62sm4379354wrq.31.2020.08.05.15.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 15:31:04 -0700 (PDT)
Date:   Wed, 5 Aug 2020 18:31:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Saeed Mahameed <saeedm@mellanox.com>, Eli Cohen <eli@mellanox.com>,
        Shahaf Shuler <shahafs@mellanox.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200805183017-mutt-send-email-mst@kernel.org>
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200805075856-mutt-send-email-mst@kernel.org>
 <20200805124054.GA125576@mtl-vdi-166.wap.labs.mlnx>
 <20200805084604-mutt-send-email-mst@kernel.org>
 <20200805130158.GA126406@mtl-vdi-166.wap.labs.mlnx>
 <20200805090304-mutt-send-email-mst@kernel.org>
 <063f66418da235ee459b367c5049948ee6db59ce.camel@mellanox.com>
 <20200805194646.GJ19097@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805194646.GJ19097@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 04:46:46PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 05, 2020 at 07:01:52PM +0000, Saeed Mahameed wrote:
> > On Wed, 2020-08-05 at 09:12 -0400, Michael S. Tsirkin wrote:
> > > On Wed, Aug 05, 2020 at 04:01:58PM +0300, Eli Cohen wrote:
> > > > On Wed, Aug 05, 2020 at 08:48:52AM -0400, Michael S. Tsirkin wrote:
> > > > > > Did you merge this?:
> > > > > > git pull
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.gi
> > > > > > t mlx5-next
> > > > > 
> > > > > I can only merge this tree if no one else will. Linus does not
> > > > > like getting same patches through two trees.
> 
> This is not quite the case
> 
> Linus does not like multiple *copies* of the same patches. The same
> actual git commits can be OK.
> 
> Linus also does not like unnecessarily cross linking trees, mlx5-next
> is designed to be small enough and approved enough that it is not
> controversial.
> 
> Linus really doesn't like it when people jams stuff together in rc7 or
> the weeks of the merge window. He wants to see stuff be in linux-next
> for at least a bit. So it may be too late regardless.

I'll try, let's see what happens.

> > We do this all the time with net-next and rdma,
> > mlx5-next is a very small branch based on a very early rc that includes
> > mlx5 shared stuff between rdma and net-next, and now virtio as well.
> 
> Yes, going on two years now? Been working well
> 
> Jason

OK, I'll merge it then. Thanks!

-- 
MST

