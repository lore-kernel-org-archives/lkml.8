Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E856C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6BF2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pagi6d2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgGJFqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 01:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgGJFqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:46:47 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707CCC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 22:46:47 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id o5so4795418iow.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 22:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=L84t8abv0xyfD18UPWNAkY9iZAsxIghfZzcWsh83U8M=;
        b=Pagi6d2oZiSFd0VM59aHdfpwoMfL4/Q3+CXdGIDISzViXc5AlNK10W+GRDqNWdKq+P
         EZTaTApX3xKeuZwGZBtFVaYE5qTyaOgN7qUsnG3wc3HTVgpsRm9eaacE+ugK9fbPFneh
         st+KmEtjBH3SR/TFWhk9tq3yBOI+6+9NA61hBJnFiVQICME8AuX+D2JsSgz/N13eEUSN
         tgEUdbeo/idS++fQErV8PSq0Wa/0q+v3KRuraowaha7KQI/FpBWzv2YGarspr1MhLm2t
         SsZDDQxzcgRwy3AozmBpFiFQb5cSW47mJjNgVtqIA+AhOz6/7leJ2BzRmJwcwkM+nnA4
         WElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L84t8abv0xyfD18UPWNAkY9iZAsxIghfZzcWsh83U8M=;
        b=RS1rIwBG9xHqZk6INcC66u4P1ipfRS1LjstD9kK5yCiQKkMholL3qACGpvQa/qbuft
         L4UG+s8Y3sP45lJDsPX096e2Yb197lneiv1E4jLNC7+sz/iQ4zWeqArpGoiAJvZKtWJz
         W/dByMTjuIlS5tu+icoDJLh77l3Ig0fFiTHOUS+EcrtOjFZ9WKr2BmyLkxx0HJFMJ9c9
         dbM4MgmABzU4w+rV1JdvP7FiFhkhDdeW1vj642a+U1HQp1Z61DbylUphmd+ex9LG9Spa
         N9c+iHD4kFrKArvmh9Z6iFAod1XFFjA/9BwrpnocPD+ioKeWsJYwF1SkPYOW9DnVs9eD
         u8KA==
X-Gm-Message-State: AOAM530zaBMdfvnmffIUKj+fMNGcfR2XbLxD9jYgXI/fk9wpO6pTiIli
        jDKdEHthoHQuz8f8fs3Tf8lIFCFWPZpSdvZSvy+DliwnH0o=
X-Google-Smtp-Source: ABdhPJxBmBm3gdS4ixe6FJyYmaDD5u6dgfZZ+aq85HFSqq+2JHPHB7iTAZq6eft2Ind3MXvTZO4et1u10VtiDKlERmg=
X-Received: by 2002:a05:6602:15ca:: with SMTP id f10mr46899167iow.52.1594360006561;
 Thu, 09 Jul 2020 22:46:46 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 10 Jul 2020 10:46:35 +0500
Message-ID: <CABXGCsN2-TTemU8JOnh3YErxe2GH7xtG+EZrF9gn_JWLmMxRag@mail.gmail.com>
Subject: Beginning 5.8rc1 kernel USB headsets (ASUS ROG Delta and HyperX Cloud
 Orbit S) play sound as if in slow-motion.
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Beginning 5.8rc1 (git 69119673bd50) kernel USB headsets (ASUS ROG
Delta and HyperX Cloud Orbit S) play sound as if in slow-motion.

And in 5.8rc4 (git dcde237b9b0e) this still not fixed yet.
The bisecting is problematic because rc1 also has another issue
https://lkml.org/lkml/2020/6/22/21 which completely breaks the sound
subsystem.
If anyone said how to fix https://lkml.org/lkml/2020/6/22/21 I can
bisect this issue.

--
Best Regards,
Mike Gavrilov.
