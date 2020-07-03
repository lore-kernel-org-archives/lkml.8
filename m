Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DB4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340682073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pl1pW6uQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgGCJlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgGCJlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:41:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A976C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 02:41:32 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f5so20331003ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HsDtcmOQJhL1tyTu4N+ET2s8ate4nY8c0MZt6PooaN4=;
        b=pl1pW6uQ8beVsnRuvmWNsd2S3FmedrBC7wgMSKttHwwa7WQppitefDxpMY3K1flvlO
         zW5/LnwD/7F4HdIMBJvpBKIg6Z62qXiU54/+9K817BRa6FiV+da2MN5n+EihxIjffrLe
         JZux/erJYPxr7hsUb6Eq6D1ZLRi2icJyGbWfE/nJYWgQceodQPT/dM0pKPYDufIKvCjm
         dUkt8cA34Bw+Ym1KxajKRtTq7xCx5WiyCTnS9DGxHOsO78PVwALR0VbJ8LyRf39qlP2S
         TnDT2yWPH8xqQsjD6RIlMlDYQ7/Q51kgExkDxqwWtyM0MlQFEmWD5iF4gxOVoHMeYvO8
         9kEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsDtcmOQJhL1tyTu4N+ET2s8ate4nY8c0MZt6PooaN4=;
        b=T0ELbexI5h7oFE9vw7LJmrhIkyTmI1ShfISsqcW4/JxbUL/WrqKKv/9+HEPAFOU98i
         zx9yyqagQzmO5cuCn5j2SrdZZsdXv9B2u6rtxQU6DhKTgGSA9DBQs2aekcE8mRXp28Zm
         BOFqWkf6S7QM1Zhas6fALczoJ/DPLDs+sluoG9Zymd39mzhW8ElLK56FKtGjakBdpebX
         DI0SpbuMFrP7yGtEXlCwcKIgh6qfsfnHlkGhelKqQuruHe/O85Pcp7o7Sg5rgQjw9wvL
         bV/jPuHbRi71AHz0v0RM44ucV2q4UnkR9c5GlOZIZS6YHkmaMjIjZfkFRYW2X24yTJJh
         F9ag==
X-Gm-Message-State: AOAM533JskQAfpU8ZAmvtGuBbffsKR9OiEadF8fomPWk8j6QB/ywATeS
        X8VytxGj8oWr5oL+PUcg3g2H1RNL/cqYdPfFhRk=
X-Google-Smtp-Source: ABdhPJyPz/qwX/EfMFDZX80H9cC6FEt7pnunrwitwQoTsjXyfYx2WSiVgh0vv544HhtTXLlj4smQDIAMEX+5fj7DnAA=
X-Received: by 2002:a05:651c:2044:: with SMTP id t4mr1682445ljo.202.1593769290817;
 Fri, 03 Jul 2020 02:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <050476a0ee608046569588936394159d650ab535.1593763492.git.zong.li@sifive.com>
 <80902e5d0d5ef752e71672e9c5794d0f5f9ccd15.camel@perches.com>
In-Reply-To: <80902e5d0d5ef752e71672e9c5794d0f5f9ccd15.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 3 Jul 2020 11:41:19 +0200
Message-ID: <CANiq72=Qakg1HAW8XggsBqiu=6-GVtQNDzeefmXxVG_RNA8MkA@mail.gmail.com>
Subject: Re: [PATCH] scripts/Lindent: increase the maximum line length to 100
To:     Joe Perches <joe@perches.com>
Cc:     Zong Li <zong.li@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 10:51 AM Joe Perches <joe@perches.com> wrote:
>
> I'd prefer to delete Lindent instead.

+1, especially since there is `clang-format` now.

Cheers,
Miguel
