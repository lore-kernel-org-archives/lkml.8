Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E603C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D741A215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KueoG3CH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCCIn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:43:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41972 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgCCIn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:43:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id v4so3211773wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 00:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=yvGUbo1dfhbwTbh96YBjm+vOHC+xmC7MRUhhdcNamr0=;
        b=KueoG3CH8d1TILJ3jEseAooEkY/vqCzu5vVfybY/sidTv3lRB7+bx+mjB5w2ewajdY
         cY8h1RYGKivEhz4QZtczAVzTeVu+P8LmMF9AqbQANAoUbkt6AxMrzXQC84mvDEoYG5Sn
         R3/Gc+FFqRUZEb3iQbSEWNuvqpxv78iVNG59hxMWr4q4lvnvaotMkLy1YuQ2jQaT8inW
         DlTbYgGFp2Duo1qHw1IXajEDprPuJtugfSxcbbaYU6xMgfl1u96wPJPHjqzrC22V/2m3
         3oLB9yd31KEWxmtyXhtjLTwMXgnlxsNdCudYoVBzxcZeNeQEAJj495TfgrRNYY2e6jwN
         lUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yvGUbo1dfhbwTbh96YBjm+vOHC+xmC7MRUhhdcNamr0=;
        b=HM5yN9tD7YXPbFJv/knU12/6L4md0OPfUZLFHirZI7TDuHb7N7TwHSwWk0fEVG1TLQ
         coqq+DD2ZWyFqq9DTFX6a4wwrngcHrIzAZOtCnQ38Z11o1qEa5wzEYrxrrl3APrGtu/u
         +Fc4mDp5W9UKlaKV33dU/tqb2m3FKk8Imocvv2YgnZF90xZt8LbXPCMQpGCIM9NSfoPR
         eKcfZ9KQ8fQvWn9tF9Lynxii0/zdclyiadXkg+R5+02DpRo8smOKwy0rqc+21KPzdNX1
         olmATKcjdv76rjWpdiXNclWf/EYeeWq+n5dAVZ7K73+4SFH9pg7AXyeAsLbKGl6veJq/
         /FtA==
X-Gm-Message-State: ANhLgQ0kug4xVH8VAM6JrdHG01DQkZb27cpzRXV8omb7PlmGku/V9ZNA
        7Hy9y6jGZ5KM7mQnPGcrzC4H0g==
X-Google-Smtp-Source: ADFU+vth77irrYVpMCLL+lMOH+om3PsHUPjCNnAr+ba1VOLlWJv+R/5L/2HoCPBEenVfN9Fm/OsO5w==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr4425101wrr.352.1583225034157;
        Tue, 03 Mar 2020 00:43:54 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p15sm2720213wma.40.2020.03.03.00.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Mar 2020 00:43:53 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rob Herring <robh@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>
List-Id: <soc.lore.kernel.org>
Cc:     linux-amlogic@lists.infradead.org,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        SoC Team <soc@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: power: Fix dt_binding_check error
In-Reply-To: <20200302201554.GA22028@bogus>
References: <1583164448-83438-1-git-send-email-jianxin.pan@amlogic.com> <20200302201554.GA22028@bogus>
Date:   Tue, 03 Mar 2020 09:43:52 +0100
Message-ID: <7h5zflrfp3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Mon, 2 Mar 2020 23:54:08 +0800, Jianxin Pan wrote:
>> Missing ';' in the end of secure-monitor example node.
>> 
>> Fixes: 165b5fb294e8 ("dt-bindings: power: add Amlogic secure power domains bindings")
>> Reported-by: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>  Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.

I've (re)added these tags:

  Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
  Acked-by: Rob Herring <robh@kernel.org>

when applying this time.

Jianxin, please collect the tags in the future and add when you send
follow-up versions.

Thanks,

Kevin
