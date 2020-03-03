Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74C2C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CC720842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DIVZ+3pW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbgCCUxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:53:00 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42413 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731796AbgCCUxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:53:00 -0500
Received: by mail-vs1-f67.google.com with SMTP id w142so3351499vsw.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 12:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySvw2VElOoI+GxWwdqvLapZW7S1uwrffgeO7svUy80k=;
        b=DIVZ+3pWVbzuKToHdSMqua+XDKFW685uSgRxSDqtN80EEn2THAGD+9qpxgcE6WaJ/0
         3fnHp8XrClvfRUtbSF1+afo1PciMZrjHCqs3+HZ+GgchXzD1hpI50Qp/kmsr1mFijGIy
         C9v5UnGj+C5SWlCdZRBMAFMoNGDxLr8CbzbGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySvw2VElOoI+GxWwdqvLapZW7S1uwrffgeO7svUy80k=;
        b=edkvX4TPej7d3/Zmq1VBvU+uf1PhtAnJ0dmJthlzzuVBCJAhi4HMy6JC6/DmcTu/IA
         6TtG4pHJNhoGtI0G8K6HTf5q+0nwWKlJIue9MVNNqEgzoDTlYhmNH4vojfbSY0A2v6Jp
         W/KcMXB03NgzkQvonJiZwBMtSZXSTR6U914DW2PYgsbPKscpbVtQXhg6bJgl3yafN40Y
         SuRSHgwv+WokIvtrq6gL7aRFJ59n29FtSrv8dORc9iPtFvQzIgW8x7Fk17stadGgf6Pn
         Q3rreGn+skYsDi5KZwedCwC5actQFfPddYot5EH4FRdJcZkeZA4IYVPxNmQ2b79TEAIT
         HgRg==
X-Gm-Message-State: ANhLgQ1grXZ77xyxa2VvHLgejrW/KOJRm+MEPTwKMH9APyCSuCkqrr56
        XuvwCXmxQ66LORGKpFyQSl2ffkR/HWQ=
X-Google-Smtp-Source: ADFU+vvuuyukfm1snxxhBwLPg00wGAElPYNMvrahs8BZEy8zXhr5H2aXry77N0PJbmv1C7g0td6qsQ==
X-Received: by 2002:a67:f557:: with SMTP id z23mr3519341vsn.21.1583268776787;
        Tue, 03 Mar 2020 12:52:56 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id h16sm4472440uao.7.2020.03.03.12.52.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 12:52:56 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id u26so3388487vsg.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 12:52:56 -0800 (PST)
X-Received: by 2002:a67:e98e:: with SMTP id b14mr1311097vso.106.1583268775719;
 Tue, 03 Mar 2020 12:52:55 -0800 (PST)
MIME-Version: 1.0
References: <20200213150553.313596-1-daniel.thompson@linaro.org>
In-Reply-To: <20200213150553.313596-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 Mar 2020 12:52:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Uqgjgf+hL7=tpBixyxiDhXA_k5kfZ1RUtk6f+CVgUikg@mail.gmail.com>
Message-ID: <CAD=FV=Uqgjgf+hL7=tpBixyxiDhXA_k5kfZ1RUtk6f+CVgUikg@mail.gmail.com>
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

On Thu, Feb 13, 2020 at 7:06 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently the code to manage the kdb history buffer uses strncpy() to
> copy strings to/and from the history and exhibits the classic "but
> nobody ever told me that strncpy() doesn't always terminate strings"
> bug. Modern gcc compilers recognise this bug and issue a warning.
>
> In reality these calls will only abridge the copied string if kdb_read()
> has *already* overflowed the command buffer. Thus the use of counted
> copies here is only used to reduce the secondary effects of a bug
> elsewhere in the code.
>
> Therefore transitioning these calls into strscpy() (without checking
> the return code) is appropriate.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index ba12e9f4661e..a4641be4123c 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -1102,12 +1102,12 @@ static int handle_ctrl_cmd(char *cmd)
>         case CTRL_P:
>                 if (cmdptr != cmd_tail)
>                         cmdptr = (cmdptr-1) % KDB_CMD_HISTORY_COUNT;

The above line (not touched by your patch) is slightly worrying to me.
I always have it in mind that "%" of numbers that might be negative
isn't an amazingly good idea.  Some searches say that this must be
true:

a == (a / b * b) + a % b

...which makes it feel like this is totally broken because "cmdptr"
will end up as -1.  Huh?

OK, after much digging and some printouts, I figured this out.  cmdptr
is _unsigned_ and KDB_CMD_HISTORY_COUNT is a power of 2 (it's 32)
which makes this work.  AKA if you start out at 0 and subtract 1, you
get 0xffffffff and then that "% 32" is 31 which is the answer that was
desired.  Totally non-obvious.

I guess a future change should make the above:

cmdptr = (cmdptr + KDB_CMD_HISTORY_COUNT - 1) %
  KDB_CMD_HISTORY_COUNT;



> -               strncpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
> +               strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
>                 return 1;
>         case CTRL_N:
>                 if (cmdptr != cmd_head)
>                         cmdptr = (cmdptr+1) % KDB_CMD_HISTORY_COUNT;
> -               strncpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
> +               strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
>                 return 1;
>         }
>         return 0;
> @@ -1314,7 +1314,7 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
>                 if (*cmdbuf != '\n') {
>                         if (*cmdbuf < 32) {
>                                 if (cmdptr == cmd_head) {
> -                                       strncpy(cmd_hist[cmd_head], cmd_cur,
> +                                       strscpy(cmd_hist[cmd_head], cmd_cur,
>                                                 CMD_BUFLEN);
>                                         *(cmd_hist[cmd_head] +
>                                           strlen(cmd_hist[cmd_head])-1) = '\0';

At first I thought the line after the strscpy() could now be removed,
but then I realized that it was stripping yet one character back.
It's a bit twisted that this relies on kdb_getstr() happening to leave
the buffer in a specific way (zero-terminated and with one extra
character at the end) when kdb_getstr() returns it's special control
characters, but not part of your change.  I guess maybe a future
cleanup could try to make this saner...

One thing that could be done to at least make it slightly cleaner
(aside from adding a comment) would be to take advantage of the return
value of strscpy() to avoid the strlen().


As with all things kgdb, there are plenty of things to fix but your
change moves us in the right direction.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
