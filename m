Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD64C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 23:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751EA2098B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 23:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9sGCz0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgH3XhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 19:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgH3XhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 19:37:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572B1C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 16:37:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w14so4661698ljj.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 16:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EL8TFBMW/hIieihPeTsDrz8LXdOaui0bvelva2VBqDc=;
        b=E9sGCz0JrQnaGVrW8I6SnshIT6NkhKRTsNmuQmoK3U1uJOY0azs76dnK5wuqZ+wac1
         QY3E1upqQ0Gv/UPI1txoDL65O1AOTPBojxhH2UuRg4PAkFpVgCyDq3QO46wu52gYyfib
         9Ez3QwvpWE9xiiMPoApCuZULj/zQ28sB3ubqRUIQUdle6izL5920MnXHRgItGocDawvO
         XgreeiqyyYf+pGSXhug6YuFJeGHJcs+jMMPTPGC9oCp+7wjoy3LONZTQvG1bB9Z1LGbx
         WbqptCXOok6oZ8G0+5MFUYjF92rE/tcaQA76THXqdaEdBtMF3XUKeAVBtOkR0UYSBzmx
         vPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EL8TFBMW/hIieihPeTsDrz8LXdOaui0bvelva2VBqDc=;
        b=YapIdfRD8Z+EoLKvQ7wuxsWz6z3DoEuW72sBwr+aiFnNMI7biDg4UjYjsPJ5rZm4zD
         SHfKF5vGiyzIwwkKIxoTTnrq7B9a4G7mAtHs6gRZeIQABS+8Lpin4c1IF12PqBobq+4t
         Z1dgbVGBP3VilGGXspZPRrsLtsoXst5ovUe+9NFIBfZ7kzDZxlHVleUkCZJ9un+lA/NK
         X4q1QM6G21oGIhkQrwh36iIkwYFbP98xHJZJ26L0FBejBco1J6jeTUwJQvEkwSvlq8sr
         crAQLhJ2CLSYov1TcbjUxiGmehsQleAKNfjDG+pCknrXzrZ0tfxJBZVP888ca11bbrFk
         6yPQ==
X-Gm-Message-State: AOAM530mZ/r2bloGAchgdL3SYg7lz3/0XGSa9Skw2pc6wbOdNSqFEen1
        5e7TLYZ4j2AFjPyyWNA1GQ8c0K4y1xL3b1poTLk=
X-Google-Smtp-Source: ABdhPJzBa92dvLVxRWdcrxeGBAcFXYc3vacOio4U5BDw0wv/USO0vHZlTx3TOXlcqVzfCL4SJKAEReJ3AOsgtrANQ1E=
X-Received: by 2002:a2e:2c17:: with SMTP id s23mr4259213ljs.265.1598830622417;
 Sun, 30 Aug 2020 16:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200828034953.354267-1-daeho43@gmail.com> <44f8d9f3-9438-fdfe-bbc3-f5347a9aaa29@kernel.org>
In-Reply-To: <44f8d9f3-9438-fdfe-bbc3-f5347a9aaa29@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 31 Aug 2020 08:36:51 +0900
Message-ID: <CACOAw_xnTh9mVO7b+inK_Gsk+g+88W7p5GmLhJV3XY8UHssLzw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: make fibmap consistent with fiemap for
 compression chunk
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got it. Thanks~ :)

2020=EB=85=84 8=EC=9B=94 30=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 8:44, C=
hao Yu <chao@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020-8-28 11:49, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Currently fibmap returns zero address for compression chunk. But it
> > is not consistent with the output of fiemap, since fiemap returns
> > real pysical block address related to the compression chunk. Therefore
> > I suggest fibmap returns the same output with fiemap.
>
> We can return real physical block address in fiemap, because we have set
> FIEMAP_EXTENT_ENCODED flag in extent.fe_flags, then user can be noticed t=
hat he
> can not just read/write that block address for access/update in-there dat=
a.
>
> Quoted from Documentation/filesystems/fiemap.rst
> "
> FIEMAP_EXTENT_ENCODED
>    This extent does not consist of plain filesystem blocks but is
>    encoded (e.g. encrypted or compressed).  Reading the data in this
>    extent via I/O to the block device will have undefined results.
> "
>
> However, there is no such flag in fibmap interface, so I just return bloc=
k
> address for those logical pages in non-compressed cluster.
>
> Thanks,
>
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  fs/f2fs/data.c | 33 ---------------------------------
> >  1 file changed, 33 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index c1b676be67b9..8c26c5d0c778 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -3708,36 +3708,6 @@ static int f2fs_set_data_page_dirty(struct page =
*page)
> >       return 0;
> >  }
> >
> > -
> > -static sector_t f2fs_bmap_compress(struct inode *inode, sector_t block=
)
> > -{
> > -#ifdef CONFIG_F2FS_FS_COMPRESSION
> > -     struct dnode_of_data dn;
> > -     sector_t start_idx, blknr =3D 0;
> > -     int ret;
> > -
> > -     start_idx =3D round_down(block, F2FS_I(inode)->i_cluster_size);
> > -
> > -     set_new_dnode(&dn, inode, NULL, NULL, 0);
> > -     ret =3D f2fs_get_dnode_of_data(&dn, start_idx, LOOKUP_NODE);
> > -     if (ret)
> > -             return 0;
> > -
> > -     if (dn.data_blkaddr !=3D COMPRESS_ADDR) {
> > -             dn.ofs_in_node +=3D block - start_idx;
> > -             blknr =3D f2fs_data_blkaddr(&dn);
> > -             if (!__is_valid_data_blkaddr(blknr))
> > -                     blknr =3D 0;
> > -     }
> > -
> > -     f2fs_put_dnode(&dn);
> > -     return blknr;
> > -#else
> > -     return 0;
> > -#endif
> > -}
> > -
> > -
> >  static sector_t f2fs_bmap(struct address_space *mapping, sector_t bloc=
k)
> >  {
> >       struct inode *inode =3D mapping->host;
> > @@ -3753,9 +3723,6 @@ static sector_t f2fs_bmap(struct address_space *m=
apping, sector_t block)
> >       if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> >               filemap_write_and_wait(mapping);
> >
> > -     if (f2fs_compressed_file(inode))
> > -             blknr =3D f2fs_bmap_compress(inode, block);
> > -
> >       if (!get_data_block_bmap(inode, block, &tmp, 0))
> >               blknr =3D tmp.b_blocknr;
> >  out:
> >
