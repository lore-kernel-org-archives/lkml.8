Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC24C47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 01:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87F8206A5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 01:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="lKfptMr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgEFB6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 21:58:39 -0400
Received: from sonic305-22.consmr.mail.ne1.yahoo.com ([66.163.185.148]:41459
        "EHLO sonic305-22.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729509AbgEFB6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 21:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1588730317; bh=CVw8L0hHvwbYi4+P+g/ulJkZcv445iN2F6ec7gN2/Cw=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=lKfptMr+itf7a5nC8vgOiNk70vnizhd2dn9GIB3ckqnr6nDv63euNBLnwCl31gF2n0zYjjNZHMbduezl2/+KEJW+YVwrLaYFjsvQJSnw6g1MZI2+/yTu7CE7B6caR2L6qOoKcFEQVfNxr/ISrculqJYgpO6enbl4UKKCFqRcwRUf4MXFOJV/BQQGYZ/oX0liiX6ORNSJkJNTSJM99bRvm4KTNfzphkKpy43V9ioq/zjK9BBiU0ZpR7C9lzmwm5JaTbAH5p5Xb8QYrM0DNpjNNJ+KJPWk0dySjC6XF41pwwNPNGTDWyZyAWjrDaGYYSJaeLAQYhLFSfPLVg0o8EYJBw==
X-YMail-OSG: dPJe8ugVM1lJ7eTlX1XsifqxHQRvA0UbC5tcZjxQjH38EgesuRdHVOrDHnnm2Cg
 yQkj4aczzG0nEe7NVRu3_8QIWgBmC.UAOWaJdIwnlUmzOddnF52P76OkmR9Bph3D_ehjmo6HEKeq
 o0GUuxdZCvB_c_cZm6pfIduHe1yU8lU0yf1pQUs.kVhQV2Nexb_lNseGEXHgqMACkp5.5S4Ncgnj
 o_Rs3bSTYryLC.wibcA6bR..m53EQBiYsV6k0KxQsr76r1q_k6z72.acLuYAF80ZlvGaFMEjJLGb
 tASr.M9C2AS1cTlSzQqR7O1UUBKdLhPjkb0y7Gwttdx_Hx1MPH_tPulIo2vEubchCSxIwtWXRU4F
 W34ETn1jRdRgIlFIJOGAGxrYzYZsmoajFQPGSAMldAcMIPEgVwZ5uuwdw3FBlMud8CTPwFQ1cXCK
 936zwuZ07o6JAE.N4ylnEyYS7GT_sAAHJICVTrkAHk_JxnTEompSdRfiwP7KAq9bKSOj2PlEpSOX
 _J_vXKdpk00W2Bp4WDMmK5R3JCGsCzfDi8seJHTItXae1RT3SRClJ1KvqmY3dRfA9ecHzjKg_Vc5
 QDYDGzyWJSc9PB1OcrNTNXLcdQ3ap5szzYmAEwwvz9sKyMW4rppaBin.IVRTiIUzCcGQjNOMfa91
 SU_OdRDMTUEnuEVDiEEB1jS8QfC54usOWPwVHRxFPt8hoUR5v3rOdE6Bn5fpgzObL.bIUQD5pSnz
 U1E338otrXRQyc9k5pzzhJoCBrzBy6_ES843l2QBrWQD8uCeyH9lKHA.Qi7Yk.jxlafUko367oSl
 _05iYXpCQ.aNCN7_peCIlMjM.DU7CDfJGnfifoyVEmArdO_PSCaCo1tasDEixfQ8sqyYPjAf_5zD
 lSavLGrzv4rPh_zgQwbAZbEhbqZxkbPcFEW.MmpQRZWep0RGEnPxc1YvOFUUXqVBYlhlGFfaoXbu
 I4KmD9sWTgF.Aar3KFxoszxXH0kREhXgmAEx8amJLYy4Q0bBH7wdtwjBUuV3jFzBjCjvrL630zGk
 wnZ.prYznyEQHPQ0LFcjL4FLv3iJJZZuMMeYH43E1vABfMmt4_viDZwUUjDIn7eP4kWBKHQeJ.nv
 rgHUxz1xKmP8N1GBwjaIWsd91_HcftbiGKLsZtxwiLKoKKJ2IigVrxx3hLlMtt3a43YkdmrNZwu5
 MUGymKNdqsV.eB4qF30Dko1MOqz3V8IlRp.VVJ8hb7GQefrBppKIS7stqY5xrK8Rd2Jf189S0rsP
 EWIRvnc0tRZic26x9yPWCA8FARrWsaWzuT0KplIZSitLNgnMfKcsOiR3y24P3Xae0nd9yClAxTiB
 QCf5_JEr1kSMrU1CWM4bwwUA.snwVNHASg59f0HQ_ENqzeVIZr3JZexKRT6GStPv8V2w6PD_xqHt
 oWRU2DRV7IMnc_7ZbsKLriaPFx8s-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Wed, 6 May 2020 01:58:37 +0000
Received: by smtp405.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e5177e5190e2c0ef014e81220c738f10;
          Wed, 06 May 2020 01:58:34 +0000 (UTC)
Date:   Wed, 6 May 2020 09:58:22 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Gao Xiang <hsiangkao@gmx.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: get parent inode when recovering pino
Message-ID: <20200506015813.GA9256@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200505153139.201697-1-jaegeuk@kernel.org>
 <20200505165847.GA98848@gmail.com>
 <20200505181323.GA55221@google.com>
 <20200505181941.GC98848@gmail.com>
 <20200506001403.GA2101@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200506012428.GG128280@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506012428.GG128280@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.15756 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 06:24:28PM -0700, Eric Biggers wrote:
> On Wed, May 06, 2020 at 08:14:07AM +0800, Gao Xiang wrote:
> > >
> > > Actually, I think this is wrong because the fsync can be done via a file
> > > descriptor that was opened to a now-deleted link to the file.
> > 
> > I'm still confused about this...
> > 
> > I don't know what's wrong with this version from my limited knowledge?
> >  inode itself is locked when fsyncing, so
> > 
> >    if the fsync inode->i_nlink == 1, this inode has only one hard link
> >    (not deleted yet) and should belong to a single directory; and
> > 
> >    the only one parent directory would not go away (not deleted as well)
> >    since there are some dirents in it (not empty).
> > 
> > Could kindly explain more so I would learn more about this scenario?
> > Thanks a lot!
> 
> i_nlink == 1 just means that there is one non-deleted link.  There can be links
> that have since been deleted, and file descriptors can still be open to them.

Thanks for your inspiration. You are right, thanks.

Correct my words... I didn't check f2fs code just now, it seems f2fs doesn't
take inode_lock as some other fs like __generic_file_fsync or ubifs_fsync.

And i_sem locks nlink / try_to_fix_pino similarly in some extent. It seems
no race by using d_find_alias here. Thanks again.

Thanks,
Gao Xiang

> 
> > 
> > >
> > > We need to find the dentry whose parent directory is still exists, i.e. the
> > > parent directory that is counting towards 'inode->i_nlink == 1'.
> > 
> > directory counting towards 'inode->i_nlink == 1', what's happening?
> 
> The non-deleted link is the one counted in i_nlink.
> 
> > 
> > >
> > > I think d_find_alias() is what we're looking for.
> > 
> > It may be simply dentry->d_parent (stable/positive as you said before, and it's
> > not empty). why need to d_find_alias()?
> 
> Because we need to get the dentry that hasn't been deleted yet, which isn't
> necessarily the one associated with the file descriptor being fsync()'ed.
> 
> > And what is the original problem? I could not get some clue from the original
> > patch description (I only saw some extra igrab/iput because of some unknown
> > reasons), it there some backtrace related to the problem?
> 
> The problem is that i_pino gets set incorrectly.  I just noticed this while
> reviewing the code.  It's not hard to reproduce, e.g.:
> 
> #include <unistd.h>
> #include <fcntl.h>
> #include <sys/stat.h>
> 
> int main()
> {
>         int fd;
> 
>         mkdir("dir1", 0700);
>         mkdir("dir2", 0700);
>         mknod("dir1/file", S_IFREG|0600, 0);
>         link("dir1/file", "dir2/file");
>         fd = open("dir2/file", O_WRONLY);
>         unlink("dir2/file");
>         write(fd, "X", 1);
>         fsync(fd);
> }
> 
> Then:
> 
> sync
> echo N | dump.f2fs -i $(stat -c %i dir1/file) /dev/vdb | grep 'i_pino'
> echo "dir1 (correct): $(stat -c %i dir1)"
> echo "dir2 (wrong): $(stat -c %i dir2)"
> 
> i_pino will point to dir2 rather than dir1 as expected.
> 
> - Eric
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
