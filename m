Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2151C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CDE206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="nDapp6Xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgCKRHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:07:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35523 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgCKRHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:07:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id k26so2815962otr.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+t9fU13Iuz/zoBPnGG3vft0C0z8m2mKCU7Saw6lmvk=;
        b=nDapp6XlmdQ95ZlIGVJCqMXN9WyMEgI8CkY0oLNB089wKVmR+TdQeZpYDltt7rgUbo
         3dLmnYrnPzoOy+BA0kNlt4kZy0eo8oxD/iQNDby4ZOZLvKsJ7toAqY+og/il5nfjvoqQ
         4nbRNzmRf1NValJ935o6Kb1TnOQckuNubNDuu5/tyTnmiaYMnvKQ02fsRkHbUXS28sG9
         ZQjcT/UAmUuOghp9CgbxknQK/JZWV3oSAA/okTSskDW+E+LNju1VyxIjyiso5WQ940vk
         bC1VPLSskaTKc8FU6ZuPNRE30Qt9QR7h7dAtWQdc0Tb8O1zmr8Tzn/NHVZwzBIxVOj5V
         CtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+t9fU13Iuz/zoBPnGG3vft0C0z8m2mKCU7Saw6lmvk=;
        b=BQ3teeSuf4fpn5759FiBd45pSIZH1u1uoYy+TrQM8p59ypxg56bPOimagiVUZVE/UA
         hY4WjP7PPKsLwKcQ5GQ1UKA3Htjjdypl175RySoWYGUQfUhVK2O0YsdEWljAEY/QY/Qs
         +3iAWTlXGTBSrWvH1wYirvL+2f2XZoSj56isauZOpuCwxKXGYDnE3s7NdDgo17qxpR0C
         LxG0lvtxvAkQisZL63R0qkjQ6G4fdenl1wbGjHUkRV7Ep16OMK5Qye4PW64DI+mePFb5
         zqdQYT7wjFanC53AzKUhF3LYOPeKGEzcUDsVW5J96NSwUVZI0FyMETe52Iv3zr6B9Ax8
         oENA==
X-Gm-Message-State: ANhLgQ393t//mqnrUGL7/VRAaiqLmE72i2UtvmPsBHBYttnPbRjZhp0w
        ERm95Ypt49dDBwFQQglb+6DGwLGgYp1Txy47lDWN4g==
X-Google-Smtp-Source: ADFU+vv33qQ1Vs3CkoYzAvtrw3SpDVVFOXBI9ccyey4I0e0R2cgw4zlbjqPoifA6+u164sdMBKOHuMFJW3vErink/7Y=
X-Received: by 2002:a05:6830:57b:: with SMTP id f27mr3211846otc.363.1583946449937;
 Wed, 11 Mar 2020 10:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200227052442.22524-1-ira.weiny@intel.com> <20200305155144.GA5598@lst.de>
 <20200309170437.GA271052@iweiny-DESK2.sc.intel.com> <20200311033614.GQ1752567@magnolia>
 <20200311062952.GA11519@lst.de>
In-Reply-To: <20200311062952.GA11519@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Mar 2020 10:07:18 -0700
Message-ID: <CAPcyv4h9Xg61jk=Uq17xC6AGj9yOSAJnCaTzHcfBZwOVdRF9dw@mail.gmail.com>
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:30 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Mar 10, 2020 at 08:36:14PM -0700, Darrick J. Wong wrote:
> > 1) Leave the inode flag (FS_XFLAG_DAX) as it is, and export the S_DAX
> > status via statx.  Document that changes to FS_XFLAG_DAX do not take
> > effect immediately and that one must check statx to find out the real
> > mode.  If we choose this, I would also deprecate the dax mount option;
> > send in my mkfs.xfs patch to make it so that you can set FS_XFLAG_DAX on
> > all files at mkfs time; and we can finally lay this whole thing to rest.
> > This is the closest to what we have today.
> >
> > 2) Withdraw FS_XFLAG_DAX entirely, and let the kernel choose based on
> > usage patterns, hardware heuristics, or spiteful arbitrariness.
>
> 3) Only allow changing FS_XFLAG_DAX on directories or files that do
> not have blocks allocated to them yet, and side step all the hard
> problems.

This sounds reasonable to me.

As for deprecating the mount option, I think at a minimum it needs to
continue be accepted as an option even if it is ignored to not break
existing setups. We're currently going through the prolonged flag day
of people discovering that if they update xfsprogs they need to
specify "-m reflink=0" to mkfs.xfs. That pain seems to have only been
a road bump not a showstopper based on the bug reports I've seen. If
anything it has added helpful pressure towards getting reflink support
bumped up in the priority. Hopefully the xfs position that the dax
mount option can be ignored makes it possible to implement the same
policy on ext4, and we can just move on...

> Which of course still side steps the hard question of what it actually
> is supposed to mean..

If we have statx to indicate the effective dax-state that addresses
the pain for applications that want to account for dax in their page
cache pressure estimates, and lets FS_XFLAG_DAX not need to specify
precise semantics.
