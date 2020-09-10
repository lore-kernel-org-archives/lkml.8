Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5DEC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA3A21556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599765563;
	bh=TSKwsi8B2WtCjIB+WVC7Mp9PvIBMFdLC+XMZ086OmBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xhTlGMtDoia5EycwcwB9pomienL3RVF626MjV/G79GHg9c6bj4fBdvvlrAIryDGPY
	 gQVWVpnF7b+MgQqS8XrcnA3yoDBn/T4JCeWetcARRZdH0tOKO6hsUE/UWllFFS4Ynm
	 vGzqXNZYlK5ln14LHVMMzE4zHpWAiKPcNoIxdAgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgIJTTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgIJTS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:18:57 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C2FC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:18:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so9684439ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=etC4N6qn30eFLor95FeZmB4oX9yZOoS1Dpapxtt3pvQ=;
        b=N/0WNm5/4giWTWDefLeUsfFNKp1JHAG/ai3snfAZ5vptNE0pWqEgGwtfAppqq8TfH9
         MG28lGOFhMEd1bq0igXIr6UmZhklDeAiosJfg12oK9l6jqBBqlDvssJ4sgJu/R0TZT+Y
         UvVlc43GfFu4XHK+zLnDLQGRhZYMLvnz5gDVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=etC4N6qn30eFLor95FeZmB4oX9yZOoS1Dpapxtt3pvQ=;
        b=RlFlskMOde1kFnShxlZx29+ioOXfi4Ft4AR68mYbN7lhqlVvLDFjtSzr7I6u4fCcq6
         pbNWCnoe0maYb93aMjm/PHrPnfTIoIIw/heicXUaNU8sLR05xrGCKllSmuThaRv03QE+
         2B+2/RkXw3y6TucVl7rBbJV4osZHhHhqcC1ZoYje8qGMgYs2GOFwvaoB6Bk+NZOkHLKJ
         A+KwcKghLWLGk3U43huM3YOmwOvZq01kidsiUSIF1UD3ynYD9C9cHJQ0Oij0zbqFNRVy
         HE2kMUVfop06ai3GkzPUPiPKoIiz0j9tx4lMNQO+CinwzfmU7mH5qBJqgwl7ofnACeVN
         lkVg==
X-Gm-Message-State: AOAM5306ZNsEivXN1TY0cAov4BdKtmZdWBkeNbwJUA2QuKUEFqlX9Lx8
        Y6VDGK9QCmR1cievq0yvQREmEzpXYonxgw==
X-Google-Smtp-Source: ABdhPJzEtHv31bLu/psmcqLWvxKFKrfLl5l3shX7gknyeDM47UJR8joFClx87sX3EaiuSAtZqNhGEg==
X-Received: by 2002:a2e:a16e:: with SMTP id u14mr5765116ljl.464.1599765534553;
        Thu, 10 Sep 2020 12:18:54 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id l82sm1551474lfd.58.2020.09.10.12.18.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 12:18:53 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id r24so9699309ljm.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:18:53 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr5057221lju.102.1599765533101;
 Thu, 10 Sep 2020 12:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200904155808.4997-1-leon@kernel.org> <6fac3754-f8db-85f5-bdb1-b4c8e7ccc046@linux.ibm.com>
In-Reply-To: <6fac3754-f8db-85f5-bdb1-b4c8e7ccc046@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Sep 2020 12:18:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6R-yQwZBBWB8EqQ1QWJGQe5njuGwax-HJtTUGsc5LxQ@mail.gmail.com>
Message-ID: <CAHk-=wg6R-yQwZBBWB8EqQ1QWJGQe5njuGwax-HJtTUGsc5LxQ@mail.gmail.com>
Subject: Re: [PATCH -rc v1] gcov: Disable gcov build with GCC 10
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 5:52 AM Peter Oberparleiter
<oberpar@linux.ibm.com> wrote:
>
> Fix this by updating the in-kernel GCOV_COUNTERS value. Also re-enable
> config GCOV_KERNEL for use with GCC 10.

Lovely.

Is there some way we could see this value automatically, or at least
have a check for it? Right now it's that _very_ magical number that
depends on a gcc version in odd and undocumented ways..

IOW - I'm assuming user space gcov infrastructure finds this number
some way, and wondering if we couldn't do the same?

Or is the gcov tool itself just doing the same kind of thing, and
having magic numbers?

I get the feeling that somebody who knows gcov would go "You are just
doing this all completely incorrectly, you should do XYZ" when they
see that GCOV_COUNTERS thing.

Maybe just a script that finds the right header file in the gcc
installation and extracts it from there, if only to verify the magic
number that we have?

               Linus
