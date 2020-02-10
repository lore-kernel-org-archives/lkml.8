Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78676C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4780E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgBJH13 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 02:27:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:63909 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgBJH13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 02:27:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 23:27:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,424,1574150400"; 
   d="scan'208";a="346993403"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2020 23:27:28 -0800
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 9 Feb 2020 23:27:27 -0800
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 9 Feb 2020 23:27:27 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.126]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.46]) with mapi id 14.03.0439.000;
 Mon, 10 Feb 2020 15:27:25 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "tysand@google.com" <tysand@google.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "alexander.h.duyck@linux.intel.com" 
        <alexander.h.duyck@linux.intel.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "namit@vmware.com" <namit@vmware.com>
Subject: RE: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Thread-Topic: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Thread-Index: AQHV3Mq/N+pHUOUW3kyXc/hsfZBMQqgQuBMAgAL6SVD//5pYgIAAuzDw
Date:   Mon, 10 Feb 2020 07:27:25 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73E42AD6D@shsmsx102.ccr.corp.intel.com>
References: <345addae-0945-2f49-52cf-8e53446e63b2@i-love.sakura.ne.jp>
 <286AC319A985734F985F78AFA26841F73E429F32@shsmsx102.ccr.corp.intel.com>
 <202002100357.01A3vNNU089831@www262.sakura.ne.jp>
In-Reply-To: <202002100357.01A3vNNU089831@www262.sakura.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 10, 2020 11:57 AM, Tetsuo Handa wrote:
> Then, "node-A's NR_FILE_PAGES is already 0 and node-B's NR_FILE_PAGES is
> not 0, but allocation request which triggered this shrinker wants to allocate
> from only node-A"
> would be confused by this change, for the pagecache pages for allocating
> thread's interested node are already depleted but the balloon cannot shrink
> when it should because the pagecache pages for allocating thread's
> uninterested nodes are not yet depleted.

The existing balloon isn't numa aware. "but the balloon cannot shrink " - even we
let balloon to shrink, it could shrink pages from the uninterested node.

When we have a numa aware balloon, we could further update the shrinker
to check with the per node counter , node_page_state(NR_FILE_PAGES).

> 
> >
> Well, my comment is rather: "Do not try to reserve guest's memory. In other
> words, do not try to maintain balloons on the guest side. Since host would
> be able to cache file data on the host's cache, guests would be able to
> quickly fetch file data from host's cache via normal I/O requests." ;-)

Didn't this one. The discussion was about guest pagecache pages v.s. guest balloon pages.
Why is host's pagecache here?

Best,
Wei
