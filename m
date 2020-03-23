Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393A1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D0E2073C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584992705;
	bh=zCAtNtjRoPXx6JmeMN5UgZhqCNa1x6VPSrcDikr0X04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WBcmOC631A8+qv3VayiOANUNoBbGmMp4erX67D0VQ0AbBgDx93KZgq+JJsFc9hl66
	 fYt0TqxmBMvmK+a1IgmKrLFxTrddkXJTHvg4RvijehwzaDiCoAhtuZnDTEaZSbJOg9
	 lLJN2zb7kv3pnelqvmxMlqjTMU0kD8vTVreI2dR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgCWTpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:45:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35579 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgCWTpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:45:03 -0400
Received: by mail-io1-f67.google.com with SMTP id h8so15672195iob.2;
        Mon, 23 Mar 2020 12:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r9i5Yy99e3CgW0P8gaLcjQIhjCX66478/XRcWS3+S84=;
        b=d8m11+ivbJP5xi/pGCJvyTYah7/QMhlokBbsrsVn5XLekaBYcOHSTkyBHc1LZU0lFk
         5Ad6hmEu6Uy1ic+rDSh4JrS1Kck2a965Vaa8XsFb8g3ck8VWuqX1612W65I3O8tLtG3D
         JdouCNEBZfYZUxs+5qx7nUZiqeVKBzNdvB+s/Zo7uQreqzYoHXNcmTZpmS0htLXtjAF0
         +JkiCkWjAtc3kSMk3neKonlai4dMRi6j31E8FeXvycllfzdc2neoig62R45Simioz7B2
         ZKvqugvbC64GtbJJ1L1APJqgxyTHpvzyU5tgYYLAb1On/Df1GUB11CULc7L3U+3Haf/r
         1VZg==
X-Gm-Message-State: ANhLgQ2GKx6fqqj7eZKyZSV8VZ2TJ+TdYr6nZ2yr6mN0mVocN711Wdet
        1s/PAJ2YcuAHZ85Ml/r79A==
X-Google-Smtp-Source: ADFU+vsAzTXBZGUBrZAQ1lAg1LZa7C8Eb/zL/ybcePG+EQHsuJFpa2ORV2x7aE10Xrh+Imf8iDK5Eg==
X-Received: by 2002:a05:6602:cf:: with SMTP id z15mr20497163ioe.13.1584992701381;
        Mon, 23 Mar 2020 12:45:01 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o23sm5554448ild.33.2020.03.23.12.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:45:00 -0700 (PDT)
Received: (nullmailer pid 21498 invoked by uid 1000);
        Mon, 23 Mar 2020 19:44:59 -0000
Date:   Mon, 23 Mar 2020 13:44:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/6] dt-bindings: sound: Convert jz4740-i2s doc to YAML
Message-ID: <20200323194459.GA21444@bogus>
References: <20200306222931.39664-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306222931.39664-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Mar 2020 23:29:26 +0100, Paul Cercueil wrote:
> Convert the textual binding documentation for the AIC (AC97/I2S
> Controller) of Ingenic SoCs to a YAML schema, and add the new compatible
> strings in the process.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/sound/ingenic,aic.yaml           | 92 +++++++++++++++++++
>  .../bindings/sound/ingenic,jz4740-i2s.txt     | 23 -----
>  2 files changed, 92 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/ingenic,aic.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
