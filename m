Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D22C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 20:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA46206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 20:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="A+0JKxQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgHAUVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 16:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHAUVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 16:21:30 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C54C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 13:21:29 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i26so21313572edv.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpdyXRkNBFG6+sXGVp5popQlf9jPzy3fYXE2HQTaqO8=;
        b=A+0JKxQ5QCsn8gb7+xJ85umagCwJG/uw+1NzJiFLUjpgcXRR4gjtb5HE4aFnaPwzu1
         HMjppwxQrBwv5i/v5lo63Hwjufzk5fxMThw+JV19D63g7GccUmHqIwIGmAnQ8+2VlPK0
         wlC23XmHDRwDfW8thWYWg42PE0sDGTQ9GU2+ZVhQSHA1/ESReQTWSVYpwC3bzdJOansx
         QVuuXFViM3gppuKL3Ly+bii6ahTj51ywLoc2sWZgUd8ndRaK3an8o4+tZTxO/W4Rc4vn
         Q/dQ+ycq7cZdxFuoxGiRUVklqJCRKqWT+YiQFJQ61wAc7DKIKX90YQSB2XfED9dnYjnO
         eXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpdyXRkNBFG6+sXGVp5popQlf9jPzy3fYXE2HQTaqO8=;
        b=p3wIChUAsZ0yji6mPuOx6FAXfScDJCkARbMc1387d6w8LQAheaYHl/fHFrGjjZ/UAt
         Mw1BX5W6rH5xhhsc0Fkkpj/niBk91IrolQYYdP9z3SFbWqgBmGtFcrRh+nwFZQfzv9bE
         57yCNOMH5C00Cr1kHTRbUc5Yb2pDwfCBPjp+9tQRn0CbKF/SxpsRTgOTpxDl8CcVuw/3
         mLcpvAogFLhhtQBg8gjBZU1Ho/OLjFEZ5ASvAuURWeik59BZIpLo+Ym3bkCyeA4iefxv
         KSmjM7ovfZaDpLcy14oGdtCRL3mmdso0xhtH8E/OjsT2o7h0p4p2Ukzkqq1eppKEAbCl
         e5KQ==
X-Gm-Message-State: AOAM531TpGIdSDiBg64oB+5ghw3BJIzteRIHOu2BxHnEDlPPTHrlNZaZ
        lRcGj8VqbuvC0+/b5JL/Tfyhqz0XS8Fe3oXRe+IC
X-Google-Smtp-Source: ABdhPJxKvpP7c/4ASnHj27ybqk8nE0dF6fzyqwCvABNvHDQ61gcaXwTR2Q6Q0tBM+zsR0oflrNIPY5GLxaAiHJz9ksg=
X-Received: by 2002:aa7:db10:: with SMTP id t16mr9125634eds.196.1596313287057;
 Sat, 01 Aug 2020 13:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200801184603.310769-1-jbi.octave@gmail.com> <20200801184603.310769-4-jbi.octave@gmail.com>
In-Reply-To: <20200801184603.310769-4-jbi.octave@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 1 Aug 2020 16:21:15 -0400
Message-ID: <CAHC9VhTQTvr2+TTL3rWyweVEDx_=q81YozPJyfhELOpn9zxDqA@mail.gmail.com>
Subject: Re: [PATCH 3/4] audit: uninitialize static variables
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        "moderated list:AUDIT SUBSYSTEM" <linux-audit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 1, 2020 at 2:46 PM Jules Irenge <jbi.octave@gmail.com> wrote:
>
> Checkpatch tool reports an error at variable declaration
>
> "ERROR: do not initialise statics to 0"
>
> This is due to the fact that these variables are stored in the buffer
> In the .bss section, one can not set an initial value
> Here we can trust the compiler to automatically set them to zero.
> The variable has since been uninitialized.
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  kernel/audit.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

In general this is fine, but it will have to wait until after the
merge window closes.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 7b1a38a211a9..7d79ecb58b01 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -311,8 +311,8 @@ void audit_panic(const char *message)
>
>  static inline int audit_rate_check(void)
>  {
> -       static unsigned long    last_check = 0;
> -       static int              messages   = 0;
> +       static unsigned long    last_check;
> +       static int              messages;
>         static DEFINE_SPINLOCK(lock);
>         unsigned long           flags;
>         unsigned long           now;
> @@ -348,7 +348,7 @@ static inline int audit_rate_check(void)
>  */
>  void audit_log_lost(const char *message)
>  {
> -       static unsigned long    last_msg = 0;
> +       static unsigned long    last_msg;
>         static DEFINE_SPINLOCK(lock);
>         unsigned long           flags;
>         unsigned long           now;
> @@ -713,7 +713,7 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
>  {
>         int rc = 0;
>         struct sk_buff *skb;
> -       static unsigned int failed = 0;
> +       static unsigned int failed;
>
>         /* NOTE: kauditd_thread takes care of all our locking, we just use
>          *       the netlink info passed to us (e.g. sk and portid) */
> --
> 2.26.2

-- 
paul moore
www.paul-moore.com
