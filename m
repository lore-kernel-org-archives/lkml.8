Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB32C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18C12071A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592484627;
	bh=mH2WUMU2W0IAN261gTllCz6ShbMxBaQh+j3VCU1IBsI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eCwdfNV2JPjPE+VtsaDHsDdIjwUudGrHueHwQBDxZXHVQMslZiXUZViSt5zo/nLOS
	 OcExipOF3nd9xeZXxXB6ypQZbESq1Dco5Q2LrNncE6UFwmGLXa+I9lCHo82z3hiuvw
	 yZ2F74WdwnK6+qo4BJrVQ1pSSBJAdUudMfKadnBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbgFRMu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729557AbgFRMu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:50:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB8C206F7;
        Thu, 18 Jun 2020 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592484625;
        bh=mH2WUMU2W0IAN261gTllCz6ShbMxBaQh+j3VCU1IBsI=;
        h=From:To:Cc:Subject:Date:From;
        b=SmWxU/4cZFOHNHAL1wyhzBu2kWokA1rjEX5nXXgqVZPMHo3mnCH5VaLQs70RW3pjz
         vtU07azgHkCIY3iluKNqoxwe1cKwivrSiP3RlWVw1y5zbzi1o93UkzcuDcEeeY6g2d
         Bo5tpka96Ahc6s1iopI56l4/gHMIfATKj4qtUSP8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.7.4
Date:   Thu, 18 Jun 2020 14:50:16 +0200
Message-Id: <1592484616163232@kroah.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.7.4 kernel.

All users of the 5.7 kernel series must upgrade.

The updated 5.7.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.7.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                |    2 +-
 lib/vdso/gettimeofday.c |   11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

Greg Kroah-Hartman (1):
      Linux 5.7.4

Thomas Gleixner (1):
      lib/vdso: Provide sanity check for cycles (again)

