Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1405C7619D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55992465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IJZnCzHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBTCVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:21:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42548 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgBTCVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 21:21:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id e8so907998plt.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 18:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=YAR5AKH97O4wD1WPqWhh58Z+vTDyTGU+wowRu7veeWo=;
        b=IJZnCzHlX08ZA7i7SWUg3SVtMUVih+MtyIhM06LeI0WUnLEa/A/npW9fObuTqHp5bR
         ng5U6jk3rSrmAJ5psu8/fWOitlD/WVffCzwla/GH8evP5zKSx+xXS6sG+O34VufGl4ih
         fmsg6Os6z9BY6etm4kkLqKNOE9U5+BSnxFpT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=YAR5AKH97O4wD1WPqWhh58Z+vTDyTGU+wowRu7veeWo=;
        b=BuPX6X/SY7bFCmSHZ3hx6IKf9rGGrtsAKxC5ZstMXKmh3GRyjf0tmU9FDa+mC6w991
         Mn1piFtCVcTl+pZy2VMhtdDiOiB3R9LZrjEC44y+yNFNhrfJFmQ6oonCd2FlCudApJD/
         kIhEJ5xClnR6tWO3yhH4tH0ZsCVtYcLm7uDNXVLVtvHfCklArHY/Ns3A212oJ69XEGA/
         m5I1lCa0aF10vOShlBjk8bdp/lkN0NsyKDaql0AUAyrDTDzuMCMTbXM4UYoHwfEY3e7K
         DPknHWFSwoz6nBKslZIJYjaT9BKJ0G1ctmyT2lAV24xHd2k9Q9ZZgLp+Khfd9rhnSkgN
         ox3A==
X-Gm-Message-State: APjAAAX1nCh1DS9V1n4EazwMmEkIgs4OFHgMVp4lhRcBsIN2ykzKVEzv
        Z454jfv3gOcdAF5Sh6pUhEtSDQt2org=
X-Google-Smtp-Source: APXvYqwSH9YFZ8odOgVn06hoHxPxyEr2qvJkCwykxh07cvNLocTEBqrTv4zhDDYp2xuIco8iBD2U1w==
X-Received: by 2002:a17:902:502:: with SMTP id 2mr28499313plf.151.1582165273803;
        Wed, 19 Feb 2020 18:21:13 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h185sm956137pfg.135.2020.02.19.18.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 18:21:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1581944408-7656-2-git-send-email-mkshah@codeaurora.org>
References: <1581944408-7656-1-git-send-email-mkshah@codeaurora.org> <1581944408-7656-2-git-send-email-mkshah@codeaurora.org>
Subject: Re: [RFC 1/2] irqchip: qcom: pdc: Introduce irq_set_wake call
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, linus.walleij@linaro.org, tglx@linutronix.de,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Date:   Wed, 19 Feb 2020 18:21:12 -0800
Message-ID: <158216527227.184098.17500969657143611632@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject should be something different. "Fix irq wake when irqs are
disabled"?

Quoting Maulik Shah (2020-02-17 05:00:07)
> Change the way interrupts get enabled at wakeup capable PDC irq chip.
> Introduce irq_set_wake call which lets interrupts enabled at PDC with
> enable_irq_wake and disabled with disable_irq_wake.
>=20
> Remove irq_disable and irq_enable calls which now will default to irq_mask
> and irq_unmask.
>=20

This commit text is pretty useless. It says what is happening in the
patch but doesn't explain why anything is changing or why anyone should
care.

How are wakeups supposed to work when the CPU cluster power is disabled
in low power CPU idle modes? Presumably the parent irq controller is
powered off (in this case it's an ARM GIC) and we would need to have the
interrupt be "enabled" or "unmasked" at the PDC for the irq to wakeup
the cluster. We shouldn't need to enable irq wake on any irq for the CPU
to get that interrupt in deep CPU idle states.
