Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16539C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2C8120768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY6u+Ik6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389097AbgFXGY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388807AbgFXGYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:24:25 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98248C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:24:25 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id z63so877778qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rWc5T8JqrPliqQCYkEzpLsyAKpL+sMGlsDYKu4QHUEA=;
        b=lY6u+Ik6BcZQKGseNLfZtXrUTunNufyPo12FHTdQdnNAEk82ApKa9CGBGo+9FG7NoJ
         YIPXHcxzjd1En0SnpXzxKwi7jnLryKfnEWcbg2QHcNZc0ImcsBGcI4W/A5vcoIN2kuar
         NPT0o9T52FOYj/jQJDd6AMWH3mEFI0AxopkEXicRnV/zWfGTzGukhXCt6M7wkYFrPUcH
         jFeaqscC98wGxTQPN5Ibhk8VyFEgerDKd4d75zq40Q99Cpf9miIId50cDO7oBxdihaJm
         PNaS0SgZkGGO/pp3tFkLJt/9mVFbJE5Y5/dikogKsT7jb9V1QHcJ0U987XPD+7ca5kyC
         B7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rWc5T8JqrPliqQCYkEzpLsyAKpL+sMGlsDYKu4QHUEA=;
        b=MDM18fAxf9OvB7BrgAL7cpl/X82it1OtaeK26SXiX4p9hqGRR3HOLVhfh4Yg+g/pM2
         KsLGIa8brTWNEysolbJKfHdhCKr2UXtsX/OVkQTdKW7V+sWm2ynGvDwbrGPiEEsaye+P
         VyYIIkNhcEHbnIRlsCWH04B7P6Blh1UE4pVCKbd+2CN688rZTqnj+JxRlVmi9XIycE04
         i1O1q9ijIFtM/Yyu7XXZoWqnhcDdgcQMKDCrNmOQBVxRNbtAeHzEr32v1dUpMX6qVMUj
         AiJ7E2fX1YloZYCF6+Wc3A87DxITqyoZovQDGrzdMRFD7wFlhu3D0WG1RnZCJLcWRoEq
         C9mQ==
X-Gm-Message-State: AOAM530pHy3Zs1Xs2WPHivyXA1rgxvDUNXz9qS1m5HRdYgpszvyqIebx
        LdeStieWzuBnCHsGgmfod+Y=
X-Google-Smtp-Source: ABdhPJz/dCIrOav/5ppWpOwMO4T3RZyH6bHIvVKIbIf3zoSBMtvQ7oHieY0c4aVxTaSpZFms5jiK+w==
X-Received: by 2002:a37:9a96:: with SMTP id c144mr21984767qke.207.1592979864678;
        Tue, 23 Jun 2020 23:24:24 -0700 (PDT)
Received: from LeoBras.ibmuc.com (179-125-148-1.dynamic.desktop.com.br. [179.125.148.1])
        by smtp.gmail.com with ESMTPSA id n2sm2489727qtp.45.2020.06.23.23.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 23:24:23 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Leonardo Bras <leobras.c@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Remove default DMA window before creating DDW
Date:   Wed, 24 Jun 2020 03:24:05 -0300
Message-Id: <20200624062411.367796-1-leobras.c@gmail.com>
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
Create defines for outputs of ibm,ddw-applicable, so it's easier to
identify them.

Patch #2:
- After LoPAR level 2.8, there is an extension that can make
  ibm,query-pe-dma-windows to have 6 outputs instead of 5. This changes the
  order of the outputs, and that can cause some trouble. 
- query_ddw() was updated to check how many outputs the 
  ibm,query-pe-dma-windows is supposed to have, update the rtas_call() and
  deal correctly with the outputs in both cases.
- This patch looks somehow unrelated to the series, but it can avoid future
  problems on DDW creation.

Patch #3 moves the window-removing code from remove_ddw() to
remove_dma_window(), creating a way to delete any DMA window, so it can be
used to delete the default DMA window.

Patch #4 makes use of the remove_dma_window() from patch #3 to remove the
default DMA window before query_ddw(). It also implements a new rtas call
to recover the default DMA window, in case anything fails after it was
removed, and a DDW couldn't be created.

Patch #5:
Instead of destroying the created DDW if it doesn't map the whole
partition, make use of it instead of the default DMA window.

Patch #6:
Changes the way iommu_bypass_supported_pSeriesLP() check for 
iommu_bypass: instead of checking the address returned by enable_ddw(),
it checks a new output value that reflects if the DDW created maps
the whole partition.


All patches were tested into an LPAR with an Ethernet VF:
4005:01:00.0 Ethernet controller: Mellanox Technologies MT27700 Family
[ConnectX-4 Virtual Function]

---
Changes since v1:
- Add defines for ibm,ddw-applicable and ibm,ddw-extensions outputs
- Merge aux function query_ddw_out_sz() into query_ddw()
- Merge reset_dma_window() patch (prev. #2) into remove default DMA
  window patch (#4).
- Keep device_node *np name instead of using pdn in remove_*()
- Rename 'device_node *pdn' into 'parent' in new functions
- Rename dfl_win to default_win
- Only remove the default DMA window if there is no window available
  in first query.
- Check if default DMA window can be restored before removing it.
- Fix 'unitialized use' (found by travis mpe:ci-test)
- New patches #5 and #6

Special thanks for Alexey Kardashevskiy and Oliver O'Halloran for
the feedback provided!

Leonardo Bras (6):
  powerpc/pseries/iommu: Create defines for operations in
    ibm,ddw-applicable
  powerpc/pseries/iommu: Update call to ibm,query-pe-dma-windows
  powerpc/pseries/iommu: Move window-removing part of remove_ddw into
    remove_dma_window
  powerpc/pseries/iommu: Remove default DMA window before creating DDW
  powerpc/pseries/iommu: Make use of DDW even if it does not map the
    partition
  powerpc/pseries/iommu: Avoid errors when DDW starts at 0x00

 arch/powerpc/platforms/pseries/iommu.c | 239 ++++++++++++++++++-------
 1 file changed, 176 insertions(+), 63 deletions(-)

-- 
2.25.4




