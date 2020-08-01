Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D65C433E3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 20:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBAD2076C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 20:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="N5BlGEIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHAU0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 16:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHAU0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 16:26:20 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B85C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 13:26:20 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qc22so19975379ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 13:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+a0yGWWLvkimp+sCjAPTJ7AG+vTG8fsI+soOkfq3Pko=;
        b=N5BlGEIXsHi8EpCipphyP8VliOgOo4GRnkefnH7vphNqt0wn2AruvHwtHbKE9jJL4j
         RUHCkue/PDymY1HlwrUyNlxvqcFs9lyxGzGzOi9NuFt22jMj+nStfWYjvzJBHJlNt8uA
         KnpvjY+uFyXkC5AAQAIBP8+bGtZMA5VMSl1S638s2NuYX7Kqjdxw7Ks4ZDLe4c7UoCqA
         IpxFRZ7ZkDybofZLmpYQpaBtoG7+7Kp7dGdEtZzww8WcvE7xujp97imyxMcLDossN6rQ
         ik+fwFC7l8pat7BwuvJ6fhygzTvDNoxWOfm6mWfVgFFtOF7CeIFIfwdZ6zxDjMslQpaD
         kYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+a0yGWWLvkimp+sCjAPTJ7AG+vTG8fsI+soOkfq3Pko=;
        b=VkGVFwbsxQfLXhYtvymLk5xTqvhol4rIp0oVPJvKMNoeRms+CVYdtgJ1AhmqAz/SUM
         Sc9ecijOkzwro64CafIuBsbdSHKCED5o0DCrARHTHbrJhOnGO4R6+39v5z3+dfJZu7DY
         sKMR6LGQAfe6rC6DpDTGa3pfSYV1YEIAtjSY30a10mTINCyJ/ZhyTAetJ4HYZ+JKtI0P
         /bj+iV9B928K9mI0WzIiBViXfL71jdFHM3DgSR0Hx/OCnRWzi0UzVEXAV2Xms0unSeil
         7J+ZQndS/m5Q9l6EV2dXs1n0FTBjtiFVBasZrYUfNn1PuQSx7yYL1dutilo9pZXZv7ba
         tLkQ==
X-Gm-Message-State: AOAM53099CmH/nQ7Ag+V3lQXrqUQgNZtO4uf1NQXDMcY1rjOFY08XWwV
        V9YnDbmBCz9P+yUF8GiaL8WfgW6MdXNNL4wjCGTr
X-Google-Smtp-Source: ABdhPJwXECVTRu8guNz+dzN8J9+xWDM9V6RqekJhlUpEKFQgqXixVlN0WdfX25oXJLL0dVvYiOa0wDOgjmoMLDdqupc=
X-Received: by 2002:a17:906:7c86:: with SMTP id w6mr9625303ejo.178.1596313578663;
 Sat, 01 Aug 2020 13:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200801184603.310769-1-jbi.octave@gmail.com> <20200801184603.310769-3-jbi.octave@gmail.com>
 <91c6c45f0d8ec0d031c216711cd8d7f6e9aad7ad.camel@perches.com>
In-Reply-To: <91c6c45f0d8ec0d031c216711cd8d7f6e9aad7ad.camel@perches.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 1 Aug 2020 16:26:07 -0400
Message-ID: <CAHC9VhRZ8_ZH_HZxG7coSgXo5O+G-o91wYrCv-UPK8R03OjFxg@mail.gmail.com>
Subject: Re: [PATCH 2/4] audit: uninitialize global variable audit_sig_sid
To:     Joe Perches <joe@perches.com>, Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        "moderated list:AUDIT SUBSYSTEM" <linux-audit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 1, 2020 at 2:55 PM Joe Perches <joe@perches.com> wrote:
> On Sat, 2020-08-01 at 19:46 +0100, Jules Irenge wrote:
> > Checkpatch tool reports an error at variable audit_sig_sid declaration
> []
> > diff --git a/kernel/audit.c b/kernel/audit.c
> []
> > @@ -125,7 +125,7 @@ static u32        audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
> >  /* The identity of the user shutting down the audit system. */
> >  kuid_t               audit_sig_uid = INVALID_UID;
> >  pid_t                audit_sig_pid = -1;
> > -u32          audit_sig_sid = 0;
> > +u32          audit_sig_sid;
>
> All of these are unused outside of audit.c and might as
> well be static and removed from the .h file.

There's plenty of time before the merge window closes, doing this
would definitely make this patch much more useful than the typical
checkpatch noise.

-- 
paul moore
www.paul-moore.com
