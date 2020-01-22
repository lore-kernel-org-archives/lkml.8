Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6704BC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 04:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392EA2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 04:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpWg1TGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAVEiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 23:38:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27817 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726605AbgAVEiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 23:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579667932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aG38Vx1puBG+RPiJmI9NRh9p5smiSfqCNqvndnPKL64=;
        b=HpWg1TGNeI1M8hc5YR3hae7yXNWxFURgv3F6DRHK8J+ITATZglbTKVypsaybEP4VBNxekb
        4hs/S7DQGFtgGnvpAiVqCQeA7f2KC4/dyPQOhU1mpUFhrBu1aC5b1tADOx6gMSZPCqsqHd
        qShrnPjoe8yIdW8VEbM4X3IC41hfIoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-oQdvpv7CORedz9qJuBr6WA-1; Tue, 21 Jan 2020 23:38:45 -0500
X-MC-Unique: oQdvpv7CORedz9qJuBr6WA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E29F066F;
        Wed, 22 Jan 2020 04:38:43 +0000 (UTC)
Received: from ovpn-120-231.rdu2.redhat.com (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26DCA5C1BB;
        Wed, 22 Jan 2020 04:38:43 +0000 (UTC)
Message-ID: <c979dd686853ea85da887cb1796cb8220dd51d0f.camel@redhat.com>
Subject: Re: [PATCH RT] Revert "cpumask: Disable CONFIG_CPUMASK_OFFSTACK for
 RT"
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Tue, 21 Jan 2020 22:38:42 -0600
In-Reply-To: <20200119103400.3vj4dr4sr4hxyxus@linutronix.de>
References: <20191218174159.ndcvzgqxavpcb37c@linutronix.de>
         <f19f0181e819989b13dc3605c25b110aa2677189.camel@redhat.com>
         <20200119103400.3vj4dr4sr4hxyxus@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-01-19 at 11:34 +0100, Sebastian Andrzej Siewior wrote:
> On 2020-01-19 02:03:23 [-0600], Scott Wood wrote:
> > I get splats with this due to zalloc_cpumask_var() with preemption
> > disabled
> > (from the get_cpu() in x86 flush_tlb_mm_range()):
> 
> Is 
> 	
> http://lkml.kernel.org/r/20200117090137.1205765-1-bigeasy@linutronix.de
> 
> solving the issue?
> 
> Sebastian
> 

Yes, looks good with those patches.

-Scott


