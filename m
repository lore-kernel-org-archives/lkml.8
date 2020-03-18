Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1CDC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B9E20754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bX1vaYCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgCRTN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:13:59 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:43273 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRTN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:13:58 -0400
Received: by mail-io1-f50.google.com with SMTP id n21so26097829ioo.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tSJww9Z+wt5Z9Xn77VWgqIlhOoz7PLwBH1L5SgYZ3LM=;
        b=bX1vaYCPPB+3hM5IVwpSxpiwzeFNin8sOnyWNNukPjTxaOJVKUXxyjAgiDzEyfVe+h
         1BDTrfV3KvpphPOsLLKjxbnoiyuCk9Of+znC0Ud79tixSrxJ8LEPC3K0TfOgAXH5o/Se
         aW4TbGghUl/qsP5mLo+Ef6Kyl0dJuFpSCoYzpaxHYAHAvDkLKLwPOKRgZ2/u2vDsHo30
         MV45Egr04OdgQXHRvUYEPgE8uAuwD6+5nbURK6tqZ+0Oy5be6np4K7sRFk8Vpr8jHo0+
         MSLXOqKHxOV1cfAYNaxIumOb0w4d1wovXdnVrlH+1aciO1ZhkBB9gqMTJoG0lvQtnC5N
         QLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tSJww9Z+wt5Z9Xn77VWgqIlhOoz7PLwBH1L5SgYZ3LM=;
        b=fkb6Y4Ww2xaLa/cHUes4+ycnpK63tzKku04GTRpmI8ugBtgUsSSpWuWD5kNfCTZXgH
         47PfQ74CQmQpa5JCzcmWLfSnhq4+9hqJ/EziLsGN8ZE9CiUxGn3cjueeck0i6m/1dYay
         7ZOmQr1yON8pAiS9AO/VKVHn18DPn5BBVs1yezWcYOm0n8q5BpqJYANGsAvJqC9WHjWf
         y8mXyUstCwlA8J3AxFE0CL3L8cuoroaFKBjuDqJZzec67KDdME3NtSBhb2TzdnD5QNaf
         Ra22z8kvIMk+CE0dh2mEwk6CkYI6PjGi3DHNPZsgYWMDn1euEOFY5oz3DVb5205bURYW
         QU1A==
X-Gm-Message-State: ANhLgQ0j0U2zDjSrM6HPB6xVxhCVxuzvOffXN6bGzwtORLrRyjPN833D
        7d0fXZt3KFIppdMSauXgdkFMdw==
X-Google-Smtp-Source: ADFU+vvxmOapBlydA+ixonR+vNYzcQ/Pqk4YMTaIcjCPOcsTiWrhK/t3R9pQW2Mpy4FH2QS+sTGdbQ==
X-Received: by 2002:a5d:894a:: with SMTP id b10mr2381488iot.38.1584558837246;
        Wed, 18 Mar 2020 12:13:57 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id u3sm2341022iob.45.2020.03.18.12.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 12:13:56 -0700 (PDT)
Date:   Wed, 18 Mar 2020 13:13:53 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Curtis Malainey <cujomalainey@google.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
Message-ID: <20200318191353.GA13459@google.com>
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
 <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <d974b46b-2899-03c2-0e98-88237f23f1e2@linux.intel.com>
 <20200318171912.GA6203@light.dominikbrodowski.net>
 <CAOReqxjmUCGX18y_XW_sjcU2xWha_+wJ7L+SuzJ5ZrOddCfZkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOReqxjmUCGX18y_XW_sjcU2xWha_+wJ7L+SuzJ5ZrOddCfZkw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 10:25:32AM -0700, Curtis Malainey wrote:
> +Ross Zwisler <zwisler@google.com>
> Do we have any BDW boards that use the rt286 codec? I can't recall any.
> Also I never saw this issue, did you?

No, I'm not aware of any Chrome OS BDW boards that use rt286.
Samus uses rt5677.

I haven't seen this issue, no.
