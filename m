Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7D9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D5120899
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG6hsiFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390096AbgFXJuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389824AbgFXJuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:50:23 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6064EC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 02:50:23 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id i25so1464935iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 02:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=i01px3Vuayzo121kyLDtsm9qpE7YLnmGfsoremYpDlk=;
        b=LG6hsiFAEb5bTM4394p1e0vDcob4HMi09Vp/7gCZybNfGF+wV+OuCFlFDAEKTCFVCc
         KRaRskoHmwzJ9tQzUfJsMiJE1T3gi0rLJmO5ivwxKAlkEzq81noRy/S9JJCYvZcZwgth
         NuPwCkz2BoaahzXM/bzK5JznFK+67/sW55L5SbeBizGwi9zNsWpepjZDWcPmLCeUwyX8
         5L1vJxiilWT3u4t+DElncC+qbG2UPjMcccB2zlAMTnraoXWgTETv5tEl1tPKey2OWzdO
         18triWyvRQm+Htl3gazYJMWP8mAprlKF32lT+WUyUUNz8bEN0AkeWRg3VAtvSk9yO29+
         0Zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=i01px3Vuayzo121kyLDtsm9qpE7YLnmGfsoremYpDlk=;
        b=U7bah/SE5dkavyIPl6bvBZFiFr25rs8dDewFLI3LIHb8cjw39+WPMGPZgeQhwZG8Ua
         nshiSbEX1Ewijzov0iks+JFrmbsXkpwKjAwHEMIH679YnjVGgAtZZ8/qAZjSgnhoiyK3
         nmpOdUSwvGTWN6KG8ps5piInexMRyZN/vARsuNaVVFYpzqEJBs6pwrJGQ48ICrAfhYxF
         6OpxSelHiKJWOtQ9SLOxkDsRT19guCbMuD+qFMEm7Z/KT0CYk/Cz9XMYKehcC7pUOFFH
         taXX+0UI2gyub/cU/18tMKOR96mr6dnJKhDCsfimN25HrNaibYQTskU3a7YTnsVmVYeC
         7xHQ==
X-Gm-Message-State: AOAM531J0+yBROCkJXEVo5W4q/XXPEiU3h/5LxdA7ol5h4ZdBtBO+bJp
        cA9lHSxrUGPQFIqfwoyw+DggxX13FyBpNPXbxOC1WNcqArM=
X-Google-Smtp-Source: ABdhPJyySuy9ApKV3weFE1PQmtcJv7Ocixo7pgfEBf5PDD/Lneqrd4MUHVlbd6FBUof+hSgszg3MPvDn2MQ4X/Fd6EY=
X-Received: by 2002:a6b:bb43:: with SMTP id l64mr11534920iof.191.1592992221999;
 Wed, 24 Jun 2020 02:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsM+SccvqTBR68b_a=a__BPN2+XCqjCGSCoGBKGqRZLV5Q@mail.gmail.com>
In-Reply-To: <CABXGCsM+SccvqTBR68b_a=a__BPN2+XCqjCGSCoGBKGqRZLV5Q@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 24 Jun 2020 14:50:11 +0500
Message-ID: <CABXGCsOB7DZSCC5M4miPdi9PXSRUbQRiMxrnwi3QBFhkgetFAg@mail.gmail.com>
Subject: Re: [snd_pcm] [5.8RC1] kernel BUG at mm/huge_memory.c:2613! (system
 stopped playing sound)
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 at 10:26, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi folks.
> After upgrade kernel to 5.8RC1 (git69119673bd50) my system stopped
> playing sound.
> In the kernel log, I see the message 'invalid opcode: 0000 [#1] SMP
> NOPTI' which probably related to this issue.

The problem with no sound was fixed after RC1 git 1b5044021070,
but all my USB headsets (ASUS ROG Delta and HyperX Cloud Orbit S) play
sound as if in slow-motion.

Demonstration: https://youtu.be/-1caV5Yn85E

And RC2 git 625d3449788f does not solve this issue.

dmesg output: https://pastebin.com/d5Mb2Z2B

--
Best Regards,
Mike Gavrilov.
