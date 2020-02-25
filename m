Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EF0C35E17
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E013A2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ftkdQ2hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgBYVLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:11:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34496 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBYVLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:11:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id j4so172374pgi.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 13:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tF+IlVAI+HS6Y0f+cneOLEXoT8cWlqM5wUtgnJmBx14=;
        b=ftkdQ2hgfFVI+hwU2MK6zYKrQrPOSgrXXuFofv2ARHivbmdOfs3ssBMzmdjnP5ZzPD
         Dr8MiMS654nUEZnmSv/nnA2aODa8F5AWISMWIlq2W5JbZQho0BgYPNraYWZPAoryyXSH
         G+T5SQyrCZgGe4xBrhoQedScDHGxcrOiKer9O53ygw/vEXo5vFkJl3NoPmX+MdWgsP1L
         Qan28rYEmUbwHA0ZPySQNAZQwsCrfKb4qnKz3CxjPFQlrY9yQBNHzugggZ0UiAAmEP++
         ITepZHHQcsLZT8uewbRgRRN9T9ryRH/AJL5KBei+/II26JUJl+y9nBjMNa/GET7EKb29
         WFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tF+IlVAI+HS6Y0f+cneOLEXoT8cWlqM5wUtgnJmBx14=;
        b=djqlA2qd4QvDijP9zGhY+5PytzpSyw9/gx73suTUZVV7y+sxMz7E0XyuGlCptflwFj
         o9bdv5Vq9jhPcmBQ1L85iYq3OdE9+5xjXyO9DXouo5tVMb7AaHoJSQyBf+0XHjiX+YrV
         REgl9mNbVd0EIZ+mEN7BwvaS0FogNAgB4tiqtiv/4G9TzHNUw3e4jg2aBzHWgmXzNKvT
         Kc33T1D9X4x2SflpBIpKKLkgIwxV5aa+eD883/hh7Z6Fhj/hANhRF47mCIrqy2mclJW6
         dg6beoSAEMFWB9IU3N3itUQBqvxvMLZ24us3MyTO4WbNAl5190uFCNavFQa1Lv9rwmrF
         gTIA==
X-Gm-Message-State: APjAAAUc+LDdSKvK/8LaJZK/SQ51Yr6X4V7N5UA10QwkXwwl8enqbvCU
        WkP490Ltp2S9CKooWTH4E/hKjQ==
X-Google-Smtp-Source: APXvYqwWoqLqv60gI3Mi9a6nyAllDkJGT9fQ6YDrQ3DDVc1ZKlkRjfSci7qWel5KG88MecI6TkZFBg==
X-Received: by 2002:a63:d90c:: with SMTP id r12mr486886pgg.106.1582665081210;
        Tue, 25 Feb 2020 13:11:21 -0800 (PST)
Received: from nuc7.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id h3sm17862064pfo.102.2020.02.25.13.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Feb 2020 13:11:20 -0800 (PST)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     kishon@ti.com
Cc:     alan.mikhak@sifive.com, amurray@thegoodpenguin.co.uk,
        arnd@arndb.de, bhelgaas@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com
Subject: [PATCH 1/5] PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer data
Date:   Tue, 25 Feb 2020 13:11:07 -0800
Message-Id: <1582665067-20462-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200225091130.29467-1-kishon@ti.com>
References: <20200225091130.29467-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@@ -380,6 +572,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
        int bar;

        cancel_delayed_work(&epf_test->cmd_handler);
+       pci_epf_clean_dma_chan(epf_test);
        pci_epc_stop(epc);
        for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
                epf_bar = &epf->bar[bar];
@@ -550,6 +743,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
                }
        }

+       epf_test->dma_supported = true;
+
+       ret = pci_epf_init_dma_chan(epf_test);
+       if (ret)
+               epf_test->dma_supported = false;
+
        if (linkup_notifier) {
                epf->nb.notifier_call = pci_epf_test_notifier;
                pci_epc_register_notifier(epc, &epf->nb);

Hi Kishon,

Looking forward to building and trying this patch series on
a platform I work on.

Would you please point me to where I can find the patches
which add pci_epf_init_dma_chan() and pci_epf_clean_dma_chan()
to Linux PCI Endpoint Framework?

Regards,
Alan Mikhak
