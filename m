Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9674C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD1520706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="StFcRwnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbgFWJal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731968AbgFWJaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:30:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D464C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:30:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so2434610wrj.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zCYJZQq+CWt0N3SNOyAvomBhVl1r23I6hjnPk6TfqcI=;
        b=StFcRwnfxTDVe2OMLh4oFlZU6N7/jmflMCCZ7Z2elI68BKwbOEtpri5IjM7pmx6QQ2
         dDxHDz4Q1QAVJO2/4NkcoJ8x6notwatJGnLohf//hTRh282Cblz5ShG0aLJadFXXthGE
         vORSjoaeZL/i0HbFt7WZUAjtpfyaGEjj+biu6nX7kED9CY5ieMlR+wK3SL+cmwYO+sI7
         NxuxCjm+QLZUuc9uuyYtvNnig7PjnpgoI8LNR3AjTGJmRmXa7slS54BPp0ZvbxYN5bjW
         NUwLRNX5hn+TBIH1EBtVZZ4fe3pnC1V1u6NRmnbb/0o7Lt38EoYxmHHA5II+BuzJnoOH
         DpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zCYJZQq+CWt0N3SNOyAvomBhVl1r23I6hjnPk6TfqcI=;
        b=Zoer1MWG0ynCRkXvwvisV31vsKibTbjBN6LXSsdKzQx2BOSdVjH8CD+1KvyKTC2/Nz
         h9F1KW7kEThHzws5H3Xy6wDg12656i+n7u8zF+Fgl55dpBMbmixWKM7M10vr6KWKSx5C
         Cb2BkFtwdoYMguB4kJ9VC4BJi3x5H+L4Uq9bkT9kngId9cGQLqsOrMZ5w1uu7s2GiwtO
         BS9MgOaK9JmJnbCk3MEua+iWSFRgINRhAp+Mm4uiosz7Q/fCmEQvZY79gnQNoXmPWJJm
         9MqHFDzQYhhj2fkja7nBznHCdsqUKvPVy/FaNY4i9EMCA5R4yR4bLxeU6cm8wMqtNkH7
         zCVw==
X-Gm-Message-State: AOAM533bbIqHiRJQe5YoqQ+vOo05VpWtPkHoNQOVIr5uUpcWZ4sE1gbz
        hd1wWviC+AZSHCVybLstPM27BA==
X-Google-Smtp-Source: ABdhPJzT+WEXkkCpW4j53nR5LZ7TeN8tRk0lj6OZ3N/8AVIv0jZWcZNE7KQgRmxiWdwP5SaJuHgTQg==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr24118666wrs.393.1592904638331;
        Tue, 23 Jun 2020 02:30:38 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id l190sm2984706wml.12.2020.06.23.02.30.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2020 02:30:37 -0700 (PDT)
Subject: Re: [PATCH v2 28/29] nvmem: core: Add nvmem_cell_read_u8()
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>,
        =?UTF-8?B?U3RhbmxleSBDaGFuZyBb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>
References: <20200623025106.31273-1-afaerber@suse.de>
 <20200623025106.31273-29-afaerber@suse.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b6c457fd-c72d-5605-dc29-bc20497a71ed@linaro.org>
Date:   Tue, 23 Jun 2020 10:30:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200623025106.31273-29-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/06/2020 03:51, Andreas Färber wrote:
> Complement the u16, u32 and u64 helpers with a u8 variant to ease
> accessing byte-sized values.
> 
> This helper will be useful for Realtek Digital Home Center platforms,
> which store some byte and sub-byte sized values in non-volatile memory.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>


Applied thanks,

--srini
