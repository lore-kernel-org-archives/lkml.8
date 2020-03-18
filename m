Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40244C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1395C2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L28rlUPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCRP5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:57:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35056 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgCRP5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:57:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so10480197wru.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WKs9IgnQjzOcey+yQmdz8NYqXjD7ApUhbxNTTHxXd2g=;
        b=L28rlUPx3+TpmA+orVyq6GD2PU1T/wM4SozCe9wCtz2g1xoXdbyk4OJJ+6J1n781Eb
         dr2y4h2+RXwrwe6flAUJt9VItB9pqnMYLBtpW3S7b/LguF+ylK3rEAZkIO+VNbiHxaXx
         1sYHVX/U4w2gtxkDKU99iDO6NBLnx+qr6Z/ZrAOBEpnjjDui5+Hm8OcvZvzLDOEi0FQF
         KuodKzde6MH+iNwZtXU6ClTVw6vsdU9SUW4fHe7cHCm+iKhYRS44N7QeevaWsTGz3mEc
         +leQoJ3D+tP+fe5kn0kS2re2nZ92mlwO8xXUaOcUcNNhsYRW7iS+W8K0ZgZ8CwwtbPiz
         rr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WKs9IgnQjzOcey+yQmdz8NYqXjD7ApUhbxNTTHxXd2g=;
        b=ZpXcuAt9NqdHnOwdykgEXG80NMeJTWXghHZ78DnelWkNDayK47b9K/qz5yimLAIPSs
         5W+zgjX8WGsh09Mk9SjbjIjcCr11Zh9E3NwRiiYRP+/VBQtDHp5TeR7wjVURyEbK4IuJ
         PQ6IQwiC2zEkKiSte5Zusw79kxpPCwab1nprOh6yKUTQ0s0XmXuF7rw+f/QcGqX5isqd
         jx4nW7qXlNcOjA6ACtDOZwN8axsYMUgODPjQrMaLBOB/wBurvwPv6Ph8Wf/SnD3+vX9T
         JqTpkT1xWM99ko2lkqqMTDS1Dik+2weKQ1UXV8sHyuBtlYKI6LjNfk02I3Iot5wlQ4Sw
         rlpA==
X-Gm-Message-State: ANhLgQ3o1ZSer0RdPotBAwUGHXow3p6chaWWJLxvPz3GtAQFjfF5+eTv
        MU6/OGLoMGWkb5TaTDUMgYCGuw==
X-Google-Smtp-Source: ADFU+vuoc90UFHCUoDzgGQkfj86K1CIpUWNNiBDamxA0TmJ2Xr8zId8gD3etAN/dAO1s4yZb9viTXA==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr5981930wrs.4.1584547060995;
        Wed, 18 Mar 2020 08:57:40 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id f9sm10057253wro.47.2020.03.18.08.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 08:57:39 -0700 (PDT)
Subject: Re: [PATCH 1/2] ASoC: qcom: sdm845: handle soundwire stream
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, vkoul@kernel.org
References: <20200317095351.15582-1-srinivas.kandagatla@linaro.org>
 <20200317095351.15582-2-srinivas.kandagatla@linaro.org>
 <8daeeb26-851b-8311-30f5-5d285ccbc255@linux.intel.com>
 <69c72f5a-e72e-b7b3-90cb-a7354dcb175d@linaro.org>
 <cbc6cc9b-24f5-8c2a-b60d-b5dab08c128e@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <fcf845bd-9803-ab04-d2a9-c258ddfcc972@linaro.org>
Date:   Wed, 18 Mar 2020 15:57:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cbc6cc9b-24f5-8c2a-b60d-b5dab08c128e@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/03/2020 15:26, Pierre-Louis Bossart wrote:
> 
> Same comment, how does the notion of cpu_dai come in the picture for a 
> SoundWire dailink?
> Would you mind listing what the components of the dailinks are?

dais that I was referring here are all codec dais from backend-dai.

Device tree entries from
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/sdm845-db845c.dts?h=next-20200318#n538


Frontend-dai:
	mm1-dai-link {
		link-name = "MultiMedia1";
		cpu {
			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
		};
	};

Backend-dai:
	slim-dai-link {
		link-name = "SLIM Playback";
		cpu {
			sound-dai = <&q6afedai SLIMBUS_0_RX>;
		};

		platform {
			sound-dai = <&q6routing>;
		};

		codec {
			sound-dai =  <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
		};
	};


--srini
