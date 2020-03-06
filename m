Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840CEC3F2DD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5299A2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eslwFNq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgCFE3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:29:33 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44634 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbgCFE3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 23:29:06 -0500
Received: by mail-yw1-f68.google.com with SMTP id t141so1054853ywc.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 20:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=miNN8i4IwcvOjiB/qs3BU+cs0LOJ0WZgNaPZTHxNf20=;
        b=eslwFNq4PwCC6+Z4KsPepXRVMSQtjU60CJu4GIG6B7Jnm4GZgJE8XkeUHt+m8sYvds
         Vb3v8FWdY/Hm7Tzv2QWOSvmxWCRZA1Q1yD2R6rTHqF0WUw8XWuYnojK+8Gzhbvnty8b1
         4FvH9hKarM9faVP8AInLEsBWcB7CTrpeDbz8B+hwcTyTXoHH1F9L2iAZtZOdn8xNMZcd
         U0qjD73Dgm3vDJkC8eBdPh7pIcbBn++HjfXSEfbn8Eu+1PLU70HJ3MKuMjeyjdKnjrrX
         WG6/hgDgSof0z3abT9dUiOIGO0mE3Pt9dt2vYe6ncLAoY1prfQBYsXM42eiTP9qihY8l
         C40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=miNN8i4IwcvOjiB/qs3BU+cs0LOJ0WZgNaPZTHxNf20=;
        b=Rlfr8mRbMELHayvfQox5gi+V37T+dw11/emoyW7YmpxmrWuCKk5M6joO1rAOYKvs39
         RngWfh70mcjEeNTFcpzLpwwr+5kq0iWV6Qs5uJpibBeSBzHapU6PUzou56azxGzFPmbI
         1xIxgKmQ8pjD+xLw2Gu4/64GzniD02At9Dpiq0WIMxPwk+PeKqnSoNVXawpXgsQ+TMwS
         8qH3QwZd7BxQVgvujKFws6Z8tRiLCjym8LGp2xBWhjAQbKUHXRyxHNwzu3doxjdfoBid
         xCj40h+4PtRpQoJmWz2ZD0IS/s/Ke01O2QNbILEgYa1b8/yBfchuftzOejyopXelIGwQ
         D+cA==
X-Gm-Message-State: ANhLgQ2bpcpZSxN02v5Jsaf+karZp7q/kXSnWVwDkVxU6YKbM7NX59d1
        xm4aWzLqAz5XaLPEpeASD+GN+g==
X-Google-Smtp-Source: ADFU+vvvxCEfuf1gOKNFIP8+FrNcl9hJa0D2HXoL/aVi6uaZ18AjxRORPUKqhxu509Q6FwPA0HW7Tg==
X-Received: by 2002:a81:49c5:: with SMTP id w188mr2205995ywa.186.1583468945849;
        Thu, 05 Mar 2020 20:29:05 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id x2sm12581836ywa.32.2020.03.05.20.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 20:29:05 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     David Miller <davem@davemloft.net>, Arnd Bergmann <arnd@arndb.de>
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
Subject: [PATCH v2 15/17] soc: qcom: ipa: support build of IPA code
Date:   Thu,  5 Mar 2020 22:28:29 -0600
Message-Id: <20200306042831.17827-16-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306042831.17827-1-elder@linaro.org>
References: <20200306042831.17827-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add build and Kconfig support for the Qualcomm IPA driver.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/Kconfig      |  2 ++
 drivers/net/Makefile     |  1 +
 drivers/net/ipa/Kconfig  | 19 +++++++++++++++++++
 drivers/net/ipa/Makefile | 12 ++++++++++++
 4 files changed, 34 insertions(+)
 create mode 100644 drivers/net/ipa/Kconfig
 create mode 100644 drivers/net/ipa/Makefile

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 66e410e58c8e..02565bc2be8a 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -444,6 +444,8 @@ source "drivers/net/fddi/Kconfig"
 
 source "drivers/net/hippi/Kconfig"
 
+source "drivers/net/ipa/Kconfig"
+
 config NET_SB1000
 	tristate "General Instruments Surfboard 1000"
 	depends on PNP
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 65967246f240..94b60800887a 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_ETHERNET) += ethernet/
 obj-$(CONFIG_FDDI) += fddi/
 obj-$(CONFIG_HIPPI) += hippi/
 obj-$(CONFIG_HAMRADIO) += hamradio/
+obj-$(CONFIG_QCOM_IPA) += ipa/
 obj-$(CONFIG_PLIP) += plip/
 obj-$(CONFIG_PPP) += ppp/
 obj-$(CONFIG_PPP_ASYNC) += ppp/
diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
new file mode 100644
index 000000000000..b8cb7cadbf75
--- /dev/null
+++ b/drivers/net/ipa/Kconfig
@@ -0,0 +1,19 @@
+config QCOM_IPA
+	tristate "Qualcomm IPA support"
+	depends on ARCH_QCOM && 64BIT && NET
+	select QCOM_QMI_HELPERS
+	select QCOM_MDT_LOADER
+	default QCOM_Q6V5_COMMON
+	help
+	  Choose Y or M here to include support for the Qualcomm
+	  IP Accelerator (IPA), a hardware block present in some
+	  Qualcomm SoCs.  The IPA is a programmable protocol processor
+	  that is capable of generic hardware handling of IP packets,
+	  including routing, filtering, and NAT.  Currently the IPA
+	  driver supports only basic transport of network traffic
+	  between the AP and modem, on the Qualcomm SDM845 SoC.
+
+	  Note that if selected, the selection type must match that
+	  of QCOM_Q6V5_COMMON (Y or M).
+
+	  If unsure, say N.
diff --git a/drivers/net/ipa/Makefile b/drivers/net/ipa/Makefile
new file mode 100644
index 000000000000..afe5df1e6eee
--- /dev/null
+++ b/drivers/net/ipa/Makefile
@@ -0,0 +1,12 @@
+# Un-comment the next line if you want to validate configuration data
+#ccflags-y		+=	-DIPA_VALIDATE
+
+obj-$(CONFIG_QCOM_IPA)	+=	ipa.o
+
+ipa-y			:=	ipa_main.o ipa_clock.o ipa_reg.o ipa_mem.o \
+				ipa_table.o ipa_interrupt.o gsi.o gsi_trans.o \
+				ipa_gsi.o ipa_smp2p.o ipa_uc.o \
+				ipa_endpoint.o ipa_cmd.o ipa_modem.o \
+				ipa_qmi.o ipa_qmi_msg.o
+
+ipa-y			+=	ipa_data-sdm845.o ipa_data-sc7180.o
-- 
2.20.1

