Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433F7C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE6321556
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KaJyPlfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgCBQXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:23:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43993 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgCBQXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:23:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id e10so424557wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 08:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=7dhtMCeqCCrozUAR7xWCIRbtdQoUsRNHKe3qSBD7eVQ=;
        b=KaJyPlfL/YL/9IzhgPdg7VRoSA7LOYbGnEm5sD16nPwvywgw/HLr/bDtR4FfsNsW/a
         6ASEkqooYQDr/nEMmzqnEbo4tfjQNdWmVrBDJjijwQxIM691mp2AwBM6bTJ1u+JZ+xDE
         GaVEo8Z+dEkN5CvjjpJduUgwMabGNiBqHWb7IhFQ9bN9Nn3wNVuBUtaz/PRNLZUrzDKU
         YNj2bOhLVym29ovWeg+gHxcz4GP2iEzej132wvegafj2QR1PdOIrD9GMvLYX2xSgrLzU
         XZI9V9LQjKtUP1Bz8GFfo1hZ1Ir5mY1RpNrO1be4JpShfuURRfd+GQLG/qI4djgTlmDT
         7FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7dhtMCeqCCrozUAR7xWCIRbtdQoUsRNHKe3qSBD7eVQ=;
        b=W7xfvFrylkXCwD3kaMIoqxVTHPCkDqysrovMJHtbYH1YSgTKJkcvCAeoM2nEwU7ODd
         UmepTEdBzVWJ7nGvThRUJ0/aX9K6soM/xIRIfqZgjM2xHJLI0+wdHjBkUZ4qkBSGR1wW
         iOndJRy+rE11z+NLd8fAOGwhom2fMr2mmu+PBZFb2fRbZy35adZxP4fxk8pmiYKehADw
         9hNhvDSCp4DxzofBfrVWHEL/1ffKkWrSKOBYDCttNJuob6hNvCO1rGQx9X9COEX9VwUn
         V9jR0m9g02Tnc844vloA4DA9ArsjmUEcfCEmMpwJo4Is6LtBDlQHWDeecPaVTKTsFQoM
         EoBg==
X-Gm-Message-State: ANhLgQ2l6IAH/dq365jJTRmoSeqpznsoGwpfRcdocQWMCsu7snFy5gqW
        Pg5ah1+jAQ6DZXGOZ1uI+R3m4g==
X-Google-Smtp-Source: ADFU+vs0kNer+mtpZoTW7AZ3bv2U14dkD7HjJHBJ4bHZFfi3uzwaxEhingENvYB1CplhRWLQ9UgEcg==
X-Received: by 2002:a05:6000:14d:: with SMTP id r13mr355801wrx.63.1583166210659;
        Mon, 02 Mar 2020 08:23:30 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n8sm27622995wrm.46.2020.03.02.08.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 08:23:29 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, mchehab@kernel.org,
        hans.verkuil@cisco.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] media: meson: vdec: Add compliant H264 support
In-Reply-To: <20200219140156.22893-1-narmstrong@baylibre.com>
References: <20200219140156.22893-1-narmstrong@baylibre.com>
Date:   Mon, 02 Mar 2020 17:23:29 +0100
Message-ID: <7h4kv6sp32.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Hello,
>
> This patch series aims to bring H.264 support as well as compliance update
> to the amlogic stateful video decoder driver.
>
> The issue in the V1 patchset at [1] is solved by patch #1 following comments
> and requirements from hans. It moves the full draining & stopped state tracking
> and handling from vicodec to core v4l2-mem2mem.
>
> The vicodec changes still passes the v4l2-utils "media-test" tests, log at [5]:
> [...]
> vicodec media controller compliance tests

Tested on meson-sm1-sei610.

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
