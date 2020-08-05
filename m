Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5F1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63399206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sks840nK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgHEDFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 23:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHEDFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:05:06 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0E7C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 20:05:06 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id h7so40444913qkk.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 20:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WtXwfpDFreDLwGVsqvsaCTe1LWZg8pmE0dEw2EJKlf0=;
        b=Sks840nKMOrcyH24HC/3BAqdEuA0rkgkLlLBy5HCVvWfWag5qxd5TGH/DvTp+PFCjw
         TDBw61DiWcwU+p836z/cGcL9YceKYcS4k1CTd53ub09Z/GoAK5EVqi9k3OhwazvppyF9
         J4DARGGWfSBmMO3XEe9ksbYWt1v54qBzzTpHj6Rr/GneGlr+eBJxs3m80oXTkHuxorF2
         1jIfhcAIz/87HGHJ4trc7lrQ628DxOziEZ6DAlyGHqEMo4AqMyS36fCkUqg46nyxava1
         Aa8WDFVGb0n0RA3v/jt5/kZ3vWFIPHEzT7Ysw7rgeR4fB3ZtL2OrI3/zhm3wWNqpeb2w
         gy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WtXwfpDFreDLwGVsqvsaCTe1LWZg8pmE0dEw2EJKlf0=;
        b=N74fQ3bQ0MMuf+KOFQQ/k/L087CojQq/kOrra9Mw4i4t8J2WUrbZckMZ7RX6NbYM/1
         GtB/cy4E7jhM2UbYDMNg5JO8Y7D2lZb3Jjoie/2omWxHr7ShjB6hjYEtgGNf2iPw7T01
         TQHHyZ5jbICoZhWI9wEH+Wt0y88qE3m+89jNno0DT0dIsPL9HKqJ5nRpWPTH+B4/jvp3
         jjWMmXE21J2DrIv32ibqxf1+8SjuqJ1hYtQkC+NRA0p6/jZLoY1fhknpOm/beoLxUV4I
         BoCQ4wsgEq1b90zQVHFdAtsa2pQqWEt6O8WmJgYeA2gzQstPA8fKRaN1Jcu6CIg5JCIJ
         cmzg==
X-Gm-Message-State: AOAM531H66yQgyrtfsO+BwvPWTYxRCmKOeFHAG+2/pEwInyUc9Cn2MDn
        6EHmjjwIjaOueebggNVpU7E=
X-Google-Smtp-Source: ABdhPJz/t43SflkR0lrII1YXGkv4uIywPsyddfdoGsBWxixbEQtoh7SeuFc8DYVpx9PqQcHow7FN4g==
X-Received: by 2002:a05:620a:1436:: with SMTP id k22mr1333392qkj.308.1596596705317;
        Tue, 04 Aug 2020 20:05:05 -0700 (PDT)
Received: from LeoBras.ibmuc.com (179-125-154-168.dynamic.desktop.com.br. [179.125.154.168])
        by smtp.gmail.com with ESMTPSA id n4sm869946qtr.73.2020.08.04.20.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 20:05:04 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] Allow bigger 64bit window by removing default DMA window
Date:   Wed,  5 Aug 2020 00:04:51 -0300
Message-Id: <20200805030455.123024-1-leobras.c@gmail.com>
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

---
Changes since v4:
- Removed patches 5+ in order to deal with a feature at a time
- Remove unnecessary parentesis in patch #4
- Changed patch #4 title from 
  "Remove default DMA window before creating DDW"
- Included David Dai tested-by
- v4 link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=190051&state=%2A&archive=both

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


Leonardo Bras (4):
  powerpc/pseries/iommu: Create defines for operations in
    ibm,ddw-applicable
  powerpc/pseries/iommu: Update call to ibm,query-pe-dma-windows
  powerpc/pseries/iommu: Move window-removing part of remove_ddw into
    remove_dma_window
  powerpc/pseries/iommu: Allow bigger 64bit window by removing default
    DMA window

 arch/powerpc/platforms/pseries/iommu.c | 242 ++++++++++++++++++++-----
 1 file changed, 195 insertions(+), 47 deletions(-)

-- 
2.25.4

