Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F79BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205022068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bH52eZn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgFOJzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgFOJzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:55:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067B7C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:55:32 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id mb16so16748747ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F2y9Crm4EpXrgojd+CYn/r/xzpbyjoctnZnKUBxxPGw=;
        b=bH52eZn08gxvWDKX63J+WIukX0j2P3n7HyPqonmets/vbXsOXhi81yedn4gWFeKKgc
         Nd97MdUX3wiXsdSQY3wQdUIPnAluBFWXhcBZ8BAQwlpAWUjchBVrXbGAlWp20KVUVUXY
         R/uBSQemQsvtwxH9SOV1pTp2yySw61Y07GninWtBfjDu5VIqdDzmfqe2jAhgIzT2Bz1B
         NRLp3I+nPXlIzSfhf1A1+gXtK0CLD4Q5Z4U/oY6RpQ2lyQkkt0yCU7eU1FiFl5kwZpMC
         zfXaocuA8lqIJ+rdIQpyAevnwQQC3rmI1YX9RyC/i/QgJ/IyrqlSl9gZkH4Fx+RfDPXN
         begA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F2y9Crm4EpXrgojd+CYn/r/xzpbyjoctnZnKUBxxPGw=;
        b=S8hGE/Xx2J5hrrIE1BKuT74B0Dnqe8x04UZOtsJhg2wyZGpZLi6mVOIiMakw+Mi1IX
         HqfqUcn13QAVWn8yeGgoNYtg1byi7hpqoJ4oW9U3SYtEzBFuBLV2SHCEMI40SeuRteht
         xxmFTYfXv4PaTK8utVVHwJK2+B0zx2pkgiXszJs731S/XMoKLrqgICTiE3ysX3EMmqxb
         5jiz97lr/AoTOqwPWQecQGCtZYnSmCSpZXi8eBsEB6Ay/xCyMuwhYDmLELzl7+OcO17r
         KoC2JRiFzYXiiLP9KpJmp38S+5p2mG7qCtR23f/13g4hkb0tBmgjPa5y/DifAnjGLgO+
         1rlg==
X-Gm-Message-State: AOAM530O10ns2ZoU8M+IwpqjL+v3HdQTcbsREm/F2RrqRCvfgIiVNuac
        dN2O6K/yA4La+P4KjGeT03xwF0UWvgutFw==
X-Google-Smtp-Source: ABdhPJz6cNXf6sv5+78+bDzU/EfsCLMtxsclb4N1u2KcEBfpSY9J/kaEdBCn6renQCfjvKPO06pKAA==
X-Received: by 2002:a17:906:d78a:: with SMTP id pj10mr25691244ejb.50.1592214931572;
        Mon, 15 Jun 2020 02:55:31 -0700 (PDT)
Received: from [192.168.1.3] (212-5-158-38.ip.btc-net.bg. [212.5.158.38])
        by smtp.googlemail.com with ESMTPSA id lx26sm8665063ejb.112.2020.06.15.02.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 02:55:30 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] venus: Make debug infrastructure more flexible
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20200613223919.7038-1-stanimir.varbanov@linaro.org>
 <20200613223919.7038-3-stanimir.varbanov@linaro.org>
 <20200614063710.GB2611869@kroah.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <c54a12a2-7f92-105c-a01c-8e85730f36bb@linaro.org>
Date:   Mon, 15 Jun 2020 12:55:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200614063710.GB2611869@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 6/14/20 9:37 AM, Greg KH wrote:
> On Sun, Jun 14, 2020 at 01:39:18AM +0300, Stanimir Varbanov wrote:
>>  	if (slot == -1) {
>> -		dev_dbg(inst->core->dev, "%s: no free slot\n", __func__);
>> +		VDBGH("no free slot for timestamp\n");
> 
> Again, no, you just lost a lot of valuable information by changing to a
> different format (like driver, specific device, etc.).  Please don't do
> this, it just makes the information less than before.

OK, one of the reasons to use pr_debug inside VDBGH macro is to avoid
having struct device *dev variable in every function with dev_dbg even
when the function doesn't use it.

Are you fine with s/pr_debug/dev_dbg in VDBGX macros?

-- 
regards,
Stan
