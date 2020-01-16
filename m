Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6D7C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B5D20728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="liY6Cfcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAPQMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:12:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34780 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAPQMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:12:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so19759054wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 08:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7fZAqN5KEgVxTr2KkYgc9fx+mk0Wbd58jdx1uS30Xdw=;
        b=liY6CfcsfJL0P+wQagP5QniA+PPHRFMuMlCgyhDtqDYGxfkCvZCkcOqg1n36N5Wgrr
         ZSh8yY85zSzJbZ5PUL4sTo16zuHvJT8AqY/sS94KwmCCyio9gjEOiTcmOFKcBevZFben
         pMWo9YynKHp2sFp6EyCt69voSUiHc29y8mIkpGkfj9BatYM7lOSA6SMVKgmRALhztOF6
         8qzjmVMYX9ieCTJd9tQDf3V1Qdp1mFf/JDMyyFZIhVZnbuo0f1QMet24SQd+UuyXEubd
         Ro5+0fBhApwCgtjYfvmAN5oJ27q4knEOmc95dyTlP5eXvF6RXcBfsL3yWhyyJiDVDazr
         hwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7fZAqN5KEgVxTr2KkYgc9fx+mk0Wbd58jdx1uS30Xdw=;
        b=BroEXWbBeWw+85FbkSCCKSkdwtw7YlBFIAq86HfndXbS/FEHee63KBxH7IYYAfJ2CZ
         aO8xkkSyWbAQxlzo8NtM7mWUH4keDp25eBmG50+hcXYYSoB6hHSR9p1EgB4C/nUFgxPk
         ERcKO8/K7Ro4avZh8IiFsFIhiDaqYxjDWUHF/6a0LqpVQR+q8AqpvluOeTb7NRNT+0d0
         fJODSiVu8FoU7JrMvo2aK9kyeH8qJ5JBqRk+uoJfd8AhIHJEeEfc93POJKiTONsdbR5K
         UGp//KcjL4elMqcOYYyDgKLDUlcS7IddLP3NTkNTfQzwa3TNkcbo8L2I1tUuw9DG0xv3
         zA+w==
X-Gm-Message-State: APjAAAVthhiOPBhzctA0RR+jSV2HHY4+ZzNufCd/vnRjbiomm5ZDs4Bh
        8VD9T4TdpVj52wLwPWnRunU3et9/Tno=
X-Google-Smtp-Source: APXvYqxFXSVeTd6MII7M/k64oozzeRVBxDES1fjiCAVexMJ+HosvhmzTmZcaJg0TeW4ijQ3Shn1kPg==
X-Received: by 2002:adf:e3c7:: with SMTP id k7mr4333353wrm.80.1579191167260;
        Thu, 16 Jan 2020 08:12:47 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id s19sm5244564wmj.33.2020.01.16.08.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:12:46 -0800 (PST)
Subject: Re: [PATCH v5] dt-bindings: nvmem: add binding for QTI SPMI SDAM
To:     Shyam Kumar Thella <sthella@codeaurora.org>, agross@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1578985692-20309-1-git-send-email-sthella@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <74686c1a-6e23-7658-5d81-c1641556e4b9@linaro.org>
Date:   Thu, 16 Jan 2020 16:12:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1578985692-20309-1-git-send-email-sthella@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/01/2020 07:08, Shyam Kumar Thella wrote:
> QTI SDAM allows PMIC peripherals to access the shared memory that is
> available on QTI PMICs. Add documentation for it.
> 
> Signed-off-by: Shyam Kumar Thella <sthella@codeaurora.org>

Applied Thanks,

--srini
