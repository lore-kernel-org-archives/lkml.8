Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD87AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 04:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F3421775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 04:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH+logvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgG1EYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 00:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgG1EYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 00:24:34 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1AFC061794;
        Mon, 27 Jul 2020 21:24:34 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id s144so6402086oie.3;
        Mon, 27 Jul 2020 21:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lw8BChbOt+3cCy8fjAi9TdK1jevRdCglCZh6ivvQ72M=;
        b=MH+logvcbnUxbInUxm2hCr72Kb94JCc1KO/eAd5bqlZeb/E1P66eAqFa8SQwF03vnF
         WdWWTd/ijhP6EghdCKI4+c/ks8DWewsXLF7C7NTN4jh7yEVdf75KhZz3eTYj/W5mouik
         pm8XA6M+x+RzLNfs899HLuhuiuP805qLtSM5GR4neoUjsnyv6Qm8T76jXFvl1hOt09eY
         cUuhBYhRYpNcd6HnC4VH4sCpViYdwJRxtz5EY7A2xluVnGMDJqHpdo8Ck1frMdgsdDH3
         u3IVNB7bxj+3ZIRY/8rIaHBwbYrHYNAGgXS46f/XyRu2SBvIqsBX2LXQh7GZmTqq9xUX
         dhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lw8BChbOt+3cCy8fjAi9TdK1jevRdCglCZh6ivvQ72M=;
        b=rdakembw9bcMeDpBJMu50AkWelfWBUv3tYna7FCCa4TgHGP96TIhS79mc6u2VAjsvN
         M0OYqp+znhKu1oaau3yq2COlCtlQS/LeRh751uG4VEaFysiuR96stYU5KpVQauZgGYwi
         5kqtVVK8GeQVwFORGdSI9WckWgQsXWAyOPZE7mb6/hCct0lUPjTDU98AmIzAWYGjiHok
         g8oSkkLYY10bQES5rw6IkW/4aUnFIS/Iqs2+Of6r7O1WyQ8GwhVl3dy1o/WdmIyA3gSA
         5d606aLt5XHW+Y0hkng43x1Pma9gPXtzobNT9bHAujzN/s6/uo5zbgNvcTqTcVcM3tQ4
         nZBA==
X-Gm-Message-State: AOAM533mpB+xKzoXTyinG/c3JYo7aXlvDB9xNBUN02G/BwG2E7mHf/6R
        2VuZM/01rgRl3PJl7vU+fxOW6xSJsIE=
X-Google-Smtp-Source: ABdhPJxxmSPcnvbuf5zau6AmKRtUr2TWD8mhzcnltgIcV9JwRo+hu2H2eVHsVX6nHyw2rRGZ/s242w==
X-Received: by 2002:aca:b2d5:: with SMTP id b204mr1970129oif.44.1595910273270;
        Mon, 27 Jul 2020 21:24:33 -0700 (PDT)
Received: from localhost.localdomain ([170.130.31.90])
        by smtp.gmail.com with ESMTPSA id v3sm765198oiv.45.2020.07.27.21.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 21:24:32 -0700 (PDT)
From:   Forest Crossman <cyrozap@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Forest Crossman <cyrozap@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Small fixes for ASMedia host controllers
Date:   Mon, 27 Jul 2020 23:24:06 -0500
Message-Id: <20200728042408.180529-1-cyrozap@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727090629.169701-1-cyrozap@gmail.com>
References: <20200727090629.169701-1-cyrozap@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch just defines some host controller device IDs to make the
code a bit easier to read (since the controller part number is not
always the same as the DID) and to prepare for the next patch.

The second patch defines a new device ID for the ASM1142 and enables the
XHCI_NO_64BIT_SUPPORT quirk for that device, since it has the same
problem with truncating the higher bits as the ASM2142/ASM3142.


Changes since v1:
 - Added changelog text to the first patch.


Forest Crossman (2):
  usb: xhci: define IDs for various ASMedia host controllers
  usb: xhci: Fix ASMedia ASM1142 DMA addressing

 drivers/usb/host/xhci-pci.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.20.1

