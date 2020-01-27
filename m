Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D90C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F79E214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GmIZc3LA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgA0QyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:54:14 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:39036 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0QyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580144054; x=1611680054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=0SviMkKcxANZUVYkfDAkB59AQTxTuaXQe+9xsrFF+KY=;
  b=GmIZc3LAUR+A+2Z0jQf65iU9RrFqv61H+uISTDBj+/NEPKZCJ/CwrNR2
   JF5gNAb2t4hTm+IROFAvHAi3VOyvy6+o6oGVeJe+SV8iNCSPYOn7liJjo
   nNyNvok/Q9k+3GgX44B02U0dMpyZXfSp8VQUZKZQRKqyLD7E29zU3HYPE
   Q=;
IronPort-SDR: KQN/UHYdxS0e4lNPplrDxisvIUDa7mjblFbw4Kkbyi5rHwH8t6bvfdVvas6iUNGq4yglNWYZL8
 BGXZ4gkuwxBw==
X-IronPort-AV: E=Sophos;i="5.70,370,1574121600"; 
   d="scan'208";a="21336953"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 Jan 2020 16:53:51 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 2D67CA1EED;
        Mon, 27 Jan 2020 16:53:49 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 27 Jan 2020 16:53:48 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.117) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 27 Jan 2020 16:53:42 +0000
From:   <sjpark@amazon.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, <acme@kernel.org>,
        <brendan.d.gregg@gmail.com>, <corbet@lwn.net>, <mgorman@suse.de>,
        <dwmw@amazon.com>, <amit@kernel.org>, <rostedt@goodmis.org>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH 0/8] Introduce Data Access MONitor (DAMON)
Date:   Mon, 27 Jan 2020 17:53:25 +0100
Message-ID: <20200127165325.21279-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120181440.7826-1-sj38.park@gmail.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.117]
X-ClientProxiedBy: EX13D28UWC001.ant.amazon.com (10.43.162.166) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020 19:14:40 +0100 SeongJae Park <sj38.park@gmail.com> wrote:

> On Mon, 20 Jan 2020 19:55:51 +0300 "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> 
> > On Mon, Jan 20, 2020 at 05:27:49PM +0100, SeongJae Park wrote:
> > > This patchset introduces a new kernel module for practical monitoring of
> > > data accesses, namely DAMON.
> > 
> > Looks like it's not integrated with perf at all right? Why?
> > Correlating measurements from different domains would help to see the
> > bigger picture.
> 
> Right, it's not integrated with perf.  DAMON provides only its debugfs
> interface.  Also I agree that correlating measurments will be helpful.  I do
> not integrate DAMON with perf with this patchset for following reasons.
> 
> First of all, I think I have no deep understanding of perf, yet.  Partly for
> the reason, I couldn't figure out the best way to integrate DAMON with perf.
> Especially, I couldn't straightforwardly classify DAMON providing information
> into one of the categories of the perf events I know.
> 
> Therefore, rather than integrating DAMON with perf in my arguable way and
> increasing the complexity of the code, I decided to keep the interface as
> simple and flexible as it can be for the first stage.  That said, I believe it
> would be not too hard to integrate DAMON with perf in a future.

I think I was unnecessarily worry about the best way.  I added a tracepoint to
the monitoring result writing logic of DAMON.  Other tracers including perf
would easily integrate DAMON using it, though the tracepoint is not highly
optimized yet.  Will post next version soon.


Thanks,
SeongJae Park

> 
> 
> Thanks,
> SeongJae Park
> 
> > 
> > -- 
> >  Kirill A. Shutemov
> > 
> > 
