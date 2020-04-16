Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8F0C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570BE221F7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lwu9UDtN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgDPU6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727983AbgDPU6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:58:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28786C061A0C;
        Thu, 16 Apr 2020 13:58:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x3so2223163pfp.7;
        Thu, 16 Apr 2020 13:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sas/tGiFl0s7XZ0zL4ohjomf4TSfEGYFHbj6ThxC/Q8=;
        b=Lwu9UDtNMgAoUxxVC9TsbsE7mMgDb72Z7+nXg04RHG4hPJ0N7N7FE5lNMo60+lpWWa
         4Eazfitgo+CVVK+5Drb42fPHtYo+SzQ0f8hzYGgX5r3AShWZt3dme+hi/rCOBoYazyEm
         +/Doa7WIUyLFDB3q7j+zeQ1WAq1+BgKZ6bRT5ctUZt7QWlw+7tyWlf6ln1MOu89rSfEB
         foIeYMaplyuyuD/qrEC3StiHCpSKQDPr24nzua+dPJeMbvjyjmEpDJRtiTlj6o4FSaUh
         Nf5iUmtFzKLlcDs/YQXLIJx6grp4KCbEseUWSV2V6dTyuxfQmI2+qaa7aKVcQQMsgL0v
         WZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sas/tGiFl0s7XZ0zL4ohjomf4TSfEGYFHbj6ThxC/Q8=;
        b=CmG2gD3MVgM0QAT0idMzQOHw+LN74iZQuPQi0jHtYKEa4P7i1LSjpT6KShcRa1iO67
         NOo4cIJl2ZcOZk52UCVTSY7IpDkvXFnobNIbD19QutGxGjasyJcBWSY61V2UuaaWnOZ0
         nEewVDJjxtBaVCBnKUfcgryiMnpquLw8jYl8gq+jGSCcf2Yocg3m00E7VDzpaWi8zRX8
         pEKiigM/tenKm4k5TaxN3qYZnKp+7p0pLgWoSr7SeLqcHIGut2XG4CD4FeEq6Wvl3PS1
         Xweo0doUZjnvouu/QOm7Rtai3eMPU46DyIrd+YRVjjrUFBzlhEnklryXedwzd/KRkl4K
         SYgA==
X-Gm-Message-State: AGi0Pua2j6wPfuDy0n82OU4mAsADKj40vlbteBBiugtMX6pgdHp7rWhr
        JQ+HH34khDypwdmqq8fkjhg=
X-Google-Smtp-Source: APiQypJ66yxVorklC/JNOIkrKD7QfHRAWlyj41i1m6VUlUr28zjVb28QuWVDrtMRRkQ16U+7sRSMXg==
X-Received: by 2002:a63:ca41:: with SMTP id o1mr34533711pgi.419.1587070686555;
        Thu, 16 Apr 2020 13:58:06 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g12sm2886932pfm.129.2020.04.16.13.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 13:58:05 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Eric Anholt <eric@anholt.net>
Cc:     linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: bcm283x: Disable dsi0 node
Date:   Thu, 16 Apr 2020 13:58:04 -0700
Message-Id: <20200416205804.4640-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415144233.23274-1-nsaenzjulienne@suse.de>
References: <20200415144233.23274-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 16:42:33 +0200, Nicolas Saenz Julienne <nsaenzjulienne@suse.de> wrote:
> Since its inception the module was meant to be disabled by default, but
> the original commit failed to add the relevant property.
> 
> Fixes: 4aba4cf82054 ("ARM: dts: bcm2835: Add the DSI module nodes and clocks")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
