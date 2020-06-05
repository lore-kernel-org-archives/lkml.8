Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81516C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC58207D3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dfoocfrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgFESSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:18:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28554 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726171AbgFESSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591381089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+Whulsqh2F7J7NlPFEUmiQ01SmA0ksSYcs3K0r2NWUw=;
        b=DfoocfrpB/qlkWTsnRre9Z4vNeh0+f3Q2KkynqZwMUsw3Z6aiY/4COFDuxpgMni6cP9hH2
        ZViEpwqb9tnXMLmBDgmPWRdcWCYVvrn2aDQ0oA+MNWLDvTsuIwNoFqLjPCk3P59KaLulbd
        lMWG7dd9zXPzbLJuEcQIbsMbh2/Ps4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-HXm56DacMJifWPCJWZ9tDg-1; Fri, 05 Jun 2020 14:18:06 -0400
X-MC-Unique: HXm56DacMJifWPCJWZ9tDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE35F801503;
        Fri,  5 Jun 2020 18:18:05 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7071D7B61A;
        Fri,  5 Jun 2020 18:18:05 +0000 (UTC)
Date:   Fri, 5 Jun 2020 13:18:03 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] dlm updates for 5.8
Message-ID: <20200605181803.GA4820@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.8

This set includes a couple minor cleanups, and dropping the
interruptible from a wait_event that waits for an event from
the userspace cluster management.

Thanks,
Dave

Arnd Bergmann (1):
      dlm: remove BUG() before panic()

Gustavo A. R. Silva (2):
      dlm: dlm_internal: Replace zero-length array with flexible-array member
      dlm: user: Replace zero-length array with flexible-array member

Ross Lagerwall (1):
      dlm: Switch to using wait_event()

Wu Bo (1):
      fs:dlm:remove unneeded semicolon in rcom.c

 fs/dlm/dlm_internal.h |  7 +++----
 fs/dlm/lockspace.c    | 18 ++++--------------
 fs/dlm/rcom.c         |  2 +-
 fs/dlm/user.c         |  2 +-
 4 files changed, 9 insertions(+), 20 deletions(-)

