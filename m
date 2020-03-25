Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B36FC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED0820740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WxeYWiQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgCYTnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:43:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44673 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgCYTnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:43:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id x16so3265828qts.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WhXRLeHWCC3uLvHj6QkFXcigLiU7sl1EvrP+2UphyIo=;
        b=WxeYWiQYlJp7FXNnqc3T8fkMKogqDooYJGlv91eChixvfStUViUK80270XGj/bGCLf
         HI9T3lP9cwzOsLdMAEoon5oG3vlIeHqL4doT/2TqzYLaTas04SYUZqKDVqxNufI/lVRW
         mEEumNvV7TFtN/p0l4Nv27iemj3gT+W9igrngkSZpJzcROzCUEElz7FPJs2w8ef0HaTv
         sOwNHZf9uEjIE8QMm0w0mkywjagE1Z7SZTvG0PCg/EsIT/PfAiiCi9MPv5/lhuqQ5ZR8
         W9AVneYAVCQTXMWcvBFptWaGUAqeP1ycKNzCRSwBjsMbuSFcTqbwMJIzi4Q093T3PFnx
         wBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WhXRLeHWCC3uLvHj6QkFXcigLiU7sl1EvrP+2UphyIo=;
        b=hJL73qws1mJxCLIA19AHzLRoUVyT1H+uRyUt2GHpN5VxzkHKKaSv3RVns9KYBepic/
         GYOR9p4RDKguynNNdVoQP9tzEC+zULVko1w+/d/8PtxwJopNN+yAJQKgHwOnhGEEbE67
         sxgsry+TXbS3ksN/abLA2p1UYCcPpEeMHdTjcibT5pESLpxJwKPa8Y4t67WU48KoW3uP
         V0CMdo7A2FJHPaxW+7tJvGGyUY5uWijrwZjOADmpzxr5SMcNXr8A93fwYlb0zMjTZR2S
         CBao2Ivz7YHpQTD8BjeedHAch+g7pspTevKCc9e3kvhWGoEieGyao2Bx1KkzGXBXkoat
         danw==
X-Gm-Message-State: ANhLgQ3RO+T/YRzcxkD8K9dQGJKI82tGXc83PFeSW9KPvn6GyWUTju5w
        x1b6r9RZW9+4e32wXvowL1oY4w==
X-Google-Smtp-Source: ADFU+vv7zuv6fuqpv4PKPxn/GujcUf/QIwRy+o0HN8sc9H5K2J573zl7iknDBQphPntRkIUaNv/7Jg==
X-Received: by 2002:aed:2ee1:: with SMTP id k88mr4831835qtd.268.1585165388512;
        Wed, 25 Mar 2020 12:43:08 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g3sm15894644qke.89.2020.03.25.12.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 12:43:07 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Null-ptr-deref due to "sanitized pathwalk machinery (v4)"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200325055830.GL23230@ZenIV.linux.org.uk>
Date:   Wed, 25 Mar 2020 15:43:06 -0400
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C2554121-109E-450A-965F-B8DFE2B0E528@lca.pw>
References: <4CBDE0F3-FB73-43F3-8535-6C75BA004233@lca.pw>
 <20200324214637.GI23230@ZenIV.linux.org.uk>
 <A32DAE66-ADBA-46C7-BD26-F9BA8F12BC18@lca.pw>
 <20200325021327.GJ23230@ZenIV.linux.org.uk>
 <5281297D-B66E-4A4C-9B41-D2242F6B7AE7@lca.pw>
 <20200325040359.GK23230@ZenIV.linux.org.uk>
 <20200325055830.GL23230@ZenIV.linux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 25, 2020, at 1:58 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>=20
> On Wed, Mar 25, 2020 at 04:03:59AM +0000, Al Viro wrote:
>=20
>> Lovely.  So
>> 	* we really do get NULL nd->path.dentry there; I've not misread =
the
>> trace.
>> 	* on the entry into link_path_walk() nd->path.dentry is =
non-NULL.
>> 	* *ALL* components should've been LAST_NORM ones
>> 	* not a single symlink in sight, unless the setup is rather =
unusual
>> 	* possibly not even a single mountpoint along the way (depending
>> upon the userland used)
>=20
> OK, I see one place where that could occur, but I really don't see how =
that
> could be triggered on this pathname, short of very odd symlink layout =
in
> the filesystem on the testbox.  Does the following fix your =
reproducer?
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 311e33dbac63..4082b70f32ff 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1805,6 +1805,8 @@ static const char *handle_dots(struct nameidata =
*nd, int type)
> 			error =3D step_into(nd, WALK_NOFOLLOW,
> 					 parent, inode, seq);
> 		}
> +		if (unlikely(error))
> +			return ERR_PTR(error);
>=20
> 		if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
> 			/*

Since that one has a compilation warning, I have tested this patch and =
seen no crash so far.

diff --git a/fs/namei.c b/fs/namei.c
index 311e33dbac63..73851acdbf3a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1806,6 +1806,9 @@ static const char *handle_dots(struct nameidata =
*nd, int type)
                                         parent, inode, seq);
                }
=20
+               if (unlikely(error))
+                       return error;
+
                if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
                        /*
                         * If there was a racing rename or mount along =
our=
