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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4965BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5722073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyk6us76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgIDDtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgIDDtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:49:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D579C061244;
        Thu,  3 Sep 2020 20:49:18 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so3850742pfg.13;
        Thu, 03 Sep 2020 20:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yUwNeEcHskKzWXeX8bUdAXXsdwwyVt0UyxCmSAJpfmw=;
        b=tyk6us76VRM4mNiW0Eg6ePdDKdKOGwiBjuyTBC7Z3460Na9zVaSTCOUrjpfiUqlx0U
         kplUyxRHHyR4whbnU5QO/T3CuIXW7sOSDRNgKjmZZNRS/X8B2ID9gb0xlvWUmaQLF/MM
         x77Zs4doxxCKG0YalXTsYEFr+Qm6d8CpLImz4sjf+rJyoO3//GDoVj7um1EkWmuT7N/J
         0XFB/5jphJEuKY3Pv27sScIGzwJY3VO043Sc8C7DoR9OjtstL+u4GAqIZKVi/KK5Fe9J
         MOPxj5sSp052Key0MB0ywJl6JOsqsMo91tyOPoN8Cu87dIb2TWfvsoyr1m/oIiNoszg+
         WLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yUwNeEcHskKzWXeX8bUdAXXsdwwyVt0UyxCmSAJpfmw=;
        b=rSEUmr7aQza2GinE3/9p80Pwd0Af+gPJp8gimw7xZhMWLhLskTcrbnetH+YBv8+uJz
         pfRjraL/B3+Z92njYjZKRDMLnqbSibfSfelFHry7ojIcnMr4Rt+oZsqIeQFYJyjaoJOs
         Bodw708FZMW4hDMSAs5Chlq8DLFmhcaw65IrsiN+ap+0yyEIxkad5oCATk2mEvoByWrK
         XRgkvnkbxv4ObhMCVQs1Zp+bcMXIZyFtoIsOApbyLr7o6LcCTt5YyQzJObwVki26y1Y7
         xWaeEoopLrfAouA5gS7A4jWyj0inEevSh9kw4uP7NW4bw/fdn01XASaPVFw8bKE32kOk
         0DXw==
X-Gm-Message-State: AOAM5303T4TYl7XN7Cve+VzGghXUPTszR5DYC75y9T04vrLMHflIoy39
        uGwTNIDwLo8RrPvMPvxOxomFkyYQ3j8=
X-Google-Smtp-Source: ABdhPJw/eSFC88ac0saM3t/fXQyFfUeCxGYnQbVZj3Us6hTMEURv3VFykxvAb+PJBLvFU9K6D56eKQ==
X-Received: by 2002:a62:14ca:: with SMTP id 193mr6553252pfu.13.1599191357764;
        Thu, 03 Sep 2020 20:49:17 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l9sm4481197pgg.29.2020.09.03.20.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 20:49:17 -0700 (PDT)
Subject: Re: [PATCH v2 02/11] usb: gadget: bdc: remove bdc_ep_set_halt()
 declaration
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
 <1597923046-12535-2-git-send-email-chunfeng.yun@mediatek.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0e482eba-7f5d-ce25-8237-ab4c4278e0cc@gmail.com>
Date:   Thu, 3 Sep 2020 20:49:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <1597923046-12535-2-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/2020 4:30 AM, Chunfeng Yun wrote:
> No definition for bdc_ep_set_halt(), so remove it.
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
