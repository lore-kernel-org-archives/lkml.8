Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB314C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD38B206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F1o28rPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgGXSLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgGXSLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:11:46 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BD3C0619E5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 11:11:46 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s189so3448330iod.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a/UQvPKtYnZLZqgUn0XW2j5+SzCkzSp8vCmVb/ZBF8c=;
        b=F1o28rPE/Yt97GiWaWB9/CKFJi6S1upJ6Y7qvou0AM54OpXJJpdCfiE77LtsvCPLY0
         fCl2y9zr5v8H6+NloqxNx5sLczH6A38Lz7fc73HJFiqo7AYIdjd8D7R9SyeLVHMiPJ9d
         03PH4NltlvA8G6XTfjLIANfY8zQx2U6xQIhuZL/gJU69jx7J9MN0Tu4tKPvbTsW/Q0b+
         eSW/mVVwoB700ynQzxgJisaN0qhUC8VHi8svndt+Nw2C2WfDEq4U/VdnqsvyGnIfop3U
         GE1W0goa4UIrqpGbamvgy2e6qd2a5WABR7o7uGUOZMHg3KZn8boqYF9qp6Fqa1QNB14y
         QrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a/UQvPKtYnZLZqgUn0XW2j5+SzCkzSp8vCmVb/ZBF8c=;
        b=Qxi8o3/RXxe+IlsSfjd5EQ91Zf1F7aj1kq+wzZ8NgZ6nXxLv2fH9EtJTOorZ9+eiGk
         BQ51kcqWjO+XRxb+F4m/tX7CK3N6ESH09eqowCp8P8kcjIO5svFoQvCKLRTqA7rbZz4j
         nmlaVnQFVtpGEAKzAjsU+YZNPbCL4MIn7vR5ug4dbiGg+kopwvpouFh6htwIEuufaPvE
         FkTwBu/9wThiouOpmn/YMf/6pwNDxxcjkW5IS2JyN0Susz/KwhNkKO/iJvygT8+dckmA
         8fhXm96g5pF1tQNgcLcxKbG1Zua6mB9ZdYyyWdnvTcpqdq6YBX93MOm/4PU3OKl1lLT5
         jX6w==
X-Gm-Message-State: AOAM530Ept6pgCcSM4mNOacBeyJnVIfqpBV+O4rOy0CkSeor4BnCKwNf
        ZI7YkiVc9UkxIohIcC5jtGP0Uw==
X-Google-Smtp-Source: ABdhPJxKkoK9PhB+aL2g3ao8CwCGXNNySWGOpuO4MoByIZoOhHzUW/Bl+9bPSdtIJpjTUHONFFluCw==
X-Received: by 2002:a6b:6e11:: with SMTP id d17mr11924957ioh.102.1595614305764;
        Fri, 24 Jul 2020 11:11:45 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id b13sm2407802iod.40.2020.07.24.11.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 11:11:45 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     agross@kernel.org, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] remoteproc: convert IPA to use new notifications
Date:   Fri, 24 Jul 2020 13:11:40 -0500
Message-Id: <20200724181142.13581-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPA driver needs to be notified about changes to the state of
the modem (starting, shutting down, etc.).  A notification mechanism
was put in place for that purpose, but a more general system has now
been accepted:
  https://lore.kernel.org/linux-remoteproc/1592965408-16908-1-git-send-email-rishabhb@codeaurora.org/

The first patch in this series converts the IPA driver to use the
new notification mechanism.  The second removes the temporary
system that was put in place for IPA use only.

					-Alex

  --> David:  Bjorn has agreed to take both of these patches through
      the remoteproc tree.  They should be merged together, and the
      first has a build-time dependency on patches in rproc-next.
      I'd appreciate an ack from you so he can merge it.

Alex Elder (2):
  net: ipa: new notification infrastructure
  remoteproc: kill IPA notify code

 drivers/net/ipa/ipa.h                         |  3 +
 drivers/net/ipa/ipa_modem.c                   | 56 +++++++-----
 drivers/remoteproc/Kconfig                    |  4 -
 drivers/remoteproc/Makefile                   |  1 -
 drivers/remoteproc/qcom_q6v5_ipa_notify.c     | 85 -------------------
 drivers/remoteproc/qcom_q6v5_mss.c            | 38 ---------
 .../linux/remoteproc/qcom_q6v5_ipa_notify.h   | 82 ------------------
 7 files changed, 38 insertions(+), 231 deletions(-)
 delete mode 100644 drivers/remoteproc/qcom_q6v5_ipa_notify.c
 delete mode 100644 include/linux/remoteproc/qcom_q6v5_ipa_notify.h

-- 
2.20.1

