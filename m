Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9D0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC18207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thKN2IkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgA1XXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 18:23:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43672 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA1XXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:23:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id u131so7821578pgc.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 15:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qtDKcDo43nmZwkqUo6vP29qxWZLR8bIUv5nEZgz1DFA=;
        b=thKN2IkHI6eoCVwhzxYpSNnGUJGshx0T0CUZf2M47Z4UBroasPMxaHiH08BWYflWFw
         h95Npz6rwv8+USJ9ELUffyniSA5/xf5N9v5y7eivzMVRvloL0gUUMgyPlhdEX/TOJ5IY
         wjlvNrNZWfTnUYJMW6wRgmDjtHfoRv1fT104AlCQyEaWKCWMbuW8De0jh60YJq+6796E
         FOhQ5zHfjHVt1TsSVfxVG5A5IUbltqkfkuKChjzv+jzf8kX+ScS8fBmtsasZoGZr8sY8
         ExbfdaFzJp9S8vHSgR8rh4A0jswrgJR1SlRnxwRCvUU2Pi/qc+/MPML1thBuX1cGJbDU
         LsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qtDKcDo43nmZwkqUo6vP29qxWZLR8bIUv5nEZgz1DFA=;
        b=nKYeezxHil/rz84rg2ywePanvanl/RbPoHFARzum5ONru1EdHqswhVNUPn5NgdZFcO
         T4NfdJxpW4GjgOmrrM3wJgtJK3mr+OUQ6cL2wPYl2H4C3ugDtc1wVwJ5oqleeotsozni
         074GJZjcmRiDF5ADMQ+4BVnBXppumIAbkawwWqPMd3ggx9BfPEYMYMisWCCukTvwgQld
         4K4ajb8f7hk61SZyS1cC0IRoXRr/YF8h+uv9U+ZUr5RJZjGXNs3noeKyMGkjVvfskywh
         hs6uTminQiCQg9x1kVL/4mbK7nruoHtRhTL6MZUkn58nCCRi/4Da/cyJzuyCAJx/rBA3
         oeNw==
X-Gm-Message-State: APjAAAWzNDV89rxWV27q+Hdv6SLGcHCt4IekSywFPBEK7FMWcBrUXkSs
        DAp1mOu9PNVP2COU9hJTiDmqBSor
X-Google-Smtp-Source: APXvYqyn/HkOe8Is5zRKMffcPVNx+Nyon8siSDSZfcG/4zALgTESbcVmvxO8gDgiOL6rEr+ehLf3Nw==
X-Received: by 2002:aa7:961b:: with SMTP id q27mr6351445pfg.23.1580253800364;
        Tue, 28 Jan 2020 15:23:20 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w187sm126882pfw.62.2020.01.28.15.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 15:23:19 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 06/20] ARM: bcm: Drop unneeded select of PCI_DOMAINS_GENERIC, HAVE_SMP, TIMER_OF
Date:   Tue, 28 Jan 2020 15:23:18 -0800
Message-Id: <20200128232318.2654-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121103722.1781-6-geert+renesas@glider.be>
References: <20200121103413.1337-1-geert+renesas@glider.be> <20200121103722.1781-1-geert+renesas@glider.be> <20200121103722.1781-6-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 11:37:08 +0100, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> Support for Broadcom SoCs depends on ARCH_MULTI_V6_V7, and thus on
> ARCH_MULTIPLATFORM, which selects PCI_DOMAINS_GENERIC and TIMER_OF.
> Support for the various Broadcom IPROC architected SoCs depends on
> ARCH_MULTI_V7, which selects HAVE_SMP.
> Hence there is no need for the Broadcom-specific symbols to select any
> of them.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> ---

Applied to soc/next, thanks!
--
Florian
