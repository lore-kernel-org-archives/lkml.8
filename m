Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46378C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC76206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGiK8r7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbgDMTsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 15:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387774AbgDMTsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 15:48:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CECFC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:48:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b7so4298711pju.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lm+T/VUWcVdciZtffG9HasauV8+M1bpsb/g8wa55C1g=;
        b=dGiK8r7I17rELbHXA4O2zbefSd+SVM9V15Eb8nay3kAL9PE0nCfsaAjpKB1yGPGQYo
         cqdFOv9CeQkRoGw7K9nv4gN3fj1QSk5PoD3mgU0TwmCwzd4iWp/FngBJYkivCIMvPHdy
         FJB7PvSFg2gfpoqZcwrPEdzFi+anN/X4NxgUmyEPM1rr9oB5Z4S+YQKQko3yFNIh4AhU
         dYPI7s4YzRtaIjGsrzEwoCGHnHTlR37dew9UbNHpMOn7VFRz+ghLaauFmZ8zQudjj1NL
         Z3+LhfEt0Ic3EQgRSPOFP0vBPyoKTVRF1SQ0/ZbT73d/c6ag1S5gm7JDZvDUIzJ0V8zQ
         Aozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lm+T/VUWcVdciZtffG9HasauV8+M1bpsb/g8wa55C1g=;
        b=brL76HCh1sRu6QtN4ka19jgHIHs013tM0RTC4esuIUvKbuqWsF7skN4rjDXUnowcwi
         ODERdyBZP5MTrgMqcGF1O9vExznfAHg906LjUqzw/9wyUwLwoTbe+pATdCicN36qnzhc
         pUrXK9spvezfT/5m5pjwv0DhCHB/zrV+xQqVryqDGt+77kp1B2PyGgMAempZ0dwmQxPT
         esBN5viONzdQi2ZIhfQNjT0RfL/Jsp0swcWnWGvVvhig3w03jExvaeTIfBwoZnbudu6t
         XCHQ3d42KBPl3vv+C8iZiPiq6yO1JniJ33LcyYkIVoEZ0Wyc0JPylkZHA1Wl0uQTZfht
         Xb8w==
X-Gm-Message-State: AGi0PuaHsQpuIJUsZLrkWfMbJtGfSu6hktpeBHvHv+ypZSqNmGkJfRhk
        SIWtUNcV8V2m9QNt1VFtYP8K3ljCGJ06Jq58BIUReQ==
X-Google-Smtp-Source: APiQypLjGmVcaJai2bby51QxxJZnymDzLr9kAcz/yErU9XADeq8tYmu4UuUjOegHJLpSLNBnalt64LSU3IUesTa7XXs=
X-Received: by 2002:a17:90a:3568:: with SMTP id q95mr15457600pjb.47.1586807289588;
 Mon, 13 Apr 2020 12:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200413115815.141587-1-vitor@massaru.org>
In-Reply-To: <20200413115815.141587-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 13 Apr 2020 12:47:58 -0700
Message-ID: <CAFd5g45yG1sSyuft4e_hrFxTNeES5fQVVyjmN8qOFyEmoUU4fg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: arch/$(SUBARCH)/include/generated/ aren't cleaned
 by mrproper
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 4:58 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> This bug was introduced in this commit a788b2ed81abe
>
> Related bug: https://bugzilla.kernel.org/show_bug.cgi?id=205219
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

Please elaborate on what this change does and why it is necessary.
Shuah and I are not the only ones who will want to understand what is
going on here.

Otherwise, the change itself looks good to me.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
