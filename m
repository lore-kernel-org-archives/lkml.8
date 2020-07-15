Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A44C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF0F207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=octiron.net header.i=@octiron.net header.b="bNOrGneS";
	dkim=pass (2048-bit key) header.d=octiron.net header.i=@octiron.net header.b="pDNq9ZX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbgGONwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:52:12 -0400
Received: from chalk.uuid.uk ([51.68.227.198]:53852 "EHLO chalk.uuid.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729086AbgGONwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20180214; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=guijBD4cg8Q7tdnUnEDYLjCfwVKhLO9XFxXD5Rd4dqU=; b=bNOrGneSfYnabKmEt6SPi+WhIf
        idXYQAEi7Poyjy3yLsuqy/0ACqYBbFcVPFXbb0YNSzDlGlr6lRMJBiNSVNdkRjtjooluEZmMcTolf
        56My/D8cvRmABhjiD0CcNIIPFiu1Eo1GycDDdij0/UemLKBWCIpEs1Alv78co2roBRY+AIx8qG++y
        EhWTf3CHekv94ORx/+LiocmaTH3L35yiDmj5oOG9zqw2fvvPl7WoZjPm9wXjMIwcwOVTC7umLLaPI
        Dek47bdZuoyPeetqJKwYcQV4sVN8Seiyk2mWO1TozYNm9peYsHxPRlG2nL3yKKZZIOV7bnisqjszV
        adyVta9g==;
Received: by chalk.uuid.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <simon@octiron.net>)
        id 1jvhpH-0000Mi-KI; Wed, 15 Jul 2020 14:52:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20180214; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version;
        bh=guijBD4cg8Q7tdnUnEDYLjCfwVKhLO9XFxXD5Rd4dqU=; b=pDNq9ZX1Rc+2yxI3frqE441dLn
        80QhNt/Yfx7iAN/mf+jMRFBtacr/seV9EPGwIbZ5N1gFvw4oZNE2C5FWPS5TXVTC7BuWXN1+AJYtn
        AR5etgDHvk6u0ceQw+5PYoOLy+nlB7C3uidtDT2OrI6F2nUj2KikkA1oBDDsBr8YXzyJCxSpDwOl1
        sIpOzTZNCGeC9RhpyQs8HKYSJYrjfSbGlV/8mdYUVfrKyjeg+qYuqFOfOBIY6UPRWhrqcXXsQSWB3
        I4xwtSVTAxF9Le/gY1Pysf3yxX1iMdR7owIo+2dYk5fbZk29pCF616RWFKKuUKUg7NXmCLt7nBQu8
        19VaFC3A==;
Received: by tsort.uuid.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <simon@octiron.net>)
        id 1jvhpC-00018M-Kr; Wed, 15 Jul 2020 14:51:57 +0100
Received: from localhost ([::1]:45698)
        by skund.uuid.uk with esmtp (Exim 4.86_2)
        (envelope-from <simon@octiron.net>)
        id 1jvhpC-0005Bx-Hy; Wed, 15 Jul 2020 14:51:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 15 Jul 2020 14:51:54 +0100
From:   Simon Arlott <simon@octiron.net>
To:     =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>, krzk@kernel.org,
        gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
In-Reply-To: <4C342CF5-7417-4C6D-B1D2-75C71B9688C1@gmail.com>
References: <20200715131803.1762064-1-noltari@gmail.com>
 <20200715131803.1762064-3-noltari@gmail.com>
 <2e28eed25955385ab2513f8b617829f3@arlott.org>
 <4C342CF5-7417-4C6D-B1D2-75C71B9688C1@gmail.com>
Message-ID: <17de4f558d512a288ff15c26e90951d0@arlott.org>
X-Sender: simon@octiron.net
User-Agent: Roundcube Webmail/1.2-beta
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-15 14:39, Álvaro Fernández Rojas wrote:
> Hello Simon,
> 
> This is based on your work:
> https://github.com/nomis/linux/commit/c4c55b603a78e2732044a833e248c1a1087e7053
> https://github.com/nomis/linux/commit/f153a58b9e6f88e72c3ef34dc076118f8b3ade5b

Ok, it has been a long time and I couldn't find a branch with those in 
locally.

Please remove my *email address* from the source code and MODULE_AUTHOR 
text.


Historical signed-off-by lines can be updated to:
Signed-off-by: Simon Arlott <simon@octiron.net>

-- 
Simon Arlott
