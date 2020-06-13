Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7740C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 07:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926FD20739
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 07:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgFMH2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 03:28:10 -0400
Received: from relay-2.mailobj.net ([213.182.54.5]:53868 "EHLO
        relay-2.mailobj.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgFMH2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 03:28:08 -0400
Received: from v-1.localdomain (v-1.in.mailobj.net [192.168.90.191])
        by relay-2.mailobj.net (Postfix) with SMTP id 7782612F5;
        Sat, 13 Jun 2020 09:28:06 +0200 (CEST)
Received: by ip-25.net-c.com [213.182.54.25] with ESMTP
        Sat, 13 Jun 2020 09:29:01 +0200 (CEST)
X-EA-Auth: l5PGjICbplBVFZcRa5FKA2zra6KgVtI3bKKlzxVI4zWQmjSg40+RR3Y7KSoqMunuUU5MCzo2jPXSnQAq/d8vl53sNJi8as1PHh4Ozu9DOYM=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     sboyd@kernel.org
Cc:     konradybcio@gmail.com, Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Add SMD RPM support for MSM8936
Date:   Sat, 13 Jun 2020 09:27:41 +0200
Message-Id: <20200613072745.1249003-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v3:
- added my missing Signed-off-by to patch 3

changes since v2:
- fixed build error by adding forgotten qcom,rpmcc.h changes in patch 1

changes since v1:
- added a forgotten patch that adds the compat string to the driver

Konrad Dybcio (1):
  drivers: soc: Add MSM8936 SMD RPM compatible

Vincent Knecht (3):
  clk: qcom: smd: Add support for MSM8936 rpm clocks
  dt-bindings: clock: rpmcc: Document MSM8936 compatible
  dt-bindings: soc: qcom: Document MSM8936 SMD RPM

 .../devicetree/bindings/clock/qcom,rpmcc.txt  |  1 +
 .../bindings/soc/qcom/qcom,smd-rpm.txt        |  1 +
 drivers/clk/qcom/clk-smd-rpm.c                | 50 +++++++++++++++++++
 drivers/soc/qcom/smd-rpm.c                    |  1 +
 include/dt-bindings/clock/qcom,rpmcc.h        |  2 +
 5 files changed, 55 insertions(+)

-- 
2.25.4


