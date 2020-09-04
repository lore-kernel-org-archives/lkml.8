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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935AFC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 677ED206F2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb+Hl9XG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgIDDsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgIDDsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:48:20 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB4AC061244;
        Thu,  3 Sep 2020 20:48:20 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p37so3645077pgl.3;
        Thu, 03 Sep 2020 20:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LLqMfP2X1w4/jx53zQazins9pmX04Mu60TQfw9itrD8=;
        b=mb+Hl9XGSjFDxPd2p1f2pWmrMALZyTgnOGltZSsAKY+ceyLlc25uoUfqCfv4SGdZ00
         2BzApt7dNMGm+qM2lH5spgflbHWPIL3hTYvYi7oTiHQEgy1gnoriuYH07qsaYIcDXcxe
         YqNwQkWYLjmcNDkwWgO1c8/O4/aOD19xb59o8nsrrFITpflaTq1Z9MOI1/aEMHLEo+2n
         4mP/M/E62GB5R5TVEOnbfSEtgoggO2tp/eNAXS+OECnOsToBoqM30yFjE27oXhgd7/2D
         36ReqsHdWTuMfW512oIc8gHkBGvfq0holRoO8LXq/p2yy5uTS7h9k+nBo7S5wAtodOht
         P3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LLqMfP2X1w4/jx53zQazins9pmX04Mu60TQfw9itrD8=;
        b=QmR4RSMcBVcJCs/RwR3POBWunTyHk/Y4EOJMxq5fTYINMlz4IJtTqbQct2br3IsAIL
         qGdg84RLjFwu3LX0fltixDrcbk+Q0iU+xqxOJKlXc0dD1LV9+TJj0IKdIZNnuQjTyX1r
         67EX4Luf18f2xW7eUvknJnx4Z44E1a4xie3W2HT0DbfYi/cIDTFi3oQXeJPOogy1GNod
         Df3NhS98spNDXPZxX2UGCoBg79lUD5lOA9Nwnyk0Vixs6moGqWO/a5OI5dd2dR39geK8
         tl0AXEALgtwNFIfbH+ck81DHCTbHnF+72hMlYej9Fc/Z6X2xTCsQxfcEYqseTyqUcYEc
         tqaA==
X-Gm-Message-State: AOAM531VYCjlTJDSBrnv5ZpzD7S5Suz2GfasnLPYTjTsqxKoafTkw/yg
        6IoIWjeu54znaMgtoaGs0As=
X-Google-Smtp-Source: ABdhPJxZxpzdB4FVjwyhMcw6LmWXi5pm+av3ieAQSNIpqfV1v7ZJR5459FGAK0H8X2gf8VjSQVuWzg==
X-Received: by 2002:aa7:9582:: with SMTP id z2mr47814pfj.257.1599191298737;
        Thu, 03 Sep 2020 20:48:18 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n11sm4224831pgd.2.2020.09.03.20.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 20:48:17 -0700 (PDT)
Subject: Re: [PATCH v2 01/11] usb: gadget: bdc: fix improper SPDX comment
 style for header file
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
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4ef74f8d-bbb3-2503-ed3e-8b5ce385a7eb@gmail.com>
Date:   Thu, 3 Sep 2020 20:48:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/2020 4:30 AM, Chunfeng Yun wrote:
> For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used).
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
