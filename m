Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCFAC47257
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E7820746
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 00:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589070921;
	bh=PwuG6ZEMO22R/K53vfhZWC0b/2lVjNtOZJwj9wy81hk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xsMmlqMz955uVkNBFNEVPWTU/LGah56QAS6OdU8ftPlhIwOJJC9jmgc43os5TD6mD
	 esfCx7lEK4LixExtUFEJJtjuSBL/1iZMgXagP3hreDdX9WJ+/Ua6ldPw3T6MWcgU5u
	 srEHn35Wy1s1WYAy6c1vu1b0j7xUkzXxCpFpKdZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgEJAfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 20:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726565AbgEJAfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 20:35:18 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24229C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 17:35:17 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 8so1728397lfp.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 17:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIj/ulxXwzU/BqtApM64/L2H6IYW1Xqha2rgujJnuic=;
        b=Aez2jDWnaE+fKs120oJmZNtlhpcevhENgd0OPCPE0bHJG0TM/MRk9jV+wNWJnjXJA5
         a09lBbGbqV9CDMms8Dz3aPk7F/35NlYffAlgkn2Lm8eNUR6J4a45CxXKCYWrDB/qoFWi
         X+n0JsxmOsUR3H+tSwTVkoukFukm9n+4MgXNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIj/ulxXwzU/BqtApM64/L2H6IYW1Xqha2rgujJnuic=;
        b=WAkgyWOx7WwlTDvNCUhRlScCZhJj096iFojbTuFEkal1dfVDmg1TDBr1TJBa1I0MUy
         X8Lj55dW4X36YlOzfs3ez0OK/54qqKtMNusSJPGoWJNKAGvBsJlI6Kk3xPu8dbCKsGP9
         Ld4X7wG2vcWERE0piXPOJQPMle6XjH4v5zei2RQAk+RqQX0RQsMnPsyxgNzFPOr6zN/a
         aMolf94ssKCm0kUe12YUKrLfTRDO4ifepltJ8riV54d/cf1oxpr0I7HuhDGTyzO5nVee
         vjVp/sybanlt7oWAOuc6U+gKCHWWGpIK+LIzFh23PvjpcdHOqogW7wnSMSvE57pR/5wG
         JYBQ==
X-Gm-Message-State: AOAM531LIMu9YyEmIZBaqHFv+fOqowYjk6H6YtVLjNeunalvETbwHZoc
        G81X87jh0BxMS1f++WI66unhLGxhc/M=
X-Google-Smtp-Source: ABdhPJx4PykXQlD9ifOFScL6knDG4k8pRN69w1bfVrTejfeoBPk5ZzbWmbMb7+6JSdsiTBiSkxqiyQ==
X-Received: by 2002:ac2:46c1:: with SMTP id p1mr5999306lfo.25.1589070915328;
        Sat, 09 May 2020 17:35:15 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r3sm5473529lfm.52.2020.05.09.17.35.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 17:35:14 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id a21so5594525ljj.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 17:35:14 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr6018733lji.201.1589070913812;
 Sat, 09 May 2020 17:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
In-Reply-To: <20200509234124.GM23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 17:34:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiC+LzLX0NGQQdD+J0Q2LUMhMyA4kWPghMVq+AmU--w4Q@mail.gmail.com>
Message-ID: <CAHk-=wiC+LzLX0NGQQdD+J0Q2LUMhMyA4kWPghMVq+AmU--w4Q@mail.gmail.com>
Subject: Re: [PATCHES] uaccess simple access_ok() removals
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 4:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Individual patches in followups; if nobody screams - into #for-next
> it goes...

Looks fine to me, although I only read your commit logs, I didn't
verify that what you stated was actually true (ie the whole "only used
for xyz" parts).

But I'll take your word for it. Particularly the double-underscore
versions are getting rare (and presumably some of the other branches
you have make it rarer still).

               Linus
