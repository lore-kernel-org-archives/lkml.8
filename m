Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A45C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFCE520674
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tutanota.com header.i=@tutanota.com header.b="21l5jwsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgHPR1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 13:27:18 -0400
Received: from w1.tutanota.de ([81.3.6.162]:41798 "EHLO w1.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgHPR1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 13:27:17 -0400
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w1.tutanota.de (Postfix) with ESMTP id 47D7FFA03C8;
        Sun, 16 Aug 2020 17:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1597598835;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=fA4h/N/F4FlCIJKQipKo5rMWNyDVxcAR2cCxC/0ydvs=;
        b=21l5jwsA3PUIJMDuYKX0m3bkonWAbDn1NCjdW8sUcBNfCKX43fio+nteLRwMTbIR
        gzotDnxzCiZBLC8WGfyKAysUKLUIUI2Ldbk4mv5NQLrk+wPKt5BtUf67wGlPRj+mDPm
        /DeAqJUfrSmJhkle/rXsX9laEaHRepexFFmlEeiCCejfJFtztbZOoXqhBwyWwiOvtpK
        FxfsvXsalbXvtR8Ak+U/OhdbQaFyGHziLEQMvJmwJDNys00KEXwATSXjplc5AWZ5qCL
        KWcFBbARXPgZ8vbslIeJqABaXzzNwuJfOFRxhpJjKA12KHYYS2kyxJa03HDl6fVooNf
        v/fw2dP9uQ==
Date:   Sun, 16 Aug 2020 19:27:15 +0200 (CEST)
From:   Cameron Nemo <cnemo@tutanota.com>
To:     Devicetree <devicetree@vger.kernel.org>,
        Linux Arm Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Rockchip <linux-rockchip@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Usb <linux-usb@vger.kernel.org>
Cc:     Robh+dt <robh+dt@kernel.org>, Heiko <heiko@sntech.de>,
        Balbi <balbi@kernel.org>, Gregkh <gregkh@linuxfoundation.org>
Message-ID: <MEsItyq--3-2@tutanota.com>
In-Reply-To: <MEsH4zf--7-2@tutanota.com>
References: <MEsGWB_--3-2@tutanota.com> <MEsGppx--3-2@tutanota.com> <MEsH4zf--7-2@tutanota.com>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: enable rk3328-rock64 usb3
 nodes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately I had not noticed that these patches were malformed when I sent them.
I will fix my email setup then resend.
--
Cameron Nemo
