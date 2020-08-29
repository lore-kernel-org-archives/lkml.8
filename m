Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9AFC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA66120776
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 21:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=platform.sh header.i=@platform.sh header.b="D96vbXFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgH2VXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 17:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgH2VXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 17:23:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C23BC061575
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 14:23:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so744081wrx.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platform.sh; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ppGohWWgfwqUfo5zDayq1wyLsm/5ZkmhZaLeovyZyM8=;
        b=D96vbXFu8elXnCds9Cw8rs4lqNaEM9sdVJUKMoaFHfTZnXh2SfjIzntCkXMucqrxk1
         PkuBKek485pYQiVhMKkcdCYPBoYex+kaSBojdCBmirKn9dS032a/93JihqNtbRYHmUdw
         XkxzPw1wi7Ggcnl1X/B5UbogjWLiEc5T8ldfGbtyjaTnofzE/si6oSFt1BX/fIvJAvMu
         Yy17jw0E6IEzCPRkVXfiVvpTszcMsHvm98PNQvOe1bmTrrdP7UPKu6KSJ2kCLuojZNLT
         62UsiZQOsweF/TerFFQ+wYZEKxtqHFH2Ur/BJ4TS3Do1sHd/wfp+DSWQYRNc2BSq72sh
         s4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ppGohWWgfwqUfo5zDayq1wyLsm/5ZkmhZaLeovyZyM8=;
        b=gKbla3sDDzgjR4tw05zlc46B+cm7WpP8duBuhrc3237dLZ9uc5lKzT5XjULmO9O7td
         /xxM+cZwov7xsZQSQI7OT0sJfNDNtat2VKKMqE640DzOMyY/pOjZ4FWczLN5CypGWRuE
         lld/AJyAbzd8uuHcVsvgxszIiPS2lbuXH52o1EV8M6010+zqLMB+zj6b6xW6wIQY7af7
         HaDw+Ks8ooLfDAh8CbZdqj8zu/IWhR6gAAUYJm6yn9BKKP1jMoEYVpsIQNgN+LdtCpVS
         82jP+CBt+2peVtizy/XFShcPDrGXzzhrHXgzg7nX9IruCfmzcVktRaCW48ozZaoCAY71
         9ymw==
X-Gm-Message-State: AOAM5338JsX6QkvWQ0WJ09S3CE2OBq2E+Ku6YX6f9Ex5yhXaor7FwX1V
        wnOU0dhB5LEHJSROWlZSzbMQvw==
X-Google-Smtp-Source: ABdhPJzk6ac/aUBzIVdCprN5ZOi+VNXlWzF0vSsb1fxKHpmLZT6lTmBU/1UOE2f2aRNnJMWXBMe60g==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr4831289wrt.159.1598736217915;
        Sat, 29 Aug 2020 14:23:37 -0700 (PDT)
Received: from localhost ([2a01:cb1c:111:4a00:dec6:dcf6:5621:172d])
        by smtp.gmail.com with ESMTPSA id z6sm4692095wml.41.2020.08.29.14.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 14:23:36 -0700 (PDT)
From:   Florian Margaine <florian@platform.sh>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: allow do_renameat2() over bind mounts of the same filesystem.
In-Reply-To: <20200828213445.GM1236603@ZenIV.linux.org.uk>
References: <871rjqh5bw.fsf@platform.sh> <20200828213445.GM1236603@ZenIV.linux.org.uk>
Date:   Sat, 29 Aug 2020 23:23:34 +0200
Message-ID: <87wo1hf8o9.fsf@platform.sh>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Fri, Aug 28, 2020 at 10:40:35PM +0200, Florian Margaine wrote:
>> There's currently this seemingly unnecessary limitation that rename()
>> cannot work over bind mounts of the same filesystem,
>
> ... is absolutely deliberate - that's how you set a boundary in the
> tree, preventing both links and renames across it.

Sorry, I'm not not sure I understand what you're saying.

As I understand it, the tree is the superblock there, not the mount. As
in, the dentries are relative to the superblock, and the mountpoint is
no more than a pointer to a superblock's dentry.

In addition, I noticed this snippet in fs/read_write.c:

    /*
     * FICLONE/FICLONERANGE ioctls enforce that src and dest files are on
     * the same mount. Practically, they only need to be on the same file
     * system.
     */
    if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
        return -EXDEV;

Which seems to confirm my understanding.

What am I getting wrong there?

>
> Incidentally, doing that would have fun effects for anyone with current
> directory inside the subtree you'd moved - try and see.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEWcDV2nrrM20UJL9WhD9tdT2UlyoFAl9Kx1YACgkQhD9tdT2U
lyr2Nwf8CQNwOqiIZx8OAU9rZqBJYxEEzzlQQerLkXwN52m7knmN1M6UibLeODFf
qmJiVA+pYOQ3JgwfzQYZJ1Asja1HnczqrHCWF6wztFYhLK1c3yEG4wARCqWIKanw
OiAt6hqlpeJNGHOBU9RlxtVerCyfzoPBCYq8lhhKM4b7DPrciVPT6kON562z5Dqm
YbvLX2aEis17VmMg1/o7U/R8hDOlll6+nhLkOBTH+6lCccYLQ/tK02Ar7DH+Ct94
YmyyaWC40DcRXTUzjnoDdEKwt2mPHsdtNWTTKxB3T6csGotzNnAsUFlLAvHOwBAV
FsYmbATtmMCzXi662PvrmzkMT6Y9dg==
=MLmB
-----END PGP SIGNATURE-----
--=-=-=--
