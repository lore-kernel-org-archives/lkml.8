Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01413C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 12:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CABC120849
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 12:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqvht0x4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbgEXMdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 08:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgEXMdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 08:33:07 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FB3C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 05:33:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id y5so1122179wmi.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 05:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kHusO+2oO2HP4q0NGQOvRX7sNmvNhNG4rdyQs8Jeu1E=;
        b=lqvht0x4H9YQD0FImlHkB1F9K2jlCzJJlRFYYIC+K+k6qQDDFQ7OB32W9x9ETt7OpW
         7it4iu2LgprNe0ageq//Ts6p61C4Cmm3hYCzzHMKVYz2B4FzegHzi2flJyADa8ADf1rw
         TrTso8L4mgO9j04XR8bOeDf96LyVidXVJ3ut95SyIH07rIEiKmlnsokSo7dyD2QAJEZT
         banI3Iy22stLJM7foOhH7o9m4AEN5MbzP1xahQ4LWRZ5JZkIFrKZB7dC2Xo9Gx2Uniyg
         6chMbGaVke3Hd5Z90LLwR9DwFVhF+XFwTv860QX0tEAc/jd1mVB8UY8VH5weFRH1p7WA
         BKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kHusO+2oO2HP4q0NGQOvRX7sNmvNhNG4rdyQs8Jeu1E=;
        b=NCdyX6DSu8LTUxmXL1WrxV0elfz+4bAYjTyrSBP7YJWvbiAWB3lqjmEZSvuBSlAtAg
         DHcOMfqwzSC6Bo6BxCIPFV8++tabVSxqya64D9iZUOr4KOgvInqTSkY9NHBiIlC+UhSu
         AQnRAbVLxy1+fqJqgUXb5X97OpSp+raM93Uo8uwKE4/og0L3KDG6sW3bhM9qqoL8GM7M
         4xWBTrp3zFuVJexa1brLlG8fnrG+sOgUXCDVPiwBWmECNJMKlnNXb4O2uV4aytgpawet
         kKdfaPqgcVw0xIwtI0h2PebWjrNnCz5J4KPmQAMCgLMXjTXAmFK6tHywQpagNKm5TGOD
         gbdA==
X-Gm-Message-State: AOAM532xvYAfssauqzm/CywyTGSDOjirgijFPb7ulQWhfVpYnRWu2F+f
        NSj5cnzZz1X0nnNgJWBj17ryUOM7qOeDgLMGIzLOR2xCzfM=
X-Google-Smtp-Source: ABdhPJyIFymZX6eg7bC9qSm7osHQtxCP2wuoqqVhz3T+zr4Cw2C+SoeLKVJI5cO3Q0Tzi6fFh9onoGRcznR0G+tyzn4=
X-Received: by 2002:a1c:18e:: with SMTP id 136mr13552106wmb.159.1590323585193;
 Sun, 24 May 2020 05:33:05 -0700 (PDT)
MIME-Version: 1.0
From:   Idan Yadgar <idanyadgar@gmail.com>
Date:   Sun, 24 May 2020 15:32:14 +0300
Message-ID: <CAOGVgQGhWSdLA5my72P-Rz6b4UFJ2-1xZcdmDm5m=by7vRWDAA@mail.gmail.com>
Subject: Capabilities are list when creating a user namespace
To:     dhowells@redhat.com
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, armijn@tjaldur.nl,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A process which changes its user namespace (unshare or setns), or a
process that is created by clone with the CLONE_NEWUSER flag has all
capabilities inside the new namespace, and loses all its capabilities
in the parent/previous user namespace.
This poses an issue because some operations require a capability in a
user namespace other then the current one for the process. The man
states multiple times that a system call requires a capability in the
initial user namespace (for example, open_by_handle_at requires
CAP_DAC_READ_SEARCH in the initial user namespace), but this cannot
happen unless the process is owned by root, thus preventing
open_by_handle_at to be run inside a user namespace.

Solving this problem can be done by allowing (via prctl or any other
mechanism) a task to save its
capabilities for a given user namespace, even when it isn't a member
in that namespace.

We would like to hear some thoughts about this issue and our proposed solution.
