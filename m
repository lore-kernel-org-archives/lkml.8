Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347CDC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBF52051A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="lB82KJtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635688AbgDOINn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635597AbgDOINf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:13:35 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852FEC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:13:34 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e4so2501109ils.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=6DK/mPj12j8ZwjwvQfkf/xcUtcNP1SXPopDgSVyVdAo=;
        b=lB82KJtSmh8jI0Ng3LQyvy7RD6sEk3AOQHRjK2q7baKgJkflGTxB09j34sDX/KfP36
         2Kh7P1TKAPGNUU0oy/CScQEaGUqMEFKSY81Qa0NmOoAgZqw9cakMaQpGCqkUmD2/ZZmi
         U+zx8SR2J4qLsjh1lyCvBsnvqhhKTtFQw9GTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6DK/mPj12j8ZwjwvQfkf/xcUtcNP1SXPopDgSVyVdAo=;
        b=alisSvEf3DfmZNXslBsaNK3AVcr/O3lkgD9mcqybbX33I15ZdOmaeLMLNcQPyOE+Cz
         fsErcZzqbWyO8wnw3LejAuguVS7zUCe7Es06dumAdXayegOxN9FFZYgeoKeOrS35Lh5O
         G1m26smNh0/NFpIqjXzSWfxs0rSCGwOID/zjKw8gxKZ7B+kyC/bInI8FsZIJYXN6oBD/
         4GHxfElpUO6fNFVEtLJuIFZbvodf1rzf+1fBBTKmX3Q4qXAP03jNvlwjmO9KKNPrksn3
         ivo5cygyPBBZ1Zu5KFFT6KMkFZWydzvZPkNRMrDMgynXsttxcjmuun6re4yNAZCK0MFs
         f+BA==
X-Gm-Message-State: AGi0PuaoCAsJw72EXf3Zf8O8xFvhK6kbQCppnWI75NthR93PYUg/N+8g
        VDHPsqjrBsT1IgCoGKrm3WzgGbiGsgxKTG7OzY282iIsz0GdAg==
X-Google-Smtp-Source: APiQypJvj7QssKUiPUbJgl4Kaikzhz3BXjs09nrXDx5XMW3JqEUFXYuN2Th0nKYV8C4f+J9bO1qYb32K7PrVAe8GAp8=
X-Received: by 2002:a92:4a07:: with SMTP id m7mr4400586ilf.53.1586938413547;
 Wed, 15 Apr 2020 01:13:33 -0700 (PDT)
MIME-Version: 1.0
From:   Angel Shtilianov <angel.shtilianov@siteground.com>
Date:   Wed, 15 Apr 2020 11:13:23 +0300
Message-ID: <CAJM9R-KQsBcE=qpQ=8j10gLPtYcpWbSX1Q0gkrEC46JkcM9wQA@mail.gmail.com>
Subject: BPF is spamming kmsg
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
that's my kernel log since 5.4.29:
[32792.704010][T10705] testing the buffer
[32792.707870][T10705] testing the buffer
[32792.711758][T10705] testing the buffer
..... over and over again.... thousands of lines ....
[43832.690006][T10705] testing the buffer
[44060.829846][T10705] testing the buffer
[44060.833723][T10705] testing the buffer

This seems to be caused by:
712c39d9319a864b74b44fd03b0e083afa2d8af2.

Is it really necessary ?!?!?
-- 
Operations:
Kernel development
