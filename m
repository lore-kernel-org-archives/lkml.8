Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7810C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09B92076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHP0scdr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgFHHMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:12:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50882 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728031AbgFHHMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591600331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UKw4nUSw4BdzvgbqOoPUtQ7cMhbZk2SwHrFMooyJ43Y=;
        b=UHP0scdruFQTjMB5YTVGsrZISkMWb75fUNLjQeahghgjzmgLFrEyqOy7GN5AlSQgmbkx8g
        kBDSfvY+ALX8qmXhn0b55x5X05KP/Y67Rr6Y+cgnYj0Ra20MEsN+FAKWfBsfmcNostYGuN
        U6v99IxeoLNXLYHW5hb1fXISs5isa9I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-p6ErVTJmMmeC3YdOdsWQKQ-1; Mon, 08 Jun 2020 03:12:08 -0400
X-MC-Unique: p6ErVTJmMmeC3YdOdsWQKQ-1
Received: by mail-wr1-f71.google.com with SMTP id m14so6763505wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 00:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UKw4nUSw4BdzvgbqOoPUtQ7cMhbZk2SwHrFMooyJ43Y=;
        b=t/uVB+HdWXTaPalPuXHXvPp4hLih3tA/POS6NUqhTV49z84T8pfSU8mdEqBIYzl6jI
         a+JltCB8W+8MTa3Ughfvw4bKrpdmhn35rus2v8AQcGsZKXb0HYK3Y49NXau9zPfQx6My
         JilqJrJp0RQlkwGM729tXbCRoPUYlFuoYvTq0JQfvwO61Hi4Bq+m5O6SWeZNeEvEFqVH
         m0OK3uW0HHDNr2kaUxaGOtzuM092Kl3wAaGiuRPD+cgGUPD+kwkBHkiS27WmrgUnrQgS
         966WYRsDhGk4VfR3+E9542pFx6Lfaaa8uRMLi91m7JgRAGrJiUXWBUPYp5GsS/C0SKZt
         bV3w==
X-Gm-Message-State: AOAM530vFePWfXVtA7Cldg8FutTwBdFZ5uyKuFcFXuZ8WQ48xQmHyVoc
        aNWb0xrKxksrAHW02cybpPhhzKdicZG5yr1fwQGVKUgivLS3kxUJ1f/z+q2wOZqizHBW4+81oB0
        xbQcMOLDCyVV0JEEVyR4KYmoj
X-Received: by 2002:a5d:42cd:: with SMTP id t13mr21516683wrr.355.1591600327146;
        Mon, 08 Jun 2020 00:12:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVt3Gpz4ofXYQ7FCSZRd7dy1tSlpmDHN44eyxOwWyKlj3SHMvIBTBjO3wVXXyIykKUl2Onng==
X-Received: by 2002:a5d:42cd:: with SMTP id t13mr21516669wrr.355.1591600326960;
        Mon, 08 Jun 2020 00:12:06 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id w17sm22908254wra.71.2020.06.08.00.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 00:12:06 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mhelsley@vmware.com,
        mbenes@suse.cz, Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 0/4] Remove dependency of check subcmd upon orc
Date:   Mon,  8 Jun 2020 08:11:59 +0100
Message-Id: <20200608071203.4055-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
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

Changes since v1 [2]:
- Remove redundant check in create_orc pointed out by Miroslav

[1] https://www.spinics.net/lists/kernel/msg3510844.html
[2] https://lkml.org/lkml/2020/6/4/675

Cheers,

Julien

-->

Julien Thierry (4):
  objtool: Move object file loading out of check
  objtool: Move orc outside of check
  objtool: orc: Skip setting orc_entry for non-text sections
  objtool: orc_gen: Move orc_entry out of instruction structure

 tools/objtool/builtin-check.c |  7 ++-
 tools/objtool/builtin-orc.c   | 24 +++++++++-
 tools/objtool/check.c         | 45 ++++---------------
 tools/objtool/check.h         |  1 -
 tools/objtool/objtool.c       | 30 +++++++++++++
 tools/objtool/objtool.h       |  5 ++-
 tools/objtool/orc_gen.c       | 83 ++++++++++++++++++++---------------
 tools/objtool/weak.c          |  4 +-
 8 files changed, 119 insertions(+), 80 deletions(-)

--
2.21.1

