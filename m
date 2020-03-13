Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E169CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE0A206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o44ARPs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgCMEHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 00:07:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38548 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgCMEHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 00:07:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so4398627pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 21:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xCr+Q6LivgZR20qx8kOsB6UAnaHNoihWEMbA4zbV/sc=;
        b=o44ARPs3a5lAysD620elxUxaHOCesUxdpX8boR7uvoOs0r8H1s9mRvOpdot+O1GMy7
         4H229iHxVuzLPYUB2vXN2HWQ2b2MMjQ/TJzf8WARRKHyuC9Av9KA8xAvOqNNrChnGsbu
         KM7I5BCrZD84Tk3kkzydCl9/z12Kq7LaOC0xes0l2v9abJ0b+RiFd9KETUlqOE6PKs3H
         9FKiJd1AR0UveRpIcQYf0CuiLZADzN+qGr8i4h7AO6EG7/raq82Et46d4vG2b05jORsa
         WXz3IQtbN0JwPb8ZSV4HrEaanr9Kj17PRdtchUBcMDdU9b8xMtU4xSInEm32yehMUPkA
         n37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xCr+Q6LivgZR20qx8kOsB6UAnaHNoihWEMbA4zbV/sc=;
        b=jdewkiYXi6+4EppO27tXYsGxA3LT0ubvpzsMs94lo6jvgN6N2wiQvZYX0OBdPYRkDZ
         EPZ4jI1EBXT4sxuC/2qLrnSnGyR8oJynDmXB33VYsGE4HlHwIfZV+Yrou6EFwmRNJD9z
         TaKXuZv7/9q6aoH6l0z7kM0j818CcxekYru6HG/bzxLe6mi17JEC0ikbyoVQ2dYfVnvC
         cvZ6m9rKen694Pvtkl/8CVSNIjhUm31Wpp8DV9yvOmxBflr6KuIseuDErpHE65ZLl7XA
         LtoLzRIPEP26PukLbYZu3/Ygg+W+/A8qD9M9ljlGcX6Y7g7QHLiwVliC/5UEnNPNQGFX
         kwLg==
X-Gm-Message-State: ANhLgQ3tBA5VvX3/UmJTk0JfV9P+QuSfctUuCJW1oxPDYD49huiASrmH
        7FJMuw+6cxvNzBOYHhkov/c=
X-Google-Smtp-Source: ADFU+vuI2hd93dCzVyio0Z87mZmKT3RPzZAsCTYS15iNhC91EuDTOYCCnBU1u1L69cUptR9GeiSGGw==
X-Received: by 2002:a62:5c07:: with SMTP id q7mr11739705pfb.200.1584072441968;
        Thu, 12 Mar 2020 21:07:21 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 6sm15576661pfx.69.2020.03.12.21.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Mar 2020 21:07:21 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     srinivas.kandagatla@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, freeman.liu@unisoc.com,
        baolin.wang7@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Optimize the Spreadtrum eFuse controller
Date:   Fri, 13 Mar 2020 12:07:06 +0800
Message-Id: <cover.1584072223.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set optimizes the block lock operation and set the double
data flag from device data.

Baolin Wang (1):
  nvmem: sprd: Determine double data programming from device data

Freeman Liu (2):
  nvmem: sprd: Fix the block lock operation
  nvmem: sprd: Optimize the block lock operation

 drivers/nvmem/sprd-efuse.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

-- 
1.9.1

