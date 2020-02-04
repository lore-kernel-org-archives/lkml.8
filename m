Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76948C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4665D2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="crTZsnwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgBDVIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:08:01 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35526 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgBDVIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:08:01 -0500
Received: by mail-vk1-f195.google.com with SMTP id o187so5626574vka.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 13:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tav9xQOCZwkuANMiV8MFJGLOVoVF6jN2hQatuYeWYMY=;
        b=crTZsnwq4J41vNDWJH/aaqvEG6L4Kx3l3lckX1j/olViQLFgMytNbzfeQJ34/O6n0I
         YtQSWStCH/JKdUlr3xEow4iTzD/wTz+YG/oFH7gUI3x2zV4rf7lSFfkDpVlXHGvaIuwd
         EK3Bnvhh6ZcfTQbOK2uFTtv1dch+fO6x9YPZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tav9xQOCZwkuANMiV8MFJGLOVoVF6jN2hQatuYeWYMY=;
        b=GVH8jhyN9mnzi3Eou0aHpJQ5GEwqnzef2HT6hMJBZYW8fuWxeKd1mYg6VymLEriTg9
         CAZnTgTHzhNjGA3Vj14aNH6f24nAqMOcPlLDcwHL7yXPm1IFkyA8NtmWw7DInZX7H2IO
         4fUl07EZ3derdXLXhYyPm9aOSTPbYr/phDbOgAHzYsqu9U06CaetCeNmdCgxOCG6oUMn
         UeLvkKxgPkzA7/U9uBDTGgon3aZaud6SbuGDUsEUvAsbh//cjRDnO0qnQmV0vLGiPZGs
         9dmkYJ7I1kuJD9Vussx+GwXygJLVTtdR+NTHNKANa9Rtnz4KWBLS5y122h8oG6gAItoo
         V1KA==
X-Gm-Message-State: APjAAAXLL8c0DMzgbOI04C7vS1R+shkAPGNJVHrd4C1PzyNvQZ8XKLNV
        uC07e7yotuGdR26uWUnObqQUbuA6I40=
X-Google-Smtp-Source: APXvYqyOjaG0FSwCXPAfomT9HFq/geXiZ/9DO8DeoNKjUEKEAk9D4X7peJYKsbP44LLXImrQPu7IfQ==
X-Received: by 2002:a1f:914b:: with SMTP id t72mr18928300vkd.101.1580850479894;
        Tue, 04 Feb 2020 13:07:59 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id r190sm7526669vkf.43.2020.02.04.13.07.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 13:07:59 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id n27so12462582vsa.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 13:07:58 -0800 (PST)
X-Received: by 2002:a67:ec4a:: with SMTP id z10mr18801232vso.73.1580850478221;
 Tue, 04 Feb 2020 13:07:58 -0800 (PST)
MIME-Version: 1.0
References: <20200204191206.97036-1-swboyd@chromium.org> <20200204191206.97036-2-swboyd@chromium.org>
In-Reply-To: <20200204191206.97036-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Feb 2020 13:07:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V2J+TDcydNUx5nbee9794ONyW4yBCcck1ADu2cWeWYnA@mail.gmail.com>
Message-ID: <CAD=FV=V2J+TDcydNUx5nbee9794ONyW4yBCcck1ADu2cWeWYnA@mail.gmail.com>
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Let firmware specify irq trigger flags
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 4, 2020 at 11:12 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need to force IRQF_TRIGGER_HIGH here as the DT or ACPI tables
> should take care of this for us. Just use 0 instead so that we use the
> flags from the firmware.
>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Dilip Kota <dkota@codeaurora.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
