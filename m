Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4606C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C95205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CpQAn/SF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgEOFSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726000AbgEOFSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:18:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E8DC05BD09
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:17:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k7so445127pjs.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hMleKhZRwYnYk8trdPGYl13OjWa3go/Bt1PhL2DTPXo=;
        b=CpQAn/SFEFpBwXkURwgPzqVVevnZWk4x5rKIicMyToKZfczl/E4eQjP8SVh/hNwYcS
         6DUz8bRV48Bj60vn5QXNut9LrXYxC5DIWKVN4GXxoF7r81tieIVTXvpM6xfcjl4MiAqp
         xsXFqJ7QuY1mhPjKV63M1s3zHaSxdJzkxb5B8Gm5VhtawWhSMz7HmYs0rEQKUrcU7tg8
         L+FYgtEvAq6ol8PfFZ3jjujajTO3kC9vaHWNOepSDCX2p0A0f2BOmmJljwfPsL52VLOD
         1TUvc/YfYy2vDMezlAsJFblCi4WifLks0PTNWpwHwqDc1Wy4y+XjKYgUV1U5HNI8eqRj
         1A3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hMleKhZRwYnYk8trdPGYl13OjWa3go/Bt1PhL2DTPXo=;
        b=HS1RNSEiX6DjBU57oD0QbKFVAoE8dyrD/VudZu0coHJ8pFM3U7mV3X384YWrMpUiA+
         FCMaKO0zg932kpddAlj5eyD0e9fx+Z4v1pDEJAsKo7oUt/1pNgfz8nP2E+IliVZ0yqry
         PRZZpOBxKDY6vb8JrIQ9DfPU7e5iuSBWFDYvlMad/sExxNekbJmMSEHJyjZIU21K9B6y
         xKlCL6tr73LEjtN/CLJNHiPlHNk4L5SS7Ck++VIW8p9BKK7Wh4BvBenhJMzjQLzkfF6q
         EGofrEcAu0iO7zYaeFKCqhL9dJofIR+8aVdmTuuvB2EpjFvqhLuJ5g4+yYeO6vCXq0ey
         7AKg==
X-Gm-Message-State: AOAM532vIvIU2gHAJ/Ln0vLAILNf0Q/HeENkbJfWMKJEQoWZPV40T6lt
        Det8tlbvh3TpVe9M0LmvVprZ2w==
X-Google-Smtp-Source: ABdhPJylEXYFkUKbsA7pjWiU7zxQPtu31zx2CCb2GDHOcQAinrwKDrX/1WSJ+z2qGzzZjFhZ364V2A==
X-Received: by 2002:a17:90a:e28c:: with SMTP id d12mr1611674pjz.19.1589519877981;
        Thu, 14 May 2020 22:17:57 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id fh18sm39271712pjb.0.2020.05.14.22.17.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 22:17:57 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Date:   Fri, 15 May 2020 10:47:38 +0530
Message-Id: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

Hi Rob, Arnd and Jassi,

This stuff has been doing rounds on the mailing list since several years
now with no agreed conclusion by all the parties. And here is another
attempt to get some feedback from everyone involved to close this once
and for ever. Your comments will very much be appreciated.

The ARM MHU is defined here in the TRM [1] for your reference, which
states following:

	"The MHU drives the signal using a 32-bit register, with all 32
	bits logically ORed together. The MHU provides a set of
	registers to enable software to set, clear, and check the status
	of each of the bits of this register independently.  The use of
	32 bits for each interrupt line enables software to provide more
	information about the source of the interrupt. For example, each
	bit of the register can be associated with a type of event that
	can contribute to raising the interrupt."

On few other platforms, like qcom, similar doorbell mechanism is present
with separate interrupt for each of the bits (that's how I understood
it), while in case of ARM MHU, there is a single interrupt line for all
the 32 bits. Also in case of ARM MHU, these registers and interrupts
have 3 copies for different priority levels, i.e. low priority
non-secure, high priority non-secure and secure channels.

For ARM MHU, both the dt bindings and the Linux driver support 3
channels for the different priorities right now and support sending a 32
bit data on every transfer in a locked fashion, i.e. only one transfer
can be done at once and the other have to wait for it to finish first.

Here are the point of view of the parties involved on this subject:

Jassi's viewpoint:

- Virtualization of channels should be discouraged in software based on
  specific usecases of the application. This may invite other mailbox
  driver authors to ask for doing virtualization in their drivers.

- In mailbox's terminology, every channel is equivalent to a signal,
  since there is only one signal generated here by the MHU, there should
  be only one channel per priority level.

- The clients should send data (of just setting 1 bit or many in the 32
  bit word) using the existing mechanism as the delays due to
  serialization shouldn't be significant anyway.

- The driver supports 90% of the users with the current implementation
  and it shouldn't be extended to support doorbell and implement two
  different modes by changing value of #mbox-cells field in bindings.

Sudeep (ARM) and myself as well to some extent:

- The hardware gives us the capability to write the register in
  parallel, i.e. we can write 0x800 and 0x400 together without any
  software locks, and so these 32 bits should be considered as separate
  channel even if only one interrupt is issued by the hardware finally.
  This shouldn't be called as virtualization of the channels, as the
  hardware supports this (as clearly mentioned in the TRM) and it takes
  care of handling the signal properly.

- With serialization, if we use only one channel as today at every
  priority, if there are 5 requests to send signal to the receiver and
  the dvfs request is the last one in queue (which may be called from
  scheduler's hot path with fast switching), it unnecessarily needs to
  wait for the first four transfers to finish due to the software
  locking imposed by the mailbox framework. This adds additional delay,
  maybe of few ms only, which isn't required by the hardware but just by
  the software and few ms can be important in scheduler's hotpath.

- With the current approach it isn't possible to assign different bits
  (or doorbell numbers) to clients from DT and the only way of doing
  that without adding new bindings is by extending #mbox-cells to accept
  a value of 2 as done in this patch.

Jassi and Sudeep, I hope I was able to represent both the view points
properly here. Please correct me if I have made a mistake here.

This is it. It would be nice to get the views of everyone now on this
and how should this be handled.

Thanks.

[1] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0515f/DDI0515F_juno_arm_development_platform_soc_trm.pdf , section 3.4.4, page 3-38.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/mailbox/arm-mhu.txt   | 39 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
index 4971f03f0b33..ba659bcc7109 100644
--- a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
+++ b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
@@ -10,6 +10,15 @@ STAT register and the remote clears it after having read the data.
 The last channel is specified to be a 'Secure' resource, hence can't be
 used by Linux running NS.
 
+The MHU drives the interrupt signal using a 32-bit register, with all
+32-bits logically ORed together. It provides a set of registers to
+enable software to set, clear and check the status of each of the bits
+of this register independently. The use of 32 bits per interrupt line
+enables software to provide more information about the source of the
+interrupt. For example, each bit of the register can be associated with
+a type of event that can contribute to raising the interrupt. Each of
+the 32-bits can be used as "doorbell" to alert the remote processor.
+
 Mailbox Device Node:
 ====================
 
@@ -18,13 +27,21 @@ used by Linux running NS.
 - compatible:		Shall be "arm,mhu" & "arm,primecell"
 - reg:			Contains the mailbox register address range (base
 			address and length)
-- #mbox-cells		Shall be 1 - the index of the channel needed.
+- #mbox-cells		Shall be 1 - the index of the channel needed when
+			not used as set of doorbell bits.
+			Shall be 2 - the index of the channel needed, and
+			the index of the doorbell bit within the channel
+			when used in doorbell mode.
 - interrupts:		Contains the interrupt information corresponding to
-			each of the 3 links of MHU.
+			each of the 3 physical channels of MHU namely low
+			priority non-secure, high priority non-secure and
+			secure channels.
 
 Example:
 --------
 
+1. Controller which doesn't support doorbells
+
 	mhu: mailbox@2b1f0000 {
 		#mbox-cells = <1>;
 		compatible = "arm,mhu", "arm,primecell";
@@ -41,3 +58,21 @@ used by Linux running NS.
 		reg = <0 0x2e000000 0x4000>;
 		mboxes = <&mhu 1>; /* HP-NonSecure */
 	};
+
+2. Controller which supports doorbells
+
+	mhu: mailbox@2b1f0000 {
+		#mbox-cells = <2>;
+		compatible = "arm,mhu", "arm,primecell";
+		reg = <0 0x2b1f0000 0x1000>;
+		interrupts = <0 36 4>, /* LP-NonSecure */
+			     <0 35 4>; /* HP-NonSecure */
+		clocks = <&clock 0 2 1>;
+		clock-names = "apb_pclk";
+	};
+
+	mhu_client: scb@2e000000 {
+		compatible = "arm,scpi";
+		reg = <0 0x2e000000 0x200>;
+		mboxes = <&mhu 1 4>; /* HP-NonSecure 5th doorbell bit */
+	};
-- 
2.25.0.rc1.19.g042ed3e048af

