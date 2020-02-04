Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D796C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4172F21582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DV7FYFA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgBDG0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 01:26:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41243 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgBDG0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:26:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id j9so5832996pfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 22:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UAbfKGPHFp5dpRo9OZT4gAhZKpnQ/tm30dsERIZmLtY=;
        b=DV7FYFA2zBtXcTFpKCZDOUo3/HxELPWgA+S/mT54nl7QsTiXhHGgURm3VYtveFUo11
         ugOwDhpr0mzpA1VVN8VABVuM/l0cY6+AooZ5Lwof2mdePv9dA1Gn+d3CG0TkRtAwegeE
         SrH8WppssxK7l8z6QIjBzaCrQ8uYxARt0YE3DNjW02z6Ix2panbgKJwAixdOPD3FTRtA
         Q7fJ5OwZgkMrwfROygPTiEVCs/uyeQPRoxnLgw++QTw0HfmsIVCiJuzfjsEyP468HHNP
         ZGo5Feeuzh/YqEoWfIWGwVvjp8bblLsJnI/Z/D/lOCRb3yeu1+rJ0QLIPclkbScg7FQY
         wJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UAbfKGPHFp5dpRo9OZT4gAhZKpnQ/tm30dsERIZmLtY=;
        b=atXljeopyuGMhR+P9oXJYfKZURt34gsAR30/3nSfYAd9Eb+Oo/8gddekWxXGd8x3tU
         81U/03loRPQ+lZ2Rlx7hEvw9Z1J0jPE19ToJcMPlWy7i4oBe40fDnqVnvSpttpDThP6v
         /BHPbpRCzRtfOWhNC8Jz6DGfRYUmFab2u0Uv8JsCWqZ5jsI7wiRTWUgb/S5c4UFNzWpW
         tJR6muMfXalPN+9VCej4Mih58qQvphicseoLYbva4pqQxVbOOInI+I6Q81tQ/TMxvVFV
         Z63h1koBOxmOXnL2ECV20z1ctRqPa0hX2GQALmK6vNkJkZ6lWah23qN6MfhTah8a4qhi
         HeVA==
X-Gm-Message-State: APjAAAVoUYDOz7hiuRjgHxucWqD2ImQsJFOEwz6VssoDnrlDnD+e5ywC
        KHJfpk+GWEC1rhzBIE059qEkPQ==
X-Google-Smtp-Source: APXvYqznRtyL0JVHhck6+gFYGWEaG3OcRjT8/aSbV6eXxQXW03/6Bi4PbIcny8W7vDKPM4kYe+O+fQ==
X-Received: by 2002:a62:4ecc:: with SMTP id c195mr29519240pfb.158.1580797605299;
        Mon, 03 Feb 2020 22:26:45 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l69sm6901897pgd.1.2020.02.03.22.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 22:26:44 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v3 0/2] remoteproc: mss: Improve mem_assign and firmware load
Date:   Mon,  3 Feb 2020 22:26:39 -0800
Message-Id: <20200204062641.393949-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two things came up in the effort of figuring out why the modem crashed the
entire system when being restarted; the first one solves the actual problem, in
that it's not possible to reclaim the main modem firmware region unless the
modem subsystem is running - causing the crash.

The second patch aligns the firmware loading process to that of the downstream
driver, which seems to be a requirement in 8974 as well.

Bjorn Andersson (2):
  remoteproc: qcom_q6v5_mss: Don't reassign mpss region on shutdown
  remoteproc: qcom_q6v5_mss: Validate each segment during loading

 drivers/remoteproc/qcom_q6v5_mss.c | 95 +++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 33 deletions(-)

-- 
2.23.0

