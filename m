Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06330C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE33C21473
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkHuSfml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgEGKBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgEGKBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:01:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14A5C061A10
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 03:01:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j3so5612362ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 03:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1Be+iELEaGBQtXonCwj1c6TNB0kDNwS6v3vYCB59a0=;
        b=JkHuSfml3EgARYC8FMpEd3gAeS1UEfhzcr3L/FFfyBwuVYzu5arGB1JQrQVXCSAx8o
         dKj87Um3DMpdj2UhEhYv0n8z452mqoRtxpaVW0E/fr1g7tBZfAleLPgSyfvZ6Y7sKaEn
         rn5SbK5SLZynH8v8mbhmPoALXMC7dpaJJYpjTYAk+CjTcBSjfE7yd8301n7XrNeUxLdr
         zF1yv/Hc6WbIS26fNfBbnEvCGXAOBRG3RrRvIEc+y993L6zgPv1ojRknB0PiyQIQPbD6
         qKGLrrK9SLGbfuLliVSEEOmc+oZcGGnDtpGmfi3YJ9sVVkm8TAMoUAijxsqkJEwajuJY
         6/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1Be+iELEaGBQtXonCwj1c6TNB0kDNwS6v3vYCB59a0=;
        b=e9rwUcOwpoyCjtwvkNmk6BlvwvSHktHMrzLcb8vlFe9fniBiZoJRC6siC+5hB3YkG+
         wUMfX8Gjp9LvVrm4ONTpi/MuCue7nibalxVcRfK2S+G55v3fHNpjOLjMPWEJj4cQ2NOf
         xoCoRZXOqKt7PFZQWNSoPDxYRmizqwhX18rW2/oghZPVC8LWizLsbHaryOgfNmJ+XNhj
         I2/lXFR1R6Qj9KrRD9VpLG4UruDGJVb4ubKfVtBMipMcXxjA7Kh1MR4tDgBp1oDt4qrh
         JOqMDgDr3dItUYqHgwxskUYFRgtzk9YyantXuVndLzi1sakqIQGDCzDbt/Ue4KRqN4Ql
         VLEA==
X-Gm-Message-State: AGi0PuZ7iqKxWka/SheNjgU4Q25TyJH60E3JzZI9neREln21dnjBc+v9
        kocaAEkGjxKbPOuQHmSQEdYQxAtI+iufMA4TDXg=
X-Google-Smtp-Source: APiQypK+mPvbELrXTbvTW39d/VBur7XHkX0v6bjIPELwPCrK3R3hHWSWXKncrvOzzO8clbdIJ6FHXDpwpK9eVZWrUqI=
X-Received: by 2002:a2e:8949:: with SMTP id b9mr8109025ljk.108.1588845682372;
 Thu, 07 May 2020 03:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAFcO6XMWpUVK_yzzCpp8_XP7+=oUpQvuBeCbMffEDkpe8jWrfg@mail.gmail.com>
 <s5hbln05b1h.wl-tiwai@suse.de>
In-Reply-To: <s5hbln05b1h.wl-tiwai@suse.de>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Thu, 7 May 2020 18:01:11 +0800
Message-ID: <CAFcO6XMitGEYHYykgmzWc4NWME+O+1KTXfmf2zaeN147c2y4_A@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in snd_rawmidi_kernel_write1
To:     Takashi Iwai <tiwai@suse.de>
Cc:     security@kernel.org, syzkaller <syzkaller@googlegroups.com>,
        tiwai@suse.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No, it's not.

Regards,
  butt3rflyh4ck.


On Thu, May 7, 2020 at 5:50 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 07 May 2020 09:54:34 +0200,
> butt3rflyh4ck wrote:
> >
> > I report a bug (in linux-5.7-rc1) found by syzkaller.
> >
> > kernel config:
> > https://github.com/butterflyhack/syzkaller-fuzz/blob/master/v5.7.0-rc1.config
> > reproducer:
> > https://github.com/butterflyhack/syzkaller-fuzz/blob/master/repro.cprog
>
> Is this report different from your another one?
>   https://lore.kernel.org/r/CAFcO6XMGT42wFBxEa01Ee5Msuecm+WiXnn4rc-VWkC4vTzycPg@mail.gmail.com
>
>
> thanks,
>
> Takashi
