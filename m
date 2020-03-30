Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61499C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D75A20757
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAYuBRzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgC3Udx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:33:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42623 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgC3Udw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:33:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id h8so9216694pgs.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAka+afRnaX/ZKYZXYNGXTAgpgy0/w8V+P2H1maC28M=;
        b=OAYuBRztVNI6QkMYDgfMScWINgazrjd7nqaQt1VP4/JIezme1Azu4u6KQCd8q2ooBC
         evqIq1WXLUGY104DtbqXII7QGPctmwATPb7ajGGATjHT5PjASxYbzoKcrih4RIVqGTbc
         lEN4wKNu0C1GxCxdBMYMvucJuPYZualHOTRes/emNr05WtUV03zRGdUVRTbF9GCFGpX8
         iFuoyxH4Sw68EYD0DqXNzVSpOzYAXiHGmGJltHrVL4xHELR5XA6lgdr65/X/25VBHpxo
         WCKx4j0nrmzr3kG8nlTGfOOEBVbbtproDCJMLtdYFE7zVaj9IxhNR0kbRe9DINxnbotU
         KxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAka+afRnaX/ZKYZXYNGXTAgpgy0/w8V+P2H1maC28M=;
        b=bAwz958nDw9YDWJ02pTEHUTH8B5T3zQyt7u5SpPoSnQimtVVKJoEWPgW/Brw07kJ+A
         5PTrMTcRFxgfpI/0KjU2XzcgjaH9C3BkHgNV0m5XJ4VC2i48mAvP94pNCo4DwsjIVVOM
         Xyte3ayFaCW5cwYK/ejUcSzuE/q3uhLJmqTpzXZtaC7kMKvoPvZmOwsRFVK/hELR425x
         vJFKd6kAVzUkY4O9ygkBYTmpTrpXghs0twMbqe0q7ufK8I4mcEZ2v7SwBH7S7kc9Id6S
         ZJh0u/l1TnQhtT8r9cKXiikglYRZjwLCPC5g/ZNsZSygMfWInbxINBGrmDdiJmMznitX
         LJSg==
X-Gm-Message-State: ANhLgQ1gv306LI4Ly+am7nHyq+hW3QhR3Q6giWWOzQhvFJyBph4wlrI/
        pA4bwwVmWWjCHI0Ic0d2N5o3cGewehS1aFFo7F3/sw==
X-Google-Smtp-Source: ADFU+vu2tg8gJ7kLYAl7nWMJb48d7OIqT5mNfZrMCzL0YQvOscWqjzviXMI3DhHC75s9EINUwjGWrIXeu6A6naCSwFY=
X-Received: by 2002:a63:9d0c:: with SMTP id i12mr14358603pgd.378.1585600431631;
 Mon, 30 Mar 2020 13:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200330045436.12645-1-xianfengting221@163.com>
In-Reply-To: <20200330045436.12645-1-xianfengting221@163.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 30 Mar 2020 13:33:40 -0700
Message-ID: <CAMo8BfLQuKHsqM5yb0N6cfquCoXR17rnkt+TXG01Fkz-Po1pqw@mail.gmail.com>
Subject: Re: [PATCH] arch/xtensa: correct an ungrammatical word
To:     Hu Haowen <xianfengting221@163.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 9:55 PM Hu Haowen <xianfengting221@163.com> wrote:
>
> The word "Dont" is not grammatical. Maybe it means "Don't".
>
> Signed-off-by: Hu Haowen <xianfengting221@163.com>
> ---
>  arch/xtensa/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my xtensa tree with a slightly modified subject
line/description.

-- Max
