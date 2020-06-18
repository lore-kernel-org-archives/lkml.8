Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB6EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4672206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e31t8BkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbgFRQkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:40:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59579 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731959AbgFRQkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592498429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+ZmXo1VT3DgmlBxctO5wOawFr9Ym28t9PdelfkR48g=;
        b=e31t8BkS6xSRALcGqv57e+ji295zDcSzyzbjhbqCPIya2fUZ79TtfL8Q09svKgs5aFv63r
        w2G2eCWwvlV+m3QmvX9nS4hIZ67OOvmncXeTlp+hdk0c7J0f5qhYsbJ5KdB3cSRoyHzcHK
        WEeRU0hMzJ37Biryh2RpuzvyJNnvKg0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-Srafve5RNliKD506qAVihQ-1; Thu, 18 Jun 2020 12:40:28 -0400
X-MC-Unique: Srafve5RNliKD506qAVihQ-1
Received: by mail-oo1-f69.google.com with SMTP id n15so3003212oov.22
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 09:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K+ZmXo1VT3DgmlBxctO5wOawFr9Ym28t9PdelfkR48g=;
        b=Wyb2UOYw0Gpfoz6Wrdu9M3ybuIWisthzBgQFFFtIbO1x3hQRTtuKjymwfbsQ/u18rM
         CuPYd/gREoVz+ms+ynOH3q4UxqFUXtRaWzX0MTA4j7UASfxzbQqVlbdYXhyewT0J7LqV
         xJR7ZFDoVk6Ysm0k1sxYe2el3duQ2/Jt9KWnDiHh0J3CtaIpRyOu/20b9wDyTi2mDyt/
         VgVftFEt2xv7f6SpDY0XDsXxKCL+nosOMH9bfBUJMz1/razS9s4weEVtKsY/MkOGmDl8
         07MiDcZcpxq3ZukTTOCoCRjLezy6S5UOE3GQNaruwEN5eBUMdyPereEaNdCo7ekXpCid
         /FyA==
X-Gm-Message-State: AOAM531rpONw+V/vfEmauXLjP8QYTr+6lWX+ysVGy3Pf0/SF05IyO0vC
        xP1uSwOSWBl0HpvPt0cvjo2D8kTvlIgpmd+pgcxnaX0dvkwJOZy/9gDm3DRhHJQccqLl8yAjoE9
        gUP5NYHDBFrnTsdMbkh6g/DRMNxWYF/3svWnfrn8Q
X-Received: by 2002:a05:6830:10c8:: with SMTP id z8mr4000193oto.95.1592498427404;
        Thu, 18 Jun 2020 09:40:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE8nhb2Q0d4GxQpaInRB14NGapvcWpYnTg96Ky3B2ltZU9DxgAABVkj/Ptn9PHhgl8mMoH1G9lpq5ufccfhow=
X-Received: by 2002:a05:6830:10c8:: with SMTP id z8mr4000168oto.95.1592498427103;
 Thu, 18 Jun 2020 09:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200414150233.24495-1-willy@infradead.org> <20200414150233.24495-17-willy@infradead.org>
 <CAHc6FU4m1M7Tv4scX0UxSiVBqkL=Vcw_z-R7SufL8k7Bw=qPOw@mail.gmail.com>
 <20200617003216.GC8681@bombadil.infradead.org> <CAHpGcMK6Yu0p-FO8CciiySqh+qcWLG-t3hEaUg-rqJnS=2uhqg@mail.gmail.com>
 <20200617022157.GF8681@bombadil.infradead.org> <CAHc6FU7NLRHKRJJ6c2kQT0ig8ed1n+3qR-YcSCWzXOeJCUsLbA@mail.gmail.com>
 <20200618150309.GP8681@bombadil.infradead.org>
In-Reply-To: <20200618150309.GP8681@bombadil.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 18 Jun 2020 18:40:15 +0200
Message-ID: <CAHc6FU6TYTiQ0a0GkN1dhh3VeQKVKrL+eALvuYzZ8nq5jvNHjg@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v11 16/25] fs: Convert mpage_readpages to mpage_readahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel <cluster-devel@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, ocfs2-devel@oss.oracle.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        linux-btrfs@vger.kernel.org,
        Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 5:03 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jun 18, 2020 at 02:46:03PM +0200, Andreas Gruenbacher wrote:
> > On Wed, Jun 17, 2020 at 4:22 AM Matthew Wilcox <willy@infradead.org> wr=
ote:
> > > On Wed, Jun 17, 2020 at 02:57:14AM +0200, Andreas Gr=C3=83=C2=BCnbach=
er wrote:
> > > > Right, the approach from the following thread might fix this:
> > > >
> > > > https://lore.kernel.org/linux-fsdevel/20191122235324.17245-1-agruen=
ba@redhat.com/T/#t
> > >
> > > In general, I think this is a sound approach.
> > >
> > > Specifically, I think FAULT_FLAG_CACHED can go away.  map_pages()
> > > will bring in the pages which are in the page cache, so when we get t=
o
> > > gfs2_fault(), we know there's a reason to acquire the glock.
> >
> > We'd still be grabbing a glock while holding a dependent page lock.
> > Another process could be holding the glock and could try to grab the
> > same page lock (i.e., a concurrent writer), leading to the same kind
> > of deadlock.
>
> What I'm saying is that gfs2_fault should just be:
>
> +static vm_fault_t gfs2_fault(struct vm_fault *vmf)
> +{
> +       struct inode *inode =3D file_inode(vmf->vma->vm_file);
> +       struct gfs2_inode *ip =3D GFS2_I(inode);
> +       struct gfs2_holder gh;
> +       vm_fault_t ret;
> +       int err;
> +
> +       gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
> +       err =3D gfs2_glock_nq(&gh);
> +       if (err) {
> +               ret =3D block_page_mkwrite_return(err);
> +               goto out_uninit;
> +       }
> +       ret =3D filemap_fault(vmf);
> +       gfs2_glock_dq(&gh);
> +out_uninit:
> +       gfs2_holder_uninit(&gh);
> +       return ret;
> +}
>
> because by the time gfs2_fault() is called, map_pages() has already been
> called and has failed to insert the necessary page, so we should just
> acquire the glock now instead of trying again to look for the page in
> the page cache.

Okay, that's great.

Thanks,
Andreas

