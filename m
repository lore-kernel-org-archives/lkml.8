Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC22EC10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70B3216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5qIP+HJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgIIJg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgIIJgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:36:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44160C061573;
        Wed,  9 Sep 2020 02:36:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l63so1933000edl.9;
        Wed, 09 Sep 2020 02:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Pv6iapq4O5SjVtL1iPYVDh7JKWlokNzhK+8UbOeBFUo=;
        b=l5qIP+HJ3LRN88aaWALWmY59d9psHRG4Hb0Srkk15LDEvgmE5fi/+JourmV+safV+4
         jeF4v2tkPmlGclswpxcp7fQD4/T95DcHOKTjy8M7a1hBEkMU9DXgamVslHRPCDGTLqaj
         AJ0mzWZ0Z7YKniv4BH3qtlBDqHJaOc5HQzwTNbIhz6xerBIjnhqKELWMgzOCVeNHGPbg
         vzQdQK3T3jscMzP1G00X4+mCKSYT4GNS7Mw2RyaGDoI06sF3xXIi3StOIkP8+Iq5tubG
         fyY/KaOklPT3WVqwszVuVvyx6QGiAogRXq4QiEmN+Fc++B2DVUZnC4pHEuGOyuWgIGD7
         BbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Pv6iapq4O5SjVtL1iPYVDh7JKWlokNzhK+8UbOeBFUo=;
        b=OyNIGLsf9W3UkrHnUI3F6U3R83mf8NKTrgJOnXwnf71unDS8TDrDm0emUgPOJggMkB
         NcRmkb9QPdwYEyKambRPoqHz20GOTt2yN1m+mjACowi6Isbre1RWV5fd0yugUYk2CLf3
         EQrMQXgoF6KtI4RIbrBA/y82/8EnXI1nD7RhnmmJgPba/Z3mQim6VIUDP5nXv6dRl0t1
         s/Of7iyT3iWaJFtH2wij7iCfKAh/ViaF8umlKJll/jcZp0Ap3Q8apIQ7HjgUrPtZB2Lc
         T8UNBDVuu3ak0j51xUPtTNTxbY9uPVyjaAOQ4skTjWNLNbOeVTbPparSTFQZpOFmi9Gz
         20fQ==
X-Gm-Message-State: AOAM5316yb8xgg7E5TSI3zYuRzUK52MCqHBNAPlWRACWCti+UzI1321W
        xR2wJAXeMIbKjE1YLc/kUnU9OybITbmzm9MS
X-Google-Smtp-Source: ABdhPJyHkS4fr/EaoKgqk7aw9pkfvPCT6zW8m7v5aBiX5PcAhV8fYS3EhOdjTPhbI5mF/c4VhkvQ6g==
X-Received: by 2002:a05:6402:644:: with SMTP id u4mr3118816edx.182.1599644206902;
        Wed, 09 Sep 2020 02:36:46 -0700 (PDT)
Received: from felia ([2001:16b8:2d44:6000:6108:df55:7b8e:67d4])
        by smtp.gmail.com with ESMTPSA id y21sm1542739eju.46.2020.09.09.02.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 02:36:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 9 Sep 2020 11:36:44 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Igor Russkikh <irusskikh@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH 0/5 REBASED to v5.9-rc4] Qlogic drivers: Convert
 to SPDX license identifiers
In-Reply-To: <DM6PR18MB305266178BB9982CBDF05319AF260@DM6PR18MB3052.namprd18.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.2009091126290.5622@felia>
References: <20200908123451.7215-1-lukas.bulwahn@gmail.com> <e5688d4c-f512-6705-6bb1-db832828fb35@marvell.com> <DM6PR18MB305266178BB9982CBDF05319AF260@DM6PR18MB3052.namprd18.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Sep 2020, Nilesh Javali wrote:

> Lukas,
> 
> I have Acked for the storage drivers and opt for option B below for spdx maintainers to pick.
>

Thomas, Greg,

We got everything straightened out with Igor and Nilesh.

Can you pick this patchset with Igor's and Nilesh's Acked-bys into the 
spdx tree and forward it to Linus?

One down. Another century of license work ahead to get it done :)

Thanks,

Lukas
