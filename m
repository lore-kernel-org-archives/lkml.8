Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A0DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85E121702
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGTXfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGTXfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:35:00 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E4DC061794;
        Mon, 20 Jul 2020 16:35:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0596B11E8EC0A;
        Mon, 20 Jul 2020 16:34:58 -0700 (PDT)
Date:   Mon, 20 Jul 2020 16:34:58 -0700 (PDT)
Message-Id: <20200720.163458.475401930020484350.davem@davemloft.net>
To:     ndesaulniers@google.com
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org, elder@linaro.org
Subject: Re: [PATCH v2 0/2 net] bitfield.h cleanups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAKwvOdkGmgdh6-4VRUGkd1KRC-PgFcGwP5vKJvO9Oj3cB_Qh6Q@mail.gmail.com>
References: <20200708230402.1644819-1-ndesaulniers@google.com>
        <CAKwvOdmXtFo8YoNd7pgBnTQEwTZw0nGx-LypDiFKRR_HzZm9aA@mail.gmail.com>
        <CAKwvOdkGmgdh6-4VRUGkd1KRC-PgFcGwP5vKJvO9Oj3cB_Qh6Q@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Jul 2020 16:34:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 20 Jul 2020 12:48:38 -0700

> Hi David, bumping for review.

If it's not active in my networking patchwork you can't just bump your original
submission like this.

You have to submit your series entirely again.

And if it is in patchwork, such "bumping" is %100 unnecessary.  It's
in my queue, it is not lost, and I will process it when I have the
time.

Thank you.
