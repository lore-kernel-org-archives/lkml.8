Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EE5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2467C204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr0uDiyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgGCGT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCGT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:19:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B297C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 23:19:59 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 145so25447521qke.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ipG8Wvdoswo12xcPBeUZhRuWbO2g2i+40JGa2nl6B0=;
        b=dr0uDiygWjBbqnu1Q53uV+f3xqqdHMU7fWR29zw5TUvYu9L3hTUvm52ivGyLliRbjY
         menDanhKwPclJjCTwO1SQfLZsO2U9+/r3YCw0G76UjKat7SOO/vGW4Ds9fu3blFdnY3b
         tCCyES/xV6tx/yknpAZ/Tb7Z6xWjBzg4AQZJWmfxKGi6Fr6Q31zqQlBEYbOBfvU/vLr1
         wmY7nWWU4fkaBAJDDZREtHd/z2cctYDmH3G/u78v6JV8hKxOsF92tJzoiv89Qb+998HE
         4Nr+GlLBZsIb7fJg1vupXxu7sAaKumkZhLaUFfkiO2CJXIznOmxh9a1vjPDd6ae+K63i
         LbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ipG8Wvdoswo12xcPBeUZhRuWbO2g2i+40JGa2nl6B0=;
        b=Yg+d0RNG7E+PhPuz3MueJYUFGRkxb2GijTjIgrTks0dpNKV8XFLBUUDoSRgp5Dy6C3
         7QSuPND7dhHtDH1r2HWyzifJwth11qfjWCsPMGvfTcahJxGvdF8RzhtXSY5mlSKnfcS1
         05IYJhhz5jEdB4XQ9gewuEJy8WQnGe84hIZRIb4aTYAtr+zWVgA0kFTsZ4VcxKDQ+Rrk
         xppdaR/kr67jUgtjOdw8xa/yayDhazT2Tg4WLqpUleOzPWnC3EWgse4jhWftODPVfd4C
         4XD5a99uAdA6XEhlr1ms5WsqLOAIJApoPHPyv+aghV1t8So0jDz9fRe47p5f7PKozlKI
         /s9A==
X-Gm-Message-State: AOAM5316kH7qEqqiPeS5ZF+YYhB3zTxEh7GjdUqfs2DU4UfKE7oX52pb
        KrZIaP+t5ButUCtNAQhdJRg=
X-Google-Smtp-Source: ABdhPJyXAUaE61WsZ85TdM9+F6OZdXjlQqx8bfvPxxKNw0pG0HD5OBhQ3LXRob57n0NFmyqIuBR9uA==
X-Received: by 2002:a37:a753:: with SMTP id q80mr21736050qke.461.1593757198278;
        Thu, 02 Jul 2020 23:19:58 -0700 (PDT)
Received: from LeoBras.ibmuc.com (200-236-245-17.dynamic.desktop.com.br. [200.236.245.17])
        by smtp.gmail.com with ESMTPSA id n28sm11165288qtf.8.2020.07.02.23.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 23:19:57 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Leonardo Bras <leobras.c@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] Remove default DMA window before creating DDW
Date:   Fri,  3 Jul 2020 03:18:38 -0300
Message-Id: <20200703061844.111865-1-leobras.c@gmail.com>
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

Patch #5:
Instead of destroying the created DDW if it doesn't map the whole
partition, make use of it instead of the default DMA window as it improves
performance.

Patch #6:
Does some renaming of 'direct window' to 'dma window', given the DDW
created can now be also used in indirect mapping if direct mapping is not
available.

All patches were tested into an LPAR with an Ethernet VF:
4005:01:00.0 Ethernet controller: Mellanox Technologies MT27700 Family
[ConnectX-4 Virtual Function]

Patch #5 It was tested with a 64GB DDW which did not map the whole
partition (128G). Performance improvement noticed by using the DDW instead
of the default DMA window:

64 thread write throughput: +203.0%
64 thread read throughput: +17.5%
1 thread write throughput: +20.5%
1 thread read throughput: +3.43%
Average write latency: -23.0%
Average read latency:  -2.26%

---
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
  powerpc/pseries/iommu: Rename "direct window" to "dma window"

 arch/powerpc/platforms/pseries/iommu.c | 379 ++++++++++++++++++-------
 1 file changed, 269 insertions(+), 110 deletions(-)

-- 
2.25.4

