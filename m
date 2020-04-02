Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FED0C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1F32078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmpK/XTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389888AbgDBUYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:24:08 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:42372 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389833AbgDBUYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:24:08 -0400
Received: by mail-lj1-f177.google.com with SMTP id q19so4628070ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fd7SnHx/BOHrzDzo3nH08QLfVlwlj49uD4NgD9MIAUM=;
        b=LmpK/XTqFkxVE/uzrxR7Nn0px4cu68RK55CBQlYhdlCLD4l0FGphLsa8/q7SbLJxro
         vrNChY8y8iFa1tBKjBi9Fl9IXNPYggUsLVo+pY5Ef39oq4gSiB7itwTieE6RojBWrU39
         PLDpuWOGcnU+UGUDMmXMop/NeeC6+TRuFFfJ3Qv9vMoPL2r/8UFczotnUb3tMOMiYZhJ
         59C7vhvO+Y/ii2RGHcVLY3av2KTl0wa953QAqG7yIGz3XsvIGuBR6JBp613sAk030gAj
         50Me2i29jSJfFbIXQbTVcur5vO5rMIKBA1T/iHyCi3a6ytEHxx3+tmKlc+YG1LXXMdXu
         vYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fd7SnHx/BOHrzDzo3nH08QLfVlwlj49uD4NgD9MIAUM=;
        b=EggvluSCptVr0DgK51yhWfGR58zRpj61lzrPwPNvpwjpL9sw4lGMmpaY0maS1nmxvU
         5ysKZTT7PRKPK3Qxu4C/+AY0w+Ni6XB5o9jMkffxPi7OqJxWElqB0S2uFaSGkV4qQASS
         KAvhwHl3IDjd/+RoT0KvbNDGiMgbUX8xrAE/2HssmASYnqYrmPSodgMn58nOGRDeat0N
         k/tzageEvnBl6wlGK5Zaa/WFmhk2NHF+IbNH1hGW94vzYc4JJGgCJhDA46rLozJpp7c/
         EtQJJTaTAyRy0zQss6nI9qkJupDw0yzY0fIhh9tFbUmkPJywakyjZPUAcD3kHAm+gibz
         U0oQ==
X-Gm-Message-State: AGi0PuamuJa7RGCisBmrqWSNB5iIRgTOtVsbEkNSzWY75dFV/5fODqv+
        PAB9eODBo5JnlwB5yPlMQTOMHYIC10uC46Q4S5h5s719
X-Google-Smtp-Source: APiQypJuMtOc9TQhQSJQ9YqdqNy91MDt2ZC//pHWDodJcq4ukVmCAJFKXihucqFrS4KvdwMc0eN9EB3DiK04egL0xUU=
X-Received: by 2002:a2e:8693:: with SMTP id l19mr3227736lji.132.1585859046516;
 Thu, 02 Apr 2020 13:24:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:3f07:0:0:0:0:0 with HTTP; Thu, 2 Apr 2020 13:24:05 -0700 (PDT)
In-Reply-To: <s5hblo9u326.wl-tiwai@suse.de>
References: <CACMCwJ++6kikxaEUon3xfwm1h3hTQ+V9BoJEAeToJQKwTufDsA@mail.gmail.com>
 <s5hblo9u326.wl-tiwai@suse.de>
From:   Jari Ruusu <jari.ruusu@gmail.com>
Date:   Thu, 2 Apr 2020 23:24:05 +0300
Message-ID: <CACMCwJK-tdLciXkUjLsLshma0O3=_89w0SfNKXgkp6Fh9Fcd=w@mail.gmail.com>
Subject: Re: linux-4.14.175 broke audio
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/20, Takashi Iwai <tiwai@suse.de> wrote:
> Does the patch below change the behavior?

Yes, it fixes the problem. No issues observed so far.
Thank you for your quick fix.

Tested-by: Jari Ruusu <jari.ruusu@gmail.com>

-- 
Jari Ruusu  4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD  ACDF F073 3C80 8132 F189
