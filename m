Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0909CC35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D71208DB
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mBZidmmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgEGXN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 19:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726514AbgEGXN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 19:13:56 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B219DC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 16:13:55 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e10so4535378vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 16:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fcgsSpkOF4V2/dMkMwoZFNyt4xCzZWf3dkFNjsli0zk=;
        b=mBZidmmPO+ALfIEafwpB3wu14fPRgMvEfTO6vKXBbWujEOWhsImPNL+r3wnUG5WvGy
         dn/ZYE1eKpBzfNbebCQDk25V+8id5VgOzM8nHflavKdMaZI5O+VTx/QB+P9FwlPQOzfb
         +XGyxarvQuOB7t5RKVuMECQLXt9CjQywEdxz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcgsSpkOF4V2/dMkMwoZFNyt4xCzZWf3dkFNjsli0zk=;
        b=Nc6VehtsbX/C04CHTq8OECNczpM7Ds5pRWtb+5J/cyEi5d91wJMfkRfLU4FOzhozA0
         qapYFOW+5EPTDGQFUonXzPRg4GRbuHjDlXnuQEYhiY1Cf4SP6p9kOLWKW1rISTOPWRjT
         9sxNm/1XyGlsYGQTJRKVxy2SM+AGTGs1hXr5k2yRyZ3ljvnl9spPQFWIakIBAAqpUaFB
         UdjXAzCfW9PW0PAe+SqKJMWjcB3dJ1nwZaCU9q2KqkuCj7wtA0VvgMUemTAix16qmaEN
         aQ8aVieyA4xhYeZXqEEh67+H+vVeAP6WhUp/ZygAnP3/U0dCc3f7wI5mNMGFPXrl8/lk
         95wA==
X-Gm-Message-State: AGi0PuYzmHaJh/iP/EMU2RB8d4iRpSXEWHQYzNLsIcU6Cu6cNLFGR2Fd
        V3bme30nIkOWlG0Y82neJKOlIg1nWJw=
X-Google-Smtp-Source: APiQypK/lIoMBopLousXfEr7ss1geKg1HD2gbt5IJjfLtYLvL7XdIVaaMtyC/eFHj8gMolstOMTzdg==
X-Received: by 2002:ab0:375a:: with SMTP id i26mr13843707uat.120.1588893234424;
        Thu, 07 May 2020 16:13:54 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id q15sm3903879vsn.24.2020.05.07.16.13.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 16:13:53 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id w188so2113972vkf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 16:13:53 -0700 (PDT)
X-Received: by 2002:a1f:5fc3:: with SMTP id t186mr13876099vkb.92.1588893233117;
 Thu, 07 May 2020 16:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200213150553.313596-1-daniel.thompson@linaro.org> <CAD=FV=Uqgjgf+hL7=tpBixyxiDhXA_k5kfZ1RUtk6f+CVgUikg@mail.gmail.com>
In-Reply-To: <CAD=FV=Uqgjgf+hL7=tpBixyxiDhXA_k5kfZ1RUtk6f+CVgUikg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 May 2020 16:13:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VUj3gPmY0TznsneWMgWO6m_WqauTiYocnihm6byVU=YQ@mail.gmail.com>
Message-ID: <CAD=FV=VUj3gPmY0TznsneWMgWO6m_WqauTiYocnihm6byVU=YQ@mail.gmail.com>
Subject: Re: [PATCH] kdb: Eliminate strncpy() warnings by replacing with strscpy()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 3, 2020 at 12:52 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Feb 13, 2020 at 7:06 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > Currently the code to manage the kdb history buffer uses strncpy() to
> > copy strings to/and from the history and exhibits the classic "but
> > nobody ever told me that strncpy() doesn't always terminate strings"
> > bug. Modern gcc compilers recognise this bug and issue a warning.
> >
> > In reality these calls will only abridge the copied string if kdb_read()
> > has *already* overflowed the command buffer. Thus the use of counted
> > copies here is only used to reduce the secondary effects of a bug
> > elsewhere in the code.
> >
> > Therefore transitioning these calls into strscpy() (without checking
> > the return code) is appropriate.
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >  kernel/debug/kdb/kdb_main.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index ba12e9f4661e..a4641be4123c 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -1102,12 +1102,12 @@ static int handle_ctrl_cmd(char *cmd)
> >         case CTRL_P:
> >                 if (cmdptr != cmd_tail)
> >                         cmdptr = (cmdptr-1) % KDB_CMD_HISTORY_COUNT;
>
> The above line (not touched by your patch) is slightly worrying to me.
> I always have it in mind that "%" of numbers that might be negative
> isn't an amazingly good idea.  Some searches say that this must be
> true:
>
> a == (a / b * b) + a % b
>
> ...which makes it feel like this is totally broken because "cmdptr"
> will end up as -1.  Huh?
>
> OK, after much digging and some printouts, I figured this out.  cmdptr
> is _unsigned_ and KDB_CMD_HISTORY_COUNT is a power of 2 (it's 32)
> which makes this work.  AKA if you start out at 0 and subtract 1, you
> get 0xffffffff and then that "% 32" is 31 which is the answer that was
> desired.  Totally non-obvious.
>
> I guess a future change should make the above:
>
> cmdptr = (cmdptr + KDB_CMD_HISTORY_COUNT - 1) %
>   KDB_CMD_HISTORY_COUNT;

This has been sitting in the back of my mind for a while.  Finally posted:

https://lore.kernel.org/r/20200507161125.1.I2cce9ac66e141230c3644b8174b6c15d4e769232@changeid

-Doug
