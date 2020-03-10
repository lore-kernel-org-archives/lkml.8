Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D5FC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3759215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SXaaUnju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgCJPtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:49:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43690 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgCJPtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:49:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id v9so16497219wrf.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JLUdZSd1H1lEETpHvCclAtf9Hxyai7jGSGVa9mBHeW4=;
        b=SXaaUnjufFDt8Mlnfyn9/nZlPn4Sx6yJeTDI9xCvB0eIdKUVY7sYTWP+92HvG9vn6s
         hxMoVzkzmbTNU/nbfIVXiPxyh1TZJEgXBe18cH53Z8C5SRpBpd8VnYKB8hswLRpiAVbx
         siJujdMUqn6EeQV4dClu6RdiAVRMN0A8eMh88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JLUdZSd1H1lEETpHvCclAtf9Hxyai7jGSGVa9mBHeW4=;
        b=Sg8pFPifZzATx9T0r0xuRFytUwtkgQ1b5YxxU7FHNo4vg2Koylrrex+ZKsUNJY0Fpu
         nEaaVObidqWLa9dp5agkwHtyYKsYwTD/CF/MgkMmlkczIbzrjqwPJKl3h0PzbmVqNzv/
         OU5XMrz1IA77Wje2mdJNg/H2dVVGTkUVTNO8qHO2DFe3Qm3tEndB24devgCkoVVr1C+1
         2+zcUowXexJej9ALjdIjpBBddNk/8zbNu+znUCaUkAk68bW9/pZmV9COSjrbSl+pVBWp
         Cyxly5KXt2O3WHzabbDhXKbdCNmHf1MpGBAyFjR52dJLQyUeNCx6dcyBDDDKz3zRDSzW
         B0Tw==
X-Gm-Message-State: ANhLgQ1tneC1B6qPIwwPWRVULqi9ZTnsjNEsHt/YsNth+JMipAY8Ybhm
        cDzBu3DG773PxEfQjf3xiwLr407DXkhfuKaIhEjuYr2ERXONfcYvg8Iibs8U6kGX0xbTmd2Ieu4
        bgQ/HynaFMEbsgGeDVF92Vrjmtx+f8MeN9cLMJDS/LIh9PMiEl7bwo0utYOtRIuaLl2Uz9FtpvX
        cHVeCS5g+NvIQ=
X-Google-Smtp-Source: ADFU+vv3M5cRnol8JRj1p0ysE6tMfdFNrNvEtcwqdFl+xa2EzKzZTzLC9tOnI+8oafPBbV9yqs7dYg==
X-Received: by 2002:adf:f70f:: with SMTP id r15mr28468158wrp.269.1583855354940;
        Tue, 10 Mar 2020 08:49:14 -0700 (PDT)
Received: from [10.136.12.253] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b187sm1201195wmb.42.2020.03.10.08.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 08:49:14 -0700 (PDT)
Subject: Re: [PATCH] ASoC: brcm: Add DSL/PON SoC audio driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Jaroslav Kysela <perex@perex.cz>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stephen Boyd <swboyd@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200306222705.13309-1-kevin-ke.li@broadcom.com>
 <20200309123307.GE4101@sirena.org.uk>
 <69138568e9c18afa57d5edba6be9887b@mail.gmail.com>
 <20200309175205.GJ4101@sirena.org.uk>
 <8113837129a1b41aee674c68258cd37f@mail.gmail.com>
 <20200309191813.GA51173@sirena.org.uk>
From:   Kevin Li <kevin-ke.li@broadcom.com>
Message-ID: <1165b736-d0fc-1247-6f46-94a51d392532@broadcom.com>
Date:   Tue, 10 Mar 2020 08:49:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20200309191813.GA51173@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> This is not how any of this is supposed to work, it's unlikely to work
> well with other devices.  If the device supports both master and slave
> operation then you should let the machine driver pick if the SoC or the
> CODEC is master via set_fmt(), randomly varying this at runtime is not
> going to be helpful.

Maybe the name "master/slave" is confusing, these names come from internal
chip signals and do not represent the state of the i2s bus master. Our SoC
supports only master mode in the i2s bus. The Rx and Tx block each have an
independent bit to indicate if it is generating the clock for the i2s bus.
The i2s bus clocks need to be generated from either the Rx block or the Tx
block, but not both.

