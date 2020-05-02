Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E39C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 21:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73DE20757
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 21:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duKx9r7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgEBVpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 17:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728517AbgEBVpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 17:45:49 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A750BC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 14:45:49 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b188so12770110qkd.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 14:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bX94DfQt1bV1P2YZB/N6Fk9j80RMwAHUWH/2nPEPXCU=;
        b=duKx9r7fwvG40664Z5QBj0CHyTmrEegm9PwE6Kel4jwKMf92j/Tuxs0l/Zq2yV7XHE
         JCoKU+9LHlEyKua+RFEOHysV5KbBw4SAWO4vfbkG+wMgjTZCOvNbxMIAdyyPA5aJmTYf
         OhUsmtRcP+H8cJakP2abIu+BKOdM6AHJjC60l5Swde1RLNmEGhxWXHkUZE0n8AfnSnfi
         xk6KnwSmOFiWEHKvvy2vjBEdOfZYaQVxe6Xorqnacd+ocXV/CKc5MpNEXBkT2k7D3hXz
         /6cjUAawY046PnPS6Hfs8eD1tXI9t3YWRe5ulsllPaWaK6Xf5njqHgdK7rseVHkt/+rO
         zWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bX94DfQt1bV1P2YZB/N6Fk9j80RMwAHUWH/2nPEPXCU=;
        b=XOFGcErFq8edK3CX5/1bmdZlJGlY2JhyEkIiLwBPDWuYzrwwaKjiQv1eSSsWwm1Rr3
         yel01Imk/ZTZb2r9YWWS8sSgY0wb+WR6jMyEkmOlM7t7TReFdeHdbB4C2ZDHpi5nuG42
         W3lMwpzpV71GU+i4n0hL9WtDt59/sVER9/B5Rr79JMItu3TMK2XjfS/yR4ZwNp3/BAv/
         S0t15Uc9izVEaItUdpSPNAJSRlsPThyW8zRATetuadm6SaNr9H6eU7GqgV4bl89aT2PL
         hY8aG7NEWh6ZfcMGIvfPEQgSUf+Up9/XbQL3qiSS0zVjzUAREkLjj6saAy0bhkcS0JAb
         jw4Q==
X-Gm-Message-State: AGi0PuY8RJmjSi+65NQ4UjSphCSd71EMXiKzYFZNK9Pjm8NW73k8ZxgN
        hOxv4dPo+CTIhg1ca5xOXd6dvbPwNsUBsW9mf4M=
X-Google-Smtp-Source: APiQypKFp6uLo3VPXXCORVmpDhKDAs3RqjYUX+zAVi/8eQ5Z7m215a42eKq/eaDp/zxiyo/aHrIlBOYD0Ygeh0+6NWo=
X-Received: by 2002:a37:d0f:: with SMTP id 15mr8420764qkn.276.1588455948750;
 Sat, 02 May 2020 14:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200502193120.79115-1-anarsoul@gmail.com> <s5hmu6qgjry.wl-tiwai@suse.de>
In-Reply-To: <s5hmu6qgjry.wl-tiwai@suse.de>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Sat, 2 May 2020 14:45:22 -0700
Message-ID: <CA+E=qVdwb==MfdbWS2oSCDN=eKd0dhJ5a6iEpwMPZcFCWr3Rvw@mail.gmail.com>
Subject: Re: [PATCH 0/2] ALSA: line6: hwdep: add support for poll and
 non-blocking read
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@denx.de>,
        Allison Randal <allison@lohutok.net>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 1:32 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sat, 02 May 2020 21:31:18 +0200,
> Vasily Khoruzhick wrote:
> >
> > This series adds support for polling and non-blocking read for hwdep
> > interface. This allows apps to listen to HW events without using busy
> > loop.
> >
> > Example of app that uses hwdep interface for POD HD500 can be found
> > here: https://github.com/anarsoul/line6_hwdep_test
> >
> > Vasily Khoruzhick (2):
> >   ALSA: line6: hwdep: add support for O_NONBLOCK opening mode
> >   ALSA: line6: Add poll callback for hwdep
>
> Looks like a nice extension.  Applied both patches now to for-next
> branch.

Thanks for such a prompt response!

>
> thanks,
>
> Takashi
