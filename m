Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D65C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F2020709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNiEsHes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgEOKyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgEOKyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:54:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDAEC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:54:49 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k13so901900wrx.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrzatufmWMFK4nc+SyNHiLXMRZJb5huqueu1eUCpxaw=;
        b=UNiEsHesxvLve4xIcfnKQRDlhKutjhuE1l+mIPf8lfPC95oL0CEDM4WHWzO5oS+BpJ
         Uuby/iDGEsRPGOq6uU+njFsyfCbN7UtqCtqCJEU5Ye8TFdgNe3V+QeyliWyBesPaVDOF
         0+ZH6RItlNXvsQBNXI6wzHttoHb+nHOFj8cr2/arRJuFVzn0a9E3WE9HJV+Kp877dpLj
         SgX5YNKNhNXw8FkQKgvj8pqUNu/muER98dQ3S+9e6sLAiHWPpzws7QOtTttpxLeAFK68
         ujG2qZAjxPN5aULyLiZQ+w8U+XUNCS5DGp94KzMQPVMh2UffSOhpZhVQHXpwg6OGS64y
         UElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jrzatufmWMFK4nc+SyNHiLXMRZJb5huqueu1eUCpxaw=;
        b=IZDY7lgWxinzYEHXDpxIXZKPsJPiu9v3kR+o+vZFxfZpKa3WjISI9wxntTeGE+FEYr
         cbKjDaMUbPY4Z4RVQjuZiBggIAw0vktHc2c2hPCIwtPtEKTzvTzYJcGwOFztPHVTLYp4
         1/kljY4dqmGgQyRnaWsECvOQQMsAVkNIFtaMlBW0Cg9bzhpflOdlZ1BESmoMkYQy5lHa
         kXH135HeqBZtelRYisv5F+fFy4NkJS9Zd1LA5qWvitO50eTI0QuGh41E4w6XcpVWF2DH
         W0RtBkRBG0OAF3fzZT1M/merGTJpDok0Agb9uBA0IQA1DqZ4crtxLl+tNpHjfMpG7MIH
         Ho+w==
X-Gm-Message-State: AOAM530LNpbmQewkpzdGl0QAObZ4J3Qq77V2fYzP6di7cgBeR0rQi3Ux
        jjf/cMN477IWVxcRxVNBfwwBxO/2
X-Google-Smtp-Source: ABdhPJynJhkxBm8TgFfT7qhd1M+X+ZR4CQyrTHTNksxeadYFWLIyg+T9Lg/A0X+wXQnfO2rV/2D2lg==
X-Received: by 2002:a5d:684a:: with SMTP id o10mr3528254wrw.311.1589540087512;
        Fri, 15 May 2020 03:54:47 -0700 (PDT)
Received: from localhost.localdomain (cpc91192-cmbg18-2-0-cust374.5-4.cable.virginm.net. [80.6.113.119])
        by smtp.gmail.com with ESMTPSA id v205sm3102988wmg.11.2020.05.15.03.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:54:46 -0700 (PDT)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: get_maintainer.pl: unexpected behaviour for path/to//file
Date:   Fri, 15 May 2020 11:52:03 +0100
Message-Id: <20200515105203.2792466-1-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Recently I've noticed that get_maintainer behaves differently if there
is a double, sequential, forward slash in the path.

AFAICT there should be no distinction between the two. Or at least many
existing applications and scripts consider them one and the same.

I've tried fixing this, although my perl isn't quite up-to scratch.
Is this some weird bug or some intended feature?

Thanks
Emil

Example:

./scripts/get_maintainer -F drivers/gpu/drm//lima

David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS,commit_signer:3/42=7%)
Qiang Yu <yuq825@gmail.com> (commit_signer:36/42=86%,authored:24/42=57%)
Vasily Khoruzhick <anarsoul@gmail.com> (commit_signer:26/42=62%)
Krzysztof Kozlowski <krzk@kernel.org> (commit_signer:5/42=12%,authored:5/42=12%)
Emil Velikov <emil.velikov@collabora.com> (commit_signer:4/42=10%)
dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
linux-kernel@vger.kernel.org (open list)

./scripts/get_maintainer -F drivers/gpu/drm/lima

Qiang Yu <yuq825@gmail.com> (maintainer:DRM DRIVERS FOR LIMA)
David Airlie <airlied@linux.ie> (maintainer:DRM DRIVERS)
Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR LIMA)
lima@lists.freedesktop.org (moderated list:DRM DRIVERS FOR LIMA)
linux-kernel@vger.kernel.org (open list)
