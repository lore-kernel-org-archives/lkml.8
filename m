Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505CFC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22BEB206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDvTZdex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgEFKvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726558AbgEFKvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:51:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF804C061A0F;
        Wed,  6 May 2020 03:51:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k19so327875pll.9;
        Wed, 06 May 2020 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvMU1aLNm7t3JO/yRaIHe2DK8IEcl3xIPaOuPy1dfKs=;
        b=MDvTZdexnqJAkzeaxFXdJOHRsal2E+C6wE/aQCzYB13i2ZNaL7h0dFhWUdUFCci9/p
         nwjYHAXeR/y010ck0u6Owg96m3CQVFMuNHfd9Nhysv04vQU86hDrJ2HG8UyPHm2AVjGK
         f5gSWuhpVppMCZ91T5PwLlK+PP2leUqWlgDdU2sOuqKF6d6L++J25/qdi76huZFbTK4K
         Kkfb906/46AI6kAGdFVBULtSWd9oRmMOJv07k+Zf1h7LZiE02aGYlPH6ngUXo3v+iofE
         Ldrn1VYeeQ3w1VPocqIaQW95CQZ6BkFzO3ElUhRf2n5sK2Pzs/yZqCVAb2Ot0EhhbSXt
         HtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvMU1aLNm7t3JO/yRaIHe2DK8IEcl3xIPaOuPy1dfKs=;
        b=eFYn4mNqbXnqqHiMdw3wv6axgBWW8L8oIiO7+jRZu0OJ9bxsDyNToBpWmppM+en2R9
         6pYCYc0zYVxWQbJngUb9ZDfznGVlpEPdt0dkAopp3s8RayYaA8h01IYWuy4jHF8xxJkL
         kn/XsMuIRBGlC6L5W/GKxDslMX5MZLcscXDJ/fh40R89dmSuGbb9CcY8ti29zp+gPWeu
         BASdQmp+KQPzBmOEV0mLcV7gcncq0lZFxG6i8mjN+8VfikgVP1GISWpNRkHt7bHGzSGc
         1jvqNjWka2Qktj3iViy7MsMXSARkoW0NERdYLZT7tyBvTsRSb3dhmV17NZsIMO6tAqyR
         24aQ==
X-Gm-Message-State: AGi0PubEv/AY5wNA+eJfP4GZaqnFOVSsBZ/E4iIT4lIDv9Ws8Tuk+kUo
        T7oTnPBasClR5r6BhGZ6yWfDXb15hREF2OgECAs=
X-Google-Smtp-Source: APiQypIbC75z+2oCLu7fR5K5Nitt18ISRUW7bK9yAzyrIhIhSJ6AJ+FWpSpIZ8Q2yY6Fc8AA6atjlryccOmS2Tx1jWM=
X-Received: by 2002:a17:902:6901:: with SMTP id j1mr7127285plk.255.1588762313376;
 Wed, 06 May 2020 03:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2005060741520.7719@felia>
In-Reply-To: <alpine.DEB.2.21.2005060741520.7719@felia>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 May 2020 13:51:47 +0300
Message-ID: <CAHp75VeNiuJ7QXvNO2=W_TjEjjK3xRbg0-Don6HkSOHV5LXRbA@mail.gmail.com>
Subject: Re: MAINTAINERS: Wrong ordering in S390 PCI SUBSYSTEM
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 8:46 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Hi Pierre,
>
> with your commit de267a7c71ba ("s390/pci: Documentation for zPCI"),
> visible on next-20200505, ./scripts/checkpatch.pl -f MAINTAINERS
> complains:
>
> WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic order
> #14723: FILE: MAINTAINERS:14723:
> +F:     drivers/pci/hotplug/s390_pci_hpc.c
> +F:     Documentation/s390/pci.rst
>
>
> This is due to wrong ordering of the entries in your submission. If you
> would like me to send you a patch fixing that, please just let me know.
>
> It is a recent addition to checkpatch.pl to report ordering problems in
> MAINTAINERS, so you might have not seen that at submission time.

Why not to send a patch?
Same for the rest of similar mails from you.

-- 
With Best Regards,
Andy Shevchenko
