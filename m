Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BB2C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 22:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C540520748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 22:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585522486;
	bh=SR6Vc+s7Ele1EtoxbBtUOFkr8hFBGZEtSlTuksX81O4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q9GQhH4DBbd2ncEoWrwpeWDVRmj9R+TwXx2ylgcLvhkHPdOkG9HAAQFhwe6N/oo/D
	 T1mkEL7HaRnhBOWpAEisb1Q/ZyfGGAc6EDo9m1YN20mki8w+NbalqVBLBuIbJ56WMH
	 DcV898nWY4QjOUf0tnWxXFG5aeNrk2eRZsLOeoqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgC2Wyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 18:54:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32813 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbgC2Wyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 18:54:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id f20so16110538ljm.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 15:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fG1FCfpblEeeyRVCOqihJyiegEdebBW/tbsZxLvpGqs=;
        b=MyJp/244+a+a3Cg9H3lGj5v7fdcZqqvXBEK5/ZDytptCJBBYHNSyPi/UFnPOxpQHDB
         VZfuMGC6PfX8sFNM71cI5qLW+kNXzrAgcXkOyqexMM8DAksV7SXKQd1WVvYZDFz7gby5
         5WJFB/qircGO/IczWSNzUuJessXnoQ0F9ANxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fG1FCfpblEeeyRVCOqihJyiegEdebBW/tbsZxLvpGqs=;
        b=sQ3r8Lg47g/U6I8yiiUvvJ9wcJpub09v6FEAq7PYrgFiqyo38qME06YQ8TuxtK081X
         OKbKYy5CmzUThP3ZCIoM7BmdjL544mRktdNQIdjpAzY3hzImzNtJMn2ZtlNiFFpOJo50
         /8xyvw1pAU7OdHrIhozmC4fzemlx97lP9j2901uh+jXrZf2IceStm2Fqdllgn5vJslGt
         6VEX23Zu9raHPoBxEcJJtSK6fsHNS+iT7DUfjJEx5vEdRzrQExiPsj0IYkA0ZcAO19Bm
         hUyMT2Ji10YzupS28zBBkiO2CJ0/HxhAecDhR/HbosljaN+xpQCQDFKGs1Hk7b/CLaj3
         cu6A==
X-Gm-Message-State: AGi0PuZmSW7PLxFAC1n2f/gEyNnYX3PVK21XeUZH0Wc+kVch4qeTd8Mi
        4aAIigfjf7+GSVOiBRqqFDAUiNiMOe0=
X-Google-Smtp-Source: APiQypKI7cxNIabEPZ6iAgYr5TmqArXtN86MJkCLH8/r65dGWxUZ/TGXOZET+o3Gxu2w+YhXbWaR8g==
X-Received: by 2002:a2e:99c9:: with SMTP id l9mr5741754ljj.79.1585522480337;
        Sun, 29 Mar 2020 15:54:40 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id q30sm3720113lfn.18.2020.03.29.15.54.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 15:54:39 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id z23so12551174lfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 15:54:39 -0700 (PDT)
X-Received: by 2002:ac2:46d3:: with SMTP id p19mr472542lfo.125.1585522479223;
 Sun, 29 Mar 2020 15:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200328.183923.1567579026552407300.davem@davemloft.net>
 <CAHk-=wgoySgT5q9L5E-Bwm_Lsn3w-bzL2SBji51WF8z4bk4SEQ@mail.gmail.com> <20200329.155232.1256733901524676876.davem@davemloft.net>
In-Reply-To: <20200329.155232.1256733901524676876.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Mar 2020 15:54:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDZTfj3wYm+HKd2tfT8j_unQwhP-t3-91Z-8qqMS=ceQ@mail.gmail.com>
Message-ID: <CAHk-=wjDZTfj3wYm+HKd2tfT8j_unQwhP-t3-91Z-8qqMS=ceQ@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 3:52 PM David Miller <davem@davemloft.net> wrote:
>
> Meanwhile, we have a wireless regression, and I'll get the fix for
> that to you by the end of today.

Oops. This came in just after I posted the 5.6 release announcement
after having said that there didn't seem to be any reason to delay.

Oh well.

                 Linus
