Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCBDC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 23:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2492098B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 23:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ4+ifh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgH3Xms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 19:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgH3Xmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 19:42:47 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F7EC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 16:42:46 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u27so1100456lfm.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 16:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bWS0GjtZyrC4e/cHEJSl78RSsFz3+ulIrv6l2lk/Cqs=;
        b=OJ4+ifh6RrIAdM0iJ9Tn/HLFL2d6gFth1jit1w5ol+Km0GmNIGfurjWsGWO/+HCVHP
         6Cn2yo7popsZNUQWNsACuea6qHM9eS5a0DVKv1Fozj/s/AZRsiFqwMxp3X1q1VSvIDzT
         VIl2ZlLRe/IqcT+lEkdXheUAIzGIe+fTBRHiG7wqMhB/SckWPONwVG5xX9nFMgovNEMX
         LLd4xl/FfUPNsvkq2y2S1e3Nj+P0F+pPIDn+uQEP119LSbzS8f4Q152lxgIuV1hbAv4y
         /+8CoX9ZcfReFYbauClXnH8Oi1505TNSNWsmfCuuXE+PLEMIfu+iFZMED2YoOnPNNoLs
         3Llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bWS0GjtZyrC4e/cHEJSl78RSsFz3+ulIrv6l2lk/Cqs=;
        b=mUzUhmQdyvMEPB38GhCjeR3qAt8kFrNY9MGP9BzegX1OydB8i8CcSoOepl2wr99t2f
         yD1oYUSbGeHSGmvRg5yZvLOSvm6XpLbbUKJVhuoyjpXqaSI7MqsI5A49/wJ1Lop+ufgs
         YbKMBTa5siXIyQ9dIi/xsliWnBuPyUf2q7KcDdSjU5Z/XTXUE/fFlt+5JlThjGcqcQFB
         0oXhkIJ+jsDTOMXvWH6TQDC9LbeVk3PDi6CfAMA0FgTOY5PLVBtd+mB8vmtXhQo8lI5A
         yXCObWvPamdB3rc6e7iKx+6AB2RJOk/ur7U6+27K1LHnjV/n39lKzyZvJHRSUTZnqpX0
         GaCQ==
X-Gm-Message-State: AOAM530kCi2Q+P9DIZJ8R8VkLFyQgiMfkjsy6+XUBipxVEBHKfmEtHCv
        MC4D/S8CpQ9PY5CYe1MOXeKO0Y332qIrROzET3Y=
X-Google-Smtp-Source: ABdhPJxYC1J1xEavzSubTLHRIY9YB71znE7pzD5QiWoim97lQEAZA2ULsHdGSYHuORknu9t5BPKvIPyHzUKYgIFaO0A=
X-Received: by 2002:a19:ae0a:: with SMTP id f10mr4294068lfc.100.1598830964648;
 Sun, 30 Aug 2020 16:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200828054629.583577-1-daeho43@gmail.com> <61996dcd-6db1-13fc-8239-7e684f3ec49e@kernel.org>
In-Reply-To: <61996dcd-6db1-13fc-8239-7e684f3ec49e@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 31 Aug 2020 08:42:33 +0900
Message-ID: <CACOAw_wc29AROzFhcGyC73i_vYZC1NmHP60uQfP7X-j6y6=kSA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent compressed file from being
 disabled after releasing cblocks
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

Do you have any reason not to put this check here?
If we do this check outside of here, we definitely make a mistake
sooner or later.

2020=EB=85=84 8=EC=9B=94 30=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 12:24, =
Chao Yu <chao@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2020-8-28 13:46, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > After releasing cblocks, the compressed file can be accidentally
> > disabled in compression mode, since it has zero cblocks. As we are
> > using IMMUTABLE flag to present released cblocks state, we can add
> > IMMUTABLE state check when considering the compressed file disabling.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  fs/f2fs/f2fs.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 02811ce15059..14d30740ba03 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3936,6 +3936,8 @@ static inline u64 f2fs_disable_compressed_file(st=
ruct inode *inode)
> >       if (!f2fs_compressed_file(inode))
> >               return 0;
> >       if (S_ISREG(inode->i_mode)) {
> > +             if (IS_IMMUTABLE(inode))
> > +                     return 1;
>
> It looks most of callers are from ioctl, should we add immutable check in=
 f2fs
> ioctl interfaces if necessary? or I missed existed check.
>
> Thanks,
>
> >               if (get_dirty_pages(inode))
> >                       return 1;
> >               if (fi->i_compr_blocks)
> >
