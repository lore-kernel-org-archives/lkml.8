Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF79C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198BD2311A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsDXHSR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgHFQrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:47:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30761 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729215AbgHFQpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596732315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=kQ8/0ag4BCcQ9dWEWrckB6cUtNt8F/dt5Qa3/Yht9h0=;
        b=EsDXHSR/3LJK4VJZPv04L6DM0XyDfhuzMq59WvMxrltBdjx7PGXA53D5kcR2CjL2+E8Ey/
        ADXKC8XwfLStAlkOSm5P8/6/waPT1oyQpwV/DtVBAcJzU1X/VE3s+hkJ70QeqrOZvt/0ic
        JpU1i6/zoUL8guzq/9kX12KbQ82UIr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-q7zoak4XPlC7eMMKlhdHXw-1; Thu, 06 Aug 2020 12:45:10 -0400
X-MC-Unique: q7zoak4XPlC7eMMKlhdHXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DCDD1005504;
        Thu,  6 Aug 2020 16:45:09 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F396010023A6;
        Thu,  6 Aug 2020 16:45:08 +0000 (UTC)
Date:   Thu, 6 Aug 2020 11:45:07 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] dlm updates for 5.9
Message-ID: <20200806164507.GC9935@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.9

This set includes a some improvements to the dlm networking layer:
improving the ability to trace dlm messages for debugging, and improved
handling of bad messages or disrupted connections.

Note two unusual things:
- There is a commit under net that was posted to netdev, which add a
  socket helper for setting a mark value on a socket.
- This branch was just rebased to drop a commit that was adding a tuning
  knob to adjust blocking during recovery; we decided there's not enough
  evidence it's necessary.

Thanks,
Dave

Alexander Aring (6):
      net: sock: add sock_set_mark
      fs: dlm: set skb mark for listen socket
      fs: dlm: set skb mark per peer socket
      fs: dlm: don't close socket on invalid message
      fs: dlm: change handling of reconnects
      fs: dlm: implement tcp graceful shutdown

Wang Hai (1):
      dlm: Fix kobject memleak

 fs/dlm/config.c    |  44 +++++++++++++++++++++++++++++
 fs/dlm/config.h    |   2 ++
 fs/dlm/lockspace.c |   6 ++--
 fs/dlm/lowcomms.c  | 131 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 include/net/sock.h |   1 +
 net/core/sock.c    |   8 ++++++
 6 files changed, 164 insertions(+), 28 deletions(-)

