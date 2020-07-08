Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34319C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124F921D6C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7N5EXkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgGHIgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgGHIgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:36:45 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1915C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 01:36:45 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id w17so28516153otl.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 01:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E9OfFYHbH3ZToik4MArfMg4xPvvnpVtVORAGHHfFrzw=;
        b=a7N5EXkH5q7VpSLTWAozI5gExPwpPLyEBtcnr+2Joyigm0wqh9O962IoDSEkQkNe24
         G0b7x3cdw0AGEOwCagxOmuU2zD2rueVP3jFwJ1lbf3nWWdqZWtyp4KjV6oVZfok6JToX
         b5iZD6fEW2fOrcX3fUDiv4C44gQbHmEgFQDXN+gKgfNQoiyXhwA+X+OmAU2s1fIInzLD
         8Fc1+guNZyjLcgN0szNlMFiaHA+C8wUa8soG5hVGc84IlOyq2splKLjARL+IhmghncC1
         Bv3M94PQA+S5+1aPAntPl45rQ9Ut5fxU8s3HhGRLBtk06ZEBoz9M7eo06qvjRzHsHzTl
         8GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9OfFYHbH3ZToik4MArfMg4xPvvnpVtVORAGHHfFrzw=;
        b=Rxp0yu32Jv21Rs1CCnxLcgTzi8e/F4l8zamWoE5k0nW+4Hexw6pE9C5ebwImgqqwE+
         5K6Orhg6qe3WJkMoWQv6Ab5YBZn/kFIAPSOsKVkKFg/6rCqUGNJt3seuhyU6+Vr5MokL
         ny+MEHFEtmN7sQ//TvMxn9QkrrTkHIUWosSXOpHZ0dySUUaHgtAenICsxxskRQcRMUqr
         v+a40TvpVKQ0Xs5sLpAoyh6WZvexOLoV6gGXPjMlaJOJ5E4VoIFZJaQP7SmZ4xYshmSu
         1EVDla24wFznFGtu+I7sKGhVzT/B8Wl+hlxmpva7FWX3zOuYV9g/jGaLcSKOiOl99xq8
         Trcg==
X-Gm-Message-State: AOAM530TBQ/bGPBcE6jtm5k47SDCqYtUIMt3fscClG6cLN6D4bVLl6Ah
        XL7cX4a+8i34HmJyLY76ls7bRQ4uMVf+gsxZYto8Ww==
X-Google-Smtp-Source: ABdhPJwKsuIiJfQBK+Z2FyMDKuMkojZ6lgZ1RE3obfX6zdiVrn4CkzrMBfnMstVN4ibNoDkOfiQQ4zMF5Hlxev2KtTc=
X-Received: by 2002:a9d:6d98:: with SMTP id x24mr38406495otp.93.1594197404821;
 Wed, 08 Jul 2020 01:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200708030552.3829094-1-drosen@google.com> <20200708030552.3829094-3-drosen@google.com>
 <20200708041230.GL839@sol.localdomain>
In-Reply-To: <20200708041230.GL839@sol.localdomain>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Wed, 8 Jul 2020 01:36:33 -0700
Message-ID: <CA+PiJmQP+kJQeCZ0LFqRcN6JYWF6pAUHaTnFOThmDLtLTveOXg@mail.gmail.com>
Subject: Re: [PATCH v11 2/4] fs: Add standard casefolding support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 9:12 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jul 07, 2020 at 08:05:50PM -0700, Daniel Rosenberg wrote:
> > +/**
> > + * generic_ci_d_compare - generic d_compare implementation for casefolding filesystems
> > + * @dentry:  dentry whose name we are checking against
> > + * @len:     len of name of dentry
> > + * @str:     str pointer to name of dentry
> > + * @name:    Name to compare against
> > + *
> > + * Return: 0 if names match, 1 if mismatch, or -ERRNO
> > + */
> > +int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
> > +                       const char *str, const struct qstr *name)
> > +{
> > +     const struct dentry *parent = READ_ONCE(dentry->d_parent);
> > +     const struct inode *inode = READ_ONCE(parent->d_inode);
>
> How about calling the 'inode' variable 'dir' instead?
>
> That would help avoid confusion about what is the directory and what is a file
> in the directory.
>
> Likewise in generic_ci_d_hash().
>
> > +/**
> > + * generic_ci_d_hash - generic d_hash implementation for casefolding filesystems
> > + * @dentry:  dentry whose name we are hashing
>
> This comment for @dentry needs to be updated.
>
> It's the parent dentry, not the dentry whose name we are hashing.
>
> > + * @str:     qstr of name whose hash we should fill in
> > + *
> > + * Return: 0 if hash was successful, or -ERRNO
>
> As I mentioned on v9, this can also return 0 if the hashing was not done because
> it wants to fallback to the standard hashing.  Can you please fix the comment?
>
> > +int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
> > +{
> > +     const struct inode *inode = READ_ONCE(dentry->d_inode);
> > +     struct super_block *sb = dentry->d_sb;
> > +     const struct unicode_map *um = sb->s_encoding;
> > +     int ret = 0;
> > +
> > +     if (!inode || !needs_casefold(inode))
> > +             return 0;
> > +
> > +     ret = utf8_casefold_hash(um, dentry, str);
> > +     if (ret < 0)
> > +             goto err;
> > +
> > +     return 0;
> > +err:
> > +     if (sb_has_strict_encoding(sb))
> > +             ret = -EINVAL;
> > +     else
> > +             ret = 0;
> > +     return ret;
> > +}
>
> On v9, Gabriel suggested simplifying this to:
>
>         ret = utf8_casefold_hash(um, dentry, str);
>         if (ret < 0 && sb_has_enc_strict_mode(sb))
>                 return -EINVAL;
>         return 0;
>
> Any reason not to do that?
>
> - Eric

Guh, I remember making those changes, must've lost them in a rebase :(
I'll resend shortly.
-Daniel
