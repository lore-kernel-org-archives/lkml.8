Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA7AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F4C20657
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 19:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="0cdTmxTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgGITKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgGITKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:10:15 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56683C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 12:10:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ga4so3415527ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2fOhJGPsa38CdJ0J83JYaoOhOOC+ex2vBW2wQq+k5E=;
        b=0cdTmxTtN7+vfGyH8NbCnBkNvIefYWEOCIlOULHgTocPWhpUR6/lquU1AM7frwbSsP
         m0CPz6J5rTWe7lN8aZ+vVp63vR/vsivRWKjx3LkEwJLq0r34vVWl/m9Q49WhadgZ1F3H
         KU9NRQV59ND/Qi7KauBOq72P8MUjWsoMmusWgGHZGn523v5N35mWFyzdl/56JJuplODT
         pfSdf5u9oVvW5ZQ52mCBlrILAgqlrxb67ULxNsl7TfzTCRiYOgrRahKlqzzros2Yy9J8
         mayfwrw298Z+elPQbmB+JqgiIwz9WvnH+WLqB2wUQdGGppNqt5U5QQyml0TSb4NO+i4p
         9YkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2fOhJGPsa38CdJ0J83JYaoOhOOC+ex2vBW2wQq+k5E=;
        b=GEzRrp/Gshk/RtUk6LwDm4S6Uuis2IcIWezLuLFjaWtpkVFSJ2JG8A1alyz5ftNZsL
         lRvG6drm8LPl8br3u20zqKQNtwXWRmDikBoqOcc3PCQRQfdBT8bq5bX9YQrhatfceFVH
         euawiHa7i+wunzJj9L+jlRUEbH3DYzifocs0A3qfa1VqFdaGlTR2KoD8DaHasKK/KjXd
         BtFXw9ps7jMdgUkuf7J4i3c8Hnx2ZVr64TOrUwAvuAc7WTcl+zHglft75uNeOYanqXpB
         S+kAsbHnjI2IQvOEqVSLkg0S5lJhWWdiItaLZD1pg/94QTpLjO0/RF8PMVB0ej0WNkfM
         qMuA==
X-Gm-Message-State: AOAM533FREeKxLlzhUSK/JE+xREz1wBKgCc9Pp/yoFUZHs4yIKR5vwCR
        v1mfS8DkR4z/Qan4GFAYduVKJUlwbkKR4cya0IJ71iBMIDE=
X-Google-Smtp-Source: ABdhPJz6e/Qh9nzMGDVNBdMj6Ao1a+kIvsOmRkQ9MF9Gyw0rlCHOGDj0lqFFJNRYxO4ZjpWCIaaHIlImKb6TqKt4bqM=
X-Received: by 2002:a17:906:f98e:: with SMTP id li14mr57482107ejb.174.1594321814142;
 Thu, 09 Jul 2020 12:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
 <5be5abc9-c2db-1f96-bc29-61cd90d985ab@suse.com>
In-Reply-To: <5be5abc9-c2db-1f96-bc29-61cd90d985ab@suse.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Jul 2020 12:10:03 -0700
Message-ID: <CAPcyv4j_c2FQa=iCFYJtyLTVXjMUFynOJ+2bw=fS3C1YSUk1ZQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v3] CodingStyle: Inclusive Terminology
To:     Matthias Brugger <mbrugger@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dave Airlie <airlied@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 2:45 AM Matthias Brugger <mbrugger@suse.com> wrote:
>
>
>
> On 08/07/2020 20:14, Dan Williams wrote:
> > Linux maintains a coding-style and its own idiomatic set of terminology.
> > Update the style guidelines to recommend replacements for the terms
> > master/slave and blacklist/whitelist.
> >
> > Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Acked-by: Dave Airlie <airlied@redhat.com>
> > Acked-by: SeongJae Park <sjpark@amazon.de>
> > Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> > Signed-off-by: Chris Mason <clm@fb.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Got it, thanks Matthias.
