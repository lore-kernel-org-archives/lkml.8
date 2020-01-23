Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856ADC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6022C22464
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579805283;
	bh=zEHXZgI3rw2iy9T9WOm9a8cYfxBrmLbuaUc9lGrAlDU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XfO5LdOVxqu08N+vfbEW0yDyp8vksjwT2SYBYvyvt9d+vD64Zs2DJnkXHGz/OKJVA
	 bE6/GtRP+60wvSFNnG2BhvLZZtrKYHk03I3zqdQjk+cizK26icO7QF2ieGD8COMUzO
	 GwkgD0LPCeVm3jt1sZ2/vvtIAiIliUdR9vd8lNd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgAWSsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:48:02 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45903 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbgAWSsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:48:02 -0500
Received: by mail-lf1-f65.google.com with SMTP id 203so3100756lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTTlf7PIq8m+h1b8hl1eM7lP8o081tv0+h5Byplabe4=;
        b=Mj9KYt/E2aNDAWdYyMNCrPSCFRO71sOFNKIv1qcIG2H25vJy2SyD3sMLVq4FaDcfeP
         iGlcEsouR1fuzQs9IjFsmMH6TyLgOGNtzw0PWZ+6esf3f+uNHjTwy2QjoAL8divZL0PF
         0AN44j8uLfXOosmSCqaAgRkchGVu+6EMdfKNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTTlf7PIq8m+h1b8hl1eM7lP8o081tv0+h5Byplabe4=;
        b=rfh7CdP2eAS/ZqAXXfOsYaZVRZuKRDuQflmYll8jcn5Usq791YwynD/IW3Y1XMk+Mb
         f8/rTBnntf1MWTa7A83t2z3+TNSWpYsfwgLGiUCHOJHtfB5NWbb5UEtx8s66hujZ/LE5
         d+Wn9W3kYTd4xEag5XvOGh9JyhA4nypnXQfenTBL49g+GiIUBohnVBz3HYtJPnBA7JaY
         xQwICrWXr2O7/T2rm5qnIc6x7qbJUMHwRRKDbijo4DpSEO/gJ0j0Htad5WDx1zhgBM2S
         B6Hjl2/rH20yzndR9ActI/YZ1NhvQLl4IDBdy1OrVDpLuvUa38APRjuFytl4/e4KsBu7
         MCkw==
X-Gm-Message-State: APjAAAUrqcGuuiGrR9CYFI+SjN+MBnCIa40WByANs+gUg32vHjoId7Nf
        VaVVBwwLvIkatJDRMUktxmAOntTuG9w=
X-Google-Smtp-Source: APXvYqzxd/FM+GbJ6AwCIn5g/hza/BMossX9AD5zw1lOORTvjwrT3ILo5ziyUdidjejF5s/uzjk4aw==
X-Received: by 2002:a19:c697:: with SMTP id w145mr5444905lff.54.1579805279417;
        Thu, 23 Jan 2020 10:47:59 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id b20sm1719610ljp.20.2020.01.23.10.47.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 10:47:58 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id y19so3110546lfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:47:58 -0800 (PST)
X-Received: by 2002:a19:4849:: with SMTP id v70mr5482335lfa.30.1579805278133;
 Thu, 23 Jan 2020 10:47:58 -0800 (PST)
MIME-Version: 1.0
References: <70f99f7474826883877e84f93224e937d9c974de.1579767339.git.christophe.leroy@c-s.fr>
In-Reply-To: <70f99f7474826883877e84f93224e937d9c974de.1579767339.git.christophe.leroy@c-s.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jan 2020 10:47:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgcm5JzyacekDGQ4Ocoe-F5it-7-sbgU8oPnhwnSH3KAA@mail.gmail.com>
Message-ID: <CAHk-=wgcm5JzyacekDGQ4Ocoe-F5it-7-sbgU8oPnhwnSH3KAA@mail.gmail.com>
Subject: Re: [PATCH] lib: Reduce user_access_begin() boundaries in
 strncpy_from_user() and strnlen_user()
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 12:34 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> The range passed to user_access_begin() by strncpy_from_user() and
> strnlen_user() starts at 'src' and goes up to the limit of userspace
> allthough reads will be limited by the 'count' param.
>
> On 32 bits powerpc (book3s/32) access has to be granted for each 256Mbytes
> segment and the cost increases with the number of segments to unlock.
>
> Limit the range with 'count' param.

Ack. I'm tempted to take this for 5.5 too, just so that the
unquestionably trivial fixes are in that baseline, and the
infrastructure is ready for any architecture that has issues like
this.

Adding 'linux-arch' to the participants, to see if other architectures
are at all looking at actually implementing the whole
user_access_begin/end() dance too..

               Linus
