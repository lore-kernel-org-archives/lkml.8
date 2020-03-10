Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B1CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8854E21927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXzaQHj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCJUdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:33:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30366 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726283AbgCJUdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583872415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IuAk3iiyWjaaAHQcjrLbiVUBF9ti+LNH3LoLdVoeonk=;
        b=LXzaQHj5j5Y6SOl7RB0xcm6Q9fyHEjR6dQwqOXSa0kLPhH3ZXskNkQD7urrLEO0PAcJWSO
        O84t3oE1pIso/NEbXQ1GjbZZVQm2S7BGV3X8bHSZSrMnRW8uJht7wTymbDiYsPmaxL8UUX
        Ut/M8+vHnheYuNgPjAiYfh1y3sC/v8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-KXglNHPLN0iwC4j7ViQC-w-1; Tue, 10 Mar 2020 16:33:31 -0400
X-MC-Unique: KXglNHPLN0iwC4j7ViQC-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41916184C80F;
        Tue, 10 Mar 2020 20:33:30 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A76C5D9CA;
        Tue, 10 Mar 2020 20:33:22 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0E4F122021D; Tue, 10 Mar 2020 16:33:22 -0400 (EDT)
Date:   Tue, 10 Mar 2020 16:33:21 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Subject: Re: [PATCH 12/20] fuse: Introduce setupmapping/removemapping commands
Message-ID: <20200310203321.GF38440@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-13-vgoyal@redhat.com>
 <CAJfpeguY8gDYVp_q3-W6JNA24zCry+SfWmEW2zuHLQLhmyUB3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguY8gDYVp_q3-W6JNA24zCry+SfWmEW2zuHLQLhmyUB3Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 08:49:49PM +0100, Miklos Szeredi wrote:
> On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Introduce two new fuse commands to setup/remove memory mappings. This
> > will be used to setup/tear down file mapping in dax window.
> >
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> > ---
> >  include/uapi/linux/fuse.h | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 5b85819e045f..62633555d547 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -894,4 +894,41 @@ struct fuse_copy_file_range_in {
> >         uint64_t        flags;
> >  };
> >
> > +#define FUSE_SETUPMAPPING_ENTRIES 8
> > +#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
> > +struct fuse_setupmapping_in {
> > +       /* An already open handle */
> > +       uint64_t        fh;
> > +       /* Offset into the file to start the mapping */
> > +       uint64_t        foffset;
> > +       /* Length of mapping required */
> > +       uint64_t        len;
> > +       /* Flags, FUSE_SETUPMAPPING_FLAG_* */
> > +       uint64_t        flags;
> > +       /* Offset in Memory Window */
> > +       uint64_t        moffset;
> > +};
> > +
> > +struct fuse_setupmapping_out {
> > +       /* Offsets into the cache of mappings */
> > +       uint64_t        coffset[FUSE_SETUPMAPPING_ENTRIES];
> > +        /* Lengths of each mapping */
> > +        uint64_t       len[FUSE_SETUPMAPPING_ENTRIES];
> > +};
> 
> fuse_setupmapping_out together with FUSE_SETUPMAPPING_ENTRIES seem to be unused.

This looks like leftover from the old code. I will get rid of it. Thanks.

Vivek

