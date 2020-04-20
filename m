Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02E8C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A042E2078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6aPhhLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDTFhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 01:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgDTFhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 01:37:18 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CF3C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 22:37:18 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id w20so9619484iob.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 22:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9Tw62Y4p0nzfrBhS9UMCOEZX7jz4ocmUX4ipr3yFe7w=;
        b=N6aPhhLt/HBO8tcdYPxkRddKXhbCChxoDVbn19qZxsM/nhF05YBmmkGUEaKF9VPw55
         IO164WYn+6eA3DuEPr3/PDU4FegWxQaXh3rLu1mDROS7WC9dv3MrVsNyDNsXqR8d3Ixg
         VVkfOUP8Ptwc7IoDka8atMuvBfvJsKmKm5SAFESLQ/o6ywZ69xGXMZMGBXputqfLs4n5
         IuC6MvWIoOEJOkLillTwT9yz2ASQKxik2gh8YQlEeZTuyy3Vbk/qMyN/DsnFNxmNAuwT
         bs6W5NQ+ePA4AC4p3XgU9R+ec039Zu2SwUlIoB1UbP+vhfVxxa1OU2rS2932LiR632Ek
         TCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9Tw62Y4p0nzfrBhS9UMCOEZX7jz4ocmUX4ipr3yFe7w=;
        b=RXL7/BBGIpkVaT8MAv/OKk6WflrWB1E3qDAlICNXpkLVB8EEtPji14nE6TTeEScKE1
         avrbBOoNZH671Xd1OrMiqHw3kSX/buKOSP3plG3XA83JFexYbo/hsfz1v7x4d10LiXTE
         BE+XM2dx3M1BEUMwEZdJ0wAkDy8JUgoW1IZMOIkP7PjHbDSemuUiRlygTCP5bycmIxth
         feTcmmke6WHra1MYrWUW+kPIoadDjopESggEyz5Sb7/O0oX3gHvghGmSzUSfovjL8M2x
         j5d0hcPCPHpPOdUaZDRW6h5nUmB++MwAUy2ybSwF5bpvjCZVyySdqRn7TMO/ckuwdMKH
         hGWw==
X-Gm-Message-State: AGi0PuZCRm+Iaoqew1Hb57ibBxYXUKC+28389LWPybJDYrv0nP/ARHiw
        7q+A78SXWr0lW6tF9PXO5h+ejMOC4C+7DTXJnJg=
X-Google-Smtp-Source: APiQypK4+4QjCFCymLkzLqGdjy6lnx0SK3FaqbbG3BHjq+3ztJLhTiiJO3hN+lq1ZSSngVkjNBbhO5dRIpddg4F0DjI=
X-Received: by 2002:a02:40c9:: with SMTP id n192mr14071875jaa.91.1587361037611;
 Sun, 19 Apr 2020 22:37:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:a58b:0:0:0:0:0 with HTTP; Sun, 19 Apr 2020 22:37:16
 -0700 (PDT)
In-Reply-To: <CAOzgRdZyueBhX+jzpgSgdyeto830O444SwmxaLEAQzSsEaGczg@mail.gmail.com>
References: <CAOzgRdbWsKY7mXgiTx3um_gdJvgPN1O2p1vxmWv9eApQAy9UzQ@mail.gmail.com>
 <CAOzgRdYkJMiQM9M-UHv5Z-6CLzaV0P8YTK5Ft-CmT5-JqCnYSA@mail.gmail.com>
 <20200409073807.GA2483@worktop.programming.kicks-ass.net> <CAOzgRdZyueBhX+jzpgSgdyeto830O444SwmxaLEAQzSsEaGczg@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Mon, 20 Apr 2020 13:37:16 +0800
Message-ID: <CAOzgRdaoGB0HUU8QEQAUwjPTMzw=9W51WnoeZ-hX67xCRey5pQ@mail.gmail.com>
Subject: Re: Merge branch 'core-objtool-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     viro@zeniv.linux.org.uk, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 5.7-rc2, Revert "objtool: Optimize find_rela_by_dest_range()"
Revert "objtool: Optimize read_sections()", can build 64bit kernel on
32bit userspace.
