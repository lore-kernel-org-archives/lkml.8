Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71303C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF5A20734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591126888;
	bh=+ncjK4e/vZsz73FIDj/hi61RsM4Ps1F1/O0723aUlLU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=HHHLn6vqQO2V62lU8RhOOwmt1iypxqkcp+74K5/YxXdZzuIv+aRyIS42AQiFWWfT8
	 JMr2rVPvixbCf6SN7McGeyn5GPPUZzjaGkAL6j3wwhuQ1BVTh1YG5wbVhtKhZnBWC/
	 XMZ780s4q4DT4sUWZ4nZtKcr61X12b1UxZm3otuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgFBTl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgFBTl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:41:26 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72600C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:41:26 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id d67so8086458oig.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dxHzvSblnkcYW/wmcNUppzoyDk3DR31hUrJu+JXhQLU=;
        b=F0jV6T5QCA+YNsQ3LVDb7Lhr7qtUYZ1w1DRaaWfX7iZwINO63+RGeKTe37zJTuzSyJ
         BLWv+LXkPOf1uxy+byvaFBimaXmUmdiWF0GEHglgAIF6MgZbNHnUEpyz1s8GwQ2u7juy
         /Wv8a/kVxDHaVoy8WM/OensLNkYsfmYPibmCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dxHzvSblnkcYW/wmcNUppzoyDk3DR31hUrJu+JXhQLU=;
        b=QDs99QZGtDakClc8K8G5uhCaSvJGEMbCftXIRkM0YJ5GKcdqOVFVsK6mTlTFstzNZQ
         jThcOMKrAsfl+Kp9yrv/6dl6GVUS2jTcKUB/RkbW2s646aArCGU9cq6xCUjoNTzie4IC
         0UKNaf9fT7JpWz288Z4+/EU1tjz9VrBWyfyVWkeL4s2B8VGwN2ysB1WnIpAjHZb0XTZy
         C3axmWBobNOejAa2bD8f5cRCVVEdRZE/6ia2F2vCDeDmXzjwfzum6SQkzq7RFyxDUWWX
         cm8yVAUprHZhouH8FbwU0mjbJqudYaDxbEN2Xg5n6HSHbrqY35fMyfQozxpGgjZCbE65
         YYpQ==
X-Gm-Message-State: AOAM531kefTpkgRSVM95Yem5DvvjoHdkZfwVlkpoHUWmArbFp0cU2niR
        pTsSCgPvm5dedVb9zeVBcn+few==
X-Google-Smtp-Source: ABdhPJwoiUfhmrhw3gvKvLm0/TnJeYPXJ2a6WEYTX85rqgL8nQDXSlQ9L0nFByJnJ/KgagaHyQmsmA==
X-Received: by 2002:aca:c704:: with SMTP id x4mr3919833oif.92.1591126885918;
        Tue, 02 Jun 2020 12:41:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 10sm848509otq.52.2020.06.02.12.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 12:41:25 -0700 (PDT)
Subject: Re: [PATCH] kunit: Fix TabError, remove defconfig code and handle
 when there is no kunitconfig
To:     Vitor Massaru Iha <vitor@massaru.org>, kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200529192845.60468-1-vitor@massaru.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ce991545-b849-1afb-8e20-839ce7a38eb9@linuxfoundation.org>
Date:   Tue, 2 Jun 2020 13:41:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529192845.60468-1-vitor@massaru.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/20 1:28 PM, Vitor Massaru Iha wrote:
> The identation before this code (`if not os.path.exists(cli_args.build_dir):``)
> was with spaces instead of tabs after fixed up merge conflits,
> this commit revert spaces to tabs:
> 


Applied to linux-kselftest kunit branch for Linux 5.8-rc1

thanks,
-- Shuah
