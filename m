Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DD6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 00:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D182078D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 00:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="2Mz9RlRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHRAjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 20:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgHRAjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 20:39:09 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9AAC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:39:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t10so19978181ejs.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJPXrsCipqi0H0PMMRI1mohpgVa4NcRS8gKWHziQUus=;
        b=2Mz9RlRkj29ledDMtSWh51eLVitvz0DsI0HaqJpwfCtxuH9I/GzqIVZd7NF8tELvC8
         yAA+JT3UTuVemnDfMtUk5SNXzLty3O2c75k9cDxf5uvz9Y7s0u0lCWl4nJxE9R6nMbY1
         c5OJg2MHD7+Mp6Tq1x3nii/KjvBvEoc4HuhJJavue27MB8A1A5SiXqEw5/9xlPdpNyby
         ksSlV5KeDuRRcZ1R6HEIhGjfGKC9UTkVPKUW9HihAaDMLhdOUzvRROQY0xHBQQYvrMpB
         C7OCNxAXkz1r1caQNf1B2oDR2Gx9Yzdlm6rcjTqnRS20DHQN9LXtv2DuFeEAxe1OWYMo
         Zqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJPXrsCipqi0H0PMMRI1mohpgVa4NcRS8gKWHziQUus=;
        b=R0p5aioLsKrIV3Ac7fPcyYChObeu7o2FTlVYDnTvb9QYboKnmsd7c5T1lz+dExG4aS
         LbutQZczis0gCDs6qcbYWiQDOMJOYMSPXm5gCTKidKYm8A0jxes3QpIT6OyxRvRbeatB
         Ol8TMUMwQOGG5iL+XjnX9xs8VDNrR9x/tivwWTS1tYv8otMX47I5TMYYbZuPohINITKb
         OCGLC0My6ckppevVYH6tf4PMQD6dUESd9jIycaijfezOO8whhJFGvjzlPtsDgZPefzsm
         dkRrY/iwSbJynoB8wmM6DKEqDG+OhR7K0e82svq2avikIRKPl45XnqBzN95UZhOds/7P
         HGjg==
X-Gm-Message-State: AOAM5339ugbJH7RnTumyIeClWAYdB7vTwXtA2yludFkFzcMWbSqPbmhn
        AvBgnGF9vrY7C4cJ+Oe2nWxzSakFG4jzB/bvTo8O
X-Google-Smtp-Source: ABdhPJyrTNshDf16Hm284AG1Fr2Wyi4JN3NzpZBgdhKWzY01mT51/NxdVP/rC0P8NQyveTJxxGdcT8E4RwMnm9plb1A=
X-Received: by 2002:a17:906:7c86:: with SMTP id w6mr17381043ejo.178.1597711148230;
 Mon, 17 Aug 2020 17:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200803123439.83400-1-jbi.octave@gmail.com> <20200803123439.83400-3-jbi.octave@gmail.com>
 <CAHC9VhQA0JZNLZbfUUecrTbMvnD3S7sRMOAoW5eeeK-jpZeEWw@mail.gmail.com>
In-Reply-To: <CAHC9VhQA0JZNLZbfUUecrTbMvnD3S7sRMOAoW5eeeK-jpZeEWw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Aug 2020 20:38:57 -0400
Message-ID: <CAHC9VhQqD52AzrYghidj+Bj9eMpFOZSxZxXw7rYPGa5U59xB+Q@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] audit: uninitialize variable audit_sig_sid
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        "moderated list:AUDIT SUBSYSTEM" <linux-audit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 2:35 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Aug 3, 2020 at 8:35 AM Jules Irenge <jbi.octave@gmail.com> wrote:
> >
> > Checkpatch tool reports
> >
> > "ERROR: do not initialise globals/statics to 0"
> >
> > To fix this, audit_sig_sid is uninitialized
> > As this is stored in the .bss section,
> > the compiler can initialize the variable automatically.
> >
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > ---
> >  kernel/audit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Similar to patch 1/2, this will need to wait until after the merge
> window closes.

... also merged this patch into audit/next.  Thanks again.

-- 
paul moore
www.paul-moore.com
