Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33493C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE2120771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsojXhgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgFSFHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 01:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFSFHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:07:22 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F2CC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:07:22 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c12so6305879qtq.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BnlNPLMsiGUU55/RUK8kstgHNMQENQOoNvRb+RK4i1E=;
        b=DsojXhguD4QDe9yg811mNfRAJm6KgD8ZcfSeegN8BgVm3PaNl2XWSd9h8uw4C9VUey
         5k60AqTqfkVahuTj0459YJUV9akus8zXXrjPNofocDgre4EqFCdRzzJcMKhgZmn5hR77
         IQcmJPgSiARH9MY/a4kGh6O7m03zHYlSokPI4nOvfi0MpWLVoPYLl9w7XHieyC9iFpWV
         +9zAQS6xdh6tLVBB85NQ5No8zrBkkNTlwcRwQf0evL454uEsAE58c5NL2lxQv8BRa9s3
         1yiEw5XbLJtKJ42IsqHjnKRltH+5b7E80oxcZdHrdGBUeK10+umhH58BJcmJz9mMeC2W
         ZCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BnlNPLMsiGUU55/RUK8kstgHNMQENQOoNvRb+RK4i1E=;
        b=MJy6+/XMlXCs0UeArwcBzZ/zEYejms/W7rltLcdkDiXNmHCLjEGeB4nZLczoWlG0GX
         +ourcsNiqTbWJ00lkUV6h2Y4ojCdOMrxJ3Gw6ebrtQwazi9K11rDV/ZovFD2DjZT0/0g
         n7gXqC4mnNCB83CiHOhbHPKnmtDdcA2klhWhOnwllcSALbhIEKzVtqf8DABKczFexIUs
         B8XVdKbd4NTj3DFNEKLkwcLRrrmKYhjqv/AC5krAU/FY6Ef1UwHk/cIrML/TZwF1us4K
         lNdv3JhVcq3dMGu0FNLHE8WCK3sG1yZfBToSSCl59AfnsazUI62dZL1UjBCJF09rbZFY
         ZZjQ==
X-Gm-Message-State: AOAM532zam0heDsF/6GwRF1/sKdGBAsPKZU4vLlimRFn+G/2svSMLIvN
        z7SpdbY/weDN9mxLhJH1c2M=
X-Google-Smtp-Source: ABdhPJyygvNI1KlzIsHW7vl+0acimWQx4VjECYGeQrIDl1dQtfL5i1FJCA6P6KKmfMR/aMoUHWCvyg==
X-Received: by 2002:ac8:378f:: with SMTP id d15mr1744308qtc.136.1592543241612;
        Thu, 18 Jun 2020 22:07:21 -0700 (PDT)
Received: from LeoBras.ibmuc.com (177-131-65-187.dynamic.desktop.com.br. [177.131.65.187])
        by smtp.gmail.com with ESMTPSA id o6sm5235503qtd.59.2020.06.18.22.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 22:07:20 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Leonardo Bras <leobras.c@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Remove default DMA window before creating DDW
Date:   Fri, 19 Jun 2020 02:06:16 -0300
Message-Id: <20200619050619.266888-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some devices that only allow 1 DMA window to exist at a time,
and in those cases, a DDW is never created to them, since the default DMA
window keeps using this resource.

LoPAR recommends this procedure:
1. Remove the default DMA window,
2. Query for which configs the DDW can be created,
3. Create a DDW.

Patch #1:
- After LoPAR level 2.8, there is an extension that can make
  ibm,query-pe-dma-windows to have 6 outputs instead of 5. This changes the
  order of the outputs, and that can cause some trouble. 
- query_ddw() was updated to check how many outputs the 
  ibm,query-pe-dma-windows is supposed to have, update the rtas_call() and
  deal correctly with the outputs in both cases.
- This patch looks somehow unrelated to the series, but it can avoid future
  problems on DDW creation.

Patch #2 implements a new rtas call to recover the default DMA window,
in case anything fails after it was removed, and a DDW couldn't be created.

Patch #3 moves the window-removing code from remove_ddw() to
remove_dma_window(), creating a way to delete any DMA window, so it can be
used to delete the default DMA window.

Patch #4 makes use of the remove_dma_window() from patch #3 to remove the
default DMA window before query_ddw() and the rtas call from patch #2
to recover it if something goes wrong.

All patches were tested into an LPAR with an Ethernet VF:
4005:01:00.0 Ethernet controller: Mellanox Technologies MT27700 Family
[ConnectX-4 Virtual Function]

Leonardo Bras (4):
  powerpc/pseries/iommu: Update call to ibm,query-pe-dma-windows
  powerpc/pseries/iommu: Implement ibm,reset-pe-dma-windows rtas call
  powerpc/pseries/iommu: Move window-removing part of remove_ddw into
    remove_dma_window
  powerpc/pseries/iommu: Remove default DMA window before creating DDW

 arch/powerpc/platforms/pseries/iommu.c | 163 +++++++++++++++++++------
 1 file changed, 127 insertions(+), 36 deletions(-)

-- 
2.25.4

