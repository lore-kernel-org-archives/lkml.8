Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360DBC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F29206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594848968;
	bh=/CTBH31ZXIkeJslrqwkrTs5dvjbsh5vjcgROvFvimZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pPOdvMg4wooQ8X6V0e7daCxNjamelbZqZjWrTpWXXJDRa7dCv6CftGE/3t3o2Tt4h
	 hIQVZ6pCH03JujazXLSp5RS8wCNzHx0ABT9mWL94bRFK85WhbLp3F4RWP7XhM3Ucmm
	 AQl7gteaMhb/oA83giUrYPgxPB5dH2gHOOoPqUVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGOVgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOVgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:36:06 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F1EC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:36:05 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t9so1938656lfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CjMxw3ResUXoWBbMIRKY+bPmsQ8ypTFl9rScDJBtLoo=;
        b=V+4l+HoxVX5Hl43um25q+wr17B2AXE1g7UXRgYNlhUnnY2Z9vjES3KDTtyn1rM6c50
         QUiWBL4+QMAAOSr6z/7YpcDE3S0c62+9nXrvP6dw/1A+cvDOAlTEClWaRd5xWHrDKXLm
         nu/w4+Yjcm2hdeH9lNInhPbF1+W7Pzk3GVZXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjMxw3ResUXoWBbMIRKY+bPmsQ8ypTFl9rScDJBtLoo=;
        b=D12rMPclHwZKFGA6nKfv1HSvCBp4Z7xDUWqurXH0RdarjWKlQaRLAVQH8FvuWXQutX
         CkGIhnFGeSHjg87lCkbmQ16KrgKNS0q8Jj7tMI3775hCcoUavfjJvWd1ddnLwjXw3/xt
         jxltbFhGrjL2HmPbGs6PlLnqbgvJeFDL45uyEzBq3DHl2wju2QSsWragp38YzJddLJFC
         08+57bJYjpKSk1P7Kj+1wtPW286SQ4bDqoGa311+RmH1l3ZIycsdsQvv/f+kfRYsQT0l
         AhTJw/A5P9NwICJ7c/WKG+U1cMFY0vWyOMdgDsqVV3zkCz8JGYA4H/ZUhakYzxC2yj/X
         TjOw==
X-Gm-Message-State: AOAM533phROtfDuHFdcTjnkKJSAYRYecRAMBM9jVHofVz0p6WRl/arlD
        29sV8VKMJ/YBiFM7MzgOFm7V2G3+BlU=
X-Google-Smtp-Source: ABdhPJzVapBtNCOKqKoJn5Xhpo2Y66bE+0+6EgQRkVKkzmASU1lpP54gswZfZIYZcggukdcPS69UjA==
X-Received: by 2002:ac2:5296:: with SMTP id q22mr488889lfm.106.1594848963956;
        Wed, 15 Jul 2020 14:36:03 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id e12sm657046ljl.94.2020.07.15.14.36.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 14:36:03 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id u25so1952525lfm.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:36:02 -0700 (PDT)
X-Received: by 2002:ac2:548a:: with SMTP id t10mr505514lfk.142.1594848962528;
 Wed, 15 Jul 2020 14:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com> <20200715205508.3rzrkhulruzpy6iv@box>
In-Reply-To: <20200715205508.3rzrkhulruzpy6iv@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jul 2020 14:35:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOgH1AYiCXS7hNqqS0FnxbjJMkbxZ0Ep6vp6QF8BUBjw@mail.gmail.com>
Message-ID: <CAHk-=wgOgH1AYiCXS7hNqqS0FnxbjJMkbxZ0Ep6vp6QF8BUBjw@mail.gmail.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 1:55 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> I don't understand 'len' calculation in try_to_align_end().

Yeah, Joel found the same thing. You don't understand it, because it's garbage.

> BUT
>
> I *think* there's a bigger problem with the patch:
>
> For stack relocation case both VMAs are the same and always(?) the only
> VMA around at the time. It means none of ADDR_BEFORE_PREV and
> ADDR_AFTER_NEXT are going to stop us.

But for the stack relocation case, that should actually be fine. We
are moving the whole thing.

Or maybe I missed something.

> Consider the following case, before and after try_to_align_start():
>
>                 before          after
> old_addr:       0x0123000       0x0000000
> new_addr:       0x1123000       0x1000000
> len:            0x1000000       0x1123000

That's the "move up" case that fundamentally doesn't work anyway
because it will corrupt the data as it moves it.

The stack relocation only moves down.

               Linus
