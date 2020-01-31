Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB734C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3CE206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CxlznEqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgAaAC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:02:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35620 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgAaAC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 19:02:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so6458294wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 16:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=uvb7UjEoJ5QUo55mMIeV2X7P8y9RLioRyMnghzSVrBk=;
        b=CxlznEqw9in4pGeFI7tiEkzvUBjjWH4ADeBPph8G4+G9QoHFQIJpjSfkOWvoW8WmES
         bO53NJg/itV1GXV6G1yDZaoJifzMxdIbQ0wmIZIrxg+0qfokN/yScPANJDpTfiYXHCP0
         VfNqWMyA5ZH6AI7fP9FDpdvUrFP1BlPUqjKbnX7z4kOScVC9S2PYgtG0SZdLk1zt4mlZ
         qbbFtJUU7oesuCNJ1/a/WEQhVtZmiHwYOpaZQyxhOMQQvZPIOyUem+cP6jJRZVfZ7pqa
         v8E1I660ZqgFJlEUdtNXhUzypivyNkoXWANhh9KC2NBUAXZeuegEtQCG+n3497o2pVyA
         iIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uvb7UjEoJ5QUo55mMIeV2X7P8y9RLioRyMnghzSVrBk=;
        b=RdNPea8joCxgs4NbbRQmchgj1dLgpu2ESHcBsZ9WMPaQNiq+DAGV2CH3GxJKysJpUn
         7gkWF8eNmyLasalU8dlMQ/SFZM4qxocr/TAoz9eNpBAUR5d5qOAKYB94iU9oQTHotleE
         AYled2CG5RJgopzC9GqrHIpqpHx9nmZk7cSI6J7IsW5XPJz8rXagHuZh/0tK9WOla93v
         p2UJXibOgu3hxAFby/uDl/JAwQlGj/KirV33Ik0D4GY0QczkuKU0W5ByfOse/b5xswC6
         Q9xW1vwDWNLEE5ovCmcDPc8ckvKrkGD0SwHT9Gsfn7x/09H0rsDyw++9q6Y9EIXqz8bx
         wgXw==
X-Gm-Message-State: APjAAAXUWJRhVelwCfQiUeIm/xKb+EoNDFFWRd3pW03LIwzw99dxHH3W
        URSPmnsYEWVQbqkHU0v6FO0L8w==
X-Google-Smtp-Source: APXvYqwPQPgXUHuMLzMgsVSYsqPcB8oArAwwWFAqxt/Aw9EdJlzgNWxKIbSrHog58z2yHs7ryG8BfQ==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr7812645wrw.289.1580428976708;
        Thu, 30 Jan 2020 16:02:56 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id g2sm9292932wrw.76.2020.01.30.16.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Jan 2020 16:02:56 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] power: avs: qcom-cpr: Avoid clang -Wsometimes-uninitialized in cpr_scale
In-Reply-To: <20200130014130.51313-1-natechancellor@gmail.com>
References: <20200130014130.51313-1-natechancellor@gmail.com>
Date:   Thu, 30 Jan 2020 16:02:53 -0800
Message-ID: <7hk158xzki.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Chancellor <natechancellor@gmail.com> writes:

> Clang warns (trimmed for brevity):
>
> ../drivers/power/avs/qcom-cpr.c:570:13: warning: variable 'reg_mask' is
> used uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>
> ../drivers/power/avs/qcom-cpr.c:520:13: warning: variable 'new_uV' is
> used uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>
> Due to the fact that Clang's static analysis happens before any
> optimization passes are taken into account, it cannot see that both
> branches in the if statement must be taken because dir cannot be
> something other than UP or DOWN due to the check at the top of this
> function. Change the else if condition to else to fix this false
> positive.
>
> Fixes: bf6910abf548 ("power: avs: Add support for CPR (Core Power Reduction)")
> Link: https://github.com/ClangBuiltLinux/linux/issues/840
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

Rafael, feel free to queue directly.

Kevin
