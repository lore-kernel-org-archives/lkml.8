Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D237C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216FB20B1F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ8btFU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgGSRme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:42:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4E1C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 10:42:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x9so7633332plr.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+itGL+wkOYuB6Tm6ltx3pOu6ONhkEl6XVNHndNYsqLk=;
        b=lJ8btFU7V0AVT8sgEVuThveMF+v6thXOww5DvlSwjiRTtgnRRZhM0RXqYMFuwxzeK9
         E5g+VvlXKj2iWQYhshU7hyljkn6mQeKS7VIrwPklQb7xhv9T4WQ0f5lgf10u2Y/oqqZs
         tP/fpucRYm2Ph3qWZSr3SwpTGJJzfRtFEqjXQOpXx58N9N/wDjM56J1ZF4G2dxIqzj5n
         cjZ0/tciJJR3YW355wgexUCr3b6sK/93Y7xgDnYtR6c8K2ovON4fHu2hTw+665dOPdvm
         QmZsP6y5IB26fTmI+j03TpImQ0H2fIWW9APH6y/q/UzXIjTcln5u2FvG5caf7JmF1QZK
         zHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+itGL+wkOYuB6Tm6ltx3pOu6ONhkEl6XVNHndNYsqLk=;
        b=MOABDAPrIdJS/UQ1EwLHbGNo7zRGpCUxIKLf6mOu/H/xfJ9iVt4XOrRux2ISxPZ5rP
         Pktwj1M8JPMamNUENcwLnZXUK1chSsqssuvUoYDmtuG9rRkNSfD8pK7WFtovZg1U1rj5
         BoCglq8o7vK6nWVytu42GIwBhxrRFab/w5F9bvO6+/D/ARY6obklsUpMeYDLZPca2LQC
         85gafiyKhtna0DphBD5XlSwxWwbhQZoQFW2zg9MI9lf6ALl5V6jhFQgGu0yuoF0ckyhC
         WfKICGBxXWygsa1dqba+NFIn+yKx3z+VBtvcVsURIyqyxVXX3/JaUqnXE3TKRSecp7Cu
         B6CQ==
X-Gm-Message-State: AOAM532dmed1BaQ+wEZniErgCPt3V+nM+BtktosWqDLnq+2onwX48ufd
        JrZcplfxy6XIPYegEoOMJ18=
X-Google-Smtp-Source: ABdhPJy0LDm8NcxAUyqU74zNmxMNY2ZAl5rukdnA2lo+16dOEoRv9MW7/C950cYLXt4l/qK12zcwpw==
X-Received: by 2002:a17:902:22:: with SMTP id 31mr13836321pla.120.1595180552653;
        Sun, 19 Jul 2020 10:42:32 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id e191sm13906083pfh.42.2020.07.19.10.42.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 10:42:31 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, robh+dt@kernel.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v7 00/10] Add MMC and DMA support for Actions S700
Date:   Sun, 19 Jul 2020 23:11:57 +0530
Message-Id: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Series(v7) brought back the uSD regulator to model it correctly
in DT, and for that patch 10/10 has changed.

------------------------------------------------------------------

Series(v6) addressed the review comments from Rob and Mani,
changes are made in patch 01/10 and 10/10.

Rob's bot reported an error for patch 01/10, and now it has been
fixed by adjusting the reg property in example section.

For patch 10/10 unnecessary regulators are removed as suggested by
Mani. 

Serie is rebased on top of:
https://github.com/torvalds/linux/commit/6a70f89cc58f2368efa055cbcbd8b37384f6c588

--------------------------------------------------------------------

Series(v5) addressed the review comments provided by Vinod, and
patch 05/10 is moved to 01/10 so that documentation patch comes before
driver.

Apart from it, changes are made in patch 03/10(earlier it was 02/10)
to replace of_match_device() with of_device_get_match_data() and
removed uintptr_t from type-cast.

This Series is rebased on top of 5.8.0-rc3.

---------------------------------------------------------------------

Series(v4) addressed the review comments provided by Mani, and
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
  dt-bindings: dmaengine: convert Actions Semi Owl SoCs bindings to yaml
  dmaengine: Actions: get rid of bit fields from dma descriptor
  dmaengine: Actions: Add support for S700 DMA engine
  clk: actions: Add MMC clock-register reset bits
  arm64: dts: actions: limit address range for pinctrl node
  arm64: dts: actions: Add DMA Controller for S700
  dt-bindings: reset: s700: Add binding constants for mmc
  dt-bindings: mmc: owl: add compatible string actions,s700-mmc
  arm64: dts: actions: Add MMC controller support for S700
  arm64: dts: actions: Add uSD support for Cubieboard7

 Documentation/devicetree/bindings/dma/owl-dma.txt  |  47 -------
 Documentation/devicetree/bindings/dma/owl-dma.yaml |  79 ++++++++++++
 Documentation/devicetree/bindings/mmc/owl-mmc.yaml |   6 +-
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts   |  33 +++++
 arch/arm64/boot/dts/actions/s700.dtsi              |  51 +++++++-
 drivers/clk/actions/owl-s700.c                     |   3 +
 drivers/dma/owl-dma.c                              | 139 +++++++++++++--------
 include/dt-bindings/reset/actions,s700-reset.h     |   3 +
 8 files changed, 263 insertions(+), 98 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.yaml

-- 
2.7.4

