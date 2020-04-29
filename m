Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A58CC83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB562064C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="v8RjEYW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgD2Sql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgD2Sqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:46:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7829BC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:46:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v8so5636466wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=V3qZVHwLaLK/I0b0rJ63jIE3SQ22bSXyi7PMzS7GVwc=;
        b=v8RjEYW2XwlnNxy17CGhj1lG7soRDm2FdRbHVvt07M7BPpiZupWPv5xqJsnSj6KoLA
         dT9Cr8hP8fI35N+Q14QOEu6k1jbn4fMl82QE+K0xgmvNVRMoVc8292y7H8ByWjjFSE7a
         PdbGY8EE7mNL29zhFBZ0bITzNJ1JSUCby2sDsYTwnaIlxN/lwf6pZgwsQvgo1zIP9RQv
         Qq2Fh/ztGRrUxpFSqjhVDt/ey9aa8li4ufifTG+lN0dB9PU2hxbGUHi2k9DZnUBRoCFI
         iEp12Az23yfAo4hTW1jDEaXzPTQYHVa6JTT+GTErAiK+w+i5TMEjybytvo6Bzyp1jSBX
         zOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=V3qZVHwLaLK/I0b0rJ63jIE3SQ22bSXyi7PMzS7GVwc=;
        b=kf5vhOa+BZ+qS0DR3a3cc4fhkb6l3DreTVqp0Ljy+uMOHf1TTrC/rCMDkp0OunL7W9
         xtd7zM5OkphfKx9hunaOjZba9A8SFchv8DDeEIuxF1zHM7Pdvzn5ucMITeTLBIw/LA5k
         yyWLm9fwlMYiRkorbnZEmtRHZXnz7VGNhuTDl4782Jvv6i98E94ojEdpbGrS25r8TYjU
         rD2YYegUIZkoSpeahmFE7aeSzKvPSA6dk5ZGwKItfY20v5pAo7r/TLjsGP9Xcpbm95ii
         mgZZVB+wiv2RQHwWD74ACO2nu+PngMWV97sh0Rn2JoXTUNp0/qjRNuXxRdJ49DfxxPat
         4+yw==
X-Gm-Message-State: AGi0PuYWX5xmj5vI+bJAPqHS7Udb8sCBFArMcUFMjrMRGX9NFluvmxxA
        8HTeTlECTKUDYCumqEZ+JeXGFg==
X-Google-Smtp-Source: APiQypJdmpXOVXDmvkIQZMAsdMpd1NkWe/42oxJwKXczVw0SkYct2NGkjK3LGFf2yreraYRKmtXSIw==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr4774219wma.138.1588185998986;
        Wed, 29 Apr 2020 11:46:38 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id o6sm145378wrw.63.2020.04.29.11.46.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 11:46:38 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-g12b-khadas-vim3: fix missing frddr_a node
In-Reply-To: <AA7AFC1F-AB6E-438D-8510-BC472552C554@gmail.com>
References: <20200415095927.3780-1-christianshewitt@gmail.com> <AA7AFC1F-AB6E-438D-8510-BC472552C554@gmail.com>
Date:   Wed, 29 Apr 2020 11:46:35 -0700
Message-ID: <7hftcmku44.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

>> On 15 Apr 2020, at 1:59 pm, chewitt <christianshewitt@gmail.com> wrote:
>> 
>> From: Christian Hewitt <christianshewitt@gmail.com>
>> 
>> The frddr_a node was accidently deleted when creating a common dtsi for the
>> Khadas VIM3/VIM3L boards, preventing audio from working on the VIM3.
>> 
>> Fixes: 4f26cc1c96c9 ("arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi")
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>> arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 4 ++++
>> 1 file changed, 4 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
>> index c33e85fbdaba..c6c8caed8327 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
>> @@ -154,6 +154,10 @@
>> 	clock-latency = <50000>;
>> };
>> 
>> +&frddr_a {
>> +	status = "okay";
>> +};
>> +
>> &frddr_b {
>> 	status = "okay";
>> };
>> -- 
>> 2.17.1
>
> NB: I appears the same change was sent by Neil in [1] as a fix to 5.4, but
> this appears to have been dropped/missed somewhere.
>
> [1] https://patchwork.kernel.org/patch/11198535/

Hmm, not sure how I dropped that one.  I applied (again) the original
from Neil (with updated tags from Jerome) and queued as fix for v5.7-rc.

Sorry,

Kevin
