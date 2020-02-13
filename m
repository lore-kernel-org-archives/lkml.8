Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C86DC3B190
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424252168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="mZSbRcoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgBMXC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:02:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34182 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBMXC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 18:02:26 -0500
Received: by mail-ed1-f66.google.com with SMTP id r18so8915295edl.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 15:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yUyZDsu+hO6lygGo4rMG4rSjy+EFMNYzYHIsqw/Bxd4=;
        b=mZSbRcoyvfbZ/lrDql3ZchQ0AQQEHs40mr6wVd7HurLsSVCt1im+XbNhERmoiOa90a
         Tja4MrCMxwjlyp3vB/V4vNjOJu49FUv60q7Z+JZH+8lxMQC13LKIk7J7KJl96Kf1S5Vu
         kW2oI7MvFff9OIkWgPx4aYxKLqFtsF/lhc3djy6CV7+uCBVm2T7BMoSqtE2Y6m94w0XG
         zT888gBszogYFLGc/Qya3hrnFgTStZOpbcb1hUu40Jh+CZrHaJWhI8hs2neph6uE3Wgr
         fUIkFtsol++DEHwi+t2SAMQ37cCfoKKB57YzBPGyKhe9RudvAZLj2uAn8GPA31ofnYPj
         VcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUyZDsu+hO6lygGo4rMG4rSjy+EFMNYzYHIsqw/Bxd4=;
        b=pmXLitl/vlah9+sUxGbBgjNgoAf61m3152MecXIVJjPHqWADPEAtgKQ/TIv21mFXDJ
         cyXX8s3Wj2rV/SYrnLakNmPh5dQlhqNaeiZGIs6Ucg/IW+Ks84WGN527cjM8FnVZWtmd
         UonigXkEHMSGg3EIBDH2hrkOFAWjmBCStgZDDsGMUoGavhEKjBYaSQQ0fyp3o3aSfPxK
         2h8hHCTp978ECgZPMoCU2Cvmyuh2wiixs4X3dL6BOCPLfqZ9vTBqaw7EKNLaNL/sdWO/
         Zj9aIS6Kp6rpP7IYPL1f5fqxTvS6CNQ+mTkv0gobq8z2n6gJ+q5pMFFYsJDG7MI7wh7o
         KZJw==
X-Gm-Message-State: APjAAAXrDNeGzNRYB/ybq9X+kYICBNQ2mDQaG4ts9+HV3uc2TNuOmI3s
        IN1cW81PfkqDEV6N+7d8KiZHqSlPXhM46HhAU7by
X-Google-Smtp-Source: APXvYqxx4RAQQ47YB6enO8WeF+wH4nyCWe7O+uyVUfeMq4SWVF3RUSzDGhrpwArr+7yjBs5YdNHytfa+SIsQzI8YUb4=
X-Received: by 2002:a17:906:7c47:: with SMTP id g7mr69108ejp.281.1581634942693;
 Thu, 13 Feb 2020 15:02:22 -0800 (PST)
MIME-Version: 1.0
References: <20200212103548.266f81fd@canb.auug.org.au> <1d0b80d272a8e8c4a7b322d2d2bcc483d9e41a28.camel@btinternet.com>
In-Reply-To: <1d0b80d272a8e8c4a7b322d2d2bcc483d9e41a28.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Feb 2020 18:02:11 -0500
Message-ID: <CAHC9VhTu+SjtOx0ZZeNHkUNTrkTHtetQapqGodEkRKM=hEqFLg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the keys tree
To:     David Howells <dhowells@redhat.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 7:03 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Wed, 2020-02-12 at 10:35 +1100, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the selinux tree got conflicts in:
> >
> >   security/selinux/include/security.h
> >   security/selinux/ss/services.c
> >
> > between commit:
> >
> >   87b14da5b76a ("security/selinux: Add support for new key
> > permissions")
> >
> > from the keys tree and commit:
> >
> >   7470d0d13fb6 ("selinux: allow kernfs symlinks to inherit parent
> > directory context")
> >
> > from the selinux tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your
> > tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any
> > particularly
> > complex conflicts.
> >
>
> I think 87b14da5b76a ("security/selinux: Add support for new key
> permissions") should be revoked and resubmitted via selinux as it was
> never ack'ed there and produced before 7470d0d13fb6 ("selinux: allow
> kernfs symlinks to inherit parent directory context"), that has been
> ack'ed.
>
> Because of this the policy capability ids are out of sync with what has
> been committed in userspace libsepol.
>
> Plus as Paul mentioned there is an outstanding query on the permission
> loop that David needs to answer.

David, I see that this patch is still getting pulled into linux-next,
could you please revert it from your keys tree?

-- 
paul moore
www.paul-moore.com
