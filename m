Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E98C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D10542075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LEtQhL50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgG3Jlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:41:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48127 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726615AbgG3Jlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596102112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z/7Qd3wsnadFWk6UFhwP36lWCWF/fRdGUrRZnq1R5GQ=;
        b=LEtQhL50h4uPfd5cyNK5/CmxDJqq4wVHQUhr5+yb7xrq4yRrbazOYEDHp+ySxXlsZrOEGG
        os447Gy4AFUYCwCYVxQNcJTVtlktPnQeGANnNP5O2dIPBFg/EeSH2J+pR2Ld8oTPSyDUw5
        bGybbR1pamDWhvWYjj3/tA2ntRVGpCg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-y7ltPvRfPgyOAiM0PrQE1Q-1; Thu, 30 Jul 2020 05:41:48 -0400
X-MC-Unique: y7ltPvRfPgyOAiM0PrQE1Q-1
Received: by mail-wr1-f71.google.com with SMTP id b13so4964130wrq.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z/7Qd3wsnadFWk6UFhwP36lWCWF/fRdGUrRZnq1R5GQ=;
        b=AurbopTN3Y/Op3I4cBO/AIIHDuO3DKUgzl5aJA7Dvx+WTpuXeRZO1wLpuNErAl3iGm
         qg8XfYPlvFFeLnDCUo1mapZj/1rO6wL//euBgdpRfWBZmRqWHq6bsLqvH1gZ9R22DyzZ
         RoVD+EJuf52d9yzj2fnQF+7g1nYTMN4WNUoI0RUlGnCZJ4uf8n/mi7KTwwdFFZqxZGcL
         DNQxnWDR4JX7iNdwf/yhVYFVBC6XZplmyMFQONhrvT2jsFKXIyqX+VImnnjJDvL+8Fem
         cf5kKdGDAwWpWdmyF8dsQ3GKYmTw+aXkW6A/HxWDlSyarP9jLjRhzNEjPOmhv3L5ykDU
         7jfw==
X-Gm-Message-State: AOAM533vBfyyIvakI2sxrHQRNXDnupyvDGFd+tejw9+Cxzy1D+rliH3R
        nI1FsWxpdDlm/LN+rHD/UoTQ8o6dAjhXyf/jvoYV9d90JRzTUsbNPepd52c4thjA9bZgH0/Ms29
        G1ej6BnbU+N3YyugF1AmfyCRb
X-Received: by 2002:a1c:2985:: with SMTP id p127mr12183510wmp.166.1596102107293;
        Thu, 30 Jul 2020 02:41:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9vIJKhZuAHTmv4Miz7yAuwrrrHcdQ9B9CapRuKDydu506ZjLSuNVa9FGD2rtPmgAhUmLvFA==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr12183488wmp.166.1596102107035;
        Thu, 30 Jul 2020 02:41:47 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id w2sm10984807wre.5.2020.07.30.02.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:41:46 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mhelsley@vmware.com,
        mbenes@suse.cz, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 0/4] Remove dependency of check subcmd upon orc
Date:   Thu, 30 Jul 2020 10:41:39 +0100
Message-Id: <20200730094143.27494-1-jthierry@redhat.com>
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


Changes since v2 [2]:
- Rebased on recent tip/objtool/core

[1] https://www.spinics.net/lists/kernel/msg3510844.html
[2] https://lkml.org/lkml/2020/6/8/59

Cheers,

Julien

-->

Julien Thierry (4):
  objtool: Move object file loading out of check
  objtool: Move orc outside of check
  objtool: orc: Skip setting orc_entry for non-text sections
  objtool: orc_gen: Move orc_entry out of instruction structure

 tools/objtool/builtin-check.c |  7 ++-
 tools/objtool/builtin-orc.c   | 27 +++++++++++-
 tools/objtool/check.c         | 47 ++++----------------
 tools/objtool/check.h         |  1 -
 tools/objtool/objtool.c       | 30 +++++++++++++
 tools/objtool/objtool.h       |  5 ++-
 tools/objtool/orc_gen.c       | 83 ++++++++++++++++++++---------------
 tools/objtool/weak.c          |  4 +-
 8 files changed, 122 insertions(+), 82 deletions(-)

--
2.21.3

