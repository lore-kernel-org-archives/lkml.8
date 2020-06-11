Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D67C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6C220829
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ObrWu3gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgFKQnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:43:50 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:49224 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726441AbgFKQnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:43:50 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 4E53C2E161D;
        Thu, 11 Jun 2020 19:43:47 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id QP4aRPdUbY-hj6a89VL;
        Thu, 11 Jun 2020 19:43:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1591893827; bh=EFVYIbdee4/gqamUqSCCUMt5aNXpP7EfA75Cnk/jXt8=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=ObrWu3gmSAPBmg9wBfovya2GcJvQiZwJE7OkyF5HKzRndJiRi5D+PZmAZxYmOihM9
         62IA64q8lZJ38EqskO5z7He2L7PUzy7Sx3ub6iQ3ImLwv9sA55m+zWDNCXoQginssR
         24KZmEeOehzR0LE1FCjoygofxOoGdGAexEc6rOBc=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 37.9.121.110-vpn.dhcp.yndx.net (37.9.121.110-vpn.dhcp.yndx.net [37.9.121.110])
        by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Q6CayAinZw-hjWaeBXS;
        Thu, 11 Jun 2020 19:43:45 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Yakunin <zeil@yandex-team.ru>
To:     osalvador@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com, max7255@yandex-team.ru
Subject: Re: [RFC PATCH v2 00/16] Hwpoison rework {hard,soft}-offline
Date:   Thu, 11 Jun 2020 19:43:19 +0300
Message-Id: <20200611164319.16860-1-zeil@yandex-team.ru>
In-Reply-To: <20191017142123.24245-1-osalvador@suse.de>
References: <20191017142123.24245-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

We are faced with similar problems with hwpoisoned pages
on one of our production clusters after kernel update to stable 4.19.
Application that does a lot of memory allocations sometimes caught SIGBUS signal
with message in dmesg about hardware memory corruption fault.
In kernel and mce logs we saw messages about soft offlining pages with
correctable errors. Those events always had happened before application
was killed. This is not the behavior we expect. We want our application to
continue working on a smaller set of available pages in the system.

This issue is difficult to reproduce, but we suppose that the reason for such
behavior is that compaction does not check for page poisonness while processing
free pages, so as a result valid userspace data gets migrated to bad pages.
We wrote the simple test:
  - soft offline first 4 pages in every 64 continuous pages in ZONE_NORMAL
    through writing pfn to /sys/devices/system/memory/soft_offline_page
  - force compaction by echo 1 >> /proc/sys/vm/compact_memory
Without this patch series after these steps bash became unusable
and every attempt to run any command leads to SIGBUS with message about
hardware memory corruption fault. And after applying this series to our kernel
tree we cannot reproduce such SIGBUSes by our test. On upstream kernel 5.7
this behavior is still reproducible.

So, we want to know, why this patchset wasn't merged to the upstream?
Is there any problems in such rework for {soft,hard}-offline handling?
BTW, this patchset should be updated with upstream changes in mm.

Thanks for you replies.

--
Dmitry Yakunin
