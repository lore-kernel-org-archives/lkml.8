Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5A4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4617C2074F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OrOtLw5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgG1Jul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgG1Juk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:50:40 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C9DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:50:40 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 12so16940669oir.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7WqU0daqgPYKzDM4wJY4PZYJHbY5NF/mgj6Y17PepM=;
        b=OrOtLw5EOmkRhXXIcYsw9TDIuzBhVZKGqOJAH/isn+0lcdD3Jrl499FjT3FlPrptex
         inWX7gaza/tr3nXnYkuumtjJl53aQwwmbqWksLtYZ7tdsYRpLvnK2XTYCv/8m+65Ufa+
         7DFk3TRCPt90E+tgIzUao4sOasvA27ToklnoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7WqU0daqgPYKzDM4wJY4PZYJHbY5NF/mgj6Y17PepM=;
        b=RREKvFCMp/oDieqGhUn1dQhOhcYVo/zw5F8Wz4Qi2eepYH80WdccA4+I2D9wtwP9r7
         g8s1KBny3cOfRHnFktICTityQRUF/t8g9gwSniIkoaGDtEG9mMKJfkBbmF+sixRig9IT
         Lrf5URS1JAh/AbxkIWtMyn6g4nVABnClYCYoWeSLpodijrwqEM6vF9UFJmA1h+8p8c3B
         blFAA0KbHOY1+4LjBAqeey8LfvkNX7zA4YPIEzc3bxd0s+JQ4DMBPWtjuSEDhEuzRi2a
         NIZcRnYHDRg6lqxq2AX85wPbLh4E1kc01OHY74DY56b0Dn4xkNgLpsqXVfOYg8hglOvJ
         rpTA==
X-Gm-Message-State: AOAM530prhuyi4iTm3pIHnpqRDDDGE0ajRtGKjaJ3rwP2GmrmyNruQmZ
        e8Ygt8kv7HEfpOBtTo3tnoyQmLfjoZLh66erkCViFA==
X-Google-Smtp-Source: ABdhPJyZW+bp+9Nwgfg/xN8qMPQYWscCoqwnaoL0A0n3guJlRQVVgay29L57+3LBo5ONHbZ3iemXiiHIVW0XxKZO5vY=
X-Received: by 2002:a05:6808:88:: with SMTP id s8mr2583624oic.101.1595929840005;
 Tue, 28 Jul 2020 02:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200727233833.05e48968@canb.auug.org.au>
In-Reply-To: <20200727233833.05e48968@canb.auug.org.au>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 28 Jul 2020 11:50:29 +0200
Message-ID: <CAKMK7uH773DCGvU92i1R-cexnsfYoxM=wrPZOYY6i1j+-xOBMA@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the drm-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 3:38 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   163d5446c37a ("drm/nouveau/disp/gm200-: fix regression from HDA SOR selection changes")
>
> Fixes tag
>
>   Fixes: 9b5ca547bb8 ("drm/nouveau/disp/gm200-: detect and potentially disable HDA support on some SORs")
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

Hm dim (our scripting) should be checking for this already, I've added
that after the last big round of malformed Fixes lines we've had ...
Dave, overuse of dim -f in your history?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
