Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDD2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E63221F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6enXb3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgGNGqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgGNGqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:46:36 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDECFC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:46:35 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id r22so14619528qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=dzxfeYMtkjsMRhuGgWk+6usvf7YkNVFphbzmaI9AE80=;
        b=D6enXb3MQ6lRfQoiLzp7fWvveVWEPafnRj0qOq8HR749w3FZ37ez2NYcHDpWVcNJ8C
         E6oilKdejmb5r0rqLFJB+CCLpscI8XUiIVZ8bDM7z6I/7R0PfB+60Ow/jN3FMTFb+aqf
         VIHAGF84TrYoYpJzXubl8z4dY24kY+GAm+G0m27ZFHu72vmK0NVCiy4kSnFIwVT401mB
         pkAFtMTtLD4gEXq7awDLySJq5spWEL2tFvchp9MVLxoMnoF7vhSgssNg+M6z59ENUxiH
         RLqIUZYFM3dl6pT13dxMsHSTwb+OG1YiOQOwRreOhSXvfmOqJOBWL9iUxFa+QBQb4eC8
         ukrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=dzxfeYMtkjsMRhuGgWk+6usvf7YkNVFphbzmaI9AE80=;
        b=eSNr6YSpauS0u+JvJXlrtHHK2Pdff6lbOlx9gQWxwPaLlIjnwuuQb28qNI6h7zno8Q
         mnb7j8tZKRorOS6PjBim8h2di940MJStupyz6u8XOGgliErahLD34XZHNCgrAR2DqUrt
         PWcuZhQLQHRR+hWSM1SLSMvpw5EIFRwlzsnyrplKzeUlVmUR1Mr7wpJHJJyTKHH55xaz
         KiokjVo5pD3xLrGXOsSMNAalVqEuyLd4meaFXoJ1WEUNSimEsWdpSHqqrK2Us8qD5KwZ
         tGWp/5nOrENk6P1/8qSnjEo7lrsQbk2XtAC2LULTm/p79wN/bS+O+PtEYkgEiQ+gSaj1
         cQoA==
X-Gm-Message-State: AOAM530mXc/6v6QnjizZeJSr6h9pWh/gAh/T9ryI3eO3M8ovnyhedA07
        R2DGwaFkVcPM2hqQS5e+wsg=
X-Google-Smtp-Source: ABdhPJyC3/V/9okdvc0CGcOc+6fmRvKD6sJ98UlaqvKOZ2nYA2QIkbbrDx8NW6BywsBA4Kr4BtJlsQ==
X-Received: by 2002:a37:4bcd:: with SMTP id y196mr3029955qka.495.1594709195156;
        Mon, 13 Jul 2020 23:46:35 -0700 (PDT)
Received: from LeoBras (179-125-193-229.dynamic.desktop.com.br. [179.125.193.229])
        by smtp.gmail.com with ESMTPSA id a68sm20906352qkc.110.2020.07.13.23.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 23:46:34 -0700 (PDT)
Message-ID: <846ba63b1f1fc4c9366f39b2cf09df71a19da891.camel@gmail.com>
Subject: Re: [PATCH v3 4/6] powerpc/pseries/iommu: Remove default DMA window
 before creating DDW
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Jul 2020 03:46:29 -0300
In-Reply-To: <eb357d42f5605a2b0234c04de477e171134c24f5.camel@gmail.com>
References: <20200703061844.111865-1-leobras.c@gmail.com>
         <20200703061844.111865-5-leobras.c@gmail.com>
         <cc15a81d-04d9-3ee4-4fdb-093618f6e635@ozlabs.ru>
         <8c29be499e8741e7d77d53ca005034a2ca0179ac.camel@gmail.com>
         <18fd94d2-4365-16d1-7c85-af07d5c9a0f3@ozlabs.ru>
         <eb357d42f5605a2b0234c04de477e171134c24f5.camel@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fact, the changes over the last patch are more complex than the
current patch. 
Just for reference, that's how enable_ddw() currently patches:

@@ -1087,7 +1119,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct
device_node *pdn)
        struct device_node *dn;
        u32 ddw_avail[DDW_APPLICABLE_SIZE];
        struct direct_window *window;
-       struct property *win64;
+       struct property *win64, *default_win = NULL;
        struct dynamic_dma_window_prop *ddwprop;
        struct failed_ddw_pdn *fpdn;
 
@@ -1133,14 +1165,38 @@ static u64 enable_ddw(struct pci_dev *dev,
struct device_node *pdn)
        if (ret != 0)
                goto out_failed;
 
+       /*
+        * If there is no window available, remove the default DMA
window,
+        * if it's present. This will make all the resources available
to the
+        * new DDW window.
+        * If anything fails after this, we need to restore it, so also
check
+        * for extensions presence.
+        */
        if (query.windows_available == 0) {
-               /*
-                * no additional windows are available for this device.
-                * We might be able to reallocate the existing window,
-                * trading in for a larger page size.
-                */
-               dev_dbg(&dev->dev, "no free dynamic windows");
-               goto out_failed;
+               int reset_win_ext;
+
+               default_win = of_find_property(pdn, "ibm,dma-window",
NULL);
+               if (!default_win)
+                       goto out_failed;
+
+               reset_win_ext = ddw_read_ext(pdn,
DDW_EXT_RESET_DMA_WIN, NULL);
+               if (reset_win_ext) {
+                       default_win = NULL;
+                       goto out_failed;
+               }
+
+               remove_dma_window(pdn, ddw_avail, default_win);
+
+               /* Query again, to check if the window is available */
+               ret = query_ddw(dev, ddw_avail, &query, pdn);
+               if (ret != 0)
+                       goto out_failed;
+
+               if (query.windows_available == 0) {
+                       /* no windows are available for this device. */
+                       dev_dbg(&dev->dev, "no free dynamic windows");
+                       goto out_failed;
+               }
        }
        if (query.page_size & 4) {
                page_shift = 24; /* 16MB */
@@ -1231,6 +1287,8 @@ static u64 enable_ddw(struct pci_dev *dev, struct
device_node *pdn)
        kfree(win64);
 
 out_failed:
+       if (default_win)
+               reset_dma_window(dev, pdn);
 
        fpdn = kzalloc(sizeof(*fpdn), GFP_KERNEL);
        if (!fpdn)

