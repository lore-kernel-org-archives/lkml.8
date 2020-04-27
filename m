Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F72AC5519B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D4F206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y81pPHV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgD0G5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 02:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0G5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:57:46 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E426C061A41
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 23:57:45 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x2so4826787pfx.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 23:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=b9oxcazi1/+l/yb4NyRDEdRqX15ANK5/BAmDpBrnUi8=;
        b=Y81pPHV6TJ9EkXH9eV7DUPae3EaO63pB3FGsztZ6e1Cs9eXuL26oRw4FSc/t7wy387
         PeMqkJ8+MP+t/42gzbWvVaaB2Yt98ewM1robv81VUAL05jhYlGT3rJAagXrgGclpxRX1
         1Nb0bk8G/TZA20P2pIB4lZs9Our5z5324+2XcBvdhhHA+A/CGZq5TPKZom1XN7r0lmXL
         iWXZSA2jK85lED9cHLdbru5wH/vOdLLGQ7nOtIhUKTYF/3OWK9xa3ZqIB+T9Qyz6qttc
         M1m0koXjvxL4yOokthBuK4FgDNXti4IgZbR5gPa4xO0hXGZJRxyQW+GoPnIwqnvHndSE
         pECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=b9oxcazi1/+l/yb4NyRDEdRqX15ANK5/BAmDpBrnUi8=;
        b=H7xKLgtdLK/vSpCMH2dSokuLKVG83rzRSznntnMsD//xP3GTJXhjw7mCqugtjpStjh
         jUq467F/DUgJikN75//QNjmsKDUqZsYyrQWiTs74tBK1adbuhHzo1gmE/58P/x4cPJo9
         2NKNG8PKkcQkJytwNxaZaY9D3y5yclb8eFxzoi19JiyycWAwDzUXPH1Fuf+Hd4zlX8ih
         0Li3UQdFtZeFESTgbSVm1TwLb8l5yoNW4UktWW/9Nr8hXuWcCOx2K6smU4OyNYNnkmPq
         uPdf+C/n+lJGkvWnI2Rg+hMAQLwRSK6my2tObqM1avkJVwAOmZZ1V8v/30nkflEl0Rci
         CPPg==
X-Gm-Message-State: AGi0PubvMmfCwnV7jr0LYo2shTjzcmYyfgg1jAzgsFFYq/0HIcPYQ/Bd
        pCZBImHSUeq0AVRCp7BQXgDd
X-Google-Smtp-Source: APiQypK24+KNrgHgySmdTtSUONrB9B6ttKM1cQgEsHUTa4gUhqc//sqXF0yTaJNY+mlpdHFzZQghNQ==
X-Received: by 2002:a63:214a:: with SMTP id s10mr20340551pgm.98.1587970664594;
        Sun, 26 Apr 2020 23:57:44 -0700 (PDT)
Received: from ?IPv6:2409:4072:608f:8328:cdd7:29cc:291b:9aa4? ([2409:4072:608f:8328:cdd7:29cc:291b:9aa4])
        by smtp.gmail.com with ESMTPSA id h5sm10438546pjv.4.2020.04.26.23.57.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Apr 2020 23:57:44 -0700 (PDT)
Date:   Mon, 27 Apr 2020 12:27:37 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <6affe7d6-4aa1-cd72-74bf-69d8f6c3c98a@web.de>
References: <85591553-f1f2-a7c9-9c5a-58f74ebeaf38@web.de> <20200427054023.GA3311@Mani-XPS-13-9360> <6affe7d6-4aa1-cd72-74bf-69d8f6c3c98a@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [v2 2/3] net: qrtr: Add MHI transport layer
To:     Markus Elfring <Markus.Elfring@web.de>,
        Chris Lew <clew@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
CC:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Message-ID: <11CCC96F-FF72-464F-AC29-8E7D53C6F31E@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27 April 2020 12:20:43 PM IST, Markus Elfring <Markus=2EElfring@web=2Ed=
e> wrote:
>>> I propose again to add a jump target so that a bit of exception
>handling code
>>> can be better reused at the end of this function implementation=2E
>>>
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/=
tree/Documentation/process/coding-style=2Erst?id=3Db2768df24ec400dd4f7fa795=
42f797e904812053#n450
>>>
>>
>> Matter of taste! goto's are really useful if there are multiple exit
>paths
>> available=2E But in this case there is only one and I don't think we
>may add
>> anymore in future=2E So I'll keep it as it is=2E
>
>Do you hope that an other optimiser software will avoid duplicate code
>like kfree_skb(skb) calls from if branches?
>

Doh=2E I didn't notice the previous kfree in skb_linearize()=2E Will spin =
v3 incorporating this change=2E=20

Thanks,=20
Mani

>Regards,
>Markus

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
