Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E1FC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B18F20691
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qFFoTnbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgFKLvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgFKLvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:51:04 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE61C08C5C5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:51:04 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l27so6181817ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=51Iu4YKAvEvBHNrMig+Xr6RS9Pbk+kC3A3u+T12TUuo=;
        b=qFFoTnbUyo38S/OO09J/80JmT9pUjWU+TUwZcoE+JDdsXbxCW1m+eaRCUou311sxgB
         Nc/DhUsoPgG1KlJzB+T2Dw/tWwA2sQi6DfvATQmypOisiBQuz60hUAkE5vao4LPR7vHY
         yF/ffR3bc0AqCX+U061aT62bF3SzQf/nKNfVAHANzZ4U/qcMT/kAiE7wtp7txOLoTqzR
         8vM+BrZDxSIPB8H8amN/fzUMSDuYu/d+bYXRrzD0htsYh+XYt0Hl6SZhbpl66DNBUKV5
         GGw0SVirZ6jgw6UXEs/LL5r5Kz8gk1JyB2kU2/dC87fraggSZixXj1F6FaVM/CBphZ0r
         VejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=51Iu4YKAvEvBHNrMig+Xr6RS9Pbk+kC3A3u+T12TUuo=;
        b=EBrGl3aOsMSYPRybb3jc7ftv8wdL0dLrfDxf3HGFNmpa7sxMWd29iDIU6Y8DyAWIhJ
         yQLAEAA4jEb7PWv20DG2IuZquwS5J+F4sQwgRBPbWq1QZL8oWUEmp9xi0k4+6nanYyEG
         3ipsdk6CNTgQB68Kv5r3DK29GBOjFmPqxN8RBz05cKF6m4MI1QZSlE8Kb8+UphY25oX6
         xKMmtWqvmfX+RZxjgt8yEb9EyDY6l60c7v+Og9aFDkXyrLdqvXWoV8KATyEOj51yg/mX
         rVuEVK8pQwTc2ftX0EUlczl2exGBhpRkO1Qg4B9+2CBpIdjDoTTlVhLRWNmAjn1om5hY
         l7tA==
X-Gm-Message-State: AOAM532WRWQaZ5wJuq4QQTq0EQrnXxL0oTsscuzDt3PketFwoKVVFN2l
        0B8jW9QrlNdXVb7XkGZ97qrvbw==
X-Google-Smtp-Source: ABdhPJxTpgK7hHHRUHAbOlbJ7reLLhEo/eG4qvHZljQK6e9jLna7/TLVs8JzLajA7B/JTN6pb8LUhg==
X-Received: by 2002:a17:906:b7cd:: with SMTP id fy13mr7737497ejb.443.1591876262967;
        Thu, 11 Jun 2020 04:51:02 -0700 (PDT)
Received: from [192.168.1.5] (212-5-158-114.ip.btc-net.bg. [212.5.158.114])
        by smtp.googlemail.com with ESMTPSA id j10sm1417528edf.97.2020.06.11.04.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 04:51:02 -0700 (PDT)
Subject: Re: [PATCH v3 5/7] venus: Add debugfs interface to set firmware log
 level
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
        Jason Baron <jbaron@akamai.com>
References: <20200609104604.1594-1-stanimir.varbanov@linaro.org>
 <20200609104604.1594-6-stanimir.varbanov@linaro.org>
 <20200609111224.GA780233@kroah.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <32eeb0ce-49fd-34ed-d5c8-0406ea174525@linaro.org>
Date:   Thu, 11 Jun 2020 14:51:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609111224.GA780233@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for the comments!

On 6/9/20 2:12 PM, Greg Kroah-Hartman wrote:
> On Tue, Jun 09, 2020 at 01:46:02PM +0300, Stanimir Varbanov wrote:
>> +int venus_dbgfs_init(struct venus_core *core)
>> +{
>> +	core->root = debugfs_create_dir("venus", NULL);
>> +	if (IS_ERR(core->root))
>> +		return IS_ERR(core->root);
> 
> You really do not care, and obviously did not test this on a system with
> CONFIG_DEBUG_FS disabled :)

Probably not :(

> 
> Just make the call to debugfs, and move on, feed it into other debugfs
> calls, all is good.
> 
> This function should just return 'void', no need to care about this at
> all.
> 
>> +	ret = venus_sys_set_debug(hdev, venus_fw_debug);
>> +	if (ret)
>> +		dev_warn(dev, "setting fw debug msg ON failed (%d)\n", ret);
> 
> Why do you care about this "error"?

I don't care so much, that's why it is dev_warn. But if I enable debug
messages from the firmware and I don't see them this warn will give me
an idea why.


-- 
regards,
Stan
