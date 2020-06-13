Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C50C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B1D2078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 20:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592081025;
	bh=EW+o1c/yxXb22VS0qXNdN4BDSMbHWjcq5d76ULRtRRI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wGLzH6S7kr54Kph9e6/E6X54PD5Dfiqp6WTue+dZpS3DZM/s/8EjFt6hUFXNOEk7Z
	 Y4iB7N9yI3RCHZHmC1CaDKWzHWAVaDmgXBc8VlvaPwaq50ptTe2AtVFLHYN1ff/gh6
	 7KnX/04M/BsHQSs35vHGEJ40bBv5Cx4e274/94rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgFMUno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 16:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgFMUnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 16:43:41 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4B3C08C5C2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 13:43:40 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so14832485ljv.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BfAOoNlHylipQkHZS54IuR6alfNSDX+dsmEDA3779Q=;
        b=C0D4FY+NjYs9uTamZVW95WF6UsL0rKaCEvHM6NwDXJBn1TirMKtaz2pf6JH7ZYwzDT
         sL7sG7QVvFiW1cO9iMANJIe7Ykz6kLBy4C03yTDKCSgITREpqb3JsY4Io6Fb63EpJKQ6
         8FoFlfTEu+8vrU25DrTddtSXW9p3ON+79rjyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BfAOoNlHylipQkHZS54IuR6alfNSDX+dsmEDA3779Q=;
        b=ovTnOXrPk/bcqg670QSQG8QjVFeyCCpAfjQhCLS5s3UtEd55qRbm2YbV107sseIb2v
         FB7C4QrpQpPYoDR8NWEchWJELvkvOcatruAuuedB7UmzAtQ4wHsrXGhEBN5VPuJU9QsG
         y3M13MfMgCq+KySMYajtfGOud8CqJfyndPnSWNg+zkOCRTZfk5utevNSaLJfUr0oAcdF
         TwjG6qT/TWn7LMGh+P4hBEWoj3LRSBwk9DdeFaE/QVAHamPmSoToB+wryJkzsYcL9+aI
         OUdexxWwwkchDRLEGrtnq74wUIb9pmoNveiwgl28nkH1dRajrPuU9dhO9XtaO0+0goBP
         zSvw==
X-Gm-Message-State: AOAM533WFqhL9qIiz19peLMy15Vqixmk5EYvPkE05A2VwHQevfjHK9FP
        6dFQD8XqHtAOq7LYNm4nvJbvtsqB5Yk=
X-Google-Smtp-Source: ABdhPJzlqEhLZLATjoIp5wz2Kw7jBxQPLrP4t2i7NE8mmatpUjuPNCHRF2L3glWWcr/vBBuQeZQoRQ==
X-Received: by 2002:a05:651c:1126:: with SMTP id e6mr9559411ljo.123.1592081017268;
        Sat, 13 Jun 2020 13:43:37 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id w6sm2842857ljw.11.2020.06.13.13.43.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 13:43:36 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id x18so14827316lji.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 13:43:36 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr8994739ljn.70.1592081016154;
 Sat, 13 Jun 2020 13:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATsQRp=kkB+THaO23XiHZsU1xJ-B42p8sMieBgJ4uftMg@mail.gmail.com>
In-Reply-To: <CAK7LNATsQRp=kkB+THaO23XiHZsU1xJ-B42p8sMieBgJ4uftMg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Jun 2020 13:43:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7vRkvFTFFQ_TQioLmoK-HWoHMAZ65J3N9jhTHVk5ATA@mail.gmail.com>
Message-ID: <CAHk-=wh7vRkvFTFFQ_TQioLmoK-HWoHMAZ65J3N9jhTHVk5ATA@mail.gmail.com>
Subject: Re: [GIT PULL] more Kbuild updates for v5.8-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 10:56 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>  - fix build rules in binderfs sample

.. oh, and now that this builds, it also made it obvious that the
.gitignore file was missing.

          Linus
