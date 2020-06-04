Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D958C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F9C20738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgm9HtO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbgFDQkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:40:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25719 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729657AbgFDQjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591288787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sQfD7DfM7A0Gmivi6tpLXZMhnc7A3tGFd2gq5rfU1s4=;
        b=hgm9HtO2+4NYjpldlY0Xvy8njEXaf9xRZorjXj6JNpqZMLnoABsyBkkTEkeYzU+lAv94CP
        3MnQ+y5tIvYB4EQogbTX90xpVZsZRgMU+kn5BbgwfGp4m6LnFNiG0AN0ULZKlP+BQBkE/1
        pMYkiZxiytt3YIhuhr5EUe5sA/Zq4uw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-4LIgXZ_uOcCTvr2_P8FZcg-1; Thu, 04 Jun 2020 12:39:44 -0400
X-MC-Unique: 4LIgXZ_uOcCTvr2_P8FZcg-1
Received: by mail-wr1-f71.google.com with SMTP id h6so2665558wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sQfD7DfM7A0Gmivi6tpLXZMhnc7A3tGFd2gq5rfU1s4=;
        b=So0GJqJslF2JPv3NSt2a6xFCJXmjEqud1xqUHn+J8xmXczaedU765FAMxXycxlEcBt
         GGzRR5u/13U6JCUVFyRzwYB7JHd2JzS3CNsMYKC/7JXQQ/zLO9OFuSmkLxpMhz1Xk/0g
         Zd6MIWAGZX8gq6rjMe6DcogB6Ybl2SEF0mD1FydBhXnIyjNa19TGmj0LVwvBA7+Vfeuw
         lNBevTkq4TYBacyYWuK1lE3PusIT0TKJjYIqQ4mMZMky261o0gFTK/3vx7ney34Pz55a
         o8RD/PMTmXp+r4qf0Mt4H2nhEaZ1snB76nessVG/S8AFcnC3TIWxGwllXZzT7YP5BWeG
         a2dQ==
X-Gm-Message-State: AOAM531XtnveZy4Ghsz8uPnFGtaG7O+52kbO+n3X24kEbxvJouFVrlAW
        4DQA5Q52aIflybqnUu8qv8ueT5KqXNkCjsQnad0Vy8zQt6VB+Q+4wMOAGK0t2kHAXYqdfGys2ip
        44Xm+qNG7Z+iaEP8/NAUyNGNw
X-Received: by 2002:a05:6000:10c3:: with SMTP id b3mr5605452wrx.53.1591288782771;
        Thu, 04 Jun 2020 09:39:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/iZt4qBXPIMd9t0x1KbJliF+RE629lbzbGD/TDpfh53s+jzO/S3om9jhWda/I5co04K1QRg==
X-Received: by 2002:a05:6000:10c3:: with SMTP id b3mr5605438wrx.53.1591288782588;
        Thu, 04 Jun 2020 09:39:42 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id p9sm7881636wma.48.2020.06.04.09.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 09:39:42 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mhelsley@vmware.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 0/4] Remove dependency of check subcmd upon orc
Date:   Thu,  4 Jun 2020 17:39:34 +0100
Message-Id: <20200604163938.21660-1-jthierry@redhat.com>
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

[1] https://www.spinics.net/lists/kernel/msg3510844.html

Cheers,

Julien Thierry (4):
  objtool: Move object file loading out of check
  objtool: Move orc outside of check
  objtool: orc: Skip setting orc_entry for non-text sections
  objtool: orc_gen: Move orc_entry out of instruction structure

 tools/objtool/builtin-check.c |  7 ++-
 tools/objtool/builtin-orc.c   | 24 +++++++++-
 tools/objtool/check.c         | 45 ++++--------------
 tools/objtool/check.h         |  1 -
 tools/objtool/objtool.c       | 30 ++++++++++++
 tools/objtool/objtool.h       |  5 +-
 tools/objtool/orc_gen.c       | 86 ++++++++++++++++++++---------------
 tools/objtool/weak.c          |  4 +-
 8 files changed, 122 insertions(+), 80 deletions(-)

--
2.21.1

