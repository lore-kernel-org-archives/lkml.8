Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA0CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6CC207ED
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4qVqQ6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgEQRRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 13:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgEQRRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 13:17:39 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6884DC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 10:17:38 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so3614469pgv.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=irZJO6pbVEj3U3ABtpGtJ2F3x8dJhV+kA+LvCOkLQAM=;
        b=g4qVqQ6ZkbUaOpYMrTZnqO73gxbWCwKvh5D7cyC6sEpkb31VApFUJkeiVXI8OV4/I1
         +II/WcosEgv/XjaqGGWrfVCvq3R3g3WHkJVOpq+TfiYFNttx15tf1PIFpIswIdT17d/n
         aNVp37XfX3SjQxAcB5AjdVfsnOAokJaofT0BdJUeqewMCcgvauxoZ1v6rhbKhObFU1Pp
         atXYjCPXzvEwZ3t9+0KzI3ExOVD7flHH93pbSejT24Iw6b9OpwyONSO3lU4TzS6xRgF2
         BkSx6z1lUFttB+UrEnN6boxXJeKmx18dRAGawqdPUO2XiUESaNJ/M71Ks/jxzi+enHWw
         rCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=irZJO6pbVEj3U3ABtpGtJ2F3x8dJhV+kA+LvCOkLQAM=;
        b=XQ7yNR9L/1k9INsVi1y6pXavV7uMz+YdZcw4vUAFc77xQdiBn8radOgy8we6EI12zi
         fyWp+9pEWCxAVbgICzPqzjHCjfS04E9vFQQy71tn6lye6buVkNtxQnmyfGRdKYfpK0+U
         H2z60InErURyf4ePz9slJvHtmw0tLJkcDNj3U1MyzcjXokkx9oL+xS0cZooqRBvMNp0K
         mqrIJu1ajc8nyKFeV+ws7q+71+1YkFw/cVbKYUSE8OZliaxz6t/qbGM3rEZrGsY+fTvp
         n8bIFC5Oa0LxHk/DBJmA6qXrbK4rYZp4PeoaTBsrWS6oolxGDcNXl5/3jAKf9WX5D4wd
         uBhQ==
X-Gm-Message-State: AOAM533pXdvTFDIPoKmumDq54DXoIy3FTaQhfPYLDiz25bYW7QJxxbOJ
        xOSJm1zD2LXxTz/Nd5PxFk4=
X-Google-Smtp-Source: ABdhPJzDMqylgG25aUmEbtkKs3TZE0hUCFM05gws1ASXnZY92+suPYvDM/e5hNgUGz7wh+/sWDgzuQ==
X-Received: by 2002:a62:4e87:: with SMTP id c129mr13264991pfb.178.1589735856985;
        Sun, 17 May 2020 10:17:36 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.googlemail.com with ESMTPSA id n69sm6513900pjc.8.2020.05.17.10.17.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 May 2020 10:17:36 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>
Subject: [PATCH V1 0/6] Enable Greybus Audio codec driver
Date:   Sun, 17 May 2020 22:47:15 +0530
Message-Id: <cover.1589734179.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing GB Audio codec driver is dependent on MSM8994 Audio driver.
During the development stage, this depdency was configured due to
various changes involved in MSM Audio driver to enable addtional codec
card and some of the changes proposed in mainline ASoC framework.
However, these are not the real dependencies and some of them can be
easily removed.

The folowing patch series includes the changes to resolve unnecessary
depedencies and make the codec driver functional with the latest kernel.

Patch 1,2: Incudes jack framework related changes.
Patch 3,4,5: Resolves compilation error observed with the latest kernel and
also provides helper APIs required to allow dynamic addition/removal of
modules.
Patch 6: Finally provides config options and related Makefile changes to
enable GB Codec driver.

Thanks to Alexandre for raising the headsup [1] and motivating me to provide
the necessary changes.

[1] https://lore.kernel.org/lkml/20200507212912.599433-1-alexandre.belloni@bootlin.com/

Vaibhav Agarwal (6):
  staging: greybus: audio: Update snd_jack FW usage as per new APIs
  staging: greybus: audio: Maintain jack list within GB Audio module
  staging: greybus: audio: Resolve compilation errors for GB codec
    module
  staging: greybus: audio: Resolve compilation error in topology parser
  staging: greybus: audio: Add helper APIs for dynamic audio modules
  staging: greybus: audio: Enable GB codec, audio module compilation.

 drivers/staging/greybus/Kconfig          |  14 ++-
 drivers/staging/greybus/Makefile         |   6 +-
 drivers/staging/greybus/audio_codec.c    | 187 ++++++++++++++++++-----------
 drivers/staging/greybus/audio_codec.h    |  12 +-
 drivers/staging/greybus/audio_helper.c   | 197 +++++++++++++++++++++++++++++++
 drivers/staging/greybus/audio_helper.h   |  17 +++
 drivers/staging/greybus/audio_module.c   |  20 ++--
 drivers/staging/greybus/audio_topology.c | 130 ++++++++++----------
 8 files changed, 427 insertions(+), 156 deletions(-)
 create mode 100644 drivers/staging/greybus/audio_helper.c
 create mode 100644 drivers/staging/greybus/audio_helper.h

-- 
2.7.4

