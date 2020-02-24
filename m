Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCC4C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E4820714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hR91BNo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgBXP2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:28:54 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37866 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgBXP2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:28:53 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so10639710ioc.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPLy+I1kf18awADSJ+a+kXYkss5ko3QnxlgaP18iAaI=;
        b=hR91BNo0v9W2lKGsQ+28dV2f5cukj0J5Cq2WtUwQzy8DbroeQONE8wkNp/8DXGAj0b
         wS2gR97Spg4fao+tg+p7ub4Y30ipXiXecLYvggLQhPDsYbVIzad1QzrJYKXyFNitudhw
         elclO4ETUa54GEeb88QHzma/x6byZ9ENFz9rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPLy+I1kf18awADSJ+a+kXYkss5ko3QnxlgaP18iAaI=;
        b=ss1dhZQYcITWHpuBTMl4zJdreQHyQTcyyYjAL3s86Qm9SxhcXOfbRlbxrUU26cWMQD
         GRemaq6XWV45LVjMoob+EMdGt/p45w1LvsHMVC7tPr1dRXbhtjdAeNukex0wzZ6RyNoK
         PqEbimJktXT7Uod+jvhN4klVeROhUsZs6G+FLFc+hXYP8RHcSd9aqHXf6hj5lhM3eONz
         56XH7fE5ujd2mRLSmSbCepz5G2ZT2YI/43fJQJTpM9sd6KG6qplEb6HigJy+rtp850la
         cNIVnLO2JgHCOxVYdlMGWe6jHA1YzxDnE1bzmiJo32WbuIbH2f2oYLggjMHk0/77B4gG
         VvOw==
X-Gm-Message-State: APjAAAVHSD0UBKjq3NHpwILrteGIK/OMjzMkFl/bCHfuptpIWVBMrm4o
        zVwS87LuCXEfjsA9NHsZauczP9fW/AN3w5udkAKhYw==
X-Google-Smtp-Source: APXvYqyvNJZ5VSWFSREvni1YMdamiTezkJiBrYDHxTOY/6jEk+6CRYsk62v8jxoGiT8VHnrEWrOj1S3gMbDf4tiBSQw=
X-Received: by 2002:a02:cc59:: with SMTP id i25mr50551851jaq.78.1582558131274;
 Mon, 24 Feb 2020 07:28:51 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com> <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com>
In-Reply-To: <1582556135.3384.4.camel@HansenPartnership.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 24 Feb 2020 16:28:40 +0100
Message-ID: <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 3:55 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:

> Once it's table driven, certainly a sysfs directory becomes possible.
> The problem with ST_DEV is filesystems like btrfs and xfs that may have
> multiple devices.

For XFS there's always  a single sb->s_dev though, that's what st_dev
will be set to on all files.

Btrfs subvolume is sort of a lightweight superblock, so basically all
such st_dev's are aliases of the same master superblock.  So lookup of
all subvolume st_dev's could result in referencing the same underlying
struct super_block (just like /proc/$PID will reference the same
underlying task group regardless of which of the task group member's
PID is used).

Having this info in sysfs would spare us a number of issues that a set
of new syscalls would bring.  The question is, would that be enough,
or is there a reason that sysfs can't be used to present the various
filesystem related information that fsinfo is supposed to present?

Thanks,
Miklos
