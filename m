Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375D0C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B101206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 22:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585781887;
	bh=91M8nqbxooeMFOEgYxQwLm7fa8krUv3JHjmd9bmF118=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aKqif59a8q+Y2LRsGJX2ouwkOcPTAxSFjtPV3PB+vOekJRNcI2EAIaVRKoDup00RC
	 aFdqDhP9M5erE5F0k+hs2B3amopeCXC4TFvlgK+4gqBXKFH5Ig4SpjcsuyHlH00pFn
	 6Qk0RViTKpAQN7VKwP8nSPqcjhWndozGrV4NAIn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbgDAW6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:58:05 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36794 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbgDAW6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 18:58:05 -0400
Received: by mail-lf1-f67.google.com with SMTP id w145so1149505lff.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 15:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gad56CloD439ohxZjon0dupGvFU9Ybe3HRlECYVOlSQ=;
        b=HocDrEHKCiLFMTYMd1fZhuSqk9lSxwYngye9ESDy4iznGNrUlEieE17iajSRTSIZbJ
         y0Mgxw7e+T1ZgkLL9I4+n1tKn9eNXCLNyNKwQZIRiOByysW/W4EN9GQZPCSTHSGkcf6e
         vJ7T6MFuMaUGRD09FJs+TDBi0Mq/3zgtK1QDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gad56CloD439ohxZjon0dupGvFU9Ybe3HRlECYVOlSQ=;
        b=PCY5SHEIGsTHSc3bRiAYQObE2au2OV+WKx/49MJKvF0+7vc0YwsOtwwVRVN/uf6jU1
         HvuvovRJhGcn+oxgJ2QgCCDnvR6XdHGVOp2SP0AHYtjk70mQgs8xqOoo9w0yF4TXBRPv
         nhik1tIGEmtJMQk0Qoin0NmOqXuuvUJKTbkqqc2cxqznONEaAhWmFu6RmwGeMc0MQJ4J
         g4CsZfTk4x4AIc9VCbjxqwFD9V34bhhshdVQ9KIU+IdmyweoQPWbhXH/OaVPxCIfrntZ
         jLwGO6E7Qb/dXvqb6mcQcPIhOT1yBBPzxPEQ1GmQl2gog0jiDazLeEoQMvXw2+qsNZd8
         LtMg==
X-Gm-Message-State: AGi0PuaoIBq8vwpZhG4GwtsNXib1rMcDuyAm+rfHr35L7UtmW/Gf8H7l
        dmcJAU3mzh/HrnAJg6Tg9+7dtSTB7h8=
X-Google-Smtp-Source: APiQypIEMSqAQc5BtwKTekKCAt1GaL33SsHI4CeK0GLJo4zioxiq5jJb4SXb5ghtXrAtcls0l2EUcQ==
X-Received: by 2002:a19:5508:: with SMTP id n8mr286670lfe.1.1585781882358;
        Wed, 01 Apr 2020 15:58:02 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id c22sm2500337lfi.41.2020.04.01.15.58.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 15:58:01 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 131so1094186lfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 15:58:00 -0700 (PDT)
X-Received: by 2002:a19:6144:: with SMTP id m4mr277724lfk.192.1585781880067;
 Wed, 01 Apr 2020 15:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2004011353080.19500@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2004011353080.19500@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Apr 2020 15:57:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgy8AM+BOt4jhnoQ+wa=YVyXT4ARg=qEYC=S-OW4ZjZzw@mail.gmail.com>
Message-ID: <CAHk-=wgy8AM+BOt4jhnoQ+wa=YVyXT4ARg=qEYC=S-OW4ZjZzw@mail.gmail.com>
Subject: Re: [GIT PULL] HID for 5.7
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 5:11 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> Samuel =C4=8Cavoj (1):
>       HID: Add driver fixing Glorious PC Gaming Race mouse report descrip=
tor

What a glorious name for a piece of hardware. Even if it's apparently
buggy and needs help to work right.

I felt bad saying I don't need that glorious driver when doing my oldconfig=
.

Anyway, because I noticed this due to the name, it does strike me that
clearly Windows must be ignoring - or otherwise reacting differently
to - the HID_MAIN_ITEM_CONSTANT flag. Because presumably those mice
work under Windows without special drivers?

In fact, reading that driver, it looks like they report being *both*
constant *and* variable in their report descriptors. Which sounds odd.
Maybe we should do whatever Windows does, and not need a special
driver for this maybe-bot-so-glorious-after-all mouse hardware?

Hmm?

              Linus
