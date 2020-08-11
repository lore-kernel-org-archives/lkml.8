Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCD2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFF420774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/zgFWVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgHKRoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:44:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48714 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728554AbgHKRop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597167884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ttmjy05YtDY5fs+rLP1raSH+zo+BvNvZy0wKOqfr0Vs=;
        b=D/zgFWVi4xC5wJ8HK80Wd4X4KElPsV8oV0b+PYmvyN/QXYVg/oib9UlONiKJ/M3F3f25pF
        8dUZsiCpsnplay3tpkPrnmpdAjlgGzsUCfC0ezEhHd9E3BdjxNMog4J9bahQKoOT/Rzl6A
        ixUOoeY6Lq00o2v/AtdyAHzDAAnQ/ZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-bJdVG4_rPeKuZKndxfh5DQ-1; Tue, 11 Aug 2020 13:44:39 -0400
X-MC-Unique: bJdVG4_rPeKuZKndxfh5DQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 184F2100CCC1;
        Tue, 11 Aug 2020 17:44:37 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-120.rdu2.redhat.com [10.10.117.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1E6D61982;
        Tue, 11 Aug 2020 17:44:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6A84222036A; Tue, 11 Aug 2020 13:44:29 -0400 (EDT)
Date:   Tue, 11 Aug 2020 13:44:29 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Subject: Re: [PATCH v2 13/20] fuse, dax: Implement dax read/write operations
Message-ID: <20200811174429.GA497326@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-14-vgoyal@redhat.com>
 <20200810220655.GC2079@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810220655.GC2079@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 08:06:55AM +1000, Dave Chinner wrote:
> On Fri, Aug 07, 2020 at 03:55:19PM -0400, Vivek Goyal wrote:
> > This patch implements basic DAX support. mmap() is not implemented
> > yet and will come in later patches. This patch looks into implemeting
> > read/write.
> 
> ....
> 
> > +static int iomap_begin_setup_new_mapping(struct inode *inode, loff_t pos,
> > +					 loff_t length, unsigned flags,
> > +					 struct iomap *iomap)
> 
> please doin't use the iomap_* namespace even for static functions in
> filesystem code. This really doesn't have anything to do with iomap
> except that whatever fuse sets up is used to fill an iomap.
> i.e. fuse_setup_new_dax_mapping() would be far more appropriate
> name.
> 
> > +static int iomap_begin_upgrade_mapping(struct inode *inode, loff_t pos,
> > +					 loff_t length, unsigned flags,
> > +					 struct iomap *iomap)
> 
> ditto: fuse_upgrade_dax_mapping().
> 

Hi Dave,

Will rename these functions as you suggested.

Vivek

