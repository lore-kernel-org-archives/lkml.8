Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16314C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67132072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="iGXM5Qyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgHYEWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHYEWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:22:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6116FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p138so13400448yba.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=/c51TfJaBziI1eN9wq01jeVj56xrIHjm/tLvMe9Q3YY=;
        b=iGXM5QycrbOT8ijGc0fdMOrgKahpDZiqXkaucZYHEAWp7oMPCLFltMCwtqKHsxS7cV
         02F3xQzc9dH5ovr6zzE9SNBwGQEFUE7GteWjLY3yGHPGtIbPZM8vZfkQKRB2MtWPi84N
         hZg9BC5Q8Yt+xUsw341pCG9qDC/sJWv0yWQTMq0BfyRPUYeOGeU4NMn1STFVxirwhXfV
         aJogMc/vJ2lHjkHL3csyJuuWPc+6SZgoJ9Y22t9YTAIxUgm9uf1zpvw2g/GWcH6PNggk
         i2g0zJY3RaiEFvH2IDRHNIKdkrz/OzWaecHGtXKFQ9xnWskSIDEdKQ405i6R+Jwpnbqj
         bGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=/c51TfJaBziI1eN9wq01jeVj56xrIHjm/tLvMe9Q3YY=;
        b=g47Ab2CLzSTFy4tDCNgxV4D1hC7n5AY8UojfoQxe00tfigkA7V//YQ57Z8fajvC9ki
         NvAZo5WEUOMAyRQeObf5B8jGI9MiPub7uWbVJN9vC67ldTnW9r7Gd7hAPDLx/WW7iYeN
         PTEvZN/cexJiw40+lsZ/V8avrAGKsKXZiohB1YvNV1JNjz1Pmxp+DnvKXeuWN7KkvIV9
         Twbzn2MnjZrJH6NSTleAKHswEJDlnaKjCMHkSH/D+d5nC2WmuKuwB7jZfSGVe04sf8mj
         jeF3sAYBh0twcQulrYnCPizt6++ZLr2L7M2oeWzCjQxFrwNURMXmKWSbtHdoSof3MCn4
         K88A==
X-Gm-Message-State: AOAM530HrT1DCyiomDup9M+zGDCVC99X2VHR6VgsQe2/XQ8aNzqvQ6tE
        lc7CmyVO7l7Qgmb8l1sBT8wFDwfuthI=
X-Google-Smtp-Source: ABdhPJyYhvZ0I7GKmQxC+8W9XVFnCFFUYlSNbsEep8zhRBabM7qpmnZtotDNd8ZuMfLd2HKdgRu5gaDK8mk=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:3c47:: with SMTP id j68mr12180701yba.59.1598329339498;
 Mon, 24 Aug 2020 21:22:19 -0700 (PDT)
Date:   Mon, 24 Aug 2020 21:21:56 -0700
Message-Id: <20200825042210.300632-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 00/14] TCPM support for FRS and AutoDischarge Disconnect
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

With this patchset, I am hoping to add Sink Fast Role swap support to TCPM.
Sink Fast Role swap is described by the USB Power Delivery Specification
Revision 3.0. The patchset also adds support to Auto Discharge Disconnect
described in the USB Type-C Port Controller Interface Specification.
I am also sending the chip level driver for the TCPCI based type-c controller
that supports Fast role swap.

I tested the fast role swap implementation with the following
accessories:
1. https://ezq.com/usb-c-multimedia-hub-adapter-8-ports.html
2. https://www.iogear.com/product/GUH3C22P/

Note: I will rebase the patchset on top of https://lkml.org/lkml/2020/8/19/52
once it's picked up in usb-next.

Badhri Jagan Sridharan (14):
  usb: typec: tcpci: Add register definitions to tcpci
  usb: typec: tcpci: Add support when hidden tx registers are
    inaccessible
  usb: typec: tcpci: update ROLE_CONTROL for DRP
  usb: typec: tcpci: Add a getter method to retrieve tcpm_port reference
  usb: typec: tcpci: Add set_vbus tcpci callback
  dt-bindings: usb: Maxim type-c controller device tree binding document
  usb: typec: tcpci_maxim: Chip level TCPC driver
  dt-bindings: connector: Add property to set initial current cap for
    FRS
  usb: typec: tcpm: Add support for Sink Fast Role SWAP(FRS)
  usb: typec: tcpci: Implement callbacks for FRS
  usb: typec: tcpci_maxim: Add support for Sink FRS
  usb: typec: tcpm: Implement enabling Auto Discharge disconnect support
  usb: typec: tcpci: Implement Auto discharge disconnect callbacks
  usb: typec: tcpci_maxim: Implemnent set_auto_vbus_discharge_threshold

 .../bindings/connector/usb-connector.txt      | 128 ++++
 .../devicetree/bindings/usb/maxim,tcpci.txt   |  44 ++
 drivers/usb/typec/tcpm/Kconfig                |   6 +
 drivers/usb/typec/tcpm/Makefile               |  13 +-
 drivers/usb/typec/tcpm/tcpci.c                | 149 ++++-
 drivers/usb/typec/tcpm/tcpci.h                |  43 ++
 drivers/usb/typec/tcpm/tcpci_maxim.c          | 564 ++++++++++++++++++
 drivers/usb/typec/tcpm/tcpm.c                 | 271 ++++++++-
 include/dt-bindings/usb/pd.h                  |  10 +
 include/linux/usb/pd.h                        |  20 +-
 include/linux/usb/tcpm.h                      |  24 +-
 include/linux/usb/typec.h                     |  13 +
 12 files changed, 1249 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
 create mode 100644 Documentation/devicetree/bindings/usb/maxim,tcpci.txt
 create mode 100644 drivers/usb/typec/tcpm/tcpci_maxim.c

-- 
2.28.0.297.g1956fa8f8d-goog

