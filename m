Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7D3C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF7D206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oNajzL3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436825AbgDNI2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436814AbgDNI2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:28:11 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59814C0A3BDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 01:28:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so6048118wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 01:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=3eKkxZpCnC5XTfujNcsY6AIiLZS5NSMLsZAyRTcNdtw=;
        b=oNajzL3gc4X6uBZq8NlN+noAZv2Gkphhx7BrqsinHbStxRK3mBSRyLl7uclZpNXySg
         hAKLdqCSypJnoRELxkRHDz3MkoVbkKTGLOcapNEJx5yYflGhMbDA2sOPdoaL0Mt5m7uF
         WDmZPNzuk3lBb7VlrPJCvT+SnY9UpA7v5Ry9dfYp2LCKE2SSH2vwUOX01e8fcqdapqev
         DT+rbiEBVy73g2jZ/jnni8D8oaG88+bkHRzUMokgsPbNPNYcLuDJGoeNs9YLm5HwISxI
         JZsjnqdYri1FBSu9hFLVNJkqg22lNndUkfXVSUev2XS+ZWNSlXA73Cg9xO4qIJEMYjO9
         kzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=3eKkxZpCnC5XTfujNcsY6AIiLZS5NSMLsZAyRTcNdtw=;
        b=NqaKobKuHk7G/vjLIJoN2Xgqy30gyOH0yGq25CXo16euzKPFT+2RM/b+8WjmvBBXuI
         8nhelE+aDYSvh6qa9LYYZesUKrHPmV6p/tAgkvTpNyY6k5lijJnYbLVdluT45gQD+WM1
         AGqDD+CJbLZpFE5Z/7AcujSmSz1dAwtw6Zr3Rrz8CHlQyfhwWYKgw/wjvSqljuZuceSw
         4y5TPmgjz0h0D0BAPCkQqyXlKoCCTixd1ue7eprfbK1oOEOQnEEQt2uR7pBNNIVP3FjR
         626w/ExdMgQQn79iR3vRfGcfL1uDjXW4neMffq2j7zgJwTDaqYkKHuvtB2xvgCywGN+t
         qO0A==
X-Gm-Message-State: AGi0PuaxC/1fhu4CDGt8N+bRSA3fT3+psvWVT8wY+g70vXheXfGbj35y
        t+SqwenJSFVguOwl/G0tRhLlaw==
X-Google-Smtp-Source: APiQypKYndSXbbLZy+b9xprQxfpL21vClPJkI92BRNsvzRKxpgVqTLytk2+trMx1JQaEpJnlT5Z1UQ==
X-Received: by 2002:adf:b78b:: with SMTP id s11mr21748716wre.235.1586852890065;
        Tue, 14 Apr 2020 01:28:10 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id k23sm17635677wmi.46.2020.04.14.01.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 01:28:09 -0700 (PDT)
References: <20200122092526.2436421-1-jbrunet@baylibre.com> <6f661498f58c6a519095d0657413f4b89d3ef21e.camel@pengutronix.de>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: reset: meson: add gxl internal dac reset
In-reply-to: <6f661498f58c6a519095d0657413f4b89d3ef21e.camel@pengutronix.de>
Date:   Tue, 14 Apr 2020 10:28:08 +0200
Message-ID: <1jimi2tqsn.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 23 Jan 2020 at 11:13, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> On Wed, 2020-01-22 at 10:25 +0100, Jerome Brunet wrote:
>> Add the reset line of the internal DAC found on the amlogic gxl SoC family
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  include/dt-bindings/reset/amlogic,meson-gxbb-reset.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
>> index ea5058618863..883bfd3bcbad 100644
>> --- a/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
>> +++ b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
>> @@ -69,7 +69,7 @@
>>  #define RESET_SYS_CPU_L2		58
>>  #define RESET_SYS_CPU_P			59
>>  #define RESET_SYS_CPU_MBIST		60
>> -/*					61	*/
>> +#define RESET_ACODEC			61
>>  /*					62	*/
>>  /*					63	*/
>>  /*	RESET2					*/
>
> Thank you, applied to reset/next.

Hi Philip,

It seems reset/next has not made it to v5.7-rc1

Would it be possible to provide an immutable branch with this change, or
maybe let Kevin apply this change through the amlogic tree ?

It would allow us to progress on some DT changes during this new cycle.

Thanks
Jerome

>
> regards
> Philipp

