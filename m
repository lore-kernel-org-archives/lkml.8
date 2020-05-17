Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCE7C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCCE206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrDveH5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgEQPun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 11:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgEQPum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 11:50:42 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51405C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:50:42 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id 14so991726uaq.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrqyWKwX+Fo3y6zOYpSb7pR9qyYbIYzcbk9GR/Z/Ams=;
        b=HrDveH5Pm5KAxHjik/u2RQB4xO6NSUjnWMOdvIhtxte52w5d+kAC88zVAsILxJJ/+g
         ezY/v3ndryuUXHH1OEVKpk23Sfy0Ohp7XyeB+gqobKrs4Jn/yLT6sgl9XBjXk8t2kOPq
         ag2Lbs9mYqknkLkhLQBCN4sviUplllFWTF89nUGxsTLgHQNGUCxg06E1JFteTcYFucLL
         fXELzo/ENJn1w8D3joljU5vgGzLEVSDP5aEvDMdfi7JaSQH5ncljsHaE2Yg2VOnXl6c2
         m5j/n4kFW93CzaWJmAnbA1shVlbpnqPeyT3XFDuIb+/caoFs3Z8FZyd/TxePp060kFb4
         IIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrqyWKwX+Fo3y6zOYpSb7pR9qyYbIYzcbk9GR/Z/Ams=;
        b=XgRPujcq6MYXsC/v0w5PjphKES+nJ8naIWkmsnJes3TplLzuv3lK8K8TlkvJmPQKry
         3xRfYUDJDGdJMQXY3ylKb7KRDIJtJP7kPXLsD+KTtu7HhUlmNKfZ04yY7M/Iv8M4HPMV
         7sEu+yMSqlej3XexRbUEuzT26tSuaLlZSC5/RoPnvqZsR8OESFs1QH5wZCY6Selna3cv
         Ns2920iCYjIgKUt4PWUzP4YG8+4uRXh9rrl2OoxF9xFKhwtuMfvs6VgIfMHRxIx/iMR6
         qsjiYXZJEyASNtQXDRGfTuVlHfaKGKxxzJvZjezUM2y73q2Oed5gfpLvVQmt/qSkIqeZ
         MDpg==
X-Gm-Message-State: AOAM532dbWk1gt/lx1KmdJv/HqeE0UfG79BJoqj2inY6ZXvTvJt1g4mT
        gEIBHHe2TT0keBIxcXiqTLsVJCoobyaCnRjv2V7DNQ==
X-Google-Smtp-Source: ABdhPJyQoWyrdr8ikSTKBJJeTscM2WvocE6S1h+caNwqM8ojA0qPrD7ha3T8pT3nJEE2pvYIQMJH39LyJgqMQZ5uc/4=
X-Received: by 2002:ab0:d97:: with SMTP id i23mr7457516uak.106.1589730641263;
 Sun, 17 May 2020 08:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200515105203.2792466-1-emil.l.velikov@gmail.com>
 <134d34de7e35861f33d3a1d9ffd8a70b0f92df33.camel@perches.com> <ba9cbced1ccb0e7da5593b587bb179328cecd80e.camel@perches.com>
In-Reply-To: <ba9cbced1ccb0e7da5593b587bb179328cecd80e.camel@perches.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Sun, 17 May 2020 16:47:52 +0100
Message-ID: <CACvgo51tt6v18btJAYMF01dwQ_bzvN9uyn-2Kg9iuhqJBSJ+dA@mail.gmail.com>
Subject: Re: get_maintainer.pl: unexpected behaviour for path/to//file
To:     Joe Perches <joe@perches.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 at 18:22, Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-05-15 at 05:31 -0700, Joe Perches wrote:
> > On Fri, 2020-05-15 at 11:52 +0100, Emil Velikov wrote:
> > > Hi Joe,
> > >
> > > Recently I've noticed that get_maintainer behaves differently if there
> > > is a double, sequential, forward slash in the path.
> > >
> > > AFAICT there should be no distinction between the two. Or at least many
> > > existing applications and scripts consider them one and the same.
> > >
> > > I've tried fixing this, although my perl isn't quite up-to scratch.
> > > Is this some weird bug or some intended feature?
> >
> > Not really an intended feature.
> > The code counts slashes for directory depth.
> >
> > I suppose it might be simpler to do this:
>
> Or perhaps a better alternative is:
> ---
>  scripts/get_maintainer.pl | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 6d973f3685f9..484d2fbf5921 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -19,6 +19,7 @@ my $V = '0.26';
>  use Getopt::Long qw(:config no_auto_abbrev);
>  use Cwd;
>  use File::Find;
> +use File::Spec::Functions;
>
>  my $cur_path = fastgetcwd() . '/';
>  my $lk_path = "./";
> @@ -532,6 +533,7 @@ if (!@ARGV) {
>
>  foreach my $file (@ARGV) {
>      if ($file ne "&STDIN") {
> +       $file = canonpath($file);

This seems like the better option since it also handles path traversal.
I would expect that people don't use it, yet who knows.

Thanks for the prompt fix.
-Emil
