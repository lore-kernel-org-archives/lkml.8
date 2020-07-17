Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CF1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88A4520734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=octiron.net header.i=@octiron.net header.b="ZnezmrH2";
	dkim=pass (2048-bit key) header.d=octiron.net header.i=@octiron.net header.b="o3D4Xy6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGQKgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:36:02 -0400
Received: from djelibeybi.uuid.uk ([45.91.101.70]:44000 "EHLO
        djelibeybi.uuid.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgGQKf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20180214; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kl1i0BpeU/fu3rTjI9F8/qTmUCwKp0XQHy8o4MvhnDA=; b=ZnezmrH2uvIIKja5UcmJ296HUy
        9F7lNnABjni3m/8Hm9ORXkjYWkI+7eAANE/bW/VtouO4xOx+gYrzl/ONpnwtLZbTmJdJ4XQl3sWwr
        pDWedRTcLQHK9UWDuPkQ7O9RtJ85C+c2LZfvWDlTjaErwn99t02xqbWM0eO4oJoU9E3aYz3cN+Cm8
        7g+vLmXG762WRuUwqB/1w7sfhpmNm9Vt4SBI55IrjgrAQ7BcSbzq4ELhe62kOfc8A3XGjxQWRHz4q
        bsPK/yaZAQl01hDNMOJmyV6/fipG9ppTiZTAHB2cxzLKP3wAw+G3y6fOR3KALCnxLsIFh3rwaOqk2
        T23PkNKA==;
Received: by djelibeybi.uuid.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <simon@octiron.net>)
        id 1jwNiQ-0005an-GU; Fri, 17 Jul 2020 11:35:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=octiron.net
        ; s=20180214; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version;
        bh=kl1i0BpeU/fu3rTjI9F8/qTmUCwKp0XQHy8o4MvhnDA=; b=o3D4Xy6pDQB+ao3CwIk8nyRKzk
        pspejMBhrBxUzp7ytuuB4kCxZhsOR5sy+0I9zirclzVZgNm7LqUN4kDXfsdlrqGl0Zl8Jn0YG9mMJ
        cpN9cLmULIT6cGO9krT/1BnACLSWjnecnOVcMT8SxuN+UF18XrJd4zZSdR7js1CEpPpNebk9qgpF8
        w+RmVYZ4AhOwyCfk4hQ5KNEO2TUdF5Rk86A0ijChV9Wm6HijGqvaP9ar6NsjAWi8vjujLAi7SJ+VV
        l1mtATUtAIBgZJnZDg5qXX0PZ3hVmuMVEr7Z1F0Q8dFD4ebRc3gHSuycJCohktgUWoRP0lozlUmXt
        qUvd6S5w==;
Received: by tsort.uuid.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <simon@octiron.net>)
        id 1jwNiO-0004d0-9V; Fri, 17 Jul 2020 11:35:40 +0100
Received: from localhost ([::1]:48888)
        by skund.uuid.uk with esmtp (Exim 4.86_2)
        (envelope-from <simon@octiron.net>)
        id 1jwNiO-0000ML-5e; Fri, 17 Jul 2020 11:35:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 17 Jul 2020 11:35:40 +0100
From:   Simon Arlott <simon@octiron.net>
To:     =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
Cc:     jonas.gorski@gmail.com, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
In-Reply-To: <20200717094756.9951-1-noltari@gmail.com>
References: <20200717094756.9951-1-noltari@gmail.com>
Message-ID: <d601559d6e0ab67c3ff02713df3eb32e@arlott.org>
X-Sender: simon@octiron.net
User-Agent: Roundcube Webmail/1.2-beta
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-17 10:47, Álvaro Fernández Rojas wrote:
> Add BCM63xx USBH PHY driver for BMIPS.
> 
> v7: remove Simon from authors and introduce changes suggested by Rob:

I asked you to remove my email address from the source code. All you've
done is update it. I don't want spam. I know the address appears in the
commit but you don't have to spray it around everywhere else.

You can keep my name in the MODULE_AUTHOR text but you need to omit the
email address.

None of the original copyright notices included email addresses so I
don't know why you think it is appropriate for you to add them.

Please only Cc: this email address, I don't want multiple copies of
everything.

-- 
Simon Arlott
