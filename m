Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2BEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F76D2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bit-cube.eu header.i=@bit-cube.eu header.b="lQq+aah7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgG3NH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3NH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:07:58 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764C4C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bit-cube.eu
        ; s=ds20207; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nKkAEooQrPys4F+nqNLeHSrWDl9KkcYV1ChHlGSjIVg=; b=lQq+aah791RxA/tWYsTMzIAl/n
        MvCDZT1o4h8HgcHyI468+GA3Sm57BNjiCSGuqyHxkoDa5Iltqo3xIXOtYUaM9ZySEwyT0uhyBmsaN
        0bKKvhk+oh4Lv+kB67yBVXGEGEvdwQw5wWptIYshZ1jtchkLq+16oKE7FfsVOif6p3315elDxLknG
        ZeYYkTWEHm7JwPFHzZDuiVKduJtGW9amya1zvs89pNNwf96BjB7A6nIvNTvqBnWzes7MyHQ3wC+fN
        zNFwqjOQR72HeqyioxleLeeC+Wbt2J4Ux1LrQSGGenqx6vemNHIjeX30IZsFDjExVHpHh+2VZDlN/
        Jy36Ju9A==;
Received: from [2a02:fe0:c700:2:8ac:86d7:cb55:d6b9] (port=50789)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <y_car@bit-cube.eu>)
        id 1k18Hr-0007DN-P2
        for linux-kernel@vger.kernel.org; Thu, 30 Jul 2020 15:07:55 +0200
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Ywe_C=c3=a6rlyn?= <y_car@bit-cube.eu>
Subject: sdX - Another fun fact.
Message-ID: <26cdca4c-44ad-a7ff-43e3-e2ee34e4e584@bit-cube.eu>
Date:   Thu, 30 Jul 2020 15:07:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name Unix seems to go back to a Scanza (pre-christian name of 
Norway) tribe, also.

We earlier discussed the Sami Tor idol, and this is where it seems to go.

These facts also make the name sdX fit perfectly, again a supply and 
demand principle based OS.

Serenity!
Ywe Cærlyn
https://www.youtube.com/channel/UCR3gmLVjHS5A702wo4bol_Q
