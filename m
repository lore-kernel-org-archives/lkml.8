Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4568C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE51B206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4cMg89y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgELMxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727859AbgELMxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:53:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADD8C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:53:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h17so6341957wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ku6Mk/Al7SQIBJBCIdteQf7kevlDKUx0+YkyJTe4la0=;
        b=D4cMg89ykEUGNXqfHTzDCR6YYBvlCtdWKW71BwUd9HbOBSs52YRFWqdhvUGzGF9Gvn
         wNo8RV13CCExoSnw3n2UYWEXPT9AeZHbf933b3b6h1E41s4D3QJDC448C8vinsHTuyah
         XZBbvAge8YIXBuIo8+dXz3SenVIcAZQxnPfCAZQu+RPMtCxTpxPiBsxuJV0IRbYWRXoj
         hwYz1eZG3Ji2W1jUUaCXZqNC0IcSVwSrJfPgJLzz03hTJpI+FmnHxPOEXCG1RtvaKCQn
         tkOw2+BPIc/e9uTR72LvOM6HwKe0lxvuZUhw7V27lzSrKveofBCK25bVPNeETgZYEtnX
         oqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ku6Mk/Al7SQIBJBCIdteQf7kevlDKUx0+YkyJTe4la0=;
        b=DI/nraHgfQNv67bVgOIr6rVIhKnZy+8nSwqpfkzfPA3Wud2IyX/nSRD33Ub9OFkIP3
         cvvuRg96vszaQpXgQ4aswpxuNqfrb5KbJwARUoKVZfb1XIghdgahkEBm89zv/Fw3T87U
         RBi4eERVZbDgq78EorEaP5EDY7K26vUctqrRoW6wcfX0R11Lx6ne9amDto5rBlcpBwoG
         ceQO7J0hhoqrLL+cmp63o3680MYltXCpU5UK1eOPhax1aHup/kNeRVkxZwyEX+c2mAqL
         0St5f0BrNh1ylOoWktug2xVWYFwFNsS0knlcPpL6eM/o8ytPZCkZDx6dUH8aDbr0/qRe
         lhgA==
X-Gm-Message-State: AGi0PuZoe5MctgwFUeU75YUnP0epF1V+HwKmXsMAbvwz+ZGwYrHjJdt7
        bujK77VDZtm7rHSH0y/rbfD+aw==
X-Google-Smtp-Source: APiQypL9YPc4HLVRC80LEbJoBfHK6TzF23U0aO/nzu0F2Fpj+PFOPai5gAhMv1nNLBXsftpFUnQjTA==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr26774429wrd.394.1589288031506;
        Tue, 12 May 2020 05:53:51 -0700 (PDT)
Received: from localhost.localdomain (212-39-89-66.ip.btc-net.bg. [212.39.89.66])
        by smtp.googlemail.com with ESMTPSA id n13sm2433938wrs.2.2020.05.12.05.53.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 05:53:50 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org
Cc:     robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v8 00/10] Introduce OPP bandwidth bindings
Date:   Tue, 12 May 2020 15:53:17 +0300
Message-Id: <20200512125327.1868-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a proposal to extend the OPP bindings with bandwidth based on
a few previous discussions [1] and patchsets from me [2][3] and Saravana
[4][5][6][7][8][9].

Changes in v8:
* Addressed review comments from Matthias, Sibi and Viresh.
* Picked reviewed-by tags.
* Picked Sibi's interconnect-tag patches into this patchset.

Changes in v7: https://lore.kernel.org/r/20200424155404.10746-1-georgi.djakov@linaro.org
* This version is combination of both patchsets by Saravana and me, based
on [3] and [9].
* The latest version of DT bindings from Saravana is used here, with a
minor change of using arrays instead of single integers for opp-peak-kBps
and opp-avg-kBps. This is needed to support multiple interconnect paths.
* The concept of having multiple OPP tables per device has been dropped,
as it was nacked by Viresh.
* Various reviews comments have been addressed and some patches are
split, and there are also some new patches. Thanks to Viresh, Sibi and
others for providing feedback!

With this version of the patchset, the CPU/GPU to DDR bandwidth scaling
will look like this in DT:

One interconnect path (no change from Saravana's v6 patches):

cpu@0 {
	operating-points-v2 = <&cpu_opp_table>;
	interconnects = <&noc1 MASTER1 &noc2 SLAVE1>,
};

cpu_opp_table: cpu_opp_table {
	compatible = "operating-points-v2";

	opp-800000000 {
		opp-hz = /bits/ 64 <800000000>;
		opp-peak-kBps = <1525000>;
		opp-avg-kBps = <457000>;
	};

	opp-998400000 {
		opp-hz = /bits/ 64 <998400000>;
		opp-peak-kBps = <7614000>;
		opp-avg-kBps = <2284000>;
	};
};

Two interconnect paths:

cpu@0 {
	operating-points-v2 = <&cpu_opp_table>;
	interconnects = <&noc1 MASTER1 &noc2 SLAVE1>,
			<&noc3 MASTER2 &noc4 SLAVE2>;
};

cpu_opp_table: cpu_opp_table {
	compatible = "operating-points-v2";

	opp-800000000 {
		opp-hz = /bits/ 64 <800000000>;
		opp-peak-kBps = <1525000 2000>;
		opp-avg-kBps = <457000 1000>;
	};

	opp-998400000 {
		opp-hz = /bits/ 64 <998400000>;
		opp-peak-kBps = <7614000 4000>;
		opp-avg-kBps = <2284000 2000>;
	};
};

------

Every functional block on a SoC can contribute to the system power
efficiency by expressing its own bandwidth needs (to memory or other SoC
modules). This will allow the system to save power when high throughput
is not required (and also provide maximum throughput when needed).

There are at least three ways for a device to determine its bandwidth
needs:
	1. The device can dynamically calculate the needed bandwidth
based on some known variable. For example: UART (baud rate), I2C (fast
mode, high-speed mode, etc), USB (specification version, data transfer
type), SDHC (SD standard, clock rate, bus-width), Video Encoder/Decoder
(video format, resolution, frame-rate)

	2. There is a hardware specific value. For example: hardware
specific constant value (e.g. for PRNG) or use-case specific value that
is hard-coded.

	3. Predefined SoC/board specific bandwidth values. For example:
CPU or GPU bandwidth is related to the current core frequency and both
bandwidth and frequency are scaled together.

This patchset is trying to address point 3 above by extending the OPP
bindings to support predefined SoC/board bandwidth values and adds
support in cpufreq-dt to scale the interconnect between the CPU and the
DDR together with frequency and voltage.

[1] https://patchwork.kernel.org/patch/10577315/
[2] https://lore.kernel.org/r/20190313090010.20534-1-georgi.djakov@linaro.org/
[3] https://lore.kernel.org/r/20190423132823.7915-1-georgi.djakov@linaro.org/
[4] https://lore.kernel.org/r/20190608044339.115026-1-saravanak@google.com
[5] https://lore.kernel.org/r/20190614041733.120807-1-saravanak@google.com
[6] https://lore.kernel.org/r/20190703011020.151615-1-saravanak@google.com
[7] https://lore.kernel.org/r/20190726231558.175130-1-saravanak@google.com
[8] https://lore.kernel.org/r/20190807223111.230846-1-saravanak@google.com
[9] https://lore.kernel.org/r/20191207002424.201796-1-saravanak@google.com

Georgi Djakov (6):
  interconnect: Add of_icc_get_by_index() helper function
  OPP: Add support for parsing interconnect bandwidth
  OPP: Add sanity checks in _read_opp_key()
  OPP: Update the bandwidth on OPP frequency changes
  cpufreq: dt: Add support for interconnect bandwidth scaling
  cpufreq: dt: Validate all interconnect paths

Saravana Kannan (2):
  dt-bindings: opp: Introduce opp-peak-kBps and opp-avg-kBps bindings
  OPP: Add helpers for reading the binding properties

Sibi Sankar (2):
  dt-bindings: interconnect: Add interconnect-tags bindings
  OPP: Add support for setting interconnect-tags

 .../bindings/interconnect/interconnect.txt    |   5 +
 Documentation/devicetree/bindings/opp/opp.txt |  17 +-
 .../devicetree/bindings/property-units.txt    |   4 +
 drivers/cpufreq/Kconfig                       |   1 +
 drivers/cpufreq/cpufreq-dt.c                  |  54 +++++
 drivers/interconnect/core.c                   |  72 +++++--
 drivers/opp/Kconfig                           |   1 +
 drivers/opp/core.c                            |  55 ++++-
 drivers/opp/of.c                              | 189 ++++++++++++++++--
 drivers/opp/opp.h                             |  10 +
 include/linux/interconnect.h                  |   6 +
 include/linux/pm_opp.h                        |  12 ++
 12 files changed, 380 insertions(+), 46 deletions(-)

