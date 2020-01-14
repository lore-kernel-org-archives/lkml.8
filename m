Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39E0C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BFB24673
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rTnI6apO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgANVl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:41:57 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:44391 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANVl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:41:57 -0500
Received: by mail-qt1-f181.google.com with SMTP id t3so13867078qtr.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 13:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=rjPJ3lo5JGTg8CpqtNYllzVD94USGlVvFifDLA2rj1Y=;
        b=rTnI6apOGb+RrfZjQi5iT/wWCr7DSsbfy/yLZjfDIbKgIew/rtpAFtS/CZ48Ug0PVa
         oBHbUVx645E912fE/h2yuAn4pb5NqFZ+030PIpCGEwc2KvAmAJRxHViM74GOjJ8rKvoE
         FoxVXwbvEETy1ps2i1A+C3IpnLkUbL0D9InTYO0cak2pzSdRWbV6fRyj3feEIg5FG1MK
         u9p/+Gq0PLhElImcANrzbAU4rimSJoblnG3shQh0hcyN43cATfftS4Ns2+fO9n2lc8r3
         STfJUK5CZB6R2I4rxfTwvLXdw1QPTX9FTK3EaAP2aHB6qwAsrioXHU6cnA34kiUpgCvI
         +S/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=rjPJ3lo5JGTg8CpqtNYllzVD94USGlVvFifDLA2rj1Y=;
        b=pDt7zKFxs2qUSnvOPBJz6tL1o90QPcDjvNsQZBrANdfn/zqNizLtZAUbXFktVaEbYE
         iqIIbAi4cqx4SZPCf7S2GUR+3atXiFccslrAp1ym4S7JsjdY2tFGZCcd7e8HNpBdNq48
         Gh7kbygOpOqB2MN4Lsh4fxm0HldkblNAWBVLhVTDKMzBdyWPUOJCmHt8kCEys/eth/Hn
         xu/jUznwxwe2NEDWOr/5AoF6go17ryyGoefkTa8xynY4SQI6ZvyGYjjNLBAWiSAU26vN
         mFEIZWqhi/Jjk/7j+4LguPMkswIwXtOTdvfdKcQhyyRWuZ1lHWSPuahtFUmDNsFhgE99
         xczQ==
X-Gm-Message-State: APjAAAUYVOv4rNGX99tJTFdvPbHEYyLJhVGkDkM6p5V/+NXOx7P0XvbN
        KlCjg0LVC5b2lsJQlVKjq3uaZA==
X-Google-Smtp-Source: APXvYqxPvFjMv9Qqx3+x3V/ymx12/LeM1yrzTQbP5zPRPG25CfkMW1ZHD/7QThRy0WJp22sAsUFAQQ==
X-Received: by 2002:ac8:4446:: with SMTP id m6mr646917qtn.159.1579038116250;
        Tue, 14 Jan 2020 13:41:56 -0800 (PST)
Received: from ?IPv6:2600:1000:b029:6649:f4b1:4b94:dfb9:77cf? ([2600:1000:b029:6649:f4b1:4b94:dfb9:77cf])
        by smtp.gmail.com with ESMTPSA id c84sm7416080qkg.78.2020.01.14.13.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 13:41:55 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: linux-next: Signed-off-by missing for commit in the random tree
Date:   Tue, 14 Jan 2020 16:41:54 -0500
Message-Id: <56AE8C0F-6133-42A5-932A-46A81F25CE0C@lca.pw>
References: <20200114213332.GF140865@mit.edu>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20200114213332.GF140865@mit.edu>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 14, 2020, at 4:33 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 
> Thanks for the clarification; given that you composed the commit log,
> would you like me to add a "Signed-off-by: Qian Cai <cai@lca.pw>" for
> you as well?  Given that you added the commit description, it would be
> fair to give you credit as well.

Yes, the patch has already had my SoB.
