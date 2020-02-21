Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA42C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232A620656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zfvhd7U/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgBUOnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:43:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32639 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728068AbgBUOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582296191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frQbF+c16vD65ZiZEf+lKyTvER21AAYID9Vfs1Sqi8c=;
        b=Zfvhd7U/yi6/UCmiCeeApRwuRGmOBGMLe0rXD3v6dhjjXcIMb7ThfWbrOqKYZdGq0W8H85
        RaYNwBub9aE+vyT0TeemuVtBIJ3p81GqtERDcnGjMKSOSErn61W90GV+0UwmQifoAWG/TF
        Ry3R9v7poHGAGbTUveRkuPtM05yScmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-rhZzXX99NbuzYxjCOs-KIg-1; Fri, 21 Feb 2020 09:43:09 -0500
X-MC-Unique: rhZzXX99NbuzYxjCOs-KIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8941718C35A0;
        Fri, 21 Feb 2020 14:43:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1CAF87B11;
        Fri, 21 Feb 2020 14:43:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200219170421.GD9496@magnolia>
References: <20200219170421.GD9496@magnolia> <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk> <158204563445.3299825.13575924510060131783.stgit@warthog.procyon.org.uk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/19] ext4: Add example fsinfo information [ver #16]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1899515.1582296185.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 21 Feb 2020 14:43:05 +0000
Message-ID: <1899516.1582296185@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick J. Wong <darrick.wong@oracle.com> wrote:

> > +	memcpy(ctx->buffer, es->s_volume_name, sizeof(es->s_volume_name));
> =

> Shouldn't this be checking that ctx->buffer is large enough to hold
> s_volume_name?

Well, the buffer is guaranteed to be 4KiB in size.

> > +	return strlen(ctx->buffer);
> =

> s_volume_name is /not/ a null-terminated string if the label is 16
> characters long.

And the buffer is precleared, so it's automatically NULL terminated.

> > +#define FSINFO_ATTR_EXT4_TIMESTAMPS	0x400	/* Ext4 superblock timestam=
ps */
> =

> I guess each filesystem gets ... 256 different attrs, and the third
> nibble determines the namespace?

No.  Think of it as allocating namespace in 256-number blocks.  That means
there are 16 million of them.  If a filesystem uses up an entire block, it=
 can
always allocate another one.  I don't think it likely that we'll get
sufficient filesystems to eat them all.

David

