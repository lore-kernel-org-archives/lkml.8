Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD79C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 04:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050DE2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 04:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jODk7oB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgFKELM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 00:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgFKELL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 00:11:11 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F3C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 21:11:08 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y5so4783186iob.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 21:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=d94BWwXDVPdkXtU6jwE/up8ZwLrJjD6cxsvZtbmlMGA=;
        b=jODk7oB9+jT79zvz+Muy8CLOWUjh/0ShkPTXQ0l8PJuG0J+VHWmWrAXpwSVVp7Ya+S
         suNSTLMTDYXbhGIkz2UxPMr8PQb3ryOT7X/oF1VP0ubb8TRkvgz8CdiyS7J/BSwRT2jx
         ziE5681SqyhplUiYbYVrK9Tg8rOIV0hHMWINVn6wt1jY+um07eJi9e8gyDKaO28r9oT5
         1Guek3IdTW2sGVbQuUckmWFAMFbjzB4XvOY9zXXa9RjZrat386NkUgeJU6qCI2u+C0+z
         9wGisS9V84+dQMAro2bPUoLXVEOXftvOWJyH/eU+htbnHdzYpl3oFB1uq579lO/GBor8
         CxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=d94BWwXDVPdkXtU6jwE/up8ZwLrJjD6cxsvZtbmlMGA=;
        b=VJM5Z0UgHCzzsPT/PUDrIGugc2uO3PSu8xMeoMnvJkZkhkoBTmrK6T5rB/Tb6M3+rw
         Uu79YIsDTxlwv6Cl0JTtqUhVTk+NghVUo3neY1Qyg3bq+M0vaQYeWMpc3PPUBSO4cQbk
         fzZCBEphvKqVyYEBucByxSbMD9ZiybnNwJjBpJGTw1XObGjyUwQ1Z7W7OcoBiwZq+1XC
         tZqlulkqOsa40SSv0Y799DnQW1cDTeimpZfezPaDkEbPJ+lzbxYSCxiONX+RVfrvyUB1
         YxHiTPtVq8ldsHDDfpjonUUFU4mof1kAWM9dZJxToCJww0zjkelEm0hu6q5ZkSpbtDOO
         cmTA==
X-Gm-Message-State: AOAM531ZZ9iP5AjMuZJhLB/VBxKLbtrsF6lA/zZJR66JaGsEJ2dCxCIo
        QDq2jPBp29AYqu5HdqBMEiiia8lOfiV2xcBMCUw=
X-Google-Smtp-Source: ABdhPJxSTl0sf4Ad32FLL6dubPqSVn1efkHEeZGVTRot6sWQ7Tkxma+Vi8eBmWS6YGM3IHnPk7obmnpYQpQo+8o9RQU=
X-Received: by 2002:a05:6602:13c6:: with SMTP id o6mr6440972iov.84.1591848666969;
 Wed, 10 Jun 2020 21:11:06 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 10 Jun 2020 23:10:56 -0500
Message-ID: <CABb+yY1q3fTJkF0zOBJ6y8u-707-tVax9Vn_TR=vgq35=7j83Q@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit ffeb595d84811dde16a28b33d8a7cf26d51d51b3:

  Merge tag 'powerpc-5.7-6' of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
(2020-05-30 12:28:44 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.8

for you to fetch changes up to e9f901dc05c09c4f89183cadcb2d93177f3100cb:

  mailbox: qcom: Add ipq6018 apcs compatible (2020-06-10 22:43:57 -0500)

----------------------------------------------------------------
- qcom :
     new controller driver for IPCC
     reorg the of_device data
     add support for ipq6018 platform
- spreadtrum:
     new sprd controller driver
- imx:
     implement suspend/resume PM support
- Misc :
     make pcc driver struct as static
     fix return value in imx_mu_scu
     disable clock before bailout in imx probe
     remove duplicate error mssg in zynqmp probe
     fix header size in imx.scu
     check for null instead of is-err in zynqmp

----------------------------------------------------------------
Anson Huang (3):
      mailbox: imx: Support runtime PM
      mailbox: imx: Add runtime PM callback to handle MU clocks
      mailbox: imx: ONLY IPC MU needs IRQF_NO_SUSPEND flag

Baolin Wang (2):
      dt-bindings: mailbox: Add the Spreadtrum mailbox documentation
      mailbox: sprd: Add Spreadtrum mailbox driver

Dan Carpenter (1):
      mailbox: imx: Fix return in imx_mu_scu_xlate()

Dong Aisheng (1):
      mailbox: imx: Add context save/restore for suspend/resume

Fabio Estevam (1):
      mailbox: imx: Disable the clock on devm_mbox_controller_register() failure

Jason Yan (1):
      mailbox: pcc: make pcc_mbox_driver static

Manivannan Sadhasivam (3):
      dt-bindings: mailbox: Add devicetree binding for Qcom IPCC
      mailbox: Add support for Qualcomm IPCC
      MAINTAINERS: Add entry for Qualcomm IPCC driver

Markus Elfring (1):
      mailbox: ZynqMP IPI: Delete an error message in zynqmp_ipi_probe()

Peng Fan (1):
      mailbox: imx-mailbox: fix scu msg header size check

Sivaprakash Murugesan (3):
      dt-bindings: mailbox: Add YAML schemas for QCOM APCS global block
      mailbox: qcom: Add clock driver name in apcs mailbox driver data
      mailbox: qcom: Add ipq6018 apcs compatible

Wei Yongjun (1):
      mailbox: zynqmp-ipi: Fix NULL vs IS_ERR() check in zynqmp_ipi_mbox_probe()

 .../bindings/mailbox/qcom,apcs-kpss-global.txt     |  88 -----
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |  86 +++++
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |  80 +++++
 .../devicetree/bindings/mailbox/sprd-mailbox.yaml  |  60 ++++
 MAINTAINERS                                        |   8 +
 drivers/mailbox/Kconfig                            |  18 +
 drivers/mailbox/Makefile                           |   4 +
 drivers/mailbox/imx-mailbox.c                      | 117 ++++++-
 drivers/mailbox/pcc.c                              |   2 +-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |  61 +++-
 drivers/mailbox/qcom-ipcc.c                        | 286 ++++++++++++++++
 drivers/mailbox/sprd-mailbox.c                     | 361 +++++++++++++++++++++
 drivers/mailbox/zynqmp-ipi-mailbox.c               |  25 +-
 include/dt-bindings/mailbox/qcom-ipcc.h            |  33 ++
 14 files changed, 1097 insertions(+), 132 deletions(-)
 delete mode 100644
Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
 create mode 100644
Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
 create mode 100644 drivers/mailbox/qcom-ipcc.c
 create mode 100644 drivers/mailbox/sprd-mailbox.c
 create mode 100644 include/dt-bindings/mailbox/qcom-ipcc.h
