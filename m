Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC803C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38CD20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfWd/9Bz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgCERwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:52:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37455 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgCERwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:52:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id 6so2688568wre.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KKlI4DeAEp5pv8YazXy5gr7JP+Ho6TalAmxr1k++h2E=;
        b=QfWd/9BzJII9/qo5WnkdjRKuOWQo15xjx9Cqq5bHumjZCc8tXKXrxnbdP/Mvwshj9X
         j2Y1q+PmDE8gZ4plzBTs2gcVJCoeTh/9fQwKEQwdsoJAeV8rIhwrK9vTtzEOXcO5GJxZ
         GaEXvryNPxht9wY5urXLqQXuDpm+wq/phxvBx16hoa2ecUV5su9z77VPWup34bFwIXye
         JpX+SVpkvYOa9gbj7gRodAnkh3f5lGri9u7jh1aEYwy5KleU3Qbv1ZCEQepk52xeU2tW
         k2n4ihyJqMR+ggmUEBPHIy/DcchZqGrwte+jtwg7/Fci3+Y+TnQNMO1KSVIDjHpuFyTE
         Zl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KKlI4DeAEp5pv8YazXy5gr7JP+Ho6TalAmxr1k++h2E=;
        b=Q+o5svZlr6szMHI/IQ0iDwnaSOKzwxfZCbzTgOF9p34uzAeMWpLpRDNU5ABusTJvV4
         iGkEfFtBFyYlsTWzY2M4HiZpA0zMChOzBD1Jgp7st7KincFPuJ+XBi4x1NZrGT18/PzK
         iW1r9SqhCXuTCvXhVAHrLkLkzjP3Rht+0e0Q1dh+iDOt/dgpsv5umkYjFsgHKJwHKY1T
         IaxeFrQ7y7k3SuXTGLCmbZmoM38AIKVrNFlyUfmU14xkJiQcm9Lj8oQE7BkmjAtE7L1k
         VrJG32255zI6BsfLwuVVc6jqLK3jDHqpcwL89j/3D4JJ5G4v7TADXBTcm33KIChyHDlT
         vJ8w==
X-Gm-Message-State: ANhLgQ338NfjIXMokKh3UYUNcvjUQYo5oxlT+tdkddjwfbg9vbsgdy4b
        ec95ZP1cipOBg4Nroi7utN/Jhw==
X-Google-Smtp-Source: ADFU+vsjY7vSv7aQngTiJFUNNqCNlMiQG1Q/oGLAEFjA2gwTj2/IFGvwnyfmLQ5qXYfEeijYNbA50Q==
X-Received: by 2002:adf:9cd2:: with SMTP id h18mr63430wre.339.1583430764059;
        Thu, 05 Mar 2020 09:52:44 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id j15sm5716878wrp.85.2020.03.05.09.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 09:52:42 -0800 (PST)
Subject: Re: [PATCH] nvmem: imx-ocotp: Drop unnecessary initializations
To:     Anson Huang <Anson.Huang@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <1582694533-18870-1-git-send-email-Anson.Huang@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1e43bdb2-c9e4-2fbd-0f4d-0ab2e94403c8@linaro.org>
Date:   Thu, 5 Mar 2020 17:52:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1582694533-18870-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/02/2020 05:22, Anson Huang wrote:
> Drop unnecessary initialization of variable 'clk_rate' and 'timing'.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied thanks,
--srini
