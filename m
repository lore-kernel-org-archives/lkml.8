Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B62C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91FD21D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jCAh83IS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgCBQX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:23:58 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55418 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgCBQX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:23:58 -0500
Received: by mail-wm1-f67.google.com with SMTP id 6so3465262wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 08:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=UaXmfdRD+RogZavDsWZ2Xu1muVDHx7qL1cRXMVQIaG8=;
        b=jCAh83IS11VcYAMyCg2IKY9ysFWiPlOllIQwqJIKu7LC0UgfNy/0YUshkg8sAsIixe
         T2tyJDMQmlUIRqvBWjVkkApLb0zj4ihySmriBj4rcrCdnF4G5NYI5sqxEfjhu4wLCcJm
         U9LPB8Xufr4d9P5gGp4lFXy1T3BYpjfEQgVc1NiTXuUdr4890HIcNTAtpHq6AL8le/WO
         gH90ODQ/OXDQtPnMnRvclPrHaaH8rQixBMs1KTJNTyQxfYN1XLIJ/pG3BM8JEANL9lvs
         VvHDtqg6YN561nKG1P3doe523Sf+y3jXbfL9CwPS544mxt3KnDPztlKlV8IOjHyPIqz3
         AfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UaXmfdRD+RogZavDsWZ2Xu1muVDHx7qL1cRXMVQIaG8=;
        b=Uugh0HL29E8RCvmW8kURXf+HsYi/Uwwiqj/GOOihUqsbNonL4vZE4o/DYYQEUZGtyO
         G0K99c092zFfTmKnpAM1WTFJ8UE0J3by0AwGI6pbE+YrfGgdFhKAz/75OoGymeY4Hc4l
         7pEpVcMWbazV/x+IFX/+Fhuy9lE+H/SMCMNraqO03bpJto8ELI6tBUStsUz/VIcEy94q
         lxzrGR7qE0ag6v1mVuZgz1B30lFFWqpFsGcPWpYtXgTC1aCQSyB2o9iaDe3fjk3320JM
         dLDporXvqzXPULU8cxGfTDjGCg+D0Svwna2L2gvxHATxhpKzyThTwYnyc5FFeRJP1DzT
         V3Kw==
X-Gm-Message-State: ANhLgQ0fDZQH9elYCi40BkMxjs+9/exdwoKDngG2GoYW15ft6DXH1XKp
        +OCTChsEMNM/hy1Lb6xNwzVHcQ==
X-Google-Smtp-Source: ADFU+vv8D6CdaqmTDhr7fwgQwP+TsU7dihlNiEMXFNlusa/13yIpEeBBvpYiQrJfUxeUtmQvHgtsHA==
X-Received: by 2002:a1c:f615:: with SMTP id w21mr200544wmc.152.1583166236090;
        Mon, 02 Mar 2020 08:23:56 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d7sm18821187wmc.6.2020.03.02.08.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 08:23:55 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, mchehab@kernel.org,
        hans.verkuil@cisco.com
Cc:     linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v5 0/5] media: meson: vdec: Add VP9 decoding support
In-Reply-To: <20200219140958.23542-1-narmstrong@baylibre.com>
References: <20200219140958.23542-1-narmstrong@baylibre.com>
Date:   Mon, 02 Mar 2020 17:23:54 +0100
Message-ID: <7h1rqasp2d.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Hello,
>
> This patchset aims to bring VP9 decoding support to Amlogic GXL, G12A & SM1
> platforms for the amlogic stateful video decoder driver.
>
> With this, it passes v4l2-compliance with streaming on Amlogic G12A and
> Amlogic SM1 SoCs successfully using the stream at [1] with a fixed
> pyv4l2compliance script for VP9 at [2].
>
> The original script kept the IVF headers in the stream, confusing the
> decoder. The fixed script only extracts the payload from the IVF container.
>
> The decoder has been tested using the Google CTS TestVectorsIttiam VP9 yuv420
> samples and the VP9 Decoder Performance streams at [5], decoding all streams from
> Profile 0 and 2 up to Level 4.1, with 10bit downsampling to 8bit.

Tested on meson-sm1-sei610,

Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
