Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB71C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D44120748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u03d4tmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgIDDwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgIDDwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:52:15 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B61EC061244;
        Thu,  3 Sep 2020 20:52:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 17so3866728pfw.9;
        Thu, 03 Sep 2020 20:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=elyY3FogBHot5CN5hK6byMac4qADUpfN6udqJsXO4hA=;
        b=u03d4tmW+TnpYHqPYeSSsOh0Oi9chvWtfUdmcTrMysZo3Df4fL+NWryFcYy2sUIltB
         rCB5rqfZYBUXKuK7jCORQTuNiimlfykj2YuTeeNWg+8ZEGG7/Gu6ic4CjH28G0sjd4eJ
         z+1jOx9BYg7D9Kq4e+OumPEBi3IZjpbe5c4wHRP+DmoRjPpHj5yaqaZvvBHq/Z7zIsqy
         alS9uMLZocIQWvALNOW4bFdXcWTCO4SCLAKwb7G6mvQ4j/Rp7NyIakzEYLue+coBWQ6c
         Dx1KmIxjpCKZZNWYxLFtk45Angn4I6M/S9ehcT2MOv9sqYpO91mUMfn7KmcpgVjPiRI6
         VSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=elyY3FogBHot5CN5hK6byMac4qADUpfN6udqJsXO4hA=;
        b=fZHUSNNb4113BVEDv3MgQXM20+VvYrz7lg3jh9pgoWyI18Kg8OEJ1cJqafB5Ac0X5a
         q4URjcqoyTmJLTONWGkKR4MU3pgEArrIqpX+uid1U3Gl4E5JsKOxHi74Phqr71x8D1w0
         nc+QbE9rBVKKzGLv3Q/CWY+hwJfXI6eeJbpPUmQj+y0e5KcaJu6AijU+T5LR4yUREiqb
         KY/dZx1XsujKVA56KyiV73rInCGluORXywYfIgjKiSo0Kpy5zkM7rtFPwE3jtDDZ93ch
         Xy0aA1tOM4iTzmFGQbAvh7ak2U3L5dQFVtfHhK2aXzCH/poXYNiepR9E0K0N3ReqYG2u
         lu5w==
X-Gm-Message-State: AOAM53015n12+Ym5PsP0XBNk4J3JHxwM/kr/dYvbukPbdD1ZeYV42vpm
        WZxN4SCCOKJ9MHeOxUdNtqU=
X-Google-Smtp-Source: ABdhPJyCxCcbp9Tp+u1fFERs8e6XkvIJ0T06AEwJQXGYcS3y4b38I1RZGnvEcdAet26hobuBZKx4rg==
X-Received: by 2002:a62:6dc1:: with SMTP id i184mr6674304pfc.57.1599191534579;
        Thu, 03 Sep 2020 20:52:14 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bt13sm3964718pjb.23.2020.09.03.20.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 20:52:13 -0700 (PDT)
Subject: Re: [PATCH v2 09/11] usb: gadget: bdc: fix checkpatch.pl tab warning
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
 <1597923046-12535-9-git-send-email-chunfeng.yun@mediatek.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <476d20c5-33aa-d0d4-5996-78f6bf262918@gmail.com>
Date:   Thu, 3 Sep 2020 20:52:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <1597923046-12535-9-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/2020 4:30 AM, Chunfeng Yun wrote:
> WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements
> WARNING:TABSTOP: Statements should start on a tabstop
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
