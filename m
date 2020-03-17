Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961EBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775C920679
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbgCQAzC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 20:55:02 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52032 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733229AbgCQAzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:55:02 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jE0VR-0004Wj-Kw; Tue, 17 Mar 2020 01:54:53 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Vivek Unune <npcomplete13@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, ezequiel@collabora.com,
        jbx6244@gmail.com, akash@openedev.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add Hugsun X99 IR receiver and power led
Date:   Tue, 17 Mar 2020 01:54:52 +0100
Message-ID: <7846021.K4VeDc98hx@phil>
In-Reply-To: <20200313230513.123049-1-npcomplete13@gmail.com>
References: <20200313230513.123049-1-npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 14. März 2020, 00:05:13 CET schrieb Vivek Unune:
>  - Add Hugsun X99 IR receiver and power led
>  - Remove pwm0 node as it interferes with power LED gpio
>    pwm0 is not used in factory firmware as well
> 
> Tested with LibreElec linux-next-20200305
> 
> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>

I've applied this for 5.7, but did split the patch into two.
One for the addition of the IR and a second for led.

Please do similar for future patches.

Thanks
Heiko


