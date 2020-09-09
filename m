Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BE0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE3921941
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HBjuZLWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgIIMTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgIIME5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:04:57 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0BEC06179B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 04:56:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gr14so3157214ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 04:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogwkQhFvnI4MZlMSYD/QWVKe2D0wYcRnW9BslwF6Qd0=;
        b=HBjuZLWTbosii7ivJ9Ywlo8ZE/yi+uOqSm+jpG3K3CaNg5EhfDmRwyHOQ+LkqQN5bt
         r8E9HZ0CmCpqg/EgdrmGDCLKPOyUAc9ZeexJq+vO0q3W1nwuh1hLu9isrW2iuMQ2Z5Mp
         wpUEZdWa955qmiMBbYZA+9GD7k/1thaZllOGhbKDLuva5LrgIEOuqFPXBjMmPe8vc3vK
         XsQKnEd31lZOKsyuLRftddoIyY6046V39zwwVyj5TbmwMijQthaBFY4YgPRywh8WzAff
         1ODAm8vxmT1yWtxFBnD0boY5J+gj+4ot/eICHddgbieS3nKkEl7LgwIjJLFpnV7AI9no
         Scyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogwkQhFvnI4MZlMSYD/QWVKe2D0wYcRnW9BslwF6Qd0=;
        b=kxNoynYCSbanMncYicAP/M2pZg0RzSd0FLr0+E9WXVGp8elFY2ENWtGrVg5UP/mNl1
         rYsmKM2GktKm8LyNLUW2uNK1peG+3kU2MKkB5nXnODzDjfxgjXZOlKSyBffP1e9My44A
         OjtPQ+0L4fGbDIBYHaki1oZ6eSxJhwxvHcKn3Kt4HiTWmZGM16Xdk/mCYdTMH53E+sHk
         lHKvh2F/Tsl6Ucm+fpWmcQCBhdLCc24t7kaKdov6XqzS+zhvqzTjSxB3/ePnR1PTzA96
         pp4AvWxrH8pyCggapC1FXqhUSGrpJlOIDOJqzoR3WbHOGK8wwPulBEn/sOTHmOj4Masj
         BG3w==
X-Gm-Message-State: AOAM532hZ1WnijUORY4jwCp0sUhE3AEHfx4jYp5ELykmShNBkdxbQoub
        dlnnaFJTa8ZYDLcC58ANkMS6GoDDkxudYCCw8XGvmw==
X-Google-Smtp-Source: ABdhPJxwxVcYxxRPx0hopbc/8wKbrEuh526OTa/mrDYz3ssckdGebxt8RtgFJRB+3GTtZQfvkNw7vv+GO+mnfJZRYag=
X-Received: by 2002:a17:906:3e90:: with SMTP id a16mr3019456ejj.363.1599652604922;
 Wed, 09 Sep 2020 04:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200903081550.6012-1-sakari.ailus@linux.intel.com>
 <20200903081550.6012-7-sakari.ailus@linux.intel.com> <CAMpxmJX40=iYYxL9Uvs1Pjj9c3NvZBGJ9Mh9-87T0c==FKEXRw@mail.gmail.com>
 <20200909111121.GJ2272@ninjato>
In-Reply-To: <20200909111121.GJ2272@ninjato>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 9 Sep 2020 13:56:34 +0200
Message-ID: <CAMpxmJXDrL92QH_Vb+P4LoQ-WGBMM42GvzXjquW2Lzotm5wggA@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] at24: Support probing while off
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        linux-media <linux-media@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 1:11 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > This currently conflicts with the fix I queued for at24 for v5.9.
> > Which tree is going to take this series?
>
> I recall we agreed on I2C.
>

Sakari,

can you rebase the at24 driver patch on top of Wolfram's tree as soon
as he merges my PR with at24 fixes?

Bartosz
