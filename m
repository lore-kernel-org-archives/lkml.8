Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA1FC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5C520702
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="PAu6LbFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgBFEOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 23:14:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37215 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgBFEOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 23:14:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id d3so4249513otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 20:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YK4pLNzComAb4RRWalE9dRpSr6kTwplmClgTn0UWb4=;
        b=PAu6LbFgkInaD/I3fnt77LxSZJFmHkyKDvDWEI5UyTUgY4uuCecKZ5XYEHCcYTGNvC
         IhqmrP40a27uFYDl0Jz0ux8ycH5Rcfu4JQtztjYSwvsbQwNBagxztJwKr4B0asvQ0aie
         mLkpDgi2UxItCv2DzBnCMjpPTdYFyJCo3xPPBTkItapDE3C2obwsQg3x1X+mhr7HPzkr
         KRvCSYglf5a++dFraoZDYbL+qKevobyDPYtYLh5jk36+1/l+SqAK4nrW2OfiOg+iib/o
         pgHViExC6kXu6hGg5bH6018gdDWdtM9+BwXRCMAuhqNNSK5H1jZYU6ctfO7iOW69GAZJ
         wOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YK4pLNzComAb4RRWalE9dRpSr6kTwplmClgTn0UWb4=;
        b=Q4n1dJtlnQOEG/LwKPoXCo4r4zck8ur0uAygzOELwUOkdCV9jUHqi3kyEhc4vfp9CC
         WhOjFDV8lFgOZG0sJPgpRUUWtxv/tIK+tjljWZ/TldPisFuuznLwXjSlAxBlKVDG/pQW
         DjrILv6lFwf1qQ59ABbvpL/sO05Nu3fJWPmKLAdpD9gbmal9WCbOYqoVdU6L1waCkQcX
         yBzMJ3Ijla49rSrowm6be2n8o7ZoHkgEDvqY0sXg+l35h08ndIXkjraDJq5MwmLHaJ32
         lN7mqSOK3IJVo1S/0V08g3ZuwIFxuv30YOuvi918BGmI/Lp1H0/pQT6mAWArOaftI2pJ
         3M7w==
X-Gm-Message-State: APjAAAUji2jhXClaB+VFtZQqvXK2Olz3b78Edx3T7bpn1VaVTl8DaMDd
        no7AOCVp918TQ+dwvGi5+Ws+KQXiG21Qq1Lo3YJMcNyj
X-Google-Smtp-Source: APXvYqxI4mUzUsqZ0Sa+xPDkLkdtxf71TqFdTm7+a8LDEGYPR1/1v8JMu9QEFrR9x3MOi2R+O/ZUnkHrFPijAeBuNbU=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr28615291otq.126.1580962464419;
 Wed, 05 Feb 2020 20:14:24 -0800 (PST)
MIME-Version: 1.0
References: <ca53823fc5d25c0be32ad937d0207a0589c08643.camel@perches.com>
In-Reply-To: <ca53823fc5d25c0be32ad937d0207a0589c08643.camel@perches.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 5 Feb 2020 20:14:13 -0800
Message-ID: <CAPcyv4g65_Jxv3GUHsTtH6KmR=AYbx4s+TAC+tLE8YeLNiH8pw@mail.gmail.com>
Subject: Re: [PATCH] get_maintainer: Remove uses of P: for maintainer name
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 7:23 PM Joe Perches <joe@perches.com> wrote:
>
> commit 1ca84ed6425f ("MAINTAINERS: Reclaim the P: tag for
> Maintainer Entry Profile") changed the use of the "P:" tag
> from "Person" to "Profile (ie: special subsystem coding styles
> and characteristics)"
>
> Change how get_maintainer.pl parses the "P:" tag to match.

Looks ok to me:

Acked-by: Dan Williams <dan.j.william@intel.com>

...although I was not able to trigger any unexpected results running
against drivers/nvdimm/.
