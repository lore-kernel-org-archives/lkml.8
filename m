Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E619DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D99206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bqOH7tKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHXSxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHXSxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:53:09 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F178C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:53:08 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id s9so5064002lfs.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kr/ilKP3KtnpaNLBR4Wfqo2ibtevdlA/61dd3WxVQbQ=;
        b=bqOH7tKogCiyKYB3sMzalRYYv42T8tBwVa1C577l6dLDiQqHISTeBcw3/rVMjcQVRr
         +oeKkG0mXbC9eLC33+u8/ltcR8dvp2UukEC9uSYpxY/C3Gkwd5Y8jfWXavf3P3sBT+Er
         X0gXWdng+UeTkQ4qPQxDaSxZZL7g5raQtCJsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kr/ilKP3KtnpaNLBR4Wfqo2ibtevdlA/61dd3WxVQbQ=;
        b=KQh/97Zihta8lzoubao7TtScOsnE6A8ZFfkOUlf100CYOg/QV66erPS3QdB2FA7ufu
         0GWAS6t1gTm2h/qfOdpbzUnWH0Dikb0gDPa+Egr8B02vkhbaBEXqKvbjdW63MabRiwyJ
         wV21tISVsG7E8NMNGRuTaiO6EMrXUJxpV9IkY6QU+Lxp63Vc4gDXtr+6UhyNr+ZzmIK1
         RlqsM7UMyqTdx/kKbCxn/IDg/1ALd29jlXwGgB8fkoOX2ld5iTT8navPp25LdH9EfjPO
         QjQ+4o2SBUesdYmCS2L7FS7JLs0Wrc41wH6EjUMjdPUe7hltq0Ia66tDh9+vPFdehorF
         6bSQ==
X-Gm-Message-State: AOAM531RcnW2FqRrK5riMtFMnY5efAsvlSRS9M7lGY0MNv8KJutoeSE0
        fqDc9+hDhmeb8Wm/I1rn9m6dPKwc1SJGeg==
X-Google-Smtp-Source: ABdhPJyXy9ttX/Eo51XPJdJQEXNsfnpN7yzT6Um0xNgrhz500Ryuk6NUh4Hkgb/0qGogYNx/YyFhAA==
X-Received: by 2002:ac2:4c0a:: with SMTP id t10mr3248261lfq.90.1598295187009;
        Mon, 24 Aug 2020 11:53:07 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id e14sm2335668ljl.96.2020.08.24.11.53.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:53:06 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id v12so10875535ljc.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:53:06 -0700 (PDT)
X-Received: by 2002:a05:651c:d5:: with SMTP id 21mr2906073ljr.276.1598295186265;
 Mon, 24 Aug 2020 11:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <MN2PR18MB2637D7C742BC235FE38367F0A09C0@MN2PR18MB2637.namprd18.prod.outlook.com>
 <20200821082720.7716-1-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20200821082720.7716-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 24 Aug 2020 11:52:53 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOHDU+SWmr+7aOUtbuzC22T-UWhZXJ5UXtcsev5ZTbqMw@mail.gmail.com>
Message-ID: <CA+ASDXOHDU+SWmr+7aOUtbuzC22T-UWhZXJ5UXtcsev5ZTbqMw@mail.gmail.com>
Subject: Re: [PATCH v2] mwifiex: don't call del_timer_sync() on uninitialized timer
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        amit karwar <amitkarwar@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Nishant Sarmukadam <nishants@marvell.com>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+373e6719b49912399d21@syzkaller.appspotmail.com>,
        syzbot <syzbot+dc4127f950da51639216@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 1:28 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is reporting that del_timer_sync() is called from
> mwifiex_usb_cleanup_tx_aggr() from mwifiex_unregister_dev() without
> checking timer_setup() from mwifiex_usb_tx_init() was called [1].
>
> Ganapathi Bhat proposed a possibly cleaner fix, but it seems that
> that fix was forgotten [2].
>
> "grep -FrB1 'del_timer' drivers/ | grep -FA1 '.function)'" says that
> currently there are 28 locations which call del_timer[_sync]() only if
> that timer's function field was initialized (because timer_setup() sets
> that timer's function field). Therefore, let's use same approach here.
>
> [1] https://syzkaller.appspot.com/bug?id=26525f643f454dd7be0078423e3cdb0d57744959
> [2] https://lkml.kernel.org/r/CA+ASDXMHt2gq9Hy+iP_BYkWXsSreWdp3_bAfMkNcuqJ3K+-jbQ@mail.gmail.com
>
> Reported-by: syzbot <syzbot+dc4127f950da51639216@syzkaller.appspotmail.com>
> Cc: Ganapathi Bhat <ganapathi.bhat@nxp.com>
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

This seems good to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>

> ---
>  drivers/net/wireless/marvell/mwifiex/usb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
> index 6f3cfde4654c..426e39d4ccf0 100644
> --- a/drivers/net/wireless/marvell/mwifiex/usb.c
> +++ b/drivers/net/wireless/marvell/mwifiex/usb.c
> @@ -1353,7 +1353,8 @@ static void mwifiex_usb_cleanup_tx_aggr(struct mwifiex_adapter *adapter)
>                                 skb_dequeue(&port->tx_aggr.aggr_list)))
>                                 mwifiex_write_data_complete(adapter, skb_tmp,
>                                                             0, -1);
> -               del_timer_sync(&port->tx_aggr.timer_cnxt.hold_timer);
> +               if (port->tx_aggr.timer_cnxt.hold_timer.function)
> +                       del_timer_sync(&port->tx_aggr.timer_cnxt.hold_timer);
>                 port->tx_aggr.timer_cnxt.is_hold_timer_set = false;
>                 port->tx_aggr.timer_cnxt.hold_tmo_msecs = 0;
>         }
> --
> 2.18.4
>
