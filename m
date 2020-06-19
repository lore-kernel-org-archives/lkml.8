Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499ACC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A74020739
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNxZ3J3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbgFSKEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731419AbgFSKEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:04:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEF9C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 03:04:32 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q19so10841022lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 03:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSmtFwjYCwONO6QiqNUmZvIHY27xkKnIoHKIztWZEmk=;
        b=oNxZ3J3tKRaqUXxm1+Swvo5fVPFXHiJcRKxLReRHXwA7OxlRcVh3cW2rVWqiJOFz0g
         2CdskXMUr9H1/EpWis2FFrnHY/s2AXVGFf+a7d9nQWsBqz14zOM/YF5Bdazf4Ts4i/c6
         +fL+6dzR0rTeUyEmH/6Wksb+Nb0VcK5mPk94yAx420DtZYRWUW6CPwaLQSJpL4AbsJUV
         LM0WFiqVeVrcYIIELPojF14qAOM2HGqewbiyGn4+nnub8mBxAH+GJmNmzJ1QyxGZG8CG
         bIynIbLVTNzI7cr8zmR1hiHGO369FRSJw6dI/peTe3nD448yCh4Z+WCSuqpkXPk+N0Ww
         x+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSmtFwjYCwONO6QiqNUmZvIHY27xkKnIoHKIztWZEmk=;
        b=RYtz94YDZHp7MWdopzYVuSRgECdWYbeGkGVRYFHKt/5lYJpy4PybEjNPcCZsr2gaq9
         3wgfFUnoosWa3LxEHhVD7TsDrG8dx7yr1KZo/RgarKoHx7s5BnVnNl8Fr6LTZCy3MItF
         HCAvc6mFLHUsG/SnVZDCCn/Y4Smo/3Z7y1rYLtAOU6jRcVR0gRmyzb/MaTnRF1tVbtQd
         wxZ+U9bILVk+0CprEBQE/Hi87KGUc/cnVKyWrOm5TbX/aSyyzXrbeN3aOXEu67WWgkH8
         /6IJdTbjsmxonSqYRHdgMG7+j/T8hXIWmA9BK1pMCwoGgkvb2cj66b7h1vuYCvqW+YaM
         8dFA==
X-Gm-Message-State: AOAM532T1TH8YttsMbfjHCSczZU2Ew9ePl5jmlKirxAXvIzuJCQhZeDy
        XsUU5EMojPUhh2X9BNHuQ1i//lwG8kg08zTp+KU=
X-Google-Smtp-Source: ABdhPJwY7AKj74y0SO5aZhYpAGlLpK+tzShI9O6Ah2LuBNDbvzOmZ+wNGr2ygKKzGBsukAJ1w1TZCWPP7Wb4GLK2qsM=
X-Received: by 2002:a2e:9b04:: with SMTP id u4mr1561058lji.364.1592561071175;
 Fri, 19 Jun 2020 03:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200617220226.88948-1-luc.vanoostenryck@gmail.com>
 <CANiq72nNQ+11ch7sRjLLc33s_OkftuOqgGkCDggq88tbJtdPNQ@mail.gmail.com>
 <20200618050249.lqwznznltm3lcykr@ltop.local> <CAMuHMdWQsirja-h3wBcZezk+H2Q_HShhAks8Hc8ps5fTAp=ObQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWQsirja-h3wBcZezk+H2Q_HShhAks8Hc8ps5fTAp=ObQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 19 Jun 2020 12:04:20 +0200
Message-ID: <CANiq72kRme3T3po+5CJeUdnOwGhWKCVHu=9cP-Roq7jY4RpA9w@mail.gmail.com>
Subject: Re: [PATCH] sparse: use identifiers to define address spaces
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 10:07 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Indeed. It looks like this whole list is completely unsorted, and was created
> by appending new definitions at the bottom.

The "historical ordering" :)

+1 for sorting, whatever the ordering (and perhaps adding a comment
saying which one it is).

Cheers,
Miguel
