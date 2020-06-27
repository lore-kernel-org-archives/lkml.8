Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D447C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 18:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 704E520760
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 18:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX2bxF1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgF0SH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 14:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0SH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 14:07:58 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772FAC061794;
        Sat, 27 Jun 2020 11:07:58 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id v8so13015933iox.2;
        Sat, 27 Jun 2020 11:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZypJVFE6v/3Jo2AiBRXxfrvf66bExjGHXFBsT718YSg=;
        b=GX2bxF1CEydDQc5wgJcXjloNHjNGMa9Zvm5DRbSodJunGDOTiK0N3rXEbx+uauBI9t
         JKaNHs36a+aossRbO48Qxa+K1+dFQiCM1RgaMmcMIHcCKn1bZxLYQHajlxNzlcd2rHJB
         +0kYMKKPmbxUqCKrlg/e4ehbJukcUw6w8I7YaPjaF6MOjIbGS7nKdX8Gi4GxMAE7Swfg
         jZ42bTOfiwWJtD0EMWDVLl5R01dsgGPs0AjBBI3733bHs1kgfIAods/aNxWrCA1cS+Al
         mpjjaf8tqVQNbU3Ug2gEeZLXLvIvkS6oyyNdddJPcL/1b11uMegYLlmGZrdtMtHaaZ3o
         QVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZypJVFE6v/3Jo2AiBRXxfrvf66bExjGHXFBsT718YSg=;
        b=JIum6AK2zsqUk9uGgRzd+O2W0VE9Vt8pZdZzuqza6+hgVGfiotcOROFsDjANw+V7bH
         zcW+GD1AHGouKcept1EotaVeHl5wP2kZUQFQwA66aAtMpJDMs3L3OVowjOlTOF79quh5
         zAt+pmwlnt1feK5JiBcI/GsD/4q0xHGwhlC/8tkNim4OnNZfqU01LR6cHdQ4Y1GCY3G6
         IelOZjPZWNNdl7VoMEOA2eAIDYz565SBJFpfUwaYYdQ3+Jzv1MUHGrDCJAzlQI58oYwc
         JejdnPEaU4QSgWIKuyxOnxJwiinbejlj/4Y9H29MoBbrAFjDC8D86+69ctrYNFpV9rpB
         gv7Q==
X-Gm-Message-State: AOAM530Q6wibyjy44ODhasdZesCsYESB3bN+Buio1y6ikPwHt8iXRC2D
        kPq3FXK5xLsMqZViElgRGXG+zmjQl/SgBncnbIU=
X-Google-Smtp-Source: ABdhPJxNDVyzjbgMHCyAFG9vELFj2zKXl2ULB/GhP9SY8wYywtMDst8YankLqwou/QRqS4GzHBnL+qPDF+xbmsk0bnI=
X-Received: by 2002:a05:6602:2f0a:: with SMTP id q10mr9242943iow.134.1593281277227;
 Sat, 27 Jun 2020 11:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cf1be105a8ffc44c@google.com> <000000000000d95a0505a910abd1@google.com>
In-Reply-To: <000000000000d95a0505a910abd1@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sat, 27 Jun 2020 11:07:47 -0700
Message-ID: <CAM_iQpUHiSsfkT8tzwAg7CKYXQQ4ZsROxKZbHKv0LxwrPeM=Jw@mail.gmail.com>
Subject: Re: possible deadlock in dev_mc_unsync
To:     syzbot <syzbot+08e3d39f3eb8643216be@syzkaller.appspotmail.com>
Cc:     Taehee Yoo <ap420073@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/congwang/linux.git net
