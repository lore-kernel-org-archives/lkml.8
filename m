Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C397C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 01:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C947207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 01:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUDCIKGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgGIBIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 21:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgGIBIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 21:08:12 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3A3C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 18:08:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e8so453543ljb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 18:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9p8A15AqAW3/4x69j3zHQIbmUxWZ5XRdsvYgz8fpSzg=;
        b=dUDCIKGyVGWqhjw5zNvQy07diR89AtZJdj1roS3qHcCVKZ/NL61/ygPihQnA5u8FWp
         tr3Dh5Ry/EkrnbBfDiYMWQAQeJOWkgbZleGn5xGKQQ1sXwMahvkmQIxdyXIdNoZs13Yb
         LqYX88bOuQi58aH98ZrSCi6L2kAyLqvTx1uZk2tAQo/w6Xvjts2UJu8kLld0QenduLS3
         7jt7E5ygqRxZPSn3SQwqvIv862ba1GbqFAmo4WfIxQngVaYCzGXQyxxAWlNZES7Iqv3O
         B96vxCyXGaB9MjTSevPXNJl+ijP1N+oAuGg0cezmj7k4mpGznUD3xqavDvkZev8J8rNQ
         AwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9p8A15AqAW3/4x69j3zHQIbmUxWZ5XRdsvYgz8fpSzg=;
        b=kY4cukKTGrlS5ADz9n8CjIYleOaA7TX3NyD5R3mWikdBR9Wg7EVyIFpT5qd4VMvQhi
         ugzRuuyW4jTPneheE/aJeWFTZooCdtc7KovEIh/60anVJaLoPdbrSpcDMkIob9pqnTtb
         Ev/f+QSJcl7+tt6q8/5nz1q99v9G8fuzpWwhXwSWZyWKGOlh6tB32Fy4EfR1TrobnAC2
         oPZstjrH8crqgrMMhyAQvGVZct0s8zZee0xAWEA+p7EtrddjKJCq12lXqV2D0cgPAGRj
         gPQrGeZv1jGx9DhK9ks1r8zEHEVSZfO2JaO/QMRS04DNPA6HctW05Wvkl4O+9EBI17BK
         WJMA==
X-Gm-Message-State: AOAM532EVqTIu0eZv4cwF29bOudRjkCpky2248omUP5mefIpoKMf2ygp
        c+r1LvpATtc0Zy00brhAh25j6rDfMRAcnshLaO47B4BH0Zk=
X-Google-Smtp-Source: ABdhPJy26n9tOY2lSGWcseACx3qTHNw3D1259rQFhSnb/5ICl4BFpXDAaJGLWWqV735TrNAgrG2jwha97ufK1F1gJIA=
X-Received: by 2002:a2e:8954:: with SMTP id b20mr33489279ljk.262.1594256890278;
 Wed, 08 Jul 2020 18:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200703065420.3544269-1-daeho43@gmail.com> <20200703141359.GA2953162@kroah.com>
 <CACOAw_yweR--34vBXBV07xEGxGhO2r9o_XYVw6h9dMP=C6zp5Q@mail.gmail.com> <20200708100527.GA448589@kroah.com>
In-Reply-To: <20200708100527.GA448589@kroah.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 9 Jul 2020 10:07:59 +0900
Message-ID: <CACOAw_zKK7oD+w2R-0OQGFvS5EUvWWTmyWvdTJZAqrLxHH1w5Q@mail.gmail.com>
Subject: Re: [PATCH v3] f2fs: add symbolic link to kobject in sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I thought it's working for our system. But as you said, it might be
not true for others. I got your point. Partition label would be a
great idea for us.

Thank you for your comment!

2020=EB=85=84 7=EC=9B=94 8=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 7:05, Gr=
eg KH <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, Jul 06, 2020 at 08:47:07AM +0900, Daeho Jeong wrote:
> > > No Documentation/ABI/ entry for your new sysfs file/link?
> >
> > This is for adding a symbolic link to a pre-existed
> > /sys/fs/f2fs/<disk> directory and it means /sys/fs/f2fs/<mount> points
> > to /sys/fs/f2fs/<disk>. I already added the description of this in
> > Documentation/filesystems/f2fs.rst.
>
> Ok, but that's not the standard location for sysfs file documentation.
>
> > > And what does this help with?
> >
> > Some system daemons in Android access with the pre-defined sysfs entry
> > name in the json file. So whenever the project changes and the
> > partition layout is changed, we have to follow up the changes and
> > modify /sys/fs/f2fs/<disk> name in the json file accordingly.
>
> That's what partition names are for, you should never depend on a
> "random number".
>
> > This will help them access all the f2fs sysfs entries consistently
> > without requiring to know those changes.
>
> No, please use a partition name, that is the only way to always know you
> are mounting the correct partition.  You have created a random number
> here that might, or might not, change between boots depending on the
> order of the filesystem being mounted.  It is not persistant or
> deterministic at all, please do not treat it as such.
>
> > > If it's really needed, why don't we do this for all filesystem types?
> >
> > This is for the daemon to change the mode of only F2FS with the power
> > hint of Android.
>
> Again, the point is that a filesystem type is not unique, this, if
> really really needed, should be an attribute for ALL filesystem types,
> f2fs is not special here at all.
>
> Please do not rely on this number ever being the same across boots,
> because your code is such that you can not guarantee that.
>
> And again, if you really want to know the partition you are mounting
> really is the partition you think you are mounting, use the partition
> label name, that is what it is there for, and is why we have been
> relying on that for decades.  A new special per-filesystem-attribute
> that is semi-random is not the correct solution for the problem you are
> describing as far as I can determine.
>
> thanks,
>
> greg k-h
