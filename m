Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB35C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F26246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 22:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDzkbR7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgB1WmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 17:42:11 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43942 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgB1WmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 17:42:11 -0500
Received: by mail-yw1-f67.google.com with SMTP id u78so127653ywf.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 14:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oMZxZrJ7Bl6W7lIllps1//BZzQUZEEMLhplq5QKAqeg=;
        b=oDzkbR7R4NzPzmaT//fTmrzHcCOKEMQHBe9r7VqhE/ldZx8JdDmCONOjnyK/uYRDKj
         mabkq79qRqJFZc3w4CK7VhFMvdD5YMSC8mnkI5sn/Z9fREwE2S8WGpbjppe0XUp9N9p4
         Q/98pdlJq28+U8ixvVWL4fZ7tL+9/Uk5F9CDtLpIaMlNeY1ncYQ26MUqRR0wSXJk5MJv
         buWtsnriVQeWjjWc5v3fj1hgaF8OToIEcqHOf38c3AEkiic8+HDTQLOvtqr8HP1WyRSS
         qACdW2pHSHnSbcR7+CS5mHA6ICpZTuA5ajDJG0+bjZE0Ru3AM2qyQ5ageuDrWXPyHhcX
         fiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oMZxZrJ7Bl6W7lIllps1//BZzQUZEEMLhplq5QKAqeg=;
        b=DtqSDuvJ79Jo6Y1kaz5vSjPnVdcwMHOQc4VLJJY+LWMNK4Dk519nMl7Z82b2l7/JCP
         G9LDexUpZDRpNtTyRPO4HcG/GzIUbmR/ZbtomfQDpnxuKSYphIomVNTyKqhOZuFxw7wl
         I45XgAhKbq5LfLMe8Ue1+yeM/0I43G0tP4XKi5q14hVbqx7twFDb0BICgeElj9JhuhS3
         zdC3gTuMTXtC2Zs9+qBAkqKeGaCceesH3HXEm9DRC1o0QXT/ItoAMg4+ROF+DDl9StH3
         hU2cflYJYLZuw0cvgQExsQ6y5jWflOpMEprvoVzrQO63qBIEk6ZJ6ZdxYsKvZw6JPJwt
         Q03g==
X-Gm-Message-State: APjAAAXgg2Gu9X8jt5GD4DV80qDTWNsEjZZgaSfv7hl5rCuia0kXLanb
        Z4sCB7gBXl3deE3HCDAPG91b8A==
X-Google-Smtp-Source: APXvYqwbqaT0saJvvn1kO9AMPxhCtCU02r6P8JPFybRCZw7gJ1GttFT36f9OLbROm/kzLbUGxjOrBg==
X-Received: by 2002:a81:82c5:: with SMTP id s188mr6858670ywf.59.1582929729704;
        Fri, 28 Feb 2020 14:42:09 -0800 (PST)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id d188sm4637830ywe.50.2020.02.28.14.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 14:42:08 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dcbw@redhat.com>,
        Evan Green <evgreen@google.com>,
        Eric Caruso <ejcaruso@google.com>,
        Susheel Yadav Yadagiri <syadagir@codeaurora.org>,
        Chaitanya Pratapa <cpratapa@codeaurora.org>,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/17] net: introduce Qualcomm IPA driver (UPDATED)
Date:   Fri, 28 Feb 2020 16:41:47 -0600
Message-Id: <20200228224204.17746-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series presents the driver for the Qualcomm IP Accelerator (IPA).

I have posted earlier versions of this code previously, but it has
undergone quite a bit of development since the last time, so rather
than calling it "version 3" I'm just treating it as a new series
(indicating it's been updated in this message).  The fast/data path
is the same as before.  But the driver now (nearly) supports a
second platform, its transaction handling has been generalized
and improved, and modem activities are now handled in a more
unified way.

This series is available (based on v5.6-rc3) in branch "ipa_updated-v1"
in this git repository:
  https://git.linaro.org/people/alex.elder/linux.git

The branch depends on other code that I sent out for review earlier
today.  The first is a very simple patch (which I already know will
be updated, but generally seems acceptable), and the second is a small
series of bugfixes for remoteproc:
  https://lore.kernel.org/lkml/20200228165343.8272-1-elder@linaro.org/
  https://lore.kernel.org/lkml/20200228183359.16229-1-elder@linaro.org/


I want to address some of the discussion that arose last time.

First, there was the WWAN discussion.  Here's the history:
  - This was last posted nine months ago.
  - Reviewers at that time favored developing a new WWAN subsystem that
    would be used for managing devices like this.  And the suggestion
    was to not accept this driver until that could be developed.
  - Along the way, Apple acquired much of Intel's modem business.
    And as a result, the generic framework became less pressing.
  - I did participate in the WWAN subsystem design however, and
    although it went dormant for a while it's been resurrected:
      https://lore.kernel.org/netdev/20200225100053.16385-1-johannes@sipsolutions.net/
  - Unfortunately the proposed WWAN design was not an easy fit
    with Qualcomm's integrated modem interfaces.  Given that
    rmnet is a supported link type for in the upstream "iproute2"
    package (more on this below), I have opted not to integrate
    with any WWAN subsystem.

So in summary, this driver does not integrate with a generic WWAN
framework.  And I'd like it to be accepted upstream despite that.


Next, Arnd Bergmann had some concerns about flow control.  (Note:
some of my discussions with Arnd about this were offline.) The
overall architecture here also involves the "rmnet" driver:
  drivers/net/ethernet/qualcomm/rmnet

The rmnet driver presents a network device for use.  It connects
with another network device presented, by the IPA driver.  The
rmnet driver wraps (and unwraps) packets transferred to (and from)
the IPA driver with QMAP headers.

   ---------------
   | rmnet_data0 |    <-- "real" netdev
   ---------------
          ||       }- QMAP spoken here
   --------------
   | rmnet_ipa0 |     <-- also netdev, transporting QMAP packets
   --------------
          ||
   --------------
  ( IPA hardware )
   --------------

Arnd's concern was that the rmnet_data0 network device does not
have the benefit of information about the state of the underlying
IPA hardware in order to be effective in controlling TX flow.
The feared result is over-buffering of TX packets (bufferbloat).
I began working on some simple experiments to see whether (or how
much) his concern was warranted.  But it turned out that completing
these experiments was much more work than had been hoped.

The rmnet driver is present in the upstream kernel.  There is also
support for the rmnet link type in the upstream "ip" user space
command in the "iproute2" package.  Changing the layering of rmnet
over IPA likely involves deprecating the rmnet driver and its
support in "iproute2".  I would really rather not go down that
path.

There is precedent for this sort of layering of network devices
(L2TP, VLAN).  And any architecture like this would suffer the
issues Arnd mentioned; the problem is not limited to rmnet and IPA.
I do think this is a problem worth solving, but the prudent thing
to do might be to try to solve it more generally.

So to summarize on this issue, this driver does not attempt to
change the way the rmnet and IPA drivers work together.  And even
though I think Arnd's concerns warrant more investigation, I'd like
this driver to to be accepted upstream without any change to this
architecture.


Finally, a more technical description for the series, and some
acknowledgements to some people who contributed to it.

The IPA is a component present in some Qualcomm SoCs that allows
network functions such as aggregation, filtering, routing, and NAT
to be performed without active involvement of the main application
processor (AP).

In this initial patch series these advanced features are not
implemented.  The IPA driver simply provides a network interface
that makes the modem's LTE network available in Linux.  This initial
series supports only the Qualcomm SDM845 SoC.  The Qualcomm SC7180
SoC is partially supported, and support for other platforms will
follow.

This code is derived from a driver developed by Qualcomm.  A version
of the original source can be seen here:
  https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree
in the "drivers/platform/msm/ipa" directory.  Many were involved in
developing this, but the following individuals deserve explicit
acknowledgement for their substantial contributions:

    Abhishek Choubey
    Ady Abraham
    Chaitanya Pratapa
    David Arinzon
    Ghanim Fodi
    Gidon Studinski
    Ravi Gummadidala
    Shihuan Liu
    Skylar Chang

					-Alex

Alex Elder (17):
  remoteproc: add IPA notification to q6v5 driver
  dt-bindings: soc: qcom: add IPA bindings
  soc: qcom: ipa: main code
  soc: qcom: ipa: configuration data
  soc: qcom: ipa: clocking, interrupts, and memory
  soc: qcom: ipa: GSI headers
  soc: qcom: ipa: the generic software interface
  soc: qcom: ipa: IPA interface to GSI
  soc: qcom: ipa: GSI transactions
  soc: qcom: ipa: IPA endpoints
  soc: qcom: ipa: filter and routing tables
  soc: qcom: ipa: immediate commands
  soc: qcom: ipa: modem and microcontroller
  soc: qcom: ipa: AP/modem communications
  soc: qcom: ipa: support build of IPA code
  MAINTAINERS: add entry for the Qualcomm IPA driver
  arm64: dts: sdm845: add IPA information

 .../devicetree/bindings/net/qcom,ipa.yaml     |  192 ++
 MAINTAINERS                                   |    6 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   51 +
 drivers/net/Kconfig                           |    2 +
 drivers/net/Makefile                          |    1 +
 drivers/net/ipa/Kconfig                       |   19 +
 drivers/net/ipa/Makefile                      |   12 +
 drivers/net/ipa/gsi.c                         | 2097 +++++++++++++++++
 drivers/net/ipa/gsi.h                         |  257 ++
 drivers/net/ipa/gsi_private.h                 |  118 +
 drivers/net/ipa/gsi_reg.h                     |  417 ++++
 drivers/net/ipa/gsi_trans.c                   |  786 ++++++
 drivers/net/ipa/gsi_trans.h                   |  226 ++
 drivers/net/ipa/ipa.h                         |  148 ++
 drivers/net/ipa/ipa_clock.c                   |  313 +++
 drivers/net/ipa/ipa_clock.h                   |   53 +
 drivers/net/ipa/ipa_cmd.c                     |  680 ++++++
 drivers/net/ipa/ipa_cmd.h                     |  195 ++
 drivers/net/ipa/ipa_data-sc7180.c             |  307 +++
 drivers/net/ipa/ipa_data-sdm845.c             |  329 +++
 drivers/net/ipa/ipa_data.h                    |  280 +++
 drivers/net/ipa/ipa_endpoint.c                | 1706 ++++++++++++++
 drivers/net/ipa/ipa_endpoint.h                |  110 +
 drivers/net/ipa/ipa_gsi.c                     |   54 +
 drivers/net/ipa/ipa_gsi.h                     |   60 +
 drivers/net/ipa/ipa_interrupt.c               |  253 ++
 drivers/net/ipa/ipa_interrupt.h               |  117 +
 drivers/net/ipa/ipa_main.c                    |  954 ++++++++
 drivers/net/ipa/ipa_mem.c                     |  314 +++
 drivers/net/ipa/ipa_mem.h                     |   90 +
 drivers/net/ipa/ipa_modem.c                   |  383 +++
 drivers/net/ipa/ipa_modem.h                   |   31 +
 drivers/net/ipa/ipa_qmi.c                     |  538 +++++
 drivers/net/ipa/ipa_qmi.h                     |   41 +
 drivers/net/ipa/ipa_qmi_msg.c                 |  663 ++++++
 drivers/net/ipa/ipa_qmi_msg.h                 |  252 ++
 drivers/net/ipa/ipa_reg.c                     |   38 +
 drivers/net/ipa/ipa_reg.h                     |  476 ++++
 drivers/net/ipa/ipa_smp2p.c                   |  335 +++
 drivers/net/ipa/ipa_smp2p.h                   |   48 +
 drivers/net/ipa/ipa_table.c                   |  700 ++++++
 drivers/net/ipa/ipa_table.h                   |  103 +
 drivers/net/ipa/ipa_uc.c                      |  211 ++
 drivers/net/ipa/ipa_uc.h                      |   32 +
 drivers/net/ipa/ipa_version.h                 |   23 +
 drivers/remoteproc/Kconfig                    |    6 +
 drivers/remoteproc/Makefile                   |    1 +
 drivers/remoteproc/qcom_q6v5_ipa_notify.c     |   85 +
 drivers/remoteproc/qcom_q6v5_mss.c            |   42 +-
 .../linux/remoteproc/qcom_q6v5_ipa_notify.h   |   82 +
 50 files changed, 14235 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,ipa.yaml
 create mode 100644 drivers/net/ipa/Kconfig
 create mode 100644 drivers/net/ipa/Makefile
 create mode 100644 drivers/net/ipa/gsi.c
 create mode 100644 drivers/net/ipa/gsi.h
 create mode 100644 drivers/net/ipa/gsi_private.h
 create mode 100644 drivers/net/ipa/gsi_reg.h
 create mode 100644 drivers/net/ipa/gsi_trans.c
 create mode 100644 drivers/net/ipa/gsi_trans.h
 create mode 100644 drivers/net/ipa/ipa.h
 create mode 100644 drivers/net/ipa/ipa_clock.c
 create mode 100644 drivers/net/ipa/ipa_clock.h
 create mode 100644 drivers/net/ipa/ipa_cmd.c
 create mode 100644 drivers/net/ipa/ipa_cmd.h
 create mode 100644 drivers/net/ipa/ipa_data-sc7180.c
 create mode 100644 drivers/net/ipa/ipa_data-sdm845.c
 create mode 100644 drivers/net/ipa/ipa_data.h
 create mode 100644 drivers/net/ipa/ipa_endpoint.c
 create mode 100644 drivers/net/ipa/ipa_endpoint.h
 create mode 100644 drivers/net/ipa/ipa_gsi.c
 create mode 100644 drivers/net/ipa/ipa_gsi.h
 create mode 100644 drivers/net/ipa/ipa_interrupt.c
 create mode 100644 drivers/net/ipa/ipa_interrupt.h
 create mode 100644 drivers/net/ipa/ipa_main.c
 create mode 100644 drivers/net/ipa/ipa_mem.c
 create mode 100644 drivers/net/ipa/ipa_mem.h
 create mode 100644 drivers/net/ipa/ipa_modem.c
 create mode 100644 drivers/net/ipa/ipa_modem.h
 create mode 100644 drivers/net/ipa/ipa_qmi.c
 create mode 100644 drivers/net/ipa/ipa_qmi.h
 create mode 100644 drivers/net/ipa/ipa_qmi_msg.c
 create mode 100644 drivers/net/ipa/ipa_qmi_msg.h
 create mode 100644 drivers/net/ipa/ipa_reg.c
 create mode 100644 drivers/net/ipa/ipa_reg.h
 create mode 100644 drivers/net/ipa/ipa_smp2p.c
 create mode 100644 drivers/net/ipa/ipa_smp2p.h
 create mode 100644 drivers/net/ipa/ipa_table.c
 create mode 100644 drivers/net/ipa/ipa_table.h
 create mode 100644 drivers/net/ipa/ipa_uc.c
 create mode 100644 drivers/net/ipa/ipa_uc.h
 create mode 100644 drivers/net/ipa/ipa_version.h
 create mode 100644 drivers/remoteproc/qcom_q6v5_ipa_notify.c
 create mode 100644 include/linux/remoteproc/qcom_q6v5_ipa_notify.h

-- 
2.20.1

