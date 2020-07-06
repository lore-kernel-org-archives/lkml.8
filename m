Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C00FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 04:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B5920720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 04:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aufaQjV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgGFEtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 00:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgGFEtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 00:49:12 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8C3C061794;
        Sun,  5 Jul 2020 21:49:12 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k15so21799569lfc.4;
        Sun, 05 Jul 2020 21:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LlRkNitp+HR82fwyqhAOC5T4sKDfW6mx6YbCDa9qCYE=;
        b=aufaQjV4h3qnwZ+7EL6rWz2Dhq/HR9mgTN9sQ5qKsfkiKr9+Zy+8TOkf9sqLd0vxVy
         WTTA/IueiLWDyKzx8AD32SCZ6dwIw8vmhW7d6YSDwBgOr7lR7tD0L9nR8FHRuyIrWvUN
         UEoNrYJHeRI7AqyKhFF6sXMu0cGtD/Q84/gOv1+fsBnjknJf2tJBPqwDxZuU7EQykMVm
         3Lrg49gUwYBHNR3Cuk3hZsGy3g6LuNhPs9m6llF1s9m6SLHM959JanUY+JGLcDUvqRsQ
         tqEHOr+oPmOo6tmYqAfHuaDPVNx2XFbdX25YFG3V0BzMcHgm/+Sc6qt5kQN3TEfPsf31
         ftvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LlRkNitp+HR82fwyqhAOC5T4sKDfW6mx6YbCDa9qCYE=;
        b=NHDeRWDn7aYkQ8AJr3fdx0KhAZKd+dd7jjFVtXSMqX3oUDCTSgQI/8belUT4HKQYez
         A5FOvhTHAXl3P8qm7ehX9xld/stV8kAMXc844KY6OcOi8vFDvimPcKhtSYJCSgMVWB2S
         25Y/IvAqJW3aQgmB2R/qHsMFoOuHEdLfGNrqU1T36/ERMWetDbBpqLwdwraA5hNHNI+f
         /wYalxa8C8vavoWYjqYiUlfP7O1dDHHD7N/6aFm/t4lwBOWz7j7aAR3q/O6/ZsSLSdFH
         JmxgdWs4xuOOzH52dG24cvDW3qMPRopYMCPY4hPOx2Ed59uIbUm5nZVkvjgs+joyTNng
         K32g==
X-Gm-Message-State: AOAM530DBS6bVEuEPDQGN+BlA1v7nnDZ/22Yysa0qOginyoZ8PLc1imO
        aI1eb65y06Zvs3ep4n9kfsUpkVxYCtJd1Ggn8P4=
X-Google-Smtp-Source: ABdhPJyF68jwLrGVh/Y8r4x+Y0KdP1oc5lZnzM1F6z+txlo8c2JMfzJ0PSnAMY2TKFJDWhUpW/Cig4+g9LnOpOaQ9Vw=
X-Received: by 2002:a19:c389:: with SMTP id t131mr15690870lff.130.1594010949775;
 Sun, 05 Jul 2020 21:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200629085911.1676554-1-masahiroy@kernel.org>
 <CAKwvOd=qe5KE1vdUYQmpsW2zmDbk5i-MgRujs9B7wqnAj+af0w@mail.gmail.com>
 <CAK7LNAR49jFZkEmBqpACE0V_-VyCXfFRcKe1Zq+cqO65QX1ozg@mail.gmail.com>
 <CANiq72nE+1F3yM+e9XzfphzOe3mb9DUcRCAtPuLMyFE4Rh38pg@mail.gmail.com> <CAK7LNATRAuEXp+Wz7f_VUTSFS4jqmdTE4Xugi1MZozimsj6zuA@mail.gmail.com>
In-Reply-To: <CAK7LNATRAuEXp+Wz7f_VUTSFS4jqmdTE4Xugi1MZozimsj6zuA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 6 Jul 2020 06:48:58 +0200
Message-ID: <CANiq72=LOgebNs7kwLGrkgsM2pr=dQG4F1VWskdndAh39jHWcw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: make Clang build userprogs for target architecture
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Sun, Jul 5, 2020 at 5:30 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hmm, adding '#include <sys/types.h>' did not make any difference.

That should have worked, because POSIX defines it to be there. It
sounds like you need --sysroot to point it to the proper ones.

> If I add -std=c99, I get a different error.

Yeah, that is the expected behavior. C99 does not have the implicit
int rule anymore (unlike older C) so ssize_t (an unknown type given
that program) is not being interpreted as int anymore (which is what
triggers the warning later about the mismatch between size_t and int
in the format string).

> In contrast, 'size_t' has no problem.

That is expected too, because size_t is defined via stdio.h (size_t is
a C standard type, ssize_t is not -- it is a POSIX one).

Hope that helps,

Cheers,
Miguel
