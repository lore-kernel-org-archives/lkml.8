Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EF1C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3912206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UhUw4kZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgBKRah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:30:37 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42068 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgBKRag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:30:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so5802787pfz.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 09:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bM2xQLURwsdpapQPw/vmgOLzWTtBkTWZo2XFKd2Fc+8=;
        b=UhUw4kZ1K/iv8XUFtbPsZE67iNVKeF3gHIfx4luTMSun/AiazJMw/EhJEbjEDMBGmB
         IqkfDnBx6ZhCodlj5vim1mqgXSqx4dtTLeAMl1sHlPvPJrMFH+QjPQbnAhl8DRqzyE+0
         bIMARUOacrDFUrqJe0XAE5Yej6WjDvGozDQToeELMtee1XjWWUOfbZdtE8RuI4cMQYMh
         FSa1l1RbZdqAagpgEPYEpj3R5jY8Jt77f+SHxdbtFHupODk8rpqr6dsAe2WScGXupCO4
         N4eiUMj6bxYgriLnjs33AThtA8d9tFc2NTnxxuziVV0X7UnODYSuSEAmeh8e8uSnsF0U
         xyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bM2xQLURwsdpapQPw/vmgOLzWTtBkTWZo2XFKd2Fc+8=;
        b=uCxO23p1CPWX7Nrr7EFc+yEpLHyP6eKzPs/3nwwnA+dlfvB64RP5TwYHgrUQDY9HJx
         EmZRJjTbkMraaHvayq8hjwNlxbU3YNqURNPBLpIOG4ZKwKyPnsNJIw/5/aVWjsdvZbLW
         uxwajOpIWFdgbOVK431ZnPz23ZIaO9DMqYMT6uKEQc+atMFE97AL5uiCIeZro80J9QJg
         +Fo790Rq1FQjxt9i2t9iJkj/zYz6hNlvlNSIA7v9u71X3dZoVuCABkQJkJmkdAXaE45S
         wO7jSxpwL5SzLUna79OKOOPRDTEahiFclqDDBV5yGqLwgoAEfVK1A7A9HzXkaseVw5q7
         5z4w==
X-Gm-Message-State: APjAAAVhR0YPwPLONlDshlqfBllewmG/A+3wElUv9+GKfSLmB1GZRpJG
        t4rDb6aCkaZurwpeZN5OWn0n6VsFIdB9xOZlhBOZCA==
X-Google-Smtp-Source: APXvYqx1sbmFj+6yubaRWA1F7s2PkQxLnUx1wxZkhe3GdVuGxqkwu5RKJGr9IlPthyKETEuHKtKYLUWWHfSwkJVG48Y=
X-Received: by 2002:a63:64c5:: with SMTP id y188mr7815807pgb.10.1581442235797;
 Tue, 11 Feb 2020 09:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20200208140858.47970-1-natechancellor@gmail.com> <your-ad-here.call-01581426728-ext-3459@work.hours>
In-Reply-To: <your-ad-here.call-01581426728-ext-3459@work.hours>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Feb 2020 17:30:24 +0000
Message-ID: <CAKwvOd=CWKnrY_T8vP4a-KXkz-V57dFqk+6FC_krm=pVAVibyg@mail.gmail.com>
Subject: Re: [PATCH] s390/time: Fix clk type in get_tod_clock
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 5:12 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
> Applied, thanks.

Hi Vasily, is this the expected tree+branch that the patch will be
pushed to? (I'm trying to track when+where our patches land).
https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=fixes

-- 
Thanks,
~Nick Desaulniers
