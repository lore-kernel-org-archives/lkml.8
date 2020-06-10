Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B63AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 680812072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWwFjtH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgFJQtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgFJQtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:49:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3879FC03E96B;
        Wed, 10 Jun 2020 09:49:14 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d66so1343738pfd.6;
        Wed, 10 Jun 2020 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/cy/uIpKW9q7ihiRoimeihBOOfnT0c4u1MNl2d7+GgU=;
        b=WWwFjtH9a8SO0yZWqP+Grk6jS2UOUMFoSnTVKoZ/A0/0yM0uT1OjDYUwmivhAM7gqL
         Q46NjNQjmBWyIZnGZdV8bkSV8DuA8RylsNHY9srRF/ob90UNDUjTEvC79t35LIsVGtrM
         2IlY2r4d7n6RyOV7frM9sqlRS/mpKynKIZnNszzNBptiSaOJZPOULtFIwVEkWiEEuY+1
         rhja8xF7s1kDGWNeFmDEe6dfG9Cd0otxxIHSunwH4r3Ra+LfBi5OWRqkVnal80+wqlvM
         2VIxRftJmSj4cRsnWk0W7w2u+MAX+Iq2El18eNLKXtRuY+0udaFpjo8UGcyMnceTOIA/
         Xcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/cy/uIpKW9q7ihiRoimeihBOOfnT0c4u1MNl2d7+GgU=;
        b=NQAGXcXLohzR7+XCNvYe/lBgM63Kj0lWYQgMJWgW97IoNRcLaDTEIdw1qu/on3q1yh
         Cie/r1FvUU5Cv8pRzWB9594dHpf4RpM0AnOcYUAAJAPnNnd0xxohw8wqkL+tbk9eaQ+S
         Lg1Vg6+5HEMZboj72mg2O642uV6PS4tREpgI+OEVSvj8FKT3HaPvyIBXD0vbcR9mRrqQ
         JFe8iCMrsgAtpECLWXwrq4RYeVilmkfflZSpi4apE9RGonEsOpPszXelvPG1uL6mmfqF
         w3NoDtRZOK228Ku7NvlBEnJs2GSMPcP/l3VH6ieDoaNSgT+2iw859c18zi1yBerHsDkw
         xE/A==
X-Gm-Message-State: AOAM533CuGsZHp8kNz7dE9HoMiIGW02Jf8GrAf9lEM36QQPoCxG6AxQy
        FlvOvWLMsHC68BT+0Oc5RtI=
X-Google-Smtp-Source: ABdhPJxjaWyE5/Gb2mNlQCzDShZJ2mCUN/2tVx5a6+9AbIH+xrje4wbBiwivdj4mCq3lCs6Tvu5OTw==
X-Received: by 2002:a62:1692:: with SMTP id 140mr3664223pfw.168.1591807753421;
        Wed, 10 Jun 2020 09:49:13 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t201sm430222pfc.104.2020.06.10.09.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 09:49:12 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] bmips: add BCM63xx power domain controller
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        hauke@hauke-m.de, zajec5@gmail.com, tsbogend@alpha.franken.de,
        robh+dt@kernel.org, f.fainelli@gmail.com, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200609105244.4014823-1-noltari@gmail.com>
 <20200610163301.461160-1-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a1c00227-275d-60e6-07e5-924b053aef27@gmail.com>
Date:   Wed, 10 Jun 2020 09:49:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610163301.461160-1-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/2020 9:32 AM, Álvaro Fernández Rojas wrote:
> BCM6318, BCM6328, BCM6362 and BCM63268 SoCs have a power domain controller
> to enable/disable certain components in order to save power.
> 
> v2: Introduce changes suggested by Florian:
>   - Add separate YAML file for dt-bindings.
>   - Add bcm63xx folder in drivers/soc/bcm.
>   - Update MAINTAINERS.
>   - Add dt-bindings header files.
>   - Also add BCM63268 support.

Thomas, since I typically send pull requests to soc@kernel.org for
drivers/soc/bcm/, do you want me to take the full series and updatse to
drivers/soc/bcm/bcm63xx/ in the future as well?
-- 
Florian
