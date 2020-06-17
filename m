Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22444C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00FA420FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH6VJBfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgFQVh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQVh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:37:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759B3C06174E;
        Wed, 17 Jun 2020 14:37:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i4so1700630pjd.0;
        Wed, 17 Jun 2020 14:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HhE6cuq1S6m9mA3V80JeAQUXPVB+qHlwzWqr6geaGME=;
        b=kH6VJBfTLpiu8T3AXlhQO6i0Uzd+L3yg5deK1pM4pCsLfptouhYEUDRbEiD4dP4M2B
         RDz5C37SP+TkKFlg646bJebX94mjRVdY0Xie5Ydtt7ZljoIyBanS3Dz4w6S1+71Q9dUD
         XnTW35gMpozJoNl8h6T4nYkGOLb5BWR8VPptACBP9XEXkTvfII4J6/rYovDdbB3o1H6D
         UW6QCmag4DNahHqmpnU+h1q9JIq8PYXtYkaLJ8mncwfbpOtoeLvs0VTnPeo/GmraUAkS
         CmiDsN5e7EtiYrw4bboRC7TWghwX2ETE6cp78PJcXWmKcP0uMHSaSPYVp3zFRBDya1sz
         xE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HhE6cuq1S6m9mA3V80JeAQUXPVB+qHlwzWqr6geaGME=;
        b=CYKSlt9PXmfsKKEBkzBcBtpjMG7FupSCVa8jXbYAnJKwp+OFRm/oKTP6ylOjw5ckjA
         PZYLHlRdSbJl5hgkW3u6zqDAnBMT7hko005irVbRmeNZFStryuhr6R2J72zD8Up4RPMR
         6PjTsfwA7369TfnJdKS8oUwetH+hRpwWy/xYo9stliDe2PWgi0Cl+/QUKDnirOt3bZRg
         kv8c37TfBepsq6vsPPLjjKlEGnrQiIik4BvZM2ziHsvxis3yQdUtE25LNS0mX/bgTtrT
         6kTHWkoidJ+3gq9bUXMK7Qxkv6EyDalfRmSULo5jlPc1jlE6j5r4efELkSmjaLaHRlK9
         oE7Q==
X-Gm-Message-State: AOAM531YjjB3A7KdjvxBC5WRX+p6dMfsAYgVL/yU2KNmwbnGvEZtrSm+
        kBJ6uxmvlFm4zfviwDfisRU=
X-Google-Smtp-Source: ABdhPJxZiMiMtOOpkeEGSVRsRKNB3WUfSvLd60nyexgUp1AoeymU5+LVS2npr6l3xowEHQJ+nSiMDg==
X-Received: by 2002:a17:90a:b949:: with SMTP id f9mr933406pjw.79.1592429878011;
        Wed, 17 Jun 2020 14:37:58 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a12sm429778pjw.35.2020.06.17.14.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:37:57 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        jonas.gorski@gmail.com, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200616184542.3504965-1-noltari@gmail.com>
 <20200616184542.3504965-3-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <947c21d8-9189-fe23-b59a-4f911b76dbe4@gmail.com>
Date:   Wed, 17 Jun 2020 14:37:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616184542.3504965-3-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/2020 11:45 AM, Álvaro Fernández Rojas wrote:
> Add BCM63xx USBH PHY driver for BMIPS.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

As discussed in the v2 series, you also need to control the
UTMI_CONTROL1 register for operating the port in device/host/otg mode.
--
Florian
