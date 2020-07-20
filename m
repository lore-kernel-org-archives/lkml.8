Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65ECC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53E722B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gJuwBswF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgGTWYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgGTWYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:24:39 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35ECC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 15:24:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so960042wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=SD6pCvrvSmO2DCp4Ax7aixATHBTxpI+s2rfIo5Cd1Tk=;
        b=gJuwBswFKpnqWojomkEAyfFJ97lPplPSeCK+E363TxmVlRV58FKEyWYXj715tEfJaF
         WJp/pzSop/BTyKgsMRvZ4wcQnnV9yHjIMPlJgPRyl7r/47L7CqPAd4hc2kR/EqXNUqng
         Fzmf7psWo0I/pPWpbRBDclhg7PyIf+6bPtBHfRPDsk5o9lVCZc2+HB8j2PxdKJKcNMz1
         Y4jJwL0UGTkWerGpjrBWGt+552ScuE4A1ci+gZiZ/w+ZvEkTYLg2ef0epgkvuwpJvTMX
         s3iBRDxK4RjDsqWn+hMiv1blBBdHqVAA+JrgsOq2VlNnIAzEi0QzFzln0/8+Fc1Fj3hS
         yUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SD6pCvrvSmO2DCp4Ax7aixATHBTxpI+s2rfIo5Cd1Tk=;
        b=TGbWhDvPmaaBWQT2Cgs8OjaEPch4vAT8lkazb7AWlPQnKz0zYjTThrjOYpZRoi3OZ/
         vtL/2JneMv4vKT/h0gy0ElEUdOzvhTnL/GCpjKx7xHq+EWmx88UxF3X8v/FsrfLI2dyv
         zTee4M/YlJIgQ9LHdaSqjqpjmrc0YpQYKiQwsd/BZoI49Or16sqishFH+xU5mp9NoKdM
         YgqKvEayAI93XD/t9LyHFg/BoBM/kr7Nlhk+qYMEsdCdv73J2P0OrBNn8YROWmbyiVke
         ImzrvaWCDuKtjpkkqqjcjf9cBsM7h5Zvru+ZzNYitN/GVYF3x2u2DRRfz+smdsrEXJHH
         0FWQ==
X-Gm-Message-State: AOAM532QONxT9s/8gVORz5XXjrAsU0xWPcAP0Qg9aK2IE2zxRz1pV4BM
        8cxjXtGQxN+3c5g/M6cKLIyBsw==
X-Google-Smtp-Source: ABdhPJzLjqSEGicKLBeM9jtOFSaC7vzuE8tYOjIYpQxTfgGZI4nBdbBv1nDffuj/z+Q+IdN56GIk7A==
X-Received: by 2002:a1c:bb44:: with SMTP id l65mr1283114wmf.51.1595283877622;
        Mon, 20 Jul 2020 15:24:37 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id v9sm36819684wri.3.2020.07.20.15.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:24:36 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: fix mmc0 tuning error on Khadas VIM3
In-Reply-To: <20200718054040.3996-1-christianshewitt@gmail.com>
References: <20200718054040.3996-1-christianshewitt@gmail.com>
Date:   Mon, 20 Jul 2020 15:24:34 -0700
Message-ID: <7ha6ztakpp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> Similar to other G12B devices using the W400 dtsi, I see reports of mmc0
> tuning errors on VIM3 after a few hours uptime:
>
> [12483.917391] mmc0: tuning execution failed: -5
> [30535.551221] mmc0: tuning execution failed: -5
> [35359.953671] mmc0: tuning execution failed: -5
> [35561.875332] mmc0: tuning execution failed: -5
> [61733.348709] mmc0: tuning execution failed: -5
>
> I do not see the same on VIM3L, so remove sd-uhs-sdr50 from the common dtsi
> to silence the error, then (re)add it to the VIM3L dts.
>
> Signed-off-by: Chrisitan Hewitt <christianshewitt@gmail.com>

Fixes?

Kevin
