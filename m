Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43643C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168B3206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DP9hF01k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgFOHZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbgFOHZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:25:49 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E0C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:25:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id i3so13348145ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0SoSPRx0KWtA6g8DOeO4fbOiBJz8HrEKhF1kXWLBN7w=;
        b=DP9hF01kqgES9xL3k2lhw4H2l39p/FA2fzB0Zwg8QVob9Qe8bJMJJw2no2a8+oeR7b
         I3g3EZNVTj0oFuLgT1Mb7r9nrM0g9IkPaOSfK5FRgcJoPNY+vQqHV57aeDZFyxRCF9kx
         GP7Enm1ZfIopI06LA/cNTs4NPGflEEjy2VqFrQivdlhUhKaLe98TMFzWkOZbqNry3h61
         a1ggzFRgAYWD2g6Pjhpky61raMvXQwhbcpE7SnOHcfzkeCtRIihEYXFFrytZwlY0wW5s
         fyNJIFLOnkkflV/7aFDCVoGXrv68K2fSniL/v/osMpUlAfYaQ1b+4T9eNJ/C//vV0+rS
         xH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0SoSPRx0KWtA6g8DOeO4fbOiBJz8HrEKhF1kXWLBN7w=;
        b=rE5/f59hHVFlTtOkaLCqHWaIr3b1Ka2NoBOr1/zcFG+tzWNS9KcZCf2omQ8Wnbhziq
         b/je+ouMXdSdsFX0ZX+BTWLh5nmTGn4u0f35oK62nwXY+6sjU8dqPefQnCmk8vhP+QsB
         5tC8dHi+OHp9PI/0ifBPxwlSF79Lb+trGYVuj8Q2Fb6kgCypatNLJYPVtSHklW3j7dMS
         YCGEjq0EFi4gOg40LVsHbnj7X6yl9G940Lcuz6FKdWtV1eqVdcS6OTG6dAJl3sysiNu7
         pi0HYwytJfL/5UWWuqRldIoY+s/HFD8b2CvcFgtdj2mghoIqHJAk9jwYQqTv26zvaZ2y
         zVTw==
X-Gm-Message-State: AOAM5312sSb+dUBcMlI8WVZrTEbyY3yxOz3tqmcrsbzUeRlps+wm+MhO
        aih6Ip/qiGQjtgoK2g5YDdAKXJlAdRRXvw2DZAWu
X-Google-Smtp-Source: ABdhPJwuVQNAuu6XqKxf+UWLMrl+UfwiMiHdojHlbYQ1yU51SXmHVFfBBmpWTBEGizOzKvwYFr4LHmq6j0Ikdc7ldkM=
X-Received: by 2002:a2e:8ed3:: with SMTP id e19mr13195530ljl.72.1592205947327;
 Mon, 15 Jun 2020 00:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <159169282952.17951.3529693809120577424.tip-bot2@tip-bot2>
 <20200611140951.GD30352@zn.tnic> <CAN_oZf16odNhpY6_LqkVY2wpy90jKM9-vgKo4LE8OJ-QTDCKiw@mail.gmail.com>
 <20200611154356.GE30352@zn.tnic> <20200615065806.GB14668@zn.tnic>
In-Reply-To: <20200615065806.GB14668@zn.tnic>
From:   Anthony Steinhauser <asteinhauser@google.com>
Date:   Mon, 15 Jun 2020 00:25:36 -0700
Message-ID: <CAN_oZf3exijOHJmY7UqDVwWma_fMqiXhen6gSsSSBnxRSeFtPQ@mail.gmail.com>
Subject: Re: [PATCH] x86/speculation: Merge one test in spectre_v2_user_select_mitigation()
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Borislav.
