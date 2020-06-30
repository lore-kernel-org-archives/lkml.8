Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8B6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF80F20768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AST/x2uF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgF3D5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgF3D5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:57:00 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEC8C061755;
        Mon, 29 Jun 2020 20:56:59 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id k1so15299759ils.2;
        Mon, 29 Jun 2020 20:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yAZduYcEKm4wiOoLB6wnk1hlMRtoPsLgtKlyIvlMUUk=;
        b=AST/x2uFdAOxU5odRsKWn9WpNVke4VbhSNvdISsxJZV/NpV7Lw4iiX0GXfsPiDW0W4
         tUrRjKiSa62sEqDUPqKDwLjTEfwaJIzROaY0JTZ45PFyGziN68HkqYHlZgAWUgmUdiPP
         HEwGMXZa8wYgmU3U9+2SswTLl2PyLa0FQlbDjmV8uhbQpGuo/BqKXIfX1spkVz3HteSf
         aRC6y9fpGFIc8J0vnAIUviWUySCHN8LvMWS2m2k9nuQwY4VMIf3in26ljVIjLireNsJu
         WIj0yyMXzaTLwD3OTnQ4fy40w42oSfRHblfTUWboKc/MMq6uDuGzjrQ141U67NzeFkvi
         oK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yAZduYcEKm4wiOoLB6wnk1hlMRtoPsLgtKlyIvlMUUk=;
        b=YxzuVhjcgo3hTJSztLZzfuDPZNMzdsj5h8Ld9gx6NxdpJhA1NfJaXMurGHdeL1ymQX
         a4Y4F3cB290YOEglXizbfuPDAjx3Qr436uVybK/9G1ExZSFFdIzqHJH1aFQJ0NxLaNMc
         dwX4+drJtwp7cIK3TNBZiY8LC3b1xsL583VSGVB4kJX8IrVSDOz/TjoOBr9Zm/TCSVLz
         iseNe23XgTDLYD7N64IGiwKHietr0NYZXX9y5i5jskwDlPeA82J3Tk2Z38Z0SCNYqiwj
         ZVyfJzYsnL4OA5hej4P8gOcNVmm2SmqDHyGEUb3wDFBypKOqCgbd6JYZjligU2I3csZC
         c+ww==
X-Gm-Message-State: AOAM530GqSsvZo7lI2kzKho4puWCzn2I2506J6O4juaIw/pZfV5aL7vE
        KuJJII29KhwAT20uCV6pCR2zeFRZ2MgLV6AAMvE=
X-Google-Smtp-Source: ABdhPJxliD+RX+5z+ADoRBWAEQRMTYQaVyBjwuy4bcMqOCiNJvHeTGmICJj9i962YuR7HghZ2ecs16GvVbRu0qa8CbI=
X-Received: by 2002:a92:bb0b:: with SMTP id w11mr777875ili.238.1593489419280;
 Mon, 29 Jun 2020 20:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000084cbe605a93bcf78@google.com>
In-Reply-To: <00000000000084cbe605a93bcf78@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 29 Jun 2020 20:56:48 -0700
Message-ID: <CAM_iQpVpaBQ5Hg9YAGRtcOWKDhyNOpZ6jfsDRbDhg-Da1xxUkw@mail.gmail.com>
Subject: Re: KASAN: vmalloc-out-of-bounds Read in netdev_name_node_lookup_rcu
To:     syzbot <syzbot+1860d20cb6a6f52be167@syzkaller.appspotmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: genetlink: get rid of family->attrbuf
