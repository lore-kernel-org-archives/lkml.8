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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4123C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8232E2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD1YVpX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgFQVjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgFQVjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:39:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282A5C06174E;
        Wed, 17 Jun 2020 14:39:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q11so3947232wrp.3;
        Wed, 17 Jun 2020 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JXqxnQrzDx0KFOUE9cZQZWZFRg6fINWzTehW9g1ojWQ=;
        b=QD1YVpX8mfIF+n1RkMXenprtAVibl19Y3u8qshEvP63c0Q0Si2Zm8nqFlAL8SMHIl9
         zT83vgcwmIOrVU0xDCtAg6pWEEMGZ6fdKZgoWUJVwID6UL/u/SjKiQmcXzvlW8cCQcD9
         KBaEZb9gVPJypzuqwEbOLryGLaERUnXNsJg09AxjrPPwSOCj9NEqzFrkL1qwHxFpxkdg
         Ec5I6ht2mDiAW+q2JGbMvI7gQMS9yi3+3kCH/e4o/uzFeMi1vY4NSeQMwyHvKQrKovhE
         rtdhsGquvXqXHXrxjIDs98MrKqjOj+TTlegkYinZilwGLRPzLg5C71PqSKNRrUQwKJOV
         dh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JXqxnQrzDx0KFOUE9cZQZWZFRg6fINWzTehW9g1ojWQ=;
        b=j3NWFLrBbI2JEmiDDaZhuGKEuaesehezZUTQHKSlJa26+LFtsMhnAJyRvsWbMFFPN/
         4avVj7fXTDN0NJwmZGIpfhskC24GJJVB2oo19RrWS75x06XFJOy4qA/BFlXAZ16RgYl1
         /ljka8CK/mWO5JxjR8ZG9y9eyIA52Yxc/Fmr//SNJ+IJc9QuPaDwwQUVeV8khOgBGKwP
         p0uAwigA9pIBowxRkw017cRnGgpf8EMzoLacJESLu+GiR34QfPY3Ur5U7mNHapmT2MQ0
         qLLFgmhmgbxmmGMU22DVrtW6Fg+X3IillpvjDGNWdPYXL/wONIs13CjrE24zyz9Gbqav
         v2WQ==
X-Gm-Message-State: AOAM530S1IXHxgkUHnGcvdgcA9xX6Icm7h2wBNC4uXxm5grdORD0u0qp
        oX1uv36jueM6Xy1yKqYQUg5GUMdH
X-Google-Smtp-Source: ABdhPJzM8txse9pxmwNfTVh2Ajki4psa6Psii2cLfEKUlqxGEvuBBO/z+mm541KTkFWnZOwt7KPbrQ==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr1189855wrw.169.1592429990649;
        Wed, 17 Jun 2020 14:39:50 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id r4sm970409wro.32.2020.06.17.14.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:39:49 -0700 (PDT)
Subject: Re: [PATCH 4/8] mips: bmips: add BCM6358 clock definitions
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20200615090231.2932696-1-noltari@gmail.com>
 <20200615090231.2932696-5-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6cfc1883-dfc3-d1b3-6125-45bbc41c8a56@gmail.com>
Date:   Wed, 17 Jun 2020 14:39:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615090231.2932696-5-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2020 2:02 AM, Álvaro Fernández Rojas wrote:
> Add header with BCM6358 definitions in order to be able to include it from
> device tree files.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
