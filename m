Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F28C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE932071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="az2M5soa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgFOVjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFOVjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:39:01 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B6BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:39:01 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h22so481266pjf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/k/xIvyaQ1ob1Iqs7BAGJ9OdBOtIbRdxPdyH1m1qNoY=;
        b=az2M5soaRvu79qQJWtcNdWb58eN0EYi4uHLIoFB8qhPelQulpBBixbAVGL5QHQ3bIK
         PjBEpVS4J22TOHDgkz+7Z1uMvtI0H8A+tn8gXUZ/MFA2k/yVcTzcUJqFW2Og6cXAtSgJ
         PyDy8TAS0uduA+vK6t4zJIaIbpG5XM/3YQELfenjExnfbxafx0/i5c94nk6CS0jnnr/Z
         z8gYV45f23kZv9Twyd36hfrWWxjbgPvmUkDxQHtLGD/9nKYkeB9ZuHh+KRcelFjxAisc
         kkwQoFDV1oMZ9bsfkURxD0r0Hxdu1E4Znh2ZgCWUyl6Ty3+8B4oARFBmYrin3iwyxEsQ
         OL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/k/xIvyaQ1ob1Iqs7BAGJ9OdBOtIbRdxPdyH1m1qNoY=;
        b=NujL+BUgqRrrhtjcZ0jAu+E3ciIyAm2EDdekiKtW/sl+j/WWB8n35tWA1Iz/Mh+5n1
         VFpzoKTd7y1kvNcaA3jcScySHT4i7/ekZGCcyn00TXsHAYuSVX3RQnWK7kmmm8kjP9ML
         gjYd2Poquwy19bgoYjopeT3UdV37d+8HwG4j7pj28DWRc0exhr8L2iYb0CZ6XUzMpbE/
         OO9U4DGhGioYWPjSQJYrGrX/DZXb5qdqLZ9WaZYebRYOfb08+Bw2gLrFIWQ8Aj5cShOf
         hf3YKGa2OSfQta/p9FRdNCOt9BHBWjbTtml6jHRU3qDzo3BUsDqKsCmqep8oxy+1MFYF
         firw==
X-Gm-Message-State: AOAM531qLzuDZ8EH/LkSpWUgDznRyhUL9Pi2VZ3SSkJh3N7K8IXTsnX2
        CthkcbLTwQ11jOuCeOLw1qfaLQ==
X-Google-Smtp-Source: ABdhPJyKEXXiTlSrUGpV4NfoDP1vLaAUJCXWcpA8QSf63Zeyqz1YSebN2m+2zf5S0jlWP8LuOntc0A==
X-Received: by 2002:a17:90b:1081:: with SMTP id gj1mr1252369pjb.77.1592257140968;
        Mon, 15 Jun 2020 14:39:00 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o186sm8708227pgo.65.2020.06.15.14.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 14:39:00 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/3] rpmsg: core: Add support for name extension
Date:   Mon, 15 Jun 2020 15:38:56 -0600
Message-Id: <20200615213859.443152-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the capability to supplement the base definition
published by an rpmsg_driver with a postfix description so that it
is easy to differentiate entities that use the same name service.

Applies cleanly on v5.8-rc1 (b3a9e3b9622a).

New for V7:
- Added Suman's acked-by.
- Deleted extra newline in patch 02.
- Avoided line break in strncmp() in patch 02.

Thanks,
Mathieu

Mathieu Poirier (3):
  rpmsg: core: Add wildcard match for name service
  rpmsg: core: Add support to retrieve name extension
  sample: rpmsg: Print out RPMSG device name extension

 drivers/rpmsg/rpmsg_core.c          | 113 +++++++++++++++++++++++++++-
 include/linux/rpmsg.h               |  13 ++++
 samples/rpmsg/rpmsg_client_sample.c |   5 ++
 3 files changed, 130 insertions(+), 1 deletion(-)

-- 
2.25.1

