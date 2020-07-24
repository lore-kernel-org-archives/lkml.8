Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FDAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22632073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="scHeXXDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGXLmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXLmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:42:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74163C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:42:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so8012104wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DS8+C7+3JkJCKAfBvk/FiQEiSKMMCSRFh6EPJECwAgM=;
        b=scHeXXDB3x5CbKvgy/DYej+AecpbeKdHEuDxRbS3gfdq6ldhScLqmtFaj1syEsALJN
         6PZvlCPs9dh4koSh72sIjQ84b0rPknYK2Ba4F2Me/a9tZnobNPgM1Ji8fI4kb7UGYSuW
         Uw0t9hJSja4HqLenih6mE4VR9uULCCY8VaQ7G62qDIT9XeteuY5vPmyjaISYGsc39yMR
         XmeMb7l+tnHrtdLiYMcr+WVH3oFGYA/MnDMmV9b2jS3eCp6GaY0CSAowB5zGDuFoYklA
         dw62TIcHLNJXhNkcTibKEJ7SPP1KNqNPrCPA6uboawYmwtK04JrF7kWW+SbspLt7tvEy
         XijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DS8+C7+3JkJCKAfBvk/FiQEiSKMMCSRFh6EPJECwAgM=;
        b=JUucic2GZDCDAB07kG1uY8QgVDmZoZWiXTP52reDdykicBUqNXb+EmGdpxnimv8sg0
         mgmojXnkxlDLgqoNW9+gZ4nD0JrtlWH2RO+ltvOohhVcLn3Scmze4TDI1djZrTlWYudc
         YuNOCYhl9BjYAwN9ERGS04sD/0M2lVaJg0yC8R1lozn4n50fsHvr8+RsKRUof8J3Av+M
         o586oO/5Z+mbQKXDP6AXRrQN59NHTqJTBwbPm+QOFk+7wPzya72wxgnDBacoP1k5paVC
         05EmxNPex8qzdKS+niweADiZjWf6UdzjiAjgs6y3FKo7DkxvzdhLaAOB7zocEwUp+wHQ
         v1eA==
X-Gm-Message-State: AOAM530bAYb6qD4ZGHIV5BEtIAPeVX+uEhvbOre9qJbF3cveSA6GP0N3
        PqEC9QSQBs8V+M0L8o1A7ug7ucD3nqI=
X-Google-Smtp-Source: ABdhPJxAyL36zQHeQpOK+bQKeJKKc+H68zY3EUmPqqgpdnrQJnOL8ZWiiHnmV64RP+8aIMYvdX31bw==
X-Received: by 2002:adf:b352:: with SMTP id k18mr8643138wrd.386.1595590964172;
        Fri, 24 Jul 2020 04:42:44 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b186sm7246297wme.1.2020.07.24.04.42.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2020 04:42:43 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [GIT PULL] interconnect changes for 5.9
Date:   Fri, 24 Jul 2020 14:42:44 +0300
Message-Id: <20200724114244.12094-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request with the interconnect changes for the 5.9-rc1
merge window. It contains some tiny core framework improvements. These
will allow us to support new provider drivers for Samsung and Nvidia
platforms, which are expected to land soon.

All patches have been in linux-next for the last few weeks without any
reported issues. Please pull into char-misc-next.

Thanks,
Georgi

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.9-rc1

for you to fetch changes up to 12a400b016ab955be8e4c569346fa18aaceed9d7:

  interconnect: Mark all dummy functions as static inline (2020-06-16 16:43:23 +0300)

----------------------------------------------------------------
interconnect changes for 5.9

Here are the interconnect changes for the 5.9-rc1 merge window
consisting mostly of changes that give the core more flexibility
in order to support some new provider drivers.

Core changes:
- Export of_icc_get_from_provider()
- Relax requirement in of_icc_get_from_provider()
- Allow inter-provider pairs to be configured
- Mark all dummy functions as static inline

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Artur Świgoń (3):
      interconnect: Export of_icc_get_from_provider()
      interconnect: Relax requirement in of_icc_get_from_provider()
      interconnect: Allow inter-provider pairs to be configured

Georgi Djakov (1):
      interconnect: Mark all dummy functions as static inline

 drivers/interconnect/core.c           | 16 ++++----
 include/linux/interconnect-provider.h | 16 ++++++--
 2 files changed, 20 insertions(+), 12 deletions(-)
