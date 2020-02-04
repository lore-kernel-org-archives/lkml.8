Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C9CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9BC218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWN5OWH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgBDJ7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:59:33 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37769 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgBDJ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:59:32 -0500
Received: by mail-oi1-f193.google.com with SMTP id q84so17865432oic.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 01:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+c+P5I8NbJ7KvdrmDqQ1PdrpFMV6E9xgMXllp3DgFLA=;
        b=YWN5OWH1S+jW+ZqO/FK8CvZv2YTPZFFL80xYclXzWSuEBS/j9zlXfKRT/95NASNAsA
         EF4CKDRfiQ/bxt2ew7Nj1WHCirmfvvPYGt4DeUpqvS6eQcht+lIjifTYzfiQ49bN/S5u
         mz0b6eKSExwqYZMFuQ/B8butBOClBl+dKDHjwmr+DyYE3RFzACqlXvFNl9g3a3ObMFQs
         1VdjLXXa6cErYEcgbMjKmBCK3XGQi4l6l7uVAX+HDoLNmEJ6rknaiJxLI+eYT8RkD8bc
         Gjjgq4P55PEfDgoCveJxVsGwjJrG0OoOQvo70ZDYYVeml2p8+J9iFwIETqLI1HHy4emO
         ulyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+c+P5I8NbJ7KvdrmDqQ1PdrpFMV6E9xgMXllp3DgFLA=;
        b=dWMH4NpCuOayONcdaO+O+BzzLwiaE2ckW+nTzZ4/nLBvy2SkN+D2XdZXO34MgLqENx
         3Zux2KsDaM5XGukbXsZu4e6mfl/ASYXqmbaKZ94eOMLvDtIKtBu7G1GRZioU3ln+FIKG
         QpRGytYek7hLZryCgjFCjrXlIVZh+49sDuaCbJQB6DpdGF8uPQeYBcx5sCwrLJZVGGV5
         0VQ5nIPCl2TMlq6caGwgFo0QSk3NBKutCJJUtaeN9N4s2QmLq7lwcXOKdqPjpt9WiIbP
         YC/AP9wj83y+dIZD1y7N00AtUS/rSnwt/+0Py0NZvRJbQDtGUpVOUOsy+se2n0eO8OSQ
         XcJg==
X-Gm-Message-State: APjAAAW2VXIT5SwZUPDzwvNrXtE8RBdQ4LJEBAGlBNKdTW44Jg+LU90i
        ik/2D97N24wD+/lFvMtYRRaa32iaAlmveQDBoFw=
X-Google-Smtp-Source: APXvYqxL3ONJ+g0dPYwUeiEo11NnyVisJS5Mv5bE0bNlew27R5M77w1CkIdMs3uy8iVQnVmmTuPvR1D66Uz4c0k1K78=
X-Received: by 2002:aca:ddc2:: with SMTP id u185mr2963896oig.24.1580810371921;
 Tue, 04 Feb 2020 01:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20200204090022.123261-1-gch981213@gmail.com> <20200204094647.GS1778@kadam>
In-Reply-To: <20200204094647.GS1778@kadam>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Tue, 4 Feb 2020 17:59:21 +0800
Message-ID: <CAJsYDV+b1bqc3b87Amo8p2UzVi4fpbRv6ytus8A5Y0r4K-X0hw@mail.gmail.com>
Subject: Re: [PATCH] staging: mt7621-dts: add dt node for 2nd/3rd uart on mt7621
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        NeilBrown <neil@brown.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Feb 4, 2020 at 5:47 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Please use ./scripts/get_maintainer.pl to pick the CC list and resend.
>
> The MAINTAINERS file says Matthias Brugger is supposed to be CC'd and
> a couple other email lists.

According to get_maintainer.pl,  Matthias Brugger is the maintainer of
Mediatek ARM SoC:

Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC support)
linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)

I specifically removed the above 3 addresses because they are all for
Mediatek ARM chips
while mt7621 is a mips chip and belongs to ralink target under
/arch/mips/mach-ralink.
Code contribution for mt7621 goes through linux-mips instead of
linux-arm or linux-mediatek,

I thinks this is an incorrect setup of get_maintainer.pl and should be
corrected.

Regards,
Chuanhong Guo
