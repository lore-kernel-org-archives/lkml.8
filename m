Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36626C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C09C216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgEAUss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:48:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:52764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAUsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:48:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 845B3ABC2;
        Fri,  1 May 2020 20:48:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4DEE51E129E; Fri,  1 May 2020 22:48:43 +0200 (CEST)
Date:   Fri, 1 May 2020 22:48:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Steven J. Magnani" <steve@digidescorp.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 09/15] udf: avoid gcc-10 zero-length-bounds warnings
Message-ID: <20200501204843.GA9544@quack2.suse.cz>
References: <20200430213101.135134-1-arnd@arndb.de>
 <20200430213101.135134-10-arnd@arndb.de>
 <20200430215450.anfwm4zikvhy2bt5@pali>
 <CAK8P3a0_BuKDK7X8dTHyx7t++CGjy3jhDVvL=Jo5=kcUxmtobg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a0_BuKDK7X8dTHyx7t++CGjy3jhDVvL=Jo5=kcUxmtobg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-05-20 22:30:27, Arnd Bergmann wrote:
> On Thu, Apr 30, 2020 at 11:54 PM Pali Rohár <pali@kernel.org> wrote:
> > > @@ -360,9 +360,9 @@ struct logicalVolIntegrityDesc {
> > >       uint8_t                 logicalVolContentsUse[32];
> > >       __le32                  numOfPartitions;
> > >       __le32                  lengthOfImpUse;
> > > -     __le32                  freeSpaceTable[0];
> > >       __le32                  sizeTable[0];
> > >       uint8_t                 impUse[0];
> > > +     __le32                  freeSpaceTable[];
> >
> > Please do not change order of members in these structures. Order is
> > strictly defined by ECMA 167 standard and changing them you would just
> > confuse reader. In LVID is free space table before size table.
> 
> Ok
> 
> > If you do not like GNU C extension for zero-length arrays then just
> > replace it by standard C99 flexible arrays. I think that there is no
> > reason to not use standard C99 language constructions, just nobody had
> > motivation or time to change (working) code.
> 
> No, the problem is that only the last member can be a flexible array,
> so when impUse[] is the last member, freeSpaceTable has to be a zero
> length array.
> 
> []> Also this file is semi-synchronized with udftools project in which I
> > already replaced all GNU C zero-length arrays by C99 flexible arrays.
> >
> > You can take inspiration what I did with logicalVolIntegrityDesc:
> > https://github.com/pali/udftools/commit/f851d84478ce881d516a76018745fa163f803880#diff-1e1a5b89f620d380f22b973f9449aeaeL381-R384
> 
> Right, this is likely the best workaround.
> 
> > Anyway, if you have a better idea what to do with such on-disk structure
> > and how to represent it in C struct syntax, let me know as it could be
> > updated also in udftools project.
> 
> The trick I used for impUse[] would also work for freeSpaceTable[] to avoid
> the gcc warning, it's still not great, but maybe you like this better:

I like Pali's version somewhat better because whenever I look at several
(obviously flexible) arrays in one struct, I start wondering what's going
on. So let's not define members of struct whose offset we actually don't
know (and thus we cannot sanely use them anyway).

								Honza
 
> arnd@threadripper:~/arm-soc$ git diff
> diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
> index 02f03fadb75b..666d022eb00b 100644
> --- a/fs/udf/balloc.c
> +++ b/fs/udf/balloc.c
> @@ -98,7 +98,7 @@ static void udf_add_free_space(struct super_block
> *sb, u16 partition, u32 cnt)
>                 return;
> 
>         lvid = (struct logicalVolIntegrityDesc *)sbi->s_lvid_bh->b_data;
> -       le32_add_cpu(&lvid->freeSpaceTable[partition], cnt);
> +       le32_add_cpu(lvid->freeSpaceTable + partition, cnt);
>         udf_updated_lvid(sb);
>  }
> 
> diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
> index 14ffe27342bc..215d97d7edc4 100644
> --- a/fs/udf/ecma_167.h
> +++ b/fs/udf/ecma_167.h
> @@ -360,9 +360,9 @@ struct logicalVolIntegrityDesc {
>         uint8_t                 logicalVolContentsUse[32];
>         __le32                  numOfPartitions;
>         __le32                  lengthOfImpUse;
>         __le32                  freeSpaceTable[0];
>         __le32                  sizeTable[0];
> -       uint8_t                 impUse[0];
> +       uint8_t                 impUse[];
>  } __packed;
> 
>  /* Integrity Type (ECMA 167r3 3/10.10.3) */
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 379867888c36..a1fc51c2261e 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -2517,8 +2517,8 @@ static unsigned int udf_count_free(struct super_block *sb)
>                         (struct logicalVolIntegrityDesc *)
>                         sbi->s_lvid_bh->b_data;
>                 if (le32_to_cpu(lvid->numOfPartitions) > part) {
> -                       accum = le32_to_cpu(
> -                                       lvid->freeSpaceTable[part]);
> +                       accum = le32_to_cpup(
> +                                       (lvid->freeSpaceTable + part));
>                         if (accum == 0xFFFFFFFF)
>                                 accum = 0;
>                 }
> 
> 
> 
> This version could easily be backported to stable kernels to let them be
> compiled with gcc-10, and then synchronizing with the udftools version of
> the header needs additional changes on top, which do not need to be
> backported.
> 
>        Arnd
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
