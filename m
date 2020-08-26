Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A29C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01FB2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O57CImDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgHZA2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 20:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHZA2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:28:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A60C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 17:28:01 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t6so311115ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 17:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RLbIHhzJWC9vCxPstzO75d+NmpabbCBp5xKdkj1CaU=;
        b=O57CImDdH1ClxTceQRs306qzuCCRk1GoRBhAGp3WeBsn9oH0gwf7W37XhWmPaVz/Nr
         CeHmWAV8n521pJ1EaILXnFbUQUMPDekJ64hBN8z9t5ZDBXKLyIrIxg7Tfo5tPxZ1dGIJ
         yTg6RbFzRWQxVeIq/Gx3gQveGc1HPDph9cLw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RLbIHhzJWC9vCxPstzO75d+NmpabbCBp5xKdkj1CaU=;
        b=IinLYyP1KFmVP/3PMZPp3nWJAlalKiZsBYsUA720Jne6cTYIFQZVvkSe2GFpegAfuo
         JsaGU2ZX9OpA4/bd0GxrP3BNaBjoJEyCa+wKoUXU0DiICkr486oFQRr7B9pkfG4SAKQv
         kRG2bAhmcoC+27dDMTN+9WNugWIvofshrRgLieOTziVtXjDDXL33IhjmRVkzS+W+lgZz
         HQI3KbuX9IG5kJ6zv57oT9AHK2lFB6kfDqHYPg4cdhkQLtZva5/SW5g3bbcBXWzJZn39
         8U9UsgIEJS88ULAL1mq4ZPEFFVO6kQUcpSSOijiX9eGn+Or8SsBN1Ui2Sya4UPQLo5Wa
         yZGQ==
X-Gm-Message-State: AOAM533DQekzVO7mguKv+HAZaVZxVJ2WpVCTVzOwCwSPOsSTRiQecZc/
        MwUXZMAPVetuRF6CYfEh2FQX2J0S6G6JbA==
X-Google-Smtp-Source: ABdhPJzg5SX0/pNocorzJHFUaIhH6VPc+CWZkNiQBM+dA8Nlu9osjuR5LIO0CEuxsNInzh7kMmwC4Q==
X-Received: by 2002:a2e:b6cd:: with SMTP id m13mr6176971ljo.91.1598401679272;
        Tue, 25 Aug 2020 17:27:59 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id k23sm117901ljk.37.2020.08.25.17.27.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 17:27:58 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id t74so12584lff.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 17:27:57 -0700 (PDT)
X-Received: by 2002:a19:3:: with SMTP id 3mr5956730lfa.121.1598401677254; Tue,
 25 Aug 2020 17:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200824093225.13689-1-kai.heng.feng@canonical.com>
In-Reply-To: <20200824093225.13689-1-kai.heng.feng@canonical.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 25 Aug 2020 17:27:45 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOizniWUk3pUM1X5UHyGcrJy=ybAwp6_jjXfEGjNPe27g@mail.gmail.com>
Message-ID: <CA+ASDXOizniWUk3pUM1X5UHyGcrJy=ybAwp6_jjXfEGjNPe27g@mail.gmail.com>
Subject: Re: [PATCH] rtw88: pci: Power cycle device during shutdown
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:REALTEK WIRELESS DRIVER (rtw88)" 
        <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 2:32 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Sometimes system freeze on cold/warm boot when rtw88 is probing.
>
> According to [1], platform firmware may not properly power manage the
> device during shutdown. I did some expirements and putting the device to
> D3 can workaround the issue.
>
> So let's power cycle the device by putting the device to D3 at shutdown
> to prevent the issue from happening.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=206411#c9
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Can you at least include some more details, like which hardware
version and firmware? And which platform? It seems a bit harsh to
include a platform workaround to run for everyone, unless there's
truly no downside. But even then, it's good to log what you're working
with, in case there are ever problems with this in the future.

Brian
