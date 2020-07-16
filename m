Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAE1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 043462067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq0RvrjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgGPHR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgGPHR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:17:27 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8C1C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:17:27 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ed14so2282710qvb.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qFJeQp9yLjeo1LueV7R117p7wDlHHRU//0IndFc0hb8=;
        b=hq0RvrjZoxwXtX/+7e0srDBAAiDfaVR5clywSt2R4RKvebtDb0SMFREULAZlSn2erw
         P7pCf+lWj01mHJnuf3WIuMbg5uTP0T1nAVSOJsArVdPtCZeQuPVsbauE64zYcfKsUrvh
         YdLQIpT6RrujoUWB7hV3fJ7GBuRACjeUQIIoAU7W2C20nyy5hd1P9HeBrAu2jE/az9Gy
         oOghaQfLeP93paCjPwZ5mUzb5FOOuwK05ohx/qzoAjWcTT1vv4k3c7uJsGZVaFSuFUh5
         Kk/su6YIaOGq2N4C8FmMM/Qd1erNIisJCv4EV7mE8kE5oxR1GfNU1whoVCcFacWNMSKR
         Ilnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qFJeQp9yLjeo1LueV7R117p7wDlHHRU//0IndFc0hb8=;
        b=IxzEli0KTQ7Ay1m80hRZQnOccQ1ckLcNgpSjGe/iv6t4uQVPkoCQHUNuMCT2pTAE0e
         Dt8S1peXlX8aoLAsOr3+3HZ64Hh7lSqJCJxkG8cV+lFecYtu3ZRq63M+00vWswolv+4R
         C4ZxVZGC4Bb7nnwFlznj5iG/Rr7L/QDkodjtvsXQ9Zqkei5cl+VR5dDoMOXR6IXjqoem
         G13EaAfv6ea4VDWimk4jh016XDN1gtblwyCETa3upE64qqcpN6/atjMaOZLeckD7H2eu
         k/B6/PI2L40o0jVOzkSw7xZL3fFPh5gTDpgQ+FgkNlNTkJIwMlxTObttkO/4Pl9zw80l
         sjUQ==
X-Gm-Message-State: AOAM530hp7/GtbxMNfY31SEPVw7HiFSxOOBSfMICc8kwbqNvURk0RN8V
        cVZm8clp6BTZCWoxHp2dzdo=
X-Google-Smtp-Source: ABdhPJwBJbMI6eG3Zk4rR1nbOO4ynRMu74+qWIZ98Od3aHrrqqWDlb4lLAaubRaQOXRVX3bkdc3weg==
X-Received: by 2002:a05:6214:851:: with SMTP id dg17mr2964534qvb.235.1594883846364;
        Thu, 16 Jul 2020 00:17:26 -0700 (PDT)
Received: from LeoBras.ibmuc.com (200-236-239-31.dynamic.desktop.com.br. [200.236.239.31])
        by smtp.gmail.com with ESMTPSA id a5sm6637989qtd.84.2020.07.16.00.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 00:17:25 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leobras.c@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] Remove default DMA window before creating DDW
Date:   Thu, 16 Jul 2020 04:16:52 -0300
Message-Id: <20200716071658.467820-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some devices in which a hypervisor may only allow 1 DMA window
to exist at a time, and in those cases, a DDW is never created to them,
since the default DMA window keeps using this resource.

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

Patch #5 moves the part of iommu_table_free() that does struct iommu_table
cleaning into iommu_table_clean, so we can invoke it separately in
patch #6.

Patch #6:
Instead of destroying the created DDW if it doesn't map the whole
partition, make use of it instead of the default DMA window as it improves
performance. Also, update the iommu_table and re-generate the pools.

Patch #7:
Does some renaming of 'direct window' to 'dma window', given the DDW
created can now be also used in indirect mapping if direct mapping is not
available.

All patches were tested into an LPAR with an Ethernet VF:
4005:01:00.0 Ethernet controller: Mellanox Technologies MT27700 Family
[ConnectX-4 Virtual Function]

Patch #6 It was tested with a 64GB DDW which did not map the whole
partition (128G). Performance improvement noticed by using the DDW instead
of the default DMA window:

64 thread write throughput: +203.0%
64 thread read throughput: +17.5%
1 thread write throughput: +20.5%
1 thread read throughput: +3.43%
Average write latency: -23.0%
Average read latency:  -2.26%

---
Changes since v3:
- Introduces new patch #5, to prepare for an important change in #6
- struct iommu_table was not being updated, so include a way to do this
  in patch #6.
- Improved patch #4 based in a suggestion from Alexey, to make code
  more easily understandable
- v3 link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=187348&state=%2A&archive=both

Changes since v2:
- Change the way ibm,ddw-extensions is accessed, using a proper function
  instead of doing this inline everytime it's used.
- Remove previous patch #6, as it doesn't look like it would be useful.
- Add new patch, for changing names from direct* to dma*, as indirect 
  mapping can be used from now on.
- Fix some typos, corrects some define usage.
- v2 link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=185433&state=%2A&archive=both

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
- v1 link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=184420&state=%2A&archive=both

Special thanks for Alexey Kardashevskiy, Brian King and
Oliver O'Halloran for the feedback provided!


Leonardo Bras (7):
  powerpc/pseries/iommu: Create defines for operations in
    ibm,ddw-applicable
  powerpc/pseries/iommu: Update call to ibm,query-pe-dma-windows
  powerpc/pseries/iommu: Move window-removing part of remove_ddw into
    remove_dma_window
  powerpc/pseries/iommu: Remove default DMA window before creating DDW
  powerpc/iommu: Move iommu_table cleaning routine to iommu_table_clean
  powerpc/pseries/iommu: Make use of DDW even if it does not map the
    partition
  powerpc/pseries/iommu: Rename "direct window" to "dma window"

 arch/powerpc/include/asm/iommu.h       |   3 +
 arch/powerpc/kernel/iommu.c            |  45 ++-
 arch/powerpc/platforms/pseries/iommu.c | 380 ++++++++++++++++++-------
 3 files changed, 313 insertions(+), 115 deletions(-)

-- 
2.25.4

