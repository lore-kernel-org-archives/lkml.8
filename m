Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0B0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 00:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB907207BB
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 00:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WaYcfZKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgFBAtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 20:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFBAtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 20:49:12 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E723C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 17:49:12 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z5so11049835ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 17:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hSYlpejsvywh9sHVQtlT/OLvvib16yqx/0D9m84zGsc=;
        b=WaYcfZKAy5mbuVKEqBa2mSMpgNmM7HONYl6mI0eeHqewZg2Mt0CaK7wA4GwBZcFuXB
         weat3O1HTGuVGMgZIGN9Op/lIOqTBRvdSJ6r2BJnnx/ujCvZ5tJctIHxoSlGcD3MDKUd
         A0LIjfTmeY1fFJBhSNlJj86QeFlSenx7pB6CccgcpqnmS6pMQkIVyQcAhpyyMmtGVR8h
         j48LO/Tb9DDTiVr85iaYKnP5jCT/Gz8I8oNxHNq0SyNJJl+xbUJV4RJQknGWnuNVoKTS
         zBhyP8+/JS0i6LgbGypaXbYQ8/DNkJ1Yq0VcuBb5BYm5IPU6AKo5gKqY/aG9N8PWbowy
         1X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hSYlpejsvywh9sHVQtlT/OLvvib16yqx/0D9m84zGsc=;
        b=Q1H0PrtHzKCBdy/ECb0SY1G7gPnjst2naaaGVrSFfodyV67QwtHURCv/mrWkA+KB74
         2y4Ywa0J7VpxM2fwxgd/1br0X698giT8JUN2IWoFsrzzArTipOnfEpqRo7ivOBNigMku
         Bsyn0hmYRvpFl1NEX4pnZ1sY8ZYdyuDNvBTVNiRPEm7drJpUglcKAgSAFenAGPGsQ8Dw
         gnwPqdpFi9hrWHkj3S1EZ0Wr821Vl/bqnnTTC+CvRZgNXotZlgtPEzUmfZBEg3hHzv4l
         qcBGb9p/HoR9qKK6ZK4ZFdSs23KEgJdEl6FYb5ZVsyLZoBkHmJ/4htNARwjBjG6OpM1b
         Jb6Q==
X-Gm-Message-State: AOAM533qYIyewHw1u0QoP1abcBy7+GTwAMhHjHYfi0Qu7Ltn1FTSNzOn
        U12vr9Wkg+grpXeFx+G30yILn9LEOxVP8Y1mGYYk951uhQ==
X-Google-Smtp-Source: ABdhPJy/vttsQNaDUQlDfH83cE90V+Tdpb9iW20QoKXFDwTKaHbuoSov682reY1NrdOcnvvYCUJ7A4DwT7GfbhArnHY=
X-Received: by 2002:a17:906:e257:: with SMTP id gq23mr2274991ejb.398.1591058950669;
 Mon, 01 Jun 2020 17:49:10 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Jun 2020 20:48:59 -0400
Message-ID: <CAHC9VhQqnAG5DxvoQKa643d06rDTVtHVFEj5arCsHwyoamCckA@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the set of audit patches for the v5.8 merge window, all
patches pass our test suite and as of a few minutes ago they also
merge cleanly with the top of your tree.  Unfortunately I just noticed
that one of the commit subject lines is truncated - sorry about that,
it's my fault not Richard's - but since the important part is there
("add subj creds to NETFILTER_CFG") I opted to leave it as-is and not
disrupt the git log.  If you would rather have the subject line fixed,
let me know and I'll correct it.

A quick summary of the significant patches:

- Record information about binds/unbinds to the audit multicast
socket.  This helps identify which processes have/had access to the
information in the audit stream.

- Cleanup and add some additional information to the netfilter
configuration events collected by audit.

- Fix some of the audit error handling code so we don't leak network
namespace references.

Thanks,
-Paul

--
The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

 Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20200601

for you to fetch changes up to 9d44a121c5a79bc8a9d67c058456bd52a83c79e7:

 audit: add subj creds to NETFILTER_CFG record to
   (2020-05-20 18:09:19 -0400)

----------------------------------------------------------------
audit/stable-5.8 PR 20200601

----------------------------------------------------------------
Gustavo A. R. Silva (1):
     audit: Replace zero-length array with flexible-array

Paul Moore (2):
     audit: fix a net reference leak in audit_send_reply()
     audit: fix a net reference leak in audit_list_rules_send()

Richard Guy Briggs (4):
     audit: log audit netlink multicast bind and unbind
     audit: tidy and extend netfilter_cfg x_tables
     netfilter: add audit table unregister actions
     audit: add subj creds to NETFILTER_CFG record to

Zheng Bin (1):
     audit: make symbol 'audit_nfcfgs' static

include/linux/audit.h           |  24 +++++++++-
include/uapi/linux/audit.h      |   1 +
kernel/audit.c                  | 100 +++++++++++++++++++++++++++---------
kernel/audit.h                  |   2 +-
kernel/auditfilter.c            |  16 +++----
kernel/auditsc.c                |  31 +++++++++++++
net/bridge/netfilter/ebtables.c |  14 +++---
net/netfilter/x_tables.c        |  14 ++----
8 files changed, 148 insertions(+), 54 deletions(-)

-- 
paul moore
www.paul-moore.com
