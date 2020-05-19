Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A278C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A796207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHq0swLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgESSUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESSUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:20:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE6BC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:20:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k19so223934pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tweaTiRjNAlBbJQOd2LW81zPO4VwEBmw+s1bm5RU2eU=;
        b=vHq0swLh3ABD8frFY+Q+x4NSOGVByP2eneaj1MaHs/gOWHnrtLDjDI+f1gQefr0YLK
         H8UsD5ubiyEhndkgLM10NpfpZCtap+ir7DE5Osjs+0VCavZ2LjY1ycsHaBrtXeX4EwQg
         F8pEEDFuQmgKsdwhv7zaaQ1adwxVcEIeYilLCSMXNvXViMXtdQefRbLNEzyRZOj/6rip
         u0/U54xMJ6D/yFYQP0IBCcfi8VwjOkr02wk29LfUC+SwPTImJ/jEwAv5anGiXZ+prS6V
         6jTX0/KlcimopFZncKG1q9rs8bq2ec9T3UryTZ6MxUHXoK1MTjuqxhSQEeFBDAVaepLx
         S66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tweaTiRjNAlBbJQOd2LW81zPO4VwEBmw+s1bm5RU2eU=;
        b=GdbD8wnZ0gD4j9SIQAL/5BkAskZuIlN7nkGEXsv1dIlN2kI32/K6/6HvUJRIuwYDPy
         RtwXs7kEbV085uTnpQ267PlQmwgLyqzJm5hT+C9PEB/OrfK/VeZrQ9YkXX9F1y+Bp1b2
         JwQ2IdiHBzc+7WfqMgyo4qGe02k9x5SnaQJtlDZQ/L+srkI0LxrWZdJqv3M2YO1CeeNv
         4hdT8CktP5zzCZ/9cVtG4A8qzuLzo/Cz3YnEOVVheLNh2QZ3La/X7s5PhlKVTUo96qPz
         ei4PeOq8eBRrWwzC00R2ALA46faAUmqBiyejNpb388iHrziBPU8xvRKfS/KnL5luvxad
         UMrA==
X-Gm-Message-State: AOAM533fyZm9akZBct1iLd2vUuGJ+j5o6f2D5vf0iIlBJ3+PBThCKE/f
        da/Em4dEGTmjm60kEoZ4Atg=
X-Google-Smtp-Source: ABdhPJyx5zytVaBkGF0VlwfL0XvKFiqFmUUAxNpAKbtFa5W/8VkVNNuk72lYjfO4ELheovvj/LX0jA==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr697128plb.235.1589912413949;
        Tue, 19 May 2020 11:20:13 -0700 (PDT)
Received: from localhost.localdomain ([223.235.145.232])
        by smtp.gmail.com with ESMTPSA id p2sm148399pgh.25.2020.05.19.11.19.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 11:20:13 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, robh+dt@kernel.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v2 00/10] Add MMC and DMA support for Actions S700
Date:   Tue, 19 May 2020 23:49:18 +0530
Message-Id: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series(v2) addressed the review comments provided by Andre, and
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

----------------------------------------------------------------------

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
  arm64: dts: actions: do not merge disable sps node from S700
  dt-bindings: dmaengine: convert Actions Semi Owl SoCs bindings to yaml
  arm64: dts: actions: Add DMA Controller for S700
  dt-bindings: reset: s700: Add binding constants for mmc
  dt-bindings: mmc: owl: add compatible string actions,s700-mmc
  arm64: dts: actions: Add MMC controller support for S700
  arm64: dts: actions: Add uSD support for Cubieboard7

 Documentation/devicetree/bindings/dma/owl-dma.txt  |  47 --------
 Documentation/devicetree/bindings/dma/owl-dma.yaml |  76 +++++++++++++
 Documentation/devicetree/bindings/mmc/owl-mmc.yaml |   6 +-
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts   |  41 +++++++
 arch/arm64/boot/dts/actions/s700.dtsi              |  48 ++++++++
 drivers/clk/actions/owl-s700.c                     |   3 +
 drivers/dma/owl-dma.c                              | 126 ++++++++++++---------
 include/dt-bindings/reset/actions,s700-reset.h     |   3 +
 8 files changed, 251 insertions(+), 99 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.yaml

-- 
2.7.4

