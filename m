Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA7FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0746520720
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbxKOXHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389907AbgFYJGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgFYJGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:06:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269C6C061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:06:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u8so2748091pje.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vylqwLtVkAhs68RnWsWSlAhcUo1YmQ++iHRAkEL/5mA=;
        b=sbxKOXHt8L3uvLDygPOkxJHqrl4jrnBuLdeLgB7vUOUtH/auhCNCtFS3SwHJOEKkfz
         0IPP1BZFUaB8dXcROcXamEjPjjB6pxNnbJvy7116WUorGDLaU57SBxUGQHtDuXewgR2i
         xzCmakuDLwazlzPS04SwV3lFQUyV5fyrHc7Zjpzy6uLskWhyRSU+ke2gE3w1YTu6Prje
         g/tI7KywvVqj2Kzw3BOaGKByh5e1hnC5WDQ5S0v6Hn2vB1PMGG2sXm4HzPQrbt/RQ9GX
         TIEBidISf48ptK61QboxrpXUFoR65YvDAFKFobJwE357y/T5IcC1kKG7TMk8UYWLgZrO
         PaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vylqwLtVkAhs68RnWsWSlAhcUo1YmQ++iHRAkEL/5mA=;
        b=SblZrnSzaLmfQ8+I7NC/CTKgz4i1/e86XogbjcyFPbwqYsvP2F0tt9u3oQmjY0GDLt
         +hmWT4xzyTtfNoLnQAWaruIHttO8qYBsJR//AaDWi6kTKsdRE6CWQwkPde7wWCDz1dsK
         idkuU8jUxEjdp4l6IAu5AiUGPmbCupb6o/nJHnF5didqIeAuTv11ypGGBOx6Uds6NHog
         KkUcrsGTE8RZj89UGRGJsZgRHj07McvsriEd9CnUJ6z8CKKN4BPLSFn6Ct/6WtJjcLBH
         Y8JtmbWmpcMnURiPW2f8cdzX+lMyOvOg8cnXE7iH0WsXNkw1b0SFDsLAPJ8MUOfNQ5tG
         wwqA==
X-Gm-Message-State: AOAM532LdLi8cd6ywqoA8uHeZBNwomcU2i3t/ZAyZwsfkfMIIlHkCZYx
        4uqjkpqHp3RhAKLDbzbyNdI=
X-Google-Smtp-Source: ABdhPJx5ciQ9sDOfrzKVH74cmWvr6eNRhXe/ZtSeWw8hLijwg334P+nM3RXOTUA+hP6hVHXgEiEQyg==
X-Received: by 2002:a17:90a:d809:: with SMTP id a9mr2307991pjv.212.1593075980539;
        Thu, 25 Jun 2020 02:06:20 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id m4sm18842659pgp.32.2020.06.25.02.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 02:06:20 -0700 (PDT)
Date:   Thu, 25 Jun 2020 02:06:18 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Hallyn <serge@hallyn.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 3/3] nsproxy: support CLONE_NEWTIME with setns()
Message-ID: <20200625090618.GC151695@gmail.com>
References: <20200619153559.724863-1-christian.brauner@ubuntu.com>
 <20200619153559.724863-4-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200619153559.724863-4-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 05:35:59PM +0200, Christian Brauner wrote:
> So far setns() was missing time namespace support. This was partially due
> to it simply not being implemented but also because vdso_join_timens()
> could still fail which made switching to multiple namespaces atomically
> problematic. This is now fixed so support CLONE_NEWTIME with setns()
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: Andrei Vagin <avagin@gmail.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Hi Christian,

I have reviewed this series and it looks good to me.

We decided to not change the return type of vdso_join_timens to avoid
conflicts with the arm64 timens patchset. With this change, you can add
my Reviewed-by to all patched in this series.

Reviewed-by: Andrei Vagin <avagin@gmail.com>

Thanks,
Andrei
