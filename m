Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F024FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AD424672
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 17:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QVtbZxL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgB2Rba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 12:31:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35551 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgB2Rba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 12:31:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id r7so7266585wro.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 09:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=gIWhpXkGhBdD7D4tCRq8IhuPOVGlHh8cgQBYQ6BUTQw=;
        b=QVtbZxL4BTuOxWG9U7zurT8eoEW0kIhCosDTS6Y/48DrOg8qUH0kOS2rvyykW/zWZ2
         QAetKLAw6hJCoqsbII4eHjnCCELiBOm8pnZHs5QmpKLTYHmaznrsrb0tpJfDJQ7Hs/Nj
         0ZPNxzQbF4rk1Sj9k/DmNS31m/LZqXrk0EIj7fYomlSssHR8jjFRqQSPryvnxMlj/oQu
         e/RBcwAWRFuX9r2qRrOUtVvjXY4ZpPBEBmUnslSZCpUfeM0YGsJxaR5J44dkxv3FpuIi
         U72YHyQ2VfOMmJCXEJ0BK1vXYd0KJ/e2RDZtfmu3gEjfZDfZogCJegkZgt9q1ce4AJLj
         JAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gIWhpXkGhBdD7D4tCRq8IhuPOVGlHh8cgQBYQ6BUTQw=;
        b=E7zFpHOMWmXTd9DS+L9gw1EiKq3DjqdoRxCzjtKY0I7VU7wV54XZ8qzPXE1q/GPGMb
         R0GxIfmZ6/b92PiNTn5aQ6qFYBnSR7AZhLoJDPjr6rHKEshHAdqYv/G2kXv8+Bwjo6Qc
         3T+JSDB+lwqfrwU7bDiVHf8YlAKEibeuhnpSCrqG7NyG6d8ZVvjersBoE3gc2W4UmH78
         tU9vWimXNyawFsEcLX01LdmDgrFINf8+1jUIvgWsXF7RoRK4LR/FPuilZEHr1gR2/+jw
         Bw2nIOg+QYnYnjxdW6/ON6lI+RYhQhAUv207NAYY+rzB4jFEf1WRFrj0e/L+fOeAj7Ym
         99Qg==
X-Gm-Message-State: APjAAAWaTL7q/G5NwQW495VsNAcxDvhoWFN6K505ByZNviO66beiqqvZ
        PM3xIFRClvkkgQ9zcubfJaE6iQ==
X-Google-Smtp-Source: APXvYqxT81ciYzv3VRN7D5AK2cO0SiOZFOz6Hky5+PclfU1bKhrwyZ6y65WbJRRZN9RDot83f+FhcA==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr12129653wrn.29.1582997488817;
        Sat, 29 Feb 2020 09:31:28 -0800 (PST)
Received: from localhost (229.3.136.88.rev.sfr.net. [88.136.3.229])
        by smtp.gmail.com with ESMTPSA id 19sm8213197wma.3.2020.02.29.09.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Feb 2020 09:31:28 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, balbi@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, Tim <elatllat@gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: g12-common: add parkmode_disable_ss_quirk on DWC3 controller
In-Reply-To: <20200221091532.8142-4-narmstrong@baylibre.com>
References: <20200221091532.8142-1-narmstrong@baylibre.com> <20200221091532.8142-4-narmstrong@baylibre.com>
Date:   Sat, 29 Feb 2020 18:31:27 +0100
Message-ID: <7hwo859u6o.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> When high load on the DWC3 SuperSpeed port, the controller crashes with:
> [  221.141621] xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
> [  221.157631] xhci-hcd xhci-hcd.0.auto: Host halt failed, -110
> [  221.157635] xhci-hcd xhci-hcd.0.auto: xHCI host controller not responding, assume dead
> [  221.159901] xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
> [  221.159961] hub 2-1.1:1.0: hub_ext_port_status failed (err = -22)
> [  221.160076] xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
> [  221.165946] usb 2-1.1-port1: cannot reset (err = -22)
>
> Setting the parkmode_disable_ss_quirk quirk fixes the issue.
>
> CC: Dongjin Kim <tobetter@gmail.com>
> Cc: Jianxin Pan <jianxin.pan@amlogic.com>
> Reported-by: Tim <elatllat@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

With the bindings reviewed/acked, I'll queue this DT patch for v5.7.
The binding and driver patches will need to go via the USB tree.

Kevin
