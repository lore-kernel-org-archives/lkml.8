Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AD1C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F030A215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gt4O3kKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgCDIDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:03:39 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]:42421 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgCDIDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:03:39 -0500
Received: by mail-qv1-f42.google.com with SMTP id e7so391444qvy.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 00:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvcgS0kaXJOVRywfNG/lNV2uF4vbt2syEwAD5+QBlzo=;
        b=Gt4O3kKNzok2CysVWD2u3PBvZtBIGkUhLJORObJgQFPs1Y7YFnfuyfGf0IfBx8ZQ6b
         p9HsmW9q9BNbFTFVIf5K3vLxwkMJKJJmbc0OUO9Zk2BhG7rz0Pdev1f0YCblgQwmOGXf
         MmD2PpAwnKc1pJra4Wq+VUWyK0UaiWPrLNw+qhxbUC7RlFqjGAZcH1OabQg6Dx14jUJ6
         QL0PoSg4O2TR3vtJdT8kEkFUrjUf+SFq4KeZ13AEAqtKK0idqq8MMAcrDUhoDZzqRVnh
         soPslGD1sOK53cGMv1QR9ngzipDeIgchY6Vpfd9Q7s2S+YAnBgUhcIeKxxdp5Bwh+ATi
         Tbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvcgS0kaXJOVRywfNG/lNV2uF4vbt2syEwAD5+QBlzo=;
        b=gexu0XCD/dkXiYPLfx5DInVJIv6suYpKl1TxhdZQmA04FVPddvL8D7UTntX6L//Zwp
         jQsddeE5ywYdWwkfZ+yb+Wr13gJdIf2xiQag73Nbrs9BngcxFHLB30gM2uVJ5t9oTDdl
         HUi7ZKtqBov7LhtCmnZCxdD8hmdV3mvisS+q/Tw0Xe7wBOknE+eo4Vl7mNoQE5xXEwOu
         rtjl1TZ/FaqH7190Yi/yuUFpRZhxGpIuQw5yd03rreh+VyXTphLOOS3FnrMWZXp4udZo
         eufbD1VgXDFcjqOCtluiTo6LmBcxDUdD9iY6HFTUX2KDHiJL8UAcYxvuqjhcQIU6N+wX
         jZSw==
X-Gm-Message-State: ANhLgQ1Jq/iPDV3b4J/hJ6PeaPkXB6JJejbtHhd+c+tj8S3bcVb3FL5h
        dj+psEI1krVTOUCPFfMTvEoIftSJVVHfmrsGQ8iEBQ==
X-Google-Smtp-Source: ADFU+vur/xZleKVdRHzI0H1ZvQvwTlsXpp6Y39wE53NWXVg1mf/u1WO9LRq/X33XIyAxU5944mW6rgngj0asd9wn9FA=
X-Received: by 2002:a05:6214:1467:: with SMTP id c7mr1167140qvy.122.1583309016750;
 Wed, 04 Mar 2020 00:03:36 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007523a60576e80a47@google.com> <CACT4Y+b3AmVQMjPNsPHOXRZS4tNYb6Z9h5-c=1ZwZk0VR-5J5Q@mail.gmail.com>
 <20180928070042.GF3439@hirez.programming.kicks-ass.net> <CACT4Y+YFmSmXjs5EMNRPvsR-mLYeAYKypBppYq_M_boTi8a9uQ@mail.gmail.com>
 <CACT4Y+ZBYYUiJejNbPcZWS+aHehvkgKkTKm0gvuviXGGcirJ5g@mail.gmail.com>
 <CACT4Y+bTGp1J9Wn=93LUObdTcWPo2JrChYKF-1v6aXmtvoQgPQ@mail.gmail.com>
 <CAM_iQpVtcNFeEtW15z_nZoyC1Q-_pCq+UfZ4vYBB3Lb2CMm4Mg@mail.gmail.com>
 <CAMArcTUJ=Nemq=hsEeOzc-hOU4bPOKq_Xa1ECGDk4ceZHzhGVw@mail.gmail.com> <CAM_iQpU+d4bbtN_oE+G0CaWmeSbBEyS1Wuc7s1vK36gGrcYzjQ@mail.gmail.com>
In-Reply-To: <CAM_iQpU+d4bbtN_oE+G0CaWmeSbBEyS1Wuc7s1vK36gGrcYzjQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 4 Mar 2020 09:03:25 +0100
Message-ID: <CACT4Y+Y-602aWheEZT8ha7qJ=P7uhu3LG5PqFebB7guNg8z=_w@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Taehee Yoo <ap420073@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 9:41 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Thu, Jan 16, 2020 at 7:09 AM Taehee Yoo <ap420073@gmail.com> wrote:
> > Yes, I fully agree with this.
> > If we calculate the subclass for lock_nested() very well, I think we
> > might use static lockdep key for addr_list_lock_key too. I think
> > "dev->upper_level" and "dev->lower_level" might be used as subclass.
> > These values are updated recursively in master/nomaster operation.
>
> Great! I will think about this too. At least I will remove the other keys
> for net-next.

Hi Cong,

Was this done? This still harms testing of the whole kernel. Disabling
LOCKDEP does not look good either...
