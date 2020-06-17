Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B206C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D6B20FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrDkRj6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgFQVkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgFQVkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:40:08 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857FCC06174E;
        Wed, 17 Jun 2020 14:40:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q2so1496508wrv.8;
        Wed, 17 Jun 2020 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TelJDy/akz0cxqXpsjPfZr7B9kQp3Gu4jk4l8uZhhzc=;
        b=mrDkRj6r4yjLNk03b4bjDHiJEXx4K48/qeBW6a8HGNY5AJr8xhJYoOQ0Lkr6sOC1fc
         nAOZQIAxKGRUCT+rJk1TzKFXUYjEOgDNotfGtiqXZF/IWG0PBWr+hznDvSlQrihPkiSE
         qqMO6S1yIx2NcTNSmEGTR5PRHJaIFbz5MveUfu5W+US9fl8mmpFPo1ML1p4hLojt1gqi
         arKIo5n7r4gRIV8RbEqKloMJEaRi2gemUncr3HH8BTHMI64sMUHNQYMPA6Y7+TiyQ/wv
         g7deJSCdGXZT+QhCkfnyU2OgDndlOu0QdzYe4zz7bn8LEnk0FTXEissgfd2tDMnW2XkC
         JGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TelJDy/akz0cxqXpsjPfZr7B9kQp3Gu4jk4l8uZhhzc=;
        b=IUlZvC0R5enbfRhWr6l3CDjumDcDkt3uqWAAn+4Mt0by6GJCwk5AYoeyyel5UGH6E2
         //anu2UBD7AqSlbklEj+wTAtb/P+JleYqHvop267CfUnbM70rIsYAHFIDGmdOjYrQW3B
         bi4ggNrQO5iPQZZjybD1Bb5GSdG0bI+2vvtf8pebASsdFX9s80ZWUl9g3PyU09UhvIlj
         MvjaH54/OF7Tr6put654kHs4zE0nFBfPy1vb4z+7tLuUhCNgqBMTx0TJP4udN+X71BG+
         ayxqCR3DEJcjILriXv/y9uV/f2WYgF2MfgI8ycEwES2tYhYOj2h0gg2T45HXiwbg0GMc
         GODw==
X-Gm-Message-State: AOAM532+sUeGzELjJBjtCBO/snFlKOGvGIZaloTQV/EouzBAH+AAjFzk
        9JuF74gNEZri/lEskPExE+V7pILw
X-Google-Smtp-Source: ABdhPJziOk076AisKbLb6sm+IehmmjiMlJ7DemnFTkoOMtBbcleHTOJBLz8zJmMRS7DOkh0sjv0K8Q==
X-Received: by 2002:a5d:4f01:: with SMTP id c1mr357781wru.190.1592430006996;
        Wed, 17 Jun 2020 14:40:06 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id e3sm1000404wrj.17.2020.06.17.14.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:40:05 -0700 (PDT)
Subject: Re: [PATCH 5/8] mips: bmips: add BCM6362 clock definitions
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20200615090231.2932696-1-noltari@gmail.com>
 <20200615090231.2932696-6-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7c456fea-1186-f18c-cf59-772115d3605a@gmail.com>
Date:   Wed, 17 Jun 2020 14:40:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615090231.2932696-6-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2020 2:02 AM, Álvaro Fernández Rojas wrote:
> Add header with BCM6362 definitions in order to be able to include it from
> device tree files.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
