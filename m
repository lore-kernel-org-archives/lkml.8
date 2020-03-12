Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23FFC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AB020691
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dq4SjmVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgCLJy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:54:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54562 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLJy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:54:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id n8so5333686wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 02:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gti9dtiZNXKPmQ12a2+yifX0C9HtE+cfekK36Alolzs=;
        b=dq4SjmVfRXEXLGf6KzFd107WHVwswuMrYi5FmbxhUGVv5eERMbFQBkASi7Llscm4FP
         xIsSZVR2rpyGH8AgzFUaZ0rNeF5+oGG3rSIP7vIqnLYGm5TiMdF/Ic3KVgGkq+zANr8X
         IgeYhDn24Xd2HbIuIvP2BtlOtYBQep43Gb3HPyA7zj7mOjSu9iwtQuFG60G7Ri6q78Qg
         GavDRFXM3IxuvEoHjQR6+PFONSFQQFPCiF0yaRne6Hup+Ep7X8O7ndAKob9oQlMcYzRh
         y2TsyebvoV2bh+1QB4sxbC/XQ8/Yj6g9zNm+OWto2Nu8T6Uf3d02SAlIqLylqtN6QYJr
         HDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gti9dtiZNXKPmQ12a2+yifX0C9HtE+cfekK36Alolzs=;
        b=TKvsFaOrTx+YhSDjEv64BVpUYebCkf7V2n9Pc7AUJXorKtL586YVEKAZUz8qt+g7OX
         FtjtJ8mkcBYdyFwUnXGnIH/prpzQHXJXJPPR/nfVpRt2O0EhrV5RD//rvHeqOrFQEbW3
         31FyDsbv3n1X/GhdRjEQMOvUX0prkOJbIE3sVv7csALN/Dx3UDBW1a2f2xgLDo0kyK4B
         7cQOuMWab0hqqIFtZ2ZgwTyKu1T+BshWbw1mL9MTCruSvuxRwl9pRymIzGv49s/zWDzW
         bEFLHOtAemhDCIvQwav5Z5dpzs3dBM1sTPMhBlxX9EXmEaI4Ey7BuddcxLB8FteGp1Sv
         XbrQ==
X-Gm-Message-State: ANhLgQ3iJPRvNemKmlPvKrNHW3mZnuO3IQQzgWCXXytxAVgJtmfIgyaD
        7VNbk7X/qMu+6Sgs6WheN5Y+Bd9NqQg=
X-Google-Smtp-Source: ADFU+vsMbysNTXcN2q4IMGtlnBj3yPlfcmijwA+eQf8BxyMDoFt8TILdrdv7jcTX52d/tu1Ks8hgdA==
X-Received: by 2002:a1c:9d41:: with SMTP id g62mr4148682wme.131.1584006895796;
        Thu, 12 Mar 2020 02:54:55 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h13sm16748590wrv.39.2020.03.12.02.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 02:54:54 -0700 (PDT)
Subject: Re: [PATCH 2/2] ASoC: wsa881x: mark read_only_wordlength flag
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20200311113545.23773-1-srinivas.kandagatla@linaro.org>
 <20200311113545.23773-3-srinivas.kandagatla@linaro.org>
 <2c56d592-719f-bd87-25cb-c5028bde729b@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ec587d04-274a-32dc-ed2d-cdb8fbdf788d@linaro.org>
Date:   Thu, 12 Mar 2020 09:54:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2c56d592-719f-bd87-25cb-c5028bde729b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/03/2020 18:58, Pierre-Louis Bossart wrote:
> 
> On 3/11/20 6:35 AM, Srinivas Kandagatla wrote:
>> WSA881x works in PDM mode so the wordlength is fixed, which also makes
>> the only field "WordLength" in DPN_BlockCtrl1 register a read-only.
>> Writing to this register will throw up errors with Qualcomm Controller.
> 
> it'd be good to clarify the nature of these errors, i.e.
> 
> a) is this the Slave device responding with a NAK?
> b) is this the Slave device responding with COMMAND_IGNORED, and those 
> responses not handled by the controller?
> c) something else?


With the current version of Qcom SoundWire controller driver, it can 
only know if the write succeeded or not based on completion interrupt. 
There are no details of the actual error code visible to the driver. But 
the new version of the same controller is expected to return better 
error codes.

thanks,
srini

> 
> Thanks!
