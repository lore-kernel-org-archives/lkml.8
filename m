Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB14CC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B152068E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YRJMFTxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgD2SW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2SW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:22:56 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB5FC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:22:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j1so3761968wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=B4AExkQ/skCkgH//SVAJ+HY/UbjZ3z29vi0E6Yau+cc=;
        b=YRJMFTxbM0bgeSz3RuGdHJxxLuwdgSWTgLgtoiXIweL8tIX9FGlQlYaJuSUPBBJz0K
         jPCUAaMxuGVVpRauDZzmKr/3YoCbJ8dGgBs4OfNCURbd46wqVR17diEUaD4lxblwDd9c
         rsKW63ZlF0YCMIMPUQT6JYhjBEUCvhRkmQ3tlpSdKpy79JwByxKi2bPbiCo5G2U3xqLz
         bjiHLqA6rzM3UqfIv4hcmbEeqCS7uT3R8NzQ6ydkUH7wkEtNdpeSvRd8rckqycaIWWkv
         L+l9Ip1j3qWw+VwY+VJRYHlAZ2TU9W196zkfI5yFx4ESXLU5l2gnaJVEfdhvY5u9L8F+
         ZjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=B4AExkQ/skCkgH//SVAJ+HY/UbjZ3z29vi0E6Yau+cc=;
        b=Kv8rvu/gFnDY+3emBhLR8aFsxXfSn7De+8H/O2Bc6txOLvMLwfkqljZ/7+yv4e2kIF
         ejD8SsXddeiOD3cuK7FGEYJg/tJYiL3ObrpYBT0ETW1m+vO102pAMeh1d2oLWkCVBYqo
         z+nNhXKO0bWcBbhVUOOb1i41zbTCENqVWBEjI45yjcG56yxB+y4G1RjupNZeEh+atf07
         SLWHIHWBFQVLwyoKzIKlLluXybmGJuDyiogH/wDLbYkY0pj1cwjImM0Z9ugEiMutK7kQ
         2gF0euFjpvlT802RTUploybkTn67F3sRJquI1VFXdqqQyCySS3oFvgRL3lOhkWWW3KR5
         Qxog==
X-Gm-Message-State: AGi0Pub1PhwWCfjkDKMx6irljLW2sCG9y3+XWPzT0LF0XVn0X1kQetL/
        xQT9Yt4DtP+GXUABrTjnhgSMuw==
X-Google-Smtp-Source: APiQypIgFkCETUKcnEqx8tMuAByNY5IhjOfevdMmAgkZMz9mukDUiKUpnYW6PV1StwGdsiqRyq/pRw==
X-Received: by 2002:adf:8b1b:: with SMTP id n27mr38786679wra.385.1588184573262;
        Wed, 29 Apr 2020 11:22:53 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id e13sm117683wrp.15.2020.04.29.11.22.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 11:22:52 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64: dts: meson-g12: usb DT fixes
In-Reply-To: <CAFBinCCwvfycP9VZ35Jn=yNRbgbUYkRucLPpRGCJv2XCTR+o6Q@mail.gmail.com>
References: <20200326160857.11929-1-narmstrong@baylibre.com> <CAFBinCCwvfycP9VZ35Jn=yNRbgbUYkRucLPpRGCJv2XCTR+o6Q@mail.gmail.com>
Date:   Wed, 29 Apr 2020 11:22:49 -0700
Message-ID: <7ho8rakv7q.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> On Thu, Mar 26, 2020 at 5:09 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Misc USB DT fixes for G12A.
>>
>> Neil Armstrong (2):
>>   arm64: dts: meson-g12b-ugoos-am6: fix usb vbus-supply
>>   arm64: dts: meson-g12-common: fix dwc2 clock names
> for both patches:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Queued as fixes for v5.7-rc,

Thanks,

Kevin
