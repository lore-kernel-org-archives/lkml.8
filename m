Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D099C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B0224683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ci/4U15Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgA1QJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:09:45 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:23951 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgA1QJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580227784; x=1611763784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=UKZCaC+hnyao15bB/vOGmUC59yDB6b1Xjy94Qevzl9s=;
  b=ci/4U15YQAQTxfUoYbPZQLcRESxcDBKqHjRTYp5u6eJ0pr5exoYx9a42
   mhdkXFXDKM2nNM1mkmYjOGrpG8j6re+hFklHEJ3MsJdGGghqKO3pW8FkP
   zVNzxSjUWFgVfxY9LG7f8Wra/DnLbOqD//9husj5R/bRd8kl6hAmtmSuu
   0=;
IronPort-SDR: hNv10iBD2veD9e759UD4yjagpQPOv0m0KnF6N1HHbgtxPLEGM7nSN8xlf6fpqw7qoLwEwIvvCy
 lmwhefhCVHJA==
X-IronPort-AV: E=Sophos;i="5.70,374,1574121600"; 
   d="scan'208";a="13686278"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 28 Jan 2020 16:09:43 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id D7E57A21D1;
        Tue, 28 Jan 2020 16:09:37 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 28 Jan 2020 16:09:37 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.133) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 Jan 2020 16:09:28 +0000
From:   <sjpark@amazon.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, <sj38.park@gmail.com>,
        <acme@kernel.org>, <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <corbet@lwn.net>, <dwmw@amazon.com>, <mgorman@suse.de>,
        <rostedt@goodmis.org>, <kirill@shutemov.name>,
        <brendanhiggins@google.com>, <colin.king@canonical.com>,
        <minchan@kernel.org>, <vdavydov.dev@gmail.com>,
        <vdavydov@parallels.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v2 1/9] mm: Introduce Data Access MONitor (DAMON)
Date:   Tue, 28 Jan 2020 17:09:15 +0100
Message-ID: <20200128160915.25653-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <95f6d1e3-7052-252e-1c29-f320e84df302@infradead.org> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.133]
X-ClientProxiedBy: EX13D29UWA003.ant.amazon.com (10.43.160.253) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020 08:06:38 -0800 Randy Dunlap <rdunlap@infradead.org> wrote:

> On 1/28/20 12:57 AM, sjpark@amazon.com wrote:
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index ab80933be65f..144fb916aa8b 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -739,4 +739,16 @@ config ARCH_HAS_HUGEPD
> >  config MAPPING_DIRTY_HELPERS
> >          bool
> >  
> > +config DAMON
> > +	tristate "Data Access Monitor"
> > +	depends on MMU
> > +	default y
> 
> Might be lightweight but still should not default to 'y'.

Good point, will default to 'n' in next spin.


Thanks,
SeongJae Park

> 
> > +	help
> > +	  Provides data access monitoring.
> > +
> > +	  DAMON is a kernel module that allows users to monitor the actual
> > +	  memory access pattern of specific user-space processes.  It aims to
> > +	  be 1) accurate enough to be useful for performance-centric domains,
> > +	  and 2) sufficiently light-weight so that it can be applied online.
> > +
> >  endmenu
> 
> thanks.
> -- 
> ~Randy
> 
