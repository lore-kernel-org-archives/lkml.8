Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B99C47247
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F6D206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lSbwrVKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgEFAOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 20:14:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:50981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgEFAOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 20:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588724055;
        bh=VstGBM+9+BOrff1fXnmRzhytiHYZbjWPVGkVLancL10=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lSbwrVKnFUHv6uPM8VAiWp2OJ8BAEw6EADIbyWpNmYoD5ADYCxycToszJuwEAYRgj
         2eXSF7lMLJaOmWptEMpnqNVb37j4aoWs0t6+0Do8n3mlMxWBs5CYMMTtPYdYIuYR5+
         q7wDeiYNIekM1uCAPAungqPVF2IFHkZxlGx9Df+c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([120.242.76.42]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MulmF-1jESOL0V9P-00rmbp; Wed, 06 May 2020 02:14:15 +0200
Date:   Wed, 6 May 2020 08:14:07 +0800
From:   Gao Xiang <hsiangkao@gmx.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: get parent inode when recovering pino
Message-ID: <20200506001403.GA2101@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200505153139.201697-1-jaegeuk@kernel.org>
 <20200505165847.GA98848@gmail.com>
 <20200505181323.GA55221@google.com>
 <20200505181941.GC98848@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505181941.GC98848@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:+cT0PQODTEdyEfpz5fSWeJDDU8z3WioTeZk54M4Xhf1yjRJkS44
 CMFp1mJW90JMOme4N7Mj0WXSqrczBdkbosVHWt3r5tNF80UszC0G7pD0sFloC26EmqVy12a
 N4jnNR6klWlwdITPteT+bdQLQ20827C9nw5JiPiWKHRYtkQ2B0Csmw+fzxXbVXp49Jlsuwe
 VQucEDOgzxJUWFd0dzgDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zqz0WlMk7ng=:em/tm00iXuGtgmOnGNV8+C
 iWr7hedhiGqpfCxvCyqHti9eM5Sb0YSvic39fJIjuEkBeIJattV+az9w61ki2fkvjoDTYHkOF
 uNo6pXIDoby+Ky1IQjjhZWw9MN0ePUQ36xIrcZ5Z+7SfUo+m7uihhnumc21tL2WOSJDa49d35
 1DG5FZRRSYSyMVCocckL3jsh5E8bDU1r1izSKoJeY6EpXowsbOQx0ws642vnNcmXaOgwJwYZt
 ntSQXL756qX2MUI65H46mgSuV0PtTbEChusD1k5JJwWSRi7wqK3fPcaoY25HMPj+bzpS6l8Ke
 CpRWrzMuyNrJ+2mJTX5XjAWkgjlGAJxTAu5anrA9X4kb91zPPcGwIsedFR+erkGW3rbfOhZtO
 EBl87dJEh7KEVBYp7nbIieXf4ZxH8omWUxbcG5oP0xhwvF4Sve/LWr0n/MVLpKZ76rGBvfCk7
 +5q++3U/EAKGQZuTtt9qmwNpGEBnvhItbYGn6uMtrPmwZMGtOWlCIE47e9saJH+QvByKb67ZK
 m4znWWxVSCq+AXlSxEMfSDeHAlLuu4V37ZM8D08/QkZTkc2jWX2m8KvzfwzFxcCLH152BdiTr
 KUwS+f0zIfpqO0OQznD86TAXezpKL+fFzkNkmSYPP/iSurLLsj4NTLb/+RsbK4cH3y5G9k7Oe
 50Nz1KRcdUclNh3Ag+sR+tNhRLuNgxIxM6SNn7MDcGHTwH8JQrU1earv1kVo7nijGRoWjmP3w
 ytOMEOTLUZa5Jm1SswvRiMVg2nhJopVGuZbCii5RvF0+6dXwZN3jSLVYGCymMcyo8bW7sRBNb
 RgQ6C4v7ENLneUiY23Ey+o4CrIqcSwxg2E84yf1AF5KPkwFlYLRTxNK0TKPTHV1XbhZXBA8pI
 cdcBKBS4TTkyWK8jgwE02oRlYVsWFT7lyRHqo+LPm25gT/FdpnzcxylFz2j+eAmOJImszIvaG
 gjF7cMA3Kf4/d5V3qT61AVYdWHhCku9gu8zdP3wUgsq2O1fTCmya1mb9vjQqtsNAJQUC0sDny
 l9qeRKL+6OyXNl5nCJmPzNxSvN+nxJHaUBg3q3OFFo1qt2oYR4mZaHF4dykZB521ljIsRmFhp
 3nZtzRpIbShj+9uGX9Mfc82CARFS7MVP42QZ9DogVXQ1VGoMdI8pTOuNLv/+ug4joBPyPHVE9
 Zx6SXU5hedTbA1gA0cDi2lc7f/VBADD66x45Bg3Mzjx7zy3XSpGCLoTT4znzHFDeJ+ZZBPCup
 N31N7+xcxwtjzile2
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Tue, May 05, 2020 at 11:19:41AM -0700, Eric Biggers wrote:
> On Tue, May 05, 2020 at 11:13:23AM -0700, Jaegeuk Kim wrote:

...

> >
> > -static int get_parent_ino(struct inode *inode, nid_t *pino)
> > -{
> > -	struct dentry *dentry;
> > -
> > -	inode =3D igrab(inode);
> > -	dentry =3D d_find_any_alias(inode);
> > -	iput(inode);
> > -	if (!dentry)
> > -		return 0;
> > -
> > -	*pino =3D parent_ino(dentry);
> > -	dput(dentry);
> > -	return 1;
> > -}
> > -
> >  static inline enum cp_reason_type need_do_checkpoint(struct inode *in=
ode)
> >  {
> >  	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> > @@ -223,14 +208,15 @@ static bool need_inode_page_update(struct f2fs_s=
b_info *sbi, nid_t ino)
> >  	return ret;
> >  }
> >
> > -static void try_to_fix_pino(struct inode *inode)
> > +static void try_to_fix_pino(struct dentry *dentry)
> >  {
> > +	struct inode *inode =3D d_inode(dentry);
> >  	struct f2fs_inode_info *fi =3D F2FS_I(inode);
> > -	nid_t pino;
> >
> >  	down_write(&fi->i_sem);
> > -	if (file_wrong_pino(inode) && inode->i_nlink =3D=3D 1 &&
> > -			get_parent_ino(inode, &pino)) {
> > +	if (file_wrong_pino(inode) && inode->i_nlink =3D=3D 1) {
> > +		nid_t pino =3D parent_ino(dentry);
> > +
> >  		f2fs_i_pino_write(inode, pino);
> >  		file_got_pino(inode);
> >  	}
> > @@ -310,7 +296,7 @@ static int f2fs_do_sync_file(struct file *file, lo=
ff_t start, loff_t end,
> >  		 * We've secured consistency through sync_fs. Following pino
> >  		 * will be used only for fsynced inodes after checkpoint.
> >  		 */
> > -		try_to_fix_pino(inode);
> > +		try_to_fix_pino(file_dentry(file));
> >  		clear_inode_flag(inode, FI_APPEND_WRITE);
> >  		clear_inode_flag(inode, FI_UPDATE_WRITE);
> >  		goto out;
>
> Actually, I think this is wrong because the fsync can be done via a file
> descriptor that was opened to a now-deleted link to the file.

I'm still confused about this...

I don't know what's wrong with this version from my limited knowledge?
 inode itself is locked when fsyncing, so

   if the fsync inode->i_nlink =3D=3D 1, this inode has only one hard link
   (not deleted yet) and should belong to a single directory; and

   the only one parent directory would not go away (not deleted as well)
   since there are some dirents in it (not empty).

Could kindly explain more so I would learn more about this scenario?
Thanks a lot!

>
> We need to find the dentry whose parent directory is still exists, i.e. =
the
> parent directory that is counting towards 'inode->i_nlink =3D=3D 1'.

directory counting towards 'inode->i_nlink =3D=3D 1', what's happening?

>
> I think d_find_alias() is what we're looking for.

It may be simply dentry->d_parent (stable/positive as you said before, and=
 it's
not empty). why need to d_find_alias()?


And what is the original problem? I could not get some clue from the origi=
nal
patch description (I only saw some extra igrab/iput because of some unknow=
n
reasons), it there some backtrace related to the problem?

Thanks,
Gao Xiang

>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6ab8f621a3c5..855f27468baa 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -165,13 +165,13 @@ static int get_parent_ino(struct inode *inode, nid=
_t *pino)
>  {
>         struct dentry *dentry;
>
> -       inode =3D igrab(inode);
> -       dentry =3D d_find_any_alias(inode);
> -       iput(inode);
> +       dentry =3D d_find_alias(inode);
>         if (!dentry)
>                 return 0;
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
