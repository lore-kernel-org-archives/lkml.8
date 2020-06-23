Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476CBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B4B2070E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtxQ8Cvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbgFWPWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:22:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49272 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732781AbgFWPWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592925762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yVGQUi0k6F1w4Mp1ZKmSQa2NLIeiYLP4SooaTKp2iqg=;
        b=gtxQ8CvfSgeXC1a0eZKp5ZJvaSz0n6XSoVzokY6pN+wWe7SF+2igtQf5e89H4Gh7vp/uqd
        sLYvonbONJqgsp2bQhRJC/wHv9og25Ou4NvrH7L0j9FsB8UHmA3aN+RSwKb5n2GtYAKAP2
        rWeWb5nnReEqz/R8gmhmaNSJm4erpVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-84sHBPIzM6O-sutYayNERQ-1; Tue, 23 Jun 2020 11:22:40 -0400
X-MC-Unique: 84sHBPIzM6O-sutYayNERQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6391810AB384;
        Tue, 23 Jun 2020 15:22:37 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 114985C290;
        Tue, 23 Jun 2020 15:22:37 +0000 (UTC)
Date:   Tue, 23 Jun 2020 11:22:36 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "dm-crypt@saout.de" <dm-crypt@saout.de>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "agk@redhat.com" <agk@redhat.com>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 0/1] dm-crypt excessive overhead
Message-ID: <20200623152235.GB19657@redhat.com>
References: <20200619164132.1648-1-ignat@cloudflare.com>
 <20200619165548.GA24779@redhat.com>
 <CY4PR04MB3751F148CCFAAC99A7F05CF7E7970@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200623150118.GA19657@redhat.com>
 <CALrw=nHNJTX3kzv2Q=dc6hYr=d8S2=gT0VHkWigS1pmwr9ps5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALrw=nHNJTX3kzv2Q=dc6hYr=d8S2=gT0VHkWigS1pmwr9ps5Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23 2020 at 11:07am -0400,
Ignat Korchagin <ignat@cloudflare.com> wrote:

> Do you think it may be better to break it in two flags: one for read
> path and one for write? So, depending on the needs and workflow these
> could be enabled independently?

If there is a need to split, then sure.  But I think Damien had a hard
requirement that writes had to be inlined but that reads didn't _need_
to be for his dm-zoned usecase.  Damien may not yet have assessed the
performance implications, of not have reads inlined, as much as you
have.

So let's see how Damien's work goes and if he trully doesn't need/want
reads to be inlined then 2 flags can be created.

Mike

