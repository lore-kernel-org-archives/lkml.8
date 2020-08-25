Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACA2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D9E20767
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nl3t5kUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgHYMsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:48:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48609 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728215AbgHYMrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598359668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WQqeovEos31NURIhF+93BKAu0gcYl/FcEI3tiNqMNwY=;
        b=Nl3t5kUn4qhM258Z2m9qWKi9Qpo3pCPnXf/Z5X5ecf4VDjAqxk8av/bKHa0HcwEO3SOEFT
        1zweJgJ4nmq8Jlmwanbh2SuTZwQZmLjE8ZOqbDgb+FYjQs49NOk+O+1k/79rBrAhprY12k
        uT2QbpcNWgoWvk+onYXZNcLCzsOvA/I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-PJ41S8w9PeqvuRW_Ug-0ig-1; Tue, 25 Aug 2020 08:47:47 -0400
X-MC-Unique: PJ41S8w9PeqvuRW_Ug-0ig-1
Received: by mail-wm1-f71.google.com with SMTP id z25so690991wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WQqeovEos31NURIhF+93BKAu0gcYl/FcEI3tiNqMNwY=;
        b=SMT2CD/jdojwDL8MuZbiy/XP8YL+JO0B11nUfzE0ogbS3Aub8iZF0hneUsn5L9NIKO
         0r6r/PR9Y/TOCEwxkABFCKtOaLhVYeDYf+5XnuoM7yrATaGGHcORqvWUYClFeEhjYiZq
         x+WgEXRv2MXvgMmm9ly6kfEsLQQBa5CpbLobUtQsTPJCW+1BrA0kJ3vfZ9DjEKgif32n
         0EJUW0r4+SEpuU2xRKquS0s9ztRSRMeaUAKBSggMjne/1Mmyq5yxeuRPsT21n3VA8LSs
         NCQWUjhydZUkdFzStIHuVLGMYf+hL/QYXtHtKaRvf3uGOM/pErzRkpPTFLyZ45NVBQX6
         eCXQ==
X-Gm-Message-State: AOAM530r1B3eiDERXHJkdgMWwqxBt7XiCvo4VilQsizbQJWB+OaQsirS
        YGrRPjdB1wFpA5aXPP5r6Um5bvvXzeXUsXacTBnpcn6OWeizTYNPn4HUOF9QvBe1PypIER0uGxg
        Nw9rMGJ3pcVg63l8pWPGfT3Z7
X-Received: by 2002:adf:e812:: with SMTP id o18mr10911988wrm.29.1598359665452;
        Tue, 25 Aug 2020 05:47:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPGbty69o0UQCbA+Zv1jCAkzVLOG/OeElcNlwe+hsyYaJQ+zPfrYyHq7C50AkxHv7mYp+v4Q==
X-Received: by 2002:adf:e812:: with SMTP id o18mr10911974wrm.29.1598359665281;
        Tue, 25 Aug 2020 05:47:45 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id u6sm27469306wrn.95.2020.08.25.05.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 05:47:44 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        benh@kernel.crashing.org, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v4 0/4] Remove dependency of check subcmd upon orc
Date:   Tue, 25 Aug 2020 13:47:38 +0100
Message-Id: <20200825124742.29782-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Matt Helsley's change[1] provided a base framework to opt-in/out
objtool subcommands at compile time. This makes it easier for
architectures to port objtool, one subcommand at a time.

Orc generation relies on the check operation implementation. However,
the way this is done causes the check implementation to depend on the
implementation of orc generation functions to call if orc generation is
requested. This means that in order to implement check subcmd, orc
subcmd also need to be implemented.

These patches aim at removing that dependency, having orc subcmd
being built on top of the check subcmd.


Changes since v3 [2]:
- Rebased on v5.9-rc1
- Renamed objtool_setup_file() to objtool_open_read()
- Fixed misplaced elf_write() when file->elf->changed is true
- Avoid additional allocation for orc data and compile out orc
  definition when not needed instead

[1] https://www.spinics.net/lists/kernel/msg3510844.html
[2] https://lkml.org/lkml/2020/7/30/415

Cheers,

Julien

-->

Julien Thierry (4):
  objtool: Move object file loading out of check
  objtool: Move orc outside of check
  objtool: orc: Skip setting orc_entry for non-text sections
  objtool: check: Use orc definition only when needed

 tools/objtool/Makefile        |  4 +++
 tools/objtool/arch.h          |  2 ++
 tools/objtool/builtin-check.c | 15 ++++++++++-
 tools/objtool/builtin-orc.c   | 27 +++++++++++++++++++-
 tools/objtool/check.c         | 47 ++++++-----------------------------
 tools/objtool/check.h         |  2 ++
 tools/objtool/objtool.c       | 29 +++++++++++++++++++++
 tools/objtool/objtool.h       |  4 ++-
 tools/objtool/orc_gen.c       |  3 +++
 tools/objtool/weak.c          |  4 +--
 10 files changed, 92 insertions(+), 45 deletions(-)

--
2.21.3

