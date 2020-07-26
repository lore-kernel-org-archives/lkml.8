Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03217C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE43620658
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRxGc1i8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgGZHSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 03:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGZHSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:18:43 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A3EC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 00:18:42 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c2so4018729edx.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=dGLXeS+mWxlsBAgmtS63GbHT1JEHLZixt8KiUN2D+Zw=;
        b=kRxGc1i81mY9PFMZHTnQziDbWphp3L3fadHixCBO+qIr3lzaIHr2hOiBomnO6FBUG4
         GmPJOPPSFTV5c0wiEf6349D86Bv8p6AwsmIApVUJnRI2lHWn6klMGve7xA7DUnGa2uxE
         bgYYA/wCPNDaEVC04c/LMrz6z44wlXD0D0ljN6Y8M9mL3lecZi/czdXq5uMgNj9cyE5v
         pEMH/QRdtlqjjBcRh0bGPPzFzy8c0jBdgPpfk/QozGaGwlHx/ndhZVE9jaIuwqr3bT8Y
         Soz29401uQl/8kZCMot0HqzQSrkA22bD58BNIolp5LaSBF6ma97JwFaCf2ipLJgJLE8X
         agkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=dGLXeS+mWxlsBAgmtS63GbHT1JEHLZixt8KiUN2D+Zw=;
        b=cxQ7a8YaTwRYAll0f1hwo23NnAQqgO/A5Cr1EvDhFohNqmOAuBoOLye6m6ClsfWwBD
         zc0zNVNLanrQJRpXIwtI0defpxVfXR72+k1hpfmtmu6+ViOvUqBJhxpuSQQhH+OLqpTy
         b6h/VMKxnQV2tC9XIZ/yEMMsAN8PW4vzO54x/fM2lkOzQQGb+aThohDw9N6L+U2Fd1ip
         00jGWY0ugsCyjVvXgGNoSu/Z3CyHCEAO3dYIpFBFyP8+P2XKRrGvhKtsjMEOSCi5g01C
         RxC1UarC9rLpWs9NkzotjIhFoXy4xT6yz3PXnBV6c62Ry921DRPMHvgZnEOAny0SwZRZ
         3J0w==
X-Gm-Message-State: AOAM532v7AvodKacHU9Tj4GwZFBsYu9u6P4BSgrLEb/g5xfoN/G6SD0d
        HGXqx/4fHNkBL3BfGIUwTLI=
X-Google-Smtp-Source: ABdhPJxYiYvJxWJ5OH7wlS9/lNrD/aCd2Q3jPf2hxfvh1gtCtwriAL4HusUOUFV6Cn4qmYAAlayqxg==
X-Received: by 2002:aa7:d353:: with SMTP id m19mr15656268edr.75.1595747921490;
        Sun, 26 Jul 2020 00:18:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:60d3:6c2f:f9ba:e713])
        by smtp.gmail.com with ESMTPSA id c7sm3542439ejr.77.2020.07.26.00.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 00:18:40 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        "SeongJae Park" <sjpark@amazon.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        colin.king@canonical.com, jslaby@suse.cz, pavel@ucw.cz,
        "SeongJae Park" <sjpark@amazon.de>
Subject: Re: Re: Re: checkpatch: support deprecated terms checking
Date:   Sun, 26 Jul 2020 09:18:25 +0200
Message-Id: <20200726071825.22532-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <6d88f6b08442b064062449c6379aa7d3b9b68ff0.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 21:27:07 -0700 Joe Perches <joe@perches.com> wrote:

> On Sun, 2020-07-26 at 01:35 +0200, SeongJae Park wrote:
> > On Sat, 25 Jul 2020 10:29:23 -0700 Joe Perches <joe@perches.com> wrote:
> > 
> > > On Sat, 2020-07-25 at 15:02 +0200, Michał Mirosław wrote:
> > > > Hello,
> > > > 
> > > > I see that this patch went into next and is already inciting people to
> > > > do wrong things [1]. Can you please fix it to require '--subjective'
> > > > switch or otherwise mark it clearly as suggestion-only?
> > > > 
> > > > The coding-style as in Linus' master says about *NEW* uses of the words
> > > > listed (those introductions I expect to be actually rare) and not about
> > > > existing use in the code or industry. Making a noise about all uses
> > > > found surely will generate a lot more irrelevant patches.
> > > > 
> > > > [1] https://www.spinics.net/lists/linux-tegra/msg51849.html
> > > 
> > > And if not reverted, perhaps do not check existing files
> > > at all but only check patches and change the message to
> > > show only suggestions not from a specification.
> > 
> > Agreed for this case.  However, excluding existing file check doesn't fully
> > avoid this problem.  Also, more terms having different deprecation rules might
> > be added in future.  How about allowing file check but show reference in the
> > suggestion message as below?
> 
> The general problem is that drivers/staging, net/ and drivers/net
> all have --strict on by default.
> 
> Emitting these deprecated terms messages with -f --file uses for
> files in those directories isn't a great idea.

Thank you for kindly explaining your concenrs in detail.  However, I think it's
ok to do this check even without '--strict' for files if we explicitly says
it's suggestion only, as Michal said.  My patch does so.

> 
> > diff --git a/scripts/deprecated_terms.txt b/scripts/deprecated_terms.txt
> []
> > @@ -3,8 +3,10 @@
> >  # The format of each line is:
> >  # deprecated||suggested
> >  #
> > +# If special rules are applied on the terms, please comment those.
> 
> Disagree.  Comments about these existing uses aren't helpful.

Sorry, I don't understand your point here.  Why do you think it's not helpful?
If 'checkpatch' finds the deprecated terms, it will ask people to read this
file, which explains special rules for each of the deprecations if exists.  The
rule is, in the case of 'slave', 'applies to new uses only'.  Therefore, people
could stop sending the noisy unnecessary patches to the maintainers.


Thanks,
SeongJae Park

> 
> > +#
> > +# Refer to "4) Naming" section of Documentation/process/coding-style.rst for
> > +# below three terms.
> >  blacklist||(denylist|blocklist)
> > -# For other alternatives of 'slave', Please refer to
> > -# Documentation/process/coding-style.rst
> >  slave||(secondary|target|...)
> >  whitelist||(allowlist|passlist)
> 
