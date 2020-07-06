Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8BAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D409F2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcUxtiMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgGFBWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 21:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgGFBWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:22:46 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55BDC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 18:22:46 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id q15so11390358uap.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 18:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ot7mI3rE8jAjD74kNoJegYGYJbELkx5qd0dgbBas8es=;
        b=GcUxtiMxGvl8wS2GE6C+lmsWSXUQw8AQf/NSKL1p3VtJVrmeKfoc82XMp+axBh0bzf
         mkVipZFloJ5KoT8io5YB24zu2Acf6oXooi7JVM1fiQWxq/6rkV1yYevFVtGl/teo5puy
         Jj5qn5c3xamlXmMkCHfMgA5Hh0MQLsV5Q9wJwWde/yK6iqxv5nlnIiC7g6SDYhY+e0Iu
         +ri1UzOgcB06OJCJ++WkAy7BREAVbleJ8uwDPEaJbD5vSiC1QG+p6nuwxdUlWCW1sTT3
         /16MvFq5jve2RXWltqqsNw+1bSI2Ld0JpFjwdcntE+K0BwTclYYDmNTQcE+h0xffVj7v
         78sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ot7mI3rE8jAjD74kNoJegYGYJbELkx5qd0dgbBas8es=;
        b=EewAl6SwXL6kI0I014EkSUcx4rxa70VaHzxr9xMlzS138Hboe0+CAocm2a1gkQMp8M
         bICcAHTs25rbn62jGLrSKb5933y4Om90NjyQIItj8pPgADRmYP/m4dmIVBLjO2ozrA3c
         TIt63yWXDTnukpE3i5OjqFbaD/Hfb5QQ0Dyh3BLPF2j37Y67UiAjCQVc+L1o9B80SWFh
         ++AJ2tzpz1lWM8mfyQZ7zfu8BMruaMZMu37YQIp1B6GMOpzBZuvFXIrV7hIZ+c70Lvy9
         wDbQKsdtaopSPJ6lwboCaK+Q2xKLQdKWDmXSSjcPYHe2G4Czgcyrfgl4RCLvxuBMhfqC
         VP4A==
X-Gm-Message-State: AOAM530bNY7474jSYq4YAbj4GT8lbYNm7/a+K/p6jy9TUYSVHpYSI8hW
        PcX9oCPypPsyiznNuwwvpwQ+0le+6sQZqkil3aKwnw==
X-Google-Smtp-Source: ABdhPJze1fgFm/SUjxkhr9qN7t1RDqxRuIY/bx3OGimTF+OCWh07YUQ6wTajvgqnhg7X2J43zT9f+NW/w37YuOypucI=
X-Received: by 2002:ab0:4a46:: with SMTP id r6mr28643097uae.107.1593998565652;
 Sun, 05 Jul 2020 18:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOqywzyuiquXRRKiJh8Zc-yUg86S-Lc8UBp5-FoExxSmV1Rkng@mail.gmail.com>
In-Reply-To: <CAOqywzyuiquXRRKiJh8Zc-yUg86S-Lc8UBp5-FoExxSmV1Rkng@mail.gmail.com>
From:   Nick <niklaus.herzog@gmail.com>
Date:   Mon, 6 Jul 2020 03:22:35 +0200
Message-ID: <CAOqywzw3F8vDCuv_T5KqsxMmWL_2hLehHxBEEc3gmWo6CyDdLQ@mail.gmail.com>
Subject: Fwd: [PATCH] CodingStyle: Inclusive Terminology
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The proposal is not just! It's bloat! Not directed at the problem!
Like ISO 9001 processes which were defined, but which were
circumvented/ignored by every single employee, for god reasons.

If the coding style document would explicite state function, names and
identifiers should be descriptive (it states this for helper
functions) the terms blacklist, master, slave would not be viable
names for anything in the kernel. Most Likely every racist wording
would be similarly excludend.
ie. black has descriptive proportion in coding/technical context, at
this point it's neither functional nor descriptive to the function a
list is used in. Same goes for master, slave and most likely every
racist connoted term.

Reference to african slavery denotes any other racist
behavior/background, which is racist itself.

So I would suggest,

1. to make a clear definition of how function, names and identifiers
should be formed.
so explicite promote the current "short descriptive functional terminology".
As far as I understand that is what linux implicitly expects today anyway.
This would make it easier for greenhorns like me to start contributing.

2.It could help to try to understand the coding style document, trying
to ignore any previous knowledge of linux programming. To my
understanding some paragraphs swallow half of the content.

3. make the maintainers reject every patch not conforming these rules,
except where it is needed for legacy/standard purpose.

4. explain just this is introduced to move away from inconsiderate
conoted racism terms. (1-2 sentence, IMHO) The rest belongs to COC.
The current draft focused to african american slavery is ill fated.
