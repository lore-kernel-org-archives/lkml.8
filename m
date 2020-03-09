Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A84CC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455B82253D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z5y/6JA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgCIWDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:03:30 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44941 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgCIWDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:03:30 -0400
Received: by mail-vk1-f195.google.com with SMTP id s194so1417434vkb.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ClLEMAmgetJxXdQd0ir1n4N2JLLEEwIIgLb8pYjrFs=;
        b=Z5y/6JA/8On9tHJd+eVK0csGW+/rNGuWN845725WoqTZLD5d3CyhFTE9ZvVR+ERVnH
         b70y1+eqAS722ITwHeAL/CsYUimbosf4OI99T8iv2wAylro4niBrKNK3E2nLKysT+38C
         X2nBlufhZKksqXwuJEMVn4oJhwmWZfJKjgHEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ClLEMAmgetJxXdQd0ir1n4N2JLLEEwIIgLb8pYjrFs=;
        b=pqkikjTFcR3qFHD/XeqEVVy+bHmag3VZ1bY4L3D5irz4zLIDmNQDk4dnwNAMgFGHnM
         6HCDylUjUep5saNtFj+yr4kHltJSHL9vZvlNG0c9PnqIfgJH5gjkkqaoQDZgFPP1+M8u
         3Uo1hYPT7vUzV6P+e+tYmA342BQwyjy03oqUNHfpcWuFcG/3ntpYDcTcKS/ZLFoijN6c
         I3/nzTNfVxoUdzV1/X95T9whiIjzbgf9T8nLqED3MK+0Z51H80xVIbrlT31tFJwrp7Ft
         i00pTpN0SRY5vqigyxsQOO9zXt87lJMuRLwHVs4NP+SDhWotiYSzhqIncACO67RG7K9k
         mTmQ==
X-Gm-Message-State: ANhLgQ1xmaGDCpzlvutzCIkrTewxwADtxWlxDHLaKU4HXsP1+ydPSAA1
        KITkroFLI3Jnzdls//tI4ju+wviLbEOjBkBskQ72HQ==
X-Google-Smtp-Source: ADFU+vtRSC56yqPhVngdmy5IhfrdvXYu5SgRvQSPpj+QTOGWNC2znS7px/H3He40jNCpzYG6qWjfKVwuR94d0+1QX/c=
X-Received: by 2002:a1f:99d6:: with SMTP id b205mr10459024vke.88.1583791409656;
 Mon, 09 Mar 2020 15:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200308212334.213841-1-abhishekpandit@chromium.org>
 <20200308142005.RFC.v5.1.I62f17edc39370044c75ad43a55a7382b4b8a5ceb@changeid> <A815D112-7B0B-47A2-9CD5-C0D2E2115F19@holtmann.org>
In-Reply-To: <A815D112-7B0B-47A2-9CD5-C0D2E2115F19@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 9 Mar 2020 15:03:19 -0700
Message-ID: <CANFp7mWJ06OHYit-sL7hvJhCNuYNmaH0N1DCww2wzReyi27Ygg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/5] Bluetooth: Handle PM_SUSPEND_PREPARE and PM_POST_SUSPEND
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No -- the kernel test robot is complaining about Patch v3 which has a
known problem (not taking into powered state into account). That was
fixed in v4.

Thanks,
Abhishek

On Mon, Mar 9, 2020 at 2:39 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > Register for PM_SUSPEND_PREPARE and PM_POST_SUSPEND to make sure the
> > Bluetooth controller is prepared correctly for suspend/resume. Implement
> > the registration, scheduling and task handling portions only in this
> > patch.
>
> is the kernel test robot bug report that just has been posted still valid?
>
> Regards
>
> Marcel
>
