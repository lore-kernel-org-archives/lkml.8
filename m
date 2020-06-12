Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3677AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04EA9207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QyhSnDux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgFLGkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 02:40:46 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:5613 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgFLGkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591944045; x=1623480045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=rqJsxKpWqEeDoioD2e5z7H/GiuoSDTICtmPX3jiDK9s=;
  b=QyhSnDuxImJUnD1a8wdN2+WdHjaS4Mt+JfpitxS6AHLVA2DEJ/agj8h8
   NgAhiD4isSzR5B2YKBTIFJ7cPKSPdgFFFrymjvySUhTKb03w4cFc8cC+9
   YyERYR19BLdGY/WpUZwgr+BBBBeh/2rzdtI71XwHvKM1/xfghCplElfG/
   c=;
IronPort-SDR: VE2d4dB/KC0LmF6pogl9AIS3oZR0Ffubv7PmyUOmWpOdNb3AqoelOLV1NO5iiJYf+xt2y+4eg6
 wu73N6w34TCg==
X-IronPort-AV: E=Sophos;i="5.73,502,1583193600"; 
   d="scan'208";a="50403555"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Jun 2020 06:40:38 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id 981BEA1C66;
        Fri, 12 Jun 2020 06:40:34 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 12 Jun 2020 06:40:33 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.97) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 12 Jun 2020 06:40:27 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Joe Perches <joe@perches.com>
CC:     Jiri Slaby <jslaby@suse.cz>, SeongJae Park <sjpark@amazon.com>,
        <akpm@linux-foundation.org>, <apw@canonical.com>,
        SeongJae Park <sjpark@amazon.de>, <colin.king@canonical.com>,
        <sj38.park@gmail.com>, <linux-kernel@vger.kernel.org>,
        <kristen.c.accardi@intel.com>, <mishi@linux.com>,
        <skhan@linuxfoundation.org>, <gregkh@linuxfoundation.org>
Subject: Re: Re: [PATCH v4 0/2] Recommend denylist/allowlist instead of blacklist/whitelist
Date:   Fri, 12 Jun 2020 08:40:09 +0200
Message-ID: <20200612064009.31523-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <3144e9630c814ca08cd940d7aff12aab822676d9.camel@perches.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.97]
X-ClientProxiedBy: EX13P01UWB004.ant.amazon.com (10.43.161.213) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 03:43:32 -0700 Joe Perches <joe@perches.com> wrote:

> On Thu, 2020-06-11 at 10:32 +0200, Jiri Slaby wrote:
> > On 11. 06. 20, 10:30, SeongJae Park wrote:
> > > For example, as it seems at least you and I agree on the f-word to hug
> > > replacement, we could add ``fuck||hug`` in the `deprecated_terms.txt` file to
> > > avoid future spread of the f-words.
> > 
> > You will likely get my ACK on that, if that helps.
> 
> But likely not mine.

It's ok, I will respect every opinion.  But...

> 
> $ git grep -i '\bfuck' | wc -l
> 15

I'm not understanding what you're meaning with this.  Could I ask your
explanation, please?


Thanks,
SeongJae Park
