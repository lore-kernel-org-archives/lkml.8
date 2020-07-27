Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F825C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEA220714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20150623.gappssmtp.com header.i=@draconx-ca.20150623.gappssmtp.com header.b="PcQmdoob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgG0RmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbgG0RmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:42:23 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF16C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 10:42:23 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id y17so9156360ybm.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8eTEImJlgOllN2N0LVMVlZdkUWAqoKd8wMgN/KPPGyw=;
        b=PcQmdoobad+ns7LDo62SRtHFW8CqQRB4OfyM2CsoZ5l2gfI3wUdbpc9Yj4KvkWQZ7N
         8XdUhqrCIftgytbRI9vziHsjeNts5Uh0BVZAoJRfgAg4KwEgh3NrzyaHezhLeYBHPm4k
         F9FpyLz33eEJtNjfTrmzoHAu2Kt0lmU+UvpqYdD4nGUjCxAAcNsx/Uutbvv9pyJ6WklG
         I/dm5avZl3GKTeDD1o7/dnoIBjePWFod0UvfipQJZ89CLhFLxYeAAcmFe7sD77C2yuuo
         MoF5iah1OaPspUQibfWciLZeqwnZ8uDhkv8mEi6YPGVvRsqjNTvmQael1e32eCGsndnj
         y85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8eTEImJlgOllN2N0LVMVlZdkUWAqoKd8wMgN/KPPGyw=;
        b=U5ZmepKqiG7rKkD7eloqXQiZOdcUr0OhZDIlLJNyNHDdOuCHxD4NL6xG1BuUF7VAq0
         oXAfBe91omfxqrDk6FnsH0v4kx7D2OulNJ3qBiqOWJlsyCYoz9kgaBUL2PMr5Hf8gEkd
         BK1AAmtwPlO9Z1iD2Sw/NkRUiki14EYN7dpSPGAl1DJkZenCp8+lckqHM3PlfAejc2AI
         0NgOUuv/n8LtrK4pvRydyJfRslZ3MkqOVdm3Hcl4K4d1WDhCVwZrrIigk4D+1FpUW9be
         7wwcCyZ2V35kV6xaI+V0RjVbPmGO4YxIgSlalLTpwKQbt6M52r0LC1CHT2I+nd5HwhrG
         g7RA==
X-Gm-Message-State: AOAM533aZzIXHRR4s64z7XpTOVRsYSlfk9AEdp3n4o+SjBHrg2VpPcdU
        ngGi3hx+wMqJMetoJS/LOPvX1D/h3e2xWV2/8UvHtg==
X-Google-Smtp-Source: ABdhPJyhgSDpr2FdTbpW7mQoCX8b9rF1eP3wUiwp1GHuEIFPNp42c9HwMG5miSAbYBtkAYUJUXiKKPD+jHA9yuLX72s=
X-Received: by 2002:a25:b446:: with SMTP id c6mr36564613ybg.279.1595871743002;
 Mon, 27 Jul 2020 10:42:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:807:0:0:0:0:0 with HTTP; Mon, 27 Jul 2020 10:42:22 -0700 (PDT)
X-Originating-IP: [24.53.240.163]
In-Reply-To: <20200727161319.GH794331@ZenIV.linux.org.uk>
References: <20200723155101.pnezpo574ot4qkzx@atlas.draconx.ca>
 <20200727160554.GG794331@ZenIV.linux.org.uk> <20200727161319.GH794331@ZenIV.linux.org.uk>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Mon, 27 Jul 2020 13:42:22 -0400
Message-ID: <CADyTPEx_dppsUK_SdPKfn-1ZgEzYubbe4tBmXSKBBXTFT5cbWA@mail.gmail.com>
Subject: Re: [PATCH] Re: PROBLEM: cryptsetup fails to unlock drive in 5.8-rc6 (regression)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-27, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Mon, Jul 27, 2020 at 05:05:54PM +0100, Al Viro wrote:
>> On Thu, Jul 23, 2020 at 11:51:01AM -0400, Nick Bowler wrote:
>> > After installing Linux 5.8-rc6, it seems cryptsetup can no longer
>> > open LUKS volumes.  Regardless of the entered passphrase (correct
>> > or otherwise), the result is a very unhelpful "Keyslot open failed."
>> > message.
[...]
> Oh, fuck...  Please see if the following fixes your reproducer; the braino
> is, of course, that instead of fetching ucmsg->cmsg_len into ucmlen we read
> the entire thing into cmsg.  Other uses of ucmlen had been replaced with
> cmsg.cmsg_len; this one was missed.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/net/compat.c b/net/compat.c
> index 5e3041a2c37d..434838bef5f8 100644
> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -202,7 +202,7 @@ int cmsghdr_from_user_compat_to_kern(struct msghdr
> *kmsg, struct sock *sk,
>
>  		/* Advance. */
>  		kcmsg = (struct cmsghdr *)((char *)kcmsg + tmp);
> -		ucmsg = cmsg_compat_nxthdr(kmsg, ucmsg, ucmlen);
> +		ucmsg = cmsg_compat_nxthdr(kmsg, ucmsg, cmsg.cmsg_len);
>  	}
>
>  	/*

This patch appears to resolve the problem when applied on top of 5.8-rc7.

Thanks,
  Nick
