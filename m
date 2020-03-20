Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DFEC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF8820753
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEgzjPtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgCTQx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:53:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40124 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgCTQxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:53:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so2738341plk.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8C5zF5efYYsMOrxwG696qzZ9hZHWQO5hRWUAVyuQn/A=;
        b=jEgzjPtWyscKRs2WuTkrzJfGnJfstU4MA3VmdQ7HzVuEugLYMadBa4nxmjQE2QVvt7
         tz09q3WdiKf20szPrhYihH9y2Jfwk9WQOik70R/8cxSV1Rm+rxFiW/BrbPXFjNktP+TH
         MJtcvmWIdApF6Gy+X6kUDu6dQWmLksMYHJ1+Fhlh1bibSASEwX3rGTxbHNVS/xl/hXld
         jjZO2WlA2NGD5B85l0KnXmvt1zxxlsxeb9WNOB2g2mTfEmrRSLtpu1U5l0pBhQOmHIlq
         Bczm08clWYU/ih4O/gikpuLyAvJtzRuN8EzGS6QuKgxd1LlZfH7kAmE1TySdt1pVcaW0
         Dxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8C5zF5efYYsMOrxwG696qzZ9hZHWQO5hRWUAVyuQn/A=;
        b=IAjcMS28Psh91Hkw/pp70SyT4he7X1+gbTiLx2YPjRPhPRsh+xFPtDB9kdWRCOVu2w
         MRUoP6FHv+iuMsUrESDLKgFOVwXS7qp/oYmH9laKlhJebiAarPVEVeNSy7Hd4ddNP/NY
         7HKynm57wwd5AyTuIzG3Ap3gk/EWtqdWHYvBeUt90gD8TlNIGLAYqzjCnqc/SP2U1jLU
         FwbvKohmCuz0vNQPYfVQbNu2LcW5KMLAGQUq/LRQsNJYu70Y3Hoi08DC5/8Gr5Z++V7I
         PiqRvIkU1n7LcntKR8szHdzJrpHbmJ+2LM12vMkB6JZ73W54TYobdCylM+JgBv7NWgvX
         nQ7w==
X-Gm-Message-State: ANhLgQ2JDvg27uCoVUNvP3HxlIpnhVmPNN97yxdoqyHqGs79m/Ej1TKc
        joMZTYeXunCZijV638Zp1QB6UFTKaWs=
X-Google-Smtp-Source: ADFU+vtRe919J/SSKPVEiKE6V6vNE9b6JsqF2kgUqNKrTg23ho0+VFqm9dm4DWsnZLdlZfmA5iGL6w==
X-Received: by 2002:a17:90a:1acd:: with SMTP id p71mr11010660pjp.112.1584723197974;
        Fri, 20 Mar 2020 09:53:17 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id x17sm6064216pfn.16.2020.03.20.09.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:53:17 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     mike.leach@linaro.org, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 11/12] docs: sysfs: coresight: Add sysfs ABI documentation for CTI
Date:   Fri, 20 Mar 2020 10:53:02 -0600
Message-Id: <20200320165303.13681-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320165303.13681-1-mathieu.poirier@linaro.org>
References: <20200320165303.13681-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

Add API usage document for sysfs API in CTI driver.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../testing/sysfs-bus-coresight-devices-cti   | 241 ++++++++++++++++++
 1 file changed, 241 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-cti

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-cti b/Documentation/ABI/testing/sysfs-bus-coresight-devices-cti
new file mode 100644
index 000000000000..9d11502b4390
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-cti
@@ -0,0 +1,241 @@
+What:		/sys/bus/coresight/devices/<cti-name>/enable
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(RW) Enable/Disable the CTI hardware.
+
+What:		/sys/bus/coresight/devices/<cti-name>/powered
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) Indicate if the CTI hardware is powered.
+
+What:		/sys/bus/coresight/devices/<cti-name>/ctmid
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) Display the associated CTM ID
+
+What:		/sys/bus/coresight/devices/<cti-name>/nr_trigger_cons
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) Number of devices connected to triggers on this CTI
+
+What:		/sys/bus/coresight/devices/<cti-name>/triggers<N>/name
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) Name of connected device <N>
+
+What:		/sys/bus/coresight/devices/<cti-name>/triggers<N>/in_signals
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) Input trigger signals from connected device <N>
+
+What:		/sys/bus/coresight/devices/<cti-name>/triggers<N>/in_types
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) Functional types for the input trigger signals
+		from connected device <N>
+
+What:		/sys/bus/coresight/devices/<cti-name>/triggers<N>/out_signals
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) Output trigger signals to connected device <N>
+
+What:		/sys/bus/coresight/devices/<cti-name>/triggers<N>/out_types
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) Functional types for the output trigger signals
+		to connected device <N>
+
+What:		/sys/bus/coresight/devices/<cti-name>/regs/inout_sel
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(RW) Select the index for inen and outen registers.
+
+What:		/sys/bus/coresight/devices/<cti-name>/regs/inen
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(RW) Read or write the CTIINEN register selected by inout_sel.
+
+What:		/sys/bus/coresight/devices/<cti-name>/regs/outen
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(RW) Read or write the CTIOUTEN register selected by inout_sel.
+
+What:		/sys/bus/coresight/devices/<cti-name>/regs/gate
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(RW) Read or write CTIGATE register.
+
+What:		/sys/bus/coresight/devices/<cti-name>/regs/asicctl
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(RW) Read or write ASICCTL register.
+
+What:		/sys/bus/coresight/devices/<cti-name>/regs/intack
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(W) Write the INTACK register.
+
+What:		/sys/bus/coresight/devices/<cti-name>/regs/appset
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(RW) Set CTIAPPSET register to activate channel. Read back to
+		determine current value of register.
+
+What:		/sys/bus/coresight/devices/<cti-name>/regs/appclear
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(W) Write APPCLEAR register to deactivate channel.
+
+What:		/sys/bus/coresight/devices/<cti-name>/regs/apppulse
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(W) Write APPPULSE to pulse a channel active for one clock
+		cycle.
+
+What:		/sys/bus/coresight/devices/<cti-name>/regs/chinstatus
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) Read current status of channel inputs.
+
+What:		/sys/bus/coresight/devices/<cti-name>/regs/choutstatus
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) read current status of channel outputs.
+
+What:		/sys/bus/coresight/devices/<cti-name>/regs/triginstatus
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) read current status of input trigger signals
+
+What:		/sys/bus/coresight/devices/<cti-name>/regs/trigoutstatus
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) read current status of output trigger signals.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/trigin_attach
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(W) Attach a CTI input trigger to a CTM channel.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/trigin_detach
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(W) Detach a CTI input trigger from a CTM channel.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/trigout_attach
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(W) Attach a CTI output trigger to a CTM channel.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/trigout_detach
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(W) Detach a CTI output trigger from a CTM channel.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_gate_enable
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(RW) Enable CTIGATE for single channel (W) or list enabled
+		channels through the gate (R).
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_gate_disable
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(W) Disable CTIGATE for single channel.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_set
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(W) Activate a single channel.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_clear
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(W) Deactivate a single channel.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_pulse
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(W) Pulse a single channel - activate for a single clock cycle.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/trigout_filtered
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) List of output triggers filtered across all connections.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/trig_filter_enable
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(RW) Enable or disable trigger output signal filtering.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_inuse
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) show channels with at least one attached trigger signal.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_free
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) show channels with no attached trigger signals.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_xtrigs_sel
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(RW) Write channel number to select a channel to view, read to
+		see selected channel number.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_xtrigs_in
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) Read to see input triggers connected to selected view
+		channel.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_xtrigs_out
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(R) Read to see output triggers connected to selected view
+		channel.
+
+What:		/sys/bus/coresight/devices/<cti-name>/channels/chan_xtrigs_reset
+Date:		March 2020
+KernelVersion	5.7
+Contact:	Mike Leach or Mathieu Poirier
+Description:	(W) Clear all channel / trigger programming.
-- 
2.20.1

