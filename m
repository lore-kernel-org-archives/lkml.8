Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CB3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1592080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKBYWfIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgGWN52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGWN52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:57:28 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0839C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:57:27 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n24so4359997otr.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qw3sNwZZnfQZzIKQqVMkKAqZzWg7tnvfIAqHN5Eqijs=;
        b=UKBYWfIn8S3ZQi+XPGaH0O+JxYDNgH0LD4NwCyEQR2Td/hemqG8T9vjh1dyesNmq64
         VdapIgBBs1AAFjmejyYRfCL0TcnsQizoOzpgI5hy8A2xqNTNVTDbdCfoHFIsmcwq0Cic
         WH9HCTU7v7nk9ShxctZgbCqMAbqSN9EBVl/FfXI0hk9XfjSWSEo4UqWByktadPsiqvZp
         3//9zNdDdpHzJrOXqrKrXV2p84PL093Dtl4MikWnaZQAcNAWeE7UB0fih8neJRbUdb+D
         43lnxh8Mt+WWRy1KJTkmdouHFryy3uy0tc4gJ8tASG++rtmIwKgLaHI94Vuj8qhm1ExO
         aeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qw3sNwZZnfQZzIKQqVMkKAqZzWg7tnvfIAqHN5Eqijs=;
        b=SoUOoiXAEae2Jv/mexwId0rFbB75iqR+oecX7Dh/8vKOmPwplxu8Y3tF+gKWrdjE50
         hknGimSf8W0LBWXikfpmFpeS4ofiM5RwX78LxVbxuagcCIsg9qIA0A7bGc1B6+XLKbYK
         Ww54kDaAmkKm0YxHHnnrUID1X+tFvuDqJJwMwQf5esSICqJhP9o237oOXdJYQ3nclKTC
         rJntfGZLvV0Xnwq3BW37zizNlUZO5uPcanMCUZqzbjVR1alLNRtIIjxNvfB7HgHJCvNi
         C4qTbyBq4I7JyVjmmjaAMbw3ypRe3z5wuzptcOOmNZXPoC4LHu4d5IpFFnuSydkRceS9
         14bw==
X-Gm-Message-State: AOAM530OIsA7n3YLsTVKhZ1COgDPft65sH2ewr/uNHqOqBV6iH2u5f/z
        EF5QHryIG1zzTHaq2E/yzSp6zd8fZ64ldCjb0Bo=
X-Google-Smtp-Source: ABdhPJyK1qsjAgzdugZllu7y20wNSYM3f0aoe/CaLITrn045m4AymNsX6rJkChM+oXukwUcwWcmklC+PULbNM/yj2dI=
X-Received: by 2002:a9d:6d03:: with SMTP id o3mr4122047otp.343.1595512647425;
 Thu, 23 Jul 2020 06:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200723091715.GL19262@shao2-debian> <87v9iexztl.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87v9iexztl.fsf@nanos.tec.linutronix.de>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Thu, 23 Jul 2020 21:57:16 +0800
Message-ID: <CAKc596KA2moT7fgO+Ount5trEbtrYsuLbde5S5Ou-c4EQbHb3g@mail.gmail.com>
Subject: Re: [Softirq] a76eadba0d: WARNING:at_net/mac80211/rx.c:#ieee80211_rx_napi[mac80211]
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel test robot <lkp@intel.com>, peterz@infradead.org,
        will@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 6:58 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> kernel test robot <lkp@intel.com> writes:
> > [  106.856151] WARNING: CPU: 5 PID: 4569 at net/mac80211/rx.c:4708 ieee80211_rx_napi+0x44d/0x560 [mac80211]
>
> Bah. I clearly should have noticed when looking at the patch.
>
>      pending = softirq_pending();
>
>      set_softirq_pending(0);
>
>      while (pending) {
>            ....
>
>            if (timeout)
>                 break;
>      }
>
> That drops everything which has not yet been processed and the above
> warning is due to this.
>
wow, I made a mistake, thank you for finding the cause of the problem
so quickly.

How about the following code.   we need to clear the corresponding
pending bit at the
right time Instead of all the pending bits cleared in the start.

pending = softirq_pending();

while ((softirq_bit = ffs(pending))) {

        pending >>= softirq_bit;

        set_softirq_pending(pending);  //Only clear the corresponding
bit which will be processed.

        h->action(h);

        if (timeout)
              break;
}

> Thanks,
>
>         tglx
>
