Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7B4C3B1BD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FB124654
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nxT8uiE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbgBNTu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:50:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44582 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387508AbgBNTuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:50:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so12256108wrx.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=RC5diiaR31GO1rhNQqP799z+UvDMaz6Wswnev5LOZWQ=;
        b=nxT8uiE/z52YUercio9Z5U9t7IR3335+MJiJlP80FZE6VyMExWaZrdmMWfDGExAHJH
         UyKPXipXu0iaHR4UEWlfizHzMWSOaQxyrEdJJR783jkcXSGK9VsyV01m2xMT0Mw8wlbO
         AaGiC16TBHGyAKgukrHgBCtrmcFsmgrF8VJJq46pfS7/biBsMnKlXrp9aIxSIXpEtxtR
         PLM75PKRSTkJnEZE5X9BssKTdQqAQ9xFVsjDPMDtFdM5VT2ICVDPbK3G/1E4QLJcjL04
         PtD8CJCvmor2gmivTA7eV+66UuAsYVEzIRikVpVo0FnB49W3iDElogQ0zRQxZRC0XeSm
         dj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RC5diiaR31GO1rhNQqP799z+UvDMaz6Wswnev5LOZWQ=;
        b=qhv+ZLZc0qrFOjMg4BabXrhRbYlA/WoZ+ak2xWOclepsgPErJe3VKfIFZtg/sBPjId
         b44Sm0IzXi4fJBwg0SCXptX03Rphs0g5nfvOEjba+Erzx/X2lo2ulwaRW/KECc/SZkMf
         yzi8rMJjNFLMPuD3boA69KsJ10G4qJSPY0VhUVJXiti61caYqToEGGlfIu7BuIo+jfd1
         MfkwGjUG9n8HLrIB9tWknJ7ETFDUM4SNlnyocy1gIc8LcIO99KXU/EC3+GfpdbHvlyDy
         zwVbQWq1xCMIaPeTd0XHWwX++Rchm+FgRxWz6e+b11FJk9DshJ75i4Mt3MwP1CBQr7bl
         Wqlg==
X-Gm-Message-State: APjAAAUI/zKCD2VCO6RhrypuYzxaVcYDPLQ2/jv7vgn1sW8txvWxrge1
        cFcfd/DqpzBFbBwE5h0QH8wA6g==
X-Google-Smtp-Source: APXvYqxJ0lDeRgZFQoYhh/V5X69ykQbrkOdOXgABmMtigig5INOR94v2BGam/S6IxkftSmbnVRCbIg==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr5387293wrv.86.1581709854692;
        Fri, 14 Feb 2020 11:50:54 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 21sm8793510wmo.8.2020.02.14.11.50.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 11:50:54 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jian Hu <jian.hu@amlogic.com>, "Rob Herring" <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: meson-a1: add I2C nodes
In-Reply-To: <20200109031756.176547-1-jian.hu@amlogic.com>
References: <20200109031756.176547-1-jian.hu@amlogic.com>
Date:   Fri, 14 Feb 2020 11:50:51 -0800
Message-ID: <7htv3t9cdg.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jian Hu <jian.hu@amlogic.com> writes:

> There are four I2C controllers in A1 series,
> Share the same comptible with AXG. Compared to AXG,
> Drive strength feature is newly added in A1.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>
> ---
> This patch depends on A1 clock patchset at [0][3]

Just FYI, due the dependency, I'm waiting on the clock series to merge
before queuing this.  When the clock series is ready, please repost this
since it no longer applies to current mainline.

Thanks,

Kevin
