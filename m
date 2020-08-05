Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245CBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03DA221D95
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0ISPGpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgHETqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgHETpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 15:45:06 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DDEC06179E;
        Wed,  5 Aug 2020 12:38:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh1so12893554plb.12;
        Wed, 05 Aug 2020 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5TXcgEgAs4Nu34HXfjY3jbM5apQONV+NnIX864cNQWg=;
        b=H0ISPGpLRV3y9tQ4W937aoZMWeGxz3wG5Byk04+BMcfetPTwhgVMR7//+YNlxmBPGR
         Chyn7D6Hd51R/+LTW5MElsg4IUtIBfT7dNVom/CTGrj9xocK0ZmtEpCj4wANYO/Rjqwr
         k1KMM/MM5xBsFiLKcPsctFreRvhT+efxV80jXwk3o/mcogbdnN5yqe9RQHghMcGsMIO5
         YZ88bzfzzIeKWCTaGZ/NJJmttlOGkIzHhF8jVVUgNv6U0icjx+Rs61YQ1xGsKX87m+0c
         hL7YiEJgmsudK2dy/zLWc6lcH+3eKJkIzuTC5tjKvhx/qKkRyflkKumSws07RuWwtRXZ
         mOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5TXcgEgAs4Nu34HXfjY3jbM5apQONV+NnIX864cNQWg=;
        b=PKxwphHtgF/QSPPykjIsvaE9+Fv4qe9w+FjmC+fvElivSO4w1+t0R3XrwkTeVZoDuS
         UipHIKMYYstZK9QPGxDfGwKjLgVs/Cx2KhRg2Bjn5OCDL59Qpe6vbCSr/Qiyp3E6LWW/
         1t/iDDaqWrfnB1K5k2kEa2M6RyTw7JUUBBBYmZF8HvziLI8Ycjud5oC1Ju5hYZpnVFs5
         La42vhESB4ye7YJqlZDE2xKCtw/FYetLGQJkPC0mQMJlTbNUyCanBjZc8q1kKMm+wvOD
         SsGYnFdF8xqmoYjd881TWM6XC+OzqddRKpuZAwEq3VUm4HZhCXnBBZQjcilExAUVUNgF
         i1xQ==
X-Gm-Message-State: AOAM530yvyo0uDtnZqrO4Fr3uwaiFmPogGPaYiveY+ioRHo/kidRa9Tk
        f0FmV4hMpMUzkpcFEMMEWh8lPRNB3WT9mA==
X-Google-Smtp-Source: ABdhPJxpsNBrfC/tIWMSvSdeG5I8GbtN42x6d7YwWee5C39MithTk79rmmNir6Zz8cbOfIUAOW+IOw==
X-Received: by 2002:a17:90a:3268:: with SMTP id k95mr4854944pjb.153.1596656306933;
        Wed, 05 Aug 2020 12:38:26 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id f20sm4901764pfk.36.2020.08.05.12.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 12:38:26 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>,
        Tomoya MORINAGA <tomoya.rohm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 0/2] i2c: eg20t: Power management upgrade and clean-ups
Date:   Thu,  6 Aug 2020 01:06:14 +0530
Message-Id: <20200805193616.384313-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200805165611.GA516242@bjorn-Precision-5520>
References: <20200805165611.GA516242@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mentee: Remove Legacy Power Management.

The purpose of this patch series is to upgrade power management in i2c-eg20t
driver. This has been done by upgrading .suspend() and .resume() callbacks.

The upgrade makes sure that the involvement of PCI Core does not change the
order of operations executed in a driver. Thus, does not change its behavior.

Also, before upgrading PM, some cleanup is required. Both .suspend() and
.resume() invoke pci_enable_wake() just to disable wakeup. This is not
required as if .suspend() does not want to enable-wake the device, PCI core
takes care of the required operations.

v2 : An additional patch had to be added in v1 to drop PCI wakeup calls.

All patches are compile-tested only.

Test tools:
    - Compiler: gcc (GCC) 10.1.0
    - allmodconfig build: make -j$(nproc) W=1 all

Vaibhav Gupta (2):
  i2c: eg20t: Drop PCI wakeup calls from .suspend/.resume
  i2c: eg20t: use generic power management

 drivers/i2c/busses/i2c-eg20t.c | 39 ++++++----------------------------
 1 file changed, 7 insertions(+), 32 deletions(-)

-- 
2.27.0

