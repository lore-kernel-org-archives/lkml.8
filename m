Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C710CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E16C206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="ljpr+RBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgHGRvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:51:23 -0400
Received: from sonic311-24.consmr.mail.gq1.yahoo.com ([98.137.65.205]:46327
        "EHLO sonic311-24.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727838AbgHGRvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1596822681; bh=7rFtTYgty6X4oWzyWCtAXM5bdgI3jqDY75d+k2FdyYw=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject; b=ljpr+RBkuOhMExQ6suaSGIXFI0Z6hwaW+LHh7V9DG4MbnJuudoIBD5UpfWYvpx52ri7ryLZw3rbtfaydmNqd90hGHXsVaw6qfkLnRldXjExbv78Odk49P+f4PX3Q0WIA4ghoo5Ma3R+dwNSGO/xklRFT0F4bzuMEBS+1Zf3Jbn/NkGnNJ675u0gHPtKlX+haTGl2setjNcdyGxMHFuyDPAJ5uI5zUUZ5JbOP8scAhxmRfHjNWU7lZI8uYvblVE56R4Uavma+tYMCePKcl1nZpm7AYTzyOFhlUTPSrtFDKko20eiWW1rW2MNZyR8S+cxh9jUmm0hbOMx3MAU5FdbunA==
X-YMail-OSG: 5wJ.4qMVM1kSov5Pd_G1D5sD7EYK6_cveIvYPN0ASCK.OdnKrAO7N2PecSKbHlK
 qAxqtseKxh0aXDocbkjyaTLGXzdea.mzo743Bkxrq70CaLQgMHrvG7XiiktQnpN9pDTWXyEKDcgB
 I45e.pIUsdHiYMX1a9ZqRthxsiH6CO4dVyiFh95lAl53AISza6pZufzP6tjtr.4H5e81.yGLosIm
 XW3T1yx1VMKqf6QIWwec2G4x144RscA0ole0dVX5DBMD.CB7ErRSmZS5IOk.yr2Tiqpr1j.6ZO57
 VDZUi2V8U7cOEgmA7WWdC6EkZ41lZsNiyiWbyywZ6J6TdEHP.EQuO_YLNwHZH75BFSgIQ9JSlxrn
 zF3_AAbXhOmNlIfNjvOzBg_5JUu.mQSHjp4VxyUxR6t2mYgqmEbHKM.eWkUd3_xvD7PESs3zmzFs
 zucjgH4BClemgug64raOiBOH_NokzYgzsI8Jwai9aHNb3ZslJNK7.WI7QB1jwBhSBZdR4dQRcG6d
 xVUWCqwYjPrQstGidUlpgqrykL5wqcYjoCu7jfXsOHLyDHx8GVjUIm0ZavHKkkHQ4z_SnmBfBRP_
 C9jMWctGeDpzp42Ook8KaaQCt5q2VkWBbvUWGoNNrziuKDkMAQTIAqjBRjMevMzu5KEhrhyLctOx
 d3gd8h3eExV7.uzZmpUZ4k1__E2WFvj2lx.fxLCmirat4a.4nn8R_tBBaqW0rYoYr8QCg8rSW2pl
 vmDy6v3z3wn4eFqHBCZ.NW7EzTlDfPChA.lTYvLJBY4rjPjd.H7Vfngbr33nmWM6SAwW4kKZ6Tg_
 UaBzDuQJYIM6PVZbQwvASZgMxa35jHi7NYQUyjmGCJXjbO6x7HfIdXx5TH4g9MHgo2sScs.EnDpc
 sn4QvMZR3FXsbXIb21bhsrOrKQWlTuI38J90SsaflpGO67rk6rkBnoONavpgilZxE4cXTM1jk7Hk
 twQ3pbs8o_M3vfEYpxRL0aMzhmdMKIVpFmAkuZzZHsoOHWLsie9v2ClQFPecpF3zS8rwjmJe8VfR
 xZBr0Q2QbM5ViRZhgQl.iiScKddiqejV2wCnh44RpR5NlcWKj1PLR1XQ6GH64k9hyQtyzAPDpCAc
 0hh1a1s4woIgvbU53NpWmTLZqr.s0Wy41DWuYnzKt5xqjdJZ1GcvQ6lW8fG3iW_bDhsh..eUg8zD
 Wc.wkgKFiZgWtIswJMU03zEmHFWh0Uog24DaJs1q4P4kj8R9zaRe0ys1y1sj03AWpsY7qUM56wHA
 2YRJNKfUk98sUmrNFRsm1ggDL4B0JL2ph3JPBsDb3Kdipaurwjvxfaw_O1LNks7Atxpt0_FwRj4P
 zDdAskBh9UP8t2IiQfvSqAFn.durl8bBXxajQskgyJWYXNyYNgnnAWQgDAZf_W9k5j5YNcGpUORs
 DgWXtm3SFmX9.iB2ND.0TPbMWsmyL8D_Y_nGPcW0B0Ylw9RJlK_Ti6VLDEO.omhq57VNMVKpdW38
 S.fbEO0_EeswMUP3ISJVJFF5Q3F4QIK1uIni1s6fHSpJ4Y_8vT4fF2TSkvC9PLJl6Pjid2PDSbR4
 7Gy1ulA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Fri, 7 Aug 2020 17:51:21 +0000
Received: by smtp423.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0b03665a650798086ff5d7b69b2720e5;
          Fri, 07 Aug 2020 17:51:16 +0000 (UTC)
Date:   Fri, 07 Aug 2020 13:51:12 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: wine fails to start with seccomp updates for v5.9-rc1
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Will Drewry <wad@chromium.org>, Will Deacon <will@kernel.org>,
        Yonghong Song <yhs@fb.com>
References: <1596812929.lz7fuo8r2w.none.ref@localhost>
        <1596812929.lz7fuo8r2w.none@localhost>
        <CAHk-=wi41L-OXCPQJi4dtc_7SmYTzXGz0XM=39rjiTNAi2gn3g@mail.gmail.com>
        <20200807173609.GJ4402@mussarela>
In-Reply-To: <20200807173609.GJ4402@mussarela>
MIME-Version: 1.0
Message-Id: <1596822616.zldk40bolg.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.16436 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Thadeu Lima de Souza Cascardo's message of August 7, 2020 1:3=
6 pm:
> On Fri, Aug 07, 2020 at 08:48:46AM -0700, Linus Torvalds wrote:
>> On Fri, Aug 7, 2020 at 8:19 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wr=
ote:
>> >
>> > On Linus' master, wine fails to start with the following error:
>> >
>> > wine client error:0: write: Bad file descriptor
>> >
>> > This issue is not present on 5.8. It appears to be caused by failure t=
o
>> > write to a pipe FD received via SCM_RIGHTS. Therefore, I tried reverti=
ng
>> > 9ecc6ea491f0, which resolved the issue.
>>=20
>> Would you mind trying to bisect exactly where it happens?
>>=20
>=20
> This report [1] seemed related and pointed out at c0029de50982 ("net/scm:
> Regularize compat handling of scm_detach_fds()"). The use of CMSG_USER_DA=
TA
> instead of CMSG_COMPAT_DATA seems fishy.
>=20
> Alex, can you try applying the patch below?
>=20
> Cascardo.
>=20
> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-August/216156.ht=
ml
>=20
>> I don't think any of the commits in that pull are supposed to change
>> semantics, and while reverting the whole merge shows that yes, that's
>> what brought in the problems, it would be good to pinpoint just which
>> change breaks so that we can fix just that thing.
>>=20
>> Kees, ideas?
>>=20
>>                  Linus
>=20
> ---
> diff --git a/net/compat.c b/net/compat.c
> index 703acb51c698..95ce707a30a3 100644
> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -294,7 +294,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct=
 scm_cookie *scm)
>  		(struct compat_cmsghdr __user *)msg->msg_control;
>  	unsigned int o_flags =3D (msg->msg_flags & MSG_CMSG_CLOEXEC) ? O_CLOEXE=
C : 0;
>  	int fdmax =3D min_t(int, scm_max_fds_compat(msg), scm->fp->count);
> -	int __user *cmsg_data =3D CMSG_USER_DATA(cm);
> +	int __user *cmsg_data =3D CMSG_COMPAT_DATA(cm);
>  	int err =3D 0, i;
> =20
>  	for (i =3D 0; i < fdmax; i++) {
>=20

Yes, this seems to work.

Tested-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>

Thanks!
