Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456CFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A1CD2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4cPu1In"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgFIKRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgFIKRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:17:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7292C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 03:17:31 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh7so7849490plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 03:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ei1IGv6pNwnI9iIwQsOj4cyb+NLYlzCDt9t3fzNXihA=;
        b=O4cPu1InWo4NtiyXgCv23ITCJpj3TORJbVbdZSIHXfmdXHml6gKL0VVIPvzLJlfmKZ
         6/RV+AEglhUuM96qYTMjvD3yS2czFsqnHd8KeXekZhpyqUxCOFJ6kw30Cc4SuaRdORHo
         gWPkJPqRiKQ5YAF8ShxHq5PK42j2LhyX7U6/QLiSfuewczEzTJUJZkjwvOWRqCmwLMqy
         WeftOIFyIsqMTb+sHvRXqKEYQWIQKTS8jzR41Eh9Mq4ZD6vkoTnEbEz12W+Q4MxEdMN5
         3sGsZlLcRJLOhn3QOYNClbGmlIG4olIUl8f+P85yH9ZRNxYWPg0WsdcHPMCo2uQQKwmJ
         Ttaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ei1IGv6pNwnI9iIwQsOj4cyb+NLYlzCDt9t3fzNXihA=;
        b=myMJ4x0WyXnxMGyOy9iFCr02NMUVQXukyz9FX+PX0ySW6YDy0kLILFcIK+iXIVgC82
         7g98G37R73ivAnkWrxnS5Z0CAEF9tJ10ZyOinOCGy94Dejg/p/uxvUR9OnLnqzC9oB0J
         N2WwAXgqxDftjVPEijy8EVOnaofI8f8/ayodVbdbrnKcFuMpykeGcI0j9xfd4/Y1lVGF
         GOMePPfJL8Fh42uZvhvH4UOa27UpZDXyx/mplqu5vwMAY3jMjRmyEILFuXFhqDyAZMgb
         CjIT/YmSkjaOFHgA2FxNpg3kuqGt0PsC76kR+sHW7BJEKuUY12AsmxJc4KpsE3/pzVdh
         qBuA==
X-Gm-Message-State: AOAM5330IyN/xoXKFhN/N8lILqZajAT275ITZUhWww5VLt9MFSXZ7dZa
        EE/GFUewCY/GkqjrTgJcxBM=
X-Google-Smtp-Source: ABdhPJxTxmMeCrekRie5MkDXGUvT9tCDia/+KW38/+b4ExBhXJR+wd43UV8lMWr60l/N4S32o2OpFw==
X-Received: by 2002:a17:902:558f:: with SMTP id g15mr2635828pli.174.1591697851144;
        Tue, 09 Jun 2020 03:17:31 -0700 (PDT)
Received: from localhost.localdomain ([223.190.87.90])
        by smtp.gmail.com with ESMTPSA id d189sm9637253pfc.51.2020.06.09.03.17.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 03:17:30 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, robh+dt@kernel.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v4 00/10] Add MMC and DMA support for Actions S700
Date:   Tue,  9 Jun 2020 15:47:00 +0530
Message-Id: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series(v4) addressed the review comments provided by Mani, and
there are changes in patch 1/10, 2/10 and 6/10 for it.

For first couple of patches , old comments are preserved and more
details about how DMA descriptors fields are programmed is added.

Apart from it, Typo is fixed patch 6/10 and placed the header file
in alphabetical order.

Also, this series fixes one compilation warning (reported by Kbuild)
introduced by patch 2/10 using clang compiler.
------------------------------------------------------------------------

Series(v3) addressed the review comments provided by Rob, and 
there are changes in patch 5/10 for it.

Also, one of the important change for this series(v3) is about the way we 
we handle address range conflict between pinctrl and sps node.

In the last Series(v2), patch 4/10 was sent as *do not merge* but while
discussing about some proper solution for it, we have come up with
idea of limiting pinctrl address range(to 0x100) to avoid this conflict.
This is safe to do as current pinctrl driver uses address range only
up to 0x100 (even less than that?), and this would let sps to work properly.

Since sps block is now enabled , we have to provide power-domain bit
for dma to work properly and patch 6/10 has that change now.

Looking forward have some comments for this series.

---------------------------------------------------------------------------

Series(v2) addressed the review comments provided by Andre, and
there are changes in patch 1/10, 2/10, 5/10 and 9/10.

* Accessor function (to get the frame lenght) has moved from
  patch 2/9 to patch 1/9 with inline removed.
* Removed the unnecessary line break.
* Added comments about the way DMA descriptor differs between S700
  and S900.
* Added a macro to define fcnt value.
* Updated dma DT bindings.
* Used SoC secific compatible string for MMC.

Apart from it, a new patch 8/10 is added in this series to
update mmc DT bindings.

Series is rebased on 5.7.0-rc6.

-----------------------------------------------------------------------------

Series(v1) have following changes from the previous series.

New patch(5/8) has been introduced that converts dma dt-binding
for Actions OWL SoC from text format to yaml file.

For patch(2/8) new accessor function is added to get the frame
lenght which is common to both S900 and S700. Apart from it
SoC check is removed from irq routine as it is not needed.

Patch(4/8) which is an hack to prove our DMA and MMC works
for S700 is now sent as *do not merge* patch.
 
DMA is tested using dmatest with follwoing result:

root@ubuntu:~# echo dma0chan1 > /sys/module/dmatest/parameters/channel
root@ubuntu:~# echo 2000 > /sys/module/dmatest/parameters/timeout
root@ubuntu:~# echo 1 > /sys/module/dmatest/parameters/iterations
root@ubuntu:~# echo 1 > /sys/module/dmatest/parameters/run

root@ubuntu:~# dmesg | tail
[  303.362586] dmatest: Added 1 threads using dma0chan1
[  317.258658] dmatest: Started 1 threads using dma0chan1
[  317.259397] dmatest: dma0chan1-copy0: summary 1 tests, 0 failures 16129.03 iops 32258 KB/s (0)

-------------------------------------------------------------------------------

The intention of RFC series is to enable uSD and DMA support for
Cubieboard7 based on Actions S700 SoC, and on the way we found that
it requires changes in dmaengine present on S700 as its different
from what is present on S900.

Patch(1/8) does provide a new way to describe DMA descriptor, idea is
to remove the bit-fields as its less maintainable. It is only build
tested and it would be great if this can be tested on S900 based
hardware.

Patch(2/8) adds S700 DMA engine support, there is new compatible
string added for it, which means a changed bindings needed to submitted
for this. I would plan to send it later the converted "owl-dma.yaml".

Patch(4/8) disables the sps node as its memory range is conflicting
pinctrl node and results in pinctrl proble failure.

Rest of patches in the series adds DMA/MMC nodes for S700
alone with binding constants and enables the uSD for Cubieboard7.

This whole series is tested, by building/compiling Kernel on
Cubieboard7-lite which was *almost* successful (OOM kicked in,
while Linking due to less RAM present on hardware).

Following is the mmc speed :

ubuntu@ubuntu:~$ sudo hdparm -tT /dev/mmcblk0

/dev/mmcblk0:
 Timing cached reads:   1310 MB in  2.00 seconds = 655.15 MB/sec
 Timing buffered disk reads:  62 MB in  3.05 seconds =  20.30 MB/sec

Amit Singh Tomar (10):
  dmaengine: Actions: get rid of bit fields from dma descriptor
  dmaengine: Actions: Add support for S700 DMA engine
  clk: actions: Add MMC clock-register reset bits
  arm64: dts: actions: limit address range for pinctrl node
  dt-bindings: dmaengine: convert Actions Semi Owl SoCs bindings to yaml
  arm64: dts: actions: Add DMA Controller for S700
  dt-bindings: reset: s700: Add binding constants for mmc
  dt-bindings: mmc: owl: add compatible string actions,s700-mmc
  arm64: dts: actions: Add MMC controller support for S700
  arm64: dts: actions: Add uSD support for Cubieboard7

 Documentation/devicetree/bindings/dma/owl-dma.txt  |  47 -------
 Documentation/devicetree/bindings/dma/owl-dma.yaml |  79 ++++++++++++
 Documentation/devicetree/bindings/mmc/owl-mmc.yaml |   6 +-
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts   |  41 ++++++
 arch/arm64/boot/dts/actions/s700.dtsi              |  51 +++++++-
 drivers/clk/actions/owl-s700.c                     |   3 +
 drivers/dma/owl-dma.c                              | 142 ++++++++++++++-------
 include/dt-bindings/reset/actions,s700-reset.h     |   3 +
 8 files changed, 274 insertions(+), 98 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.yaml

-- 
2.7.4

