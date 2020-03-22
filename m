Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F5EC54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 21:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6002072E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 21:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMFzl4FI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCVVpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 17:45:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40936 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgCVVpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 17:45:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so6846345wmf.5;
        Sun, 22 Mar 2020 14:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OpdeFZCvMQp27xwp2Tkj2mPcsWQWcBhE0TOwloVk27k=;
        b=pMFzl4FIIFKiwlVVKkDpcAvi8Xr7ebjsyJ+45EvVDwTCHq8aoQ04FgVF525A4U58gp
         O8EIQ7jOgrBRP18W7AEDefhIUu5HHflIjR45LODjEVsx94S3yvBLMPcOUq5Zc3dNAl4G
         w7puYOBv6jqNCXyPUwkPuiT8xb1zA9XkpwOHgNCZ3BDyCnBd6PY2IVQH1ZYU7Z4HYXzV
         21yI8L1SCyLJrGXwSlYc1A8ykHC6ZjaDWWpRGpiy6hsnEFGiQ4nA0tNeIxo2XD++yfMa
         nn5T/VKtrC270jorEaA52HVS0tiWOdV6c4lJoVsznpKsP/Wz0pkNAqBvh03wTlUuSfbt
         iqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OpdeFZCvMQp27xwp2Tkj2mPcsWQWcBhE0TOwloVk27k=;
        b=TDvJ1K7tTAVIxCeciSYVisHCQG8I9eCOKQydiSBj7m5+ZKv/eCzv4jvXmvNvk6giKv
         PCFGeI4oxv/b7a7CibD0nLmlCEFhJdAvGKXToEPo73odXkJbdAs+iZFe4zs8ar66v855
         M88I0e2fpKYTCvggEOkMcjDd9w7qkep6ja2Y1FTzTWB/wGqWRY2J9SKrFz/J6aKsUnC0
         CycQRGnDdrW915njJOhyidyyucAPMCKhYZS6yy2LbAZQ1HLarieMqhKlBSdxrnND9Wly
         8SnxE5GlxNwTY9nDLl41WHOa/+P9AUqQd+FJDETFzVkGXPEskFjrUd6DlUWLRtrhqb/o
         sPZg==
X-Gm-Message-State: ANhLgQ3MuhlCSxa37ppRSa4WxwtWkhJH35+s7F3kYgGlfZFvxNIS5wHt
        muue00nCpwP+l4d6J7br7WI=
X-Google-Smtp-Source: ADFU+vtbH3TS1f00itgIsqg+Hkz9E+q5Sr+819jdZ6V7TxoKXnzXioWQwjVy/j5R9ehKLP4aPXBPBA==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr8561213wmi.177.1584913529649;
        Sun, 22 Mar 2020 14:45:29 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 9sm1310226wmm.6.2020.03.22.14.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 14:45:29 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>
Cc:     devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: bcm283x: Fix vc4's firmware bus DMA limitations
Date:   Sun, 22 Mar 2020 14:45:24 -0700
Message-Id: <20200322214524.19940-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319190013.21377-1-nsaenzjulienne@suse.de>
References: <20200319190013.21377-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020 20:00:13 +0100, Nicolas Saenz Julienne <nsaenzjulienne@suse.de> wrote:
> The bus is virtual and devices have to inherit their DMA constraints
> from the underlying interconnect. So add an empty dma-ranges property to
> the bus node, implying the firmware bus' DMA constraints are identical to
> its parent's.
> 
> Fixes: 7dbe8c62ceeb ("ARM: dts: Add minimal Raspberry Pi 4 support")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
