Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6B8C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 01:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B9F2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 01:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FHpyZjmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgEGBL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 21:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgEGBLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 21:11:55 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3407FC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 18:11:55 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so3855693edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 18:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BHSYd56y/P/AUtkor9mWMhsnnvoYQniivekGDDl33VE=;
        b=FHpyZjmUtqznPles3ZOTSsJgpog1COpvoPMjD4c8pV3qSNINY3kTWbwgeD/3h14vwQ
         u6+VJrr41RD7Cx7piBakvcqtkTnpXlg7a3XnQKnc7zDPWgC8wzc8O6Zlg0qEWpdoIdP9
         xfYDLRUDIJLvol0oqXI+WWsJ4+pebSiR5PWtk09UPNnK9Xy+ZKNh2SEQnPc2cuUtSh53
         Dqd+3WO2tSpZl6wg/vNecAc1LHLQxjU0i/sWs5x+aHCa09JgabVTNo9IcdVncaBrYfK8
         FlNC21LUJSdWTDOAxByum/NdwDE40+ga7HxCQvzdhNY9wLP+VZ83km3qt1TDd81/z/TS
         tRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHSYd56y/P/AUtkor9mWMhsnnvoYQniivekGDDl33VE=;
        b=HSWkVaV0f2xrPgpi1n0ze0vGKoxSx/5vnoh03IEAKTi0B4xhJweHy3mUz6FZHPSC/N
         ohhmSRG+Q/eCiJpjFPXCdVloR8gbXfC+jPXWVRkGxkxpMFWF17qolOKHPX3pAk0jT0+U
         7kYdPLuHyNdeYHRxw1EI2B9RhliMCGfmult6Jo019dDwt6d8okGMSR7mM68RRcxxTtt1
         fqXcnC5Os4r3wD1rNdwAlsQdOIQGFeGab9oKjXG+NWU1V6f/B8nmhmxAQ/pN/L80crvW
         5aPNRwxX6/eN2dkEX5zJKmjlGqHbhnSfweYw/nR+OG2hvuP0qbmjnydzAeihmMdX7+jh
         BoUQ==
X-Gm-Message-State: AGi0PuY4FEC88QmkqW7pUbVwbaIOuEAeC9727FG84l5LItK+L/CgOt16
        E/ZKS89ygipFZ98K+wuJ+pZJ5O8jhHgepK0koICKRQ==
X-Google-Smtp-Source: APiQypJi40Eci4aiL9uRsmX+8iVMgQz9PK0rFJdqmVeRclEGT3sprJ6Ip6a/6WRwPbVZiZPzz88EuAPuMw3ojMIJwNo=
X-Received: by 2002:a50:eb0a:: with SMTP id y10mr9645097edp.312.1588813913603;
 Wed, 06 May 2020 18:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200506172158.218366-1-bgeffon@google.com> <CAEXW_YS_rAxHuj_Jr+0xWQSUyiOX3WKnJNevh2ReE=O+Xsp6SA@mail.gmail.com>
In-Reply-To: <CAEXW_YS_rAxHuj_Jr+0xWQSUyiOX3WKnJNevh2ReE=O+Xsp6SA@mail.gmail.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 6 May 2020 18:11:17 -0700
Message-ID: <CADyq12wW-j9vi0oxXB_+sjSyP=FgaNWkRM2Yo9YqkEwGnOb0bA@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: fix remap event with MREMAP_DONTUNMAP.
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -       mremap_userfaultfd_complete(&uf, addr, new_addr, old_len);
> > +       mremap_userfaultfd_complete(&uf, addr, ret, old_len);
>
> Not super familiar with this code, but thought I'd ask, does ret
> to be checked for -ENOMEM before calling mremap_userfaultfd_complete?
> Sorry if I missed something.

No, mremap_userfaultfd_complete will do a check similar to
offset_in_page() by checking the page mask.
It does (to & ~PAGE_MASK) to check for a non-aligned "to" value, so we're good.

Additionally, earlier in the process then ctx will be null because we
will have never called mremap_userfaultfd_prep,
and mremap_userfaultfd_complete will check if there is a context
before proceeding.

Brian
