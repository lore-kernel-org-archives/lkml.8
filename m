Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9EEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 01:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADCAD20656
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 01:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BClZOK3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgG2Bl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 21:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgG2Bl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 21:41:57 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EDDC061794;
        Tue, 28 Jul 2020 18:41:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 74so3824099pfx.13;
        Tue, 28 Jul 2020 18:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ShpMJE4OIEv6PxHTCcLYNHQznGjFTXHy5yRHP4HI7Go=;
        b=BClZOK3dAzubCSEkbwRfwnCusyjEcYWZ7pk8/KbxyBcExOrFWxmlvM19CYMKFTYj/w
         C7sIyeILZs1yEzEVoYrjY2zvprbMcO9Vvjow5oWczQC1JIEi2oZ/bKDVqfReXYasxfjW
         JaQtvkzKr/3qVnoSxEgL6Ebd8YtCEAbOlqC2D9JxOgpxYIhB2nhH+8zNg87hRGDFWrWe
         q6GKmziLH6Oe4Hiit/fwwXxYnl0JSCMo8uFehR1mQU9RMgbUVTQ0Z8iup0dPlChQ/Pb3
         qwGBs/ms5wfED9RjRmE0ZBybq53yewSsNNkLVDGESsXuhPSRQVKY7lI3KDKt79WuYK3v
         TdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShpMJE4OIEv6PxHTCcLYNHQznGjFTXHy5yRHP4HI7Go=;
        b=lipN9On+MtpkJn1ljpY8cGWST8NcYGtnr0Xe9Ej5vWdot18RGunoX9K43ENQw7xDGA
         wPSPGVpjLa3XggUDbawQineWCXaNT9ZfbmEn25gYUTSmbvnupgdcPqXoDEAAUOd7xr3p
         Dv9tX2vQ8upXjQlt03knuC1hnp+bAA258IOTyDnJFegGEJ1Z4+YXY9NQ1e7PDfqmwg0+
         /HKkfLGqNmsLmhKTdNwXkl5mfOe0kRYxyQ4E2RJuFICUFuuzmvJwEG/cffY1R+fj91PQ
         E7Z1VqT2/6rxLqLrSWbOXLhGNXlAvuZ3pGzTHsxF5kB+rdPEGFyDrZ87tFI5rGOtQEDM
         oE9w==
X-Gm-Message-State: AOAM530fWpjTwpbnHhL+QxOscWS7drhbL81fmncS+vYmkpg7rJziVdq9
        aBWfy5Fp7wjVLtlnvC44HO6oMh4OkL0Vf1KzMJc=
X-Google-Smtp-Source: ABdhPJzRyRPYIzQuluFIPUnCUXJqDzC9f1vexKbcyflvgO7aEhNqaBlnKXxoCBVGQgappFRHb7pbRVGvKerBnMB+f88=
X-Received: by 2002:aa7:9d0e:: with SMTP id k14mr3291266pfp.162.1595986916147;
 Tue, 28 Jul 2020 18:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200726110524.151957-1-xie.he.0141@gmail.com> <20200728195246.GA482576@google.com>
In-Reply-To: <20200728195246.GA482576@google.com>
From:   Xie He <xie.he.0141@gmail.com>
Date:   Tue, 28 Jul 2020 18:41:45 -0700
Message-ID: <CAJht_EOcRx=J5PiZwsSh+0Yb0=QJFahqxVbeMgFbSxh+cNZLew@mail.gmail.com>
Subject: Re: [PATCH] drivers/net/wan/lapbether: Use needed_headroom instead of hard_header_len
To:     Brian Norris <briannorris@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux X25 <linux-x25@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your detailed review, Brian!

I guess we have the same understanding on the "hard_header_len vs
needed_headroom" part. I agree it is not well documented and is also
confusing to driver developers. I didn't understand it either until I
looked at af_packet.c.

On Tue, Jul 28, 2020 at 12:52 PM -0700
Brian Norris <briannorris@chromium.org> wrote:
>
> What's to say you shouldn't be implementing header_ops instead? Note
> that with WiFi drivers, they're exposing themselves as ARPHRD_ETHER, and
> only the Ethernet headers are part of the upper "protocol" headers. So
> my patch deferred to the eth headers.
>
> What is the intention with this X25 protocol? I guess the headers added
> in lapbeth_data_transmit() are supposed to be "invisible", as with this
> note in af_packet.c?
>
>    - if device has no dev->hard_header routine, it adds and removes ll header
>      inside itself. In this case ll header is invisible outside of device,
>      but higher levels still should reserve dev->hard_header_len.
>
> If that's the case, then yes, I believe this patch should be correct.

This driver is not intended to be used with IPv4 or IPv6 protocols,
but is intended to be used with a special "X.25" protocol. That's the
reason the device type is ARPHRD_X25. I used "grep" in the X.25
network layer code (net/x25) and I found there's nowhere
"dev_hard_header" is called. I also used "grep" in all the X.25
drivers in the kernel (lapbether.c, x25_asy.c, hdlc_x25.c under
drivers/net/wan) and I found no driver implemented "header_ops". So I
think the X.25 networking code doesn't expect any header visible
outside of the device driver, and X.25 drivers should make their
headers invisible outside of them.

So I think hard_header_len should be 0 for all X.25 drivers, so that
they can be used correctly with af_packet.c.

I don't know if this sounds plausible to you. If it does, could you
please let me have your name in a "Reviewed_by" tag. It would be of
great help to have your support. Thanks!
