Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C105DC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91FA5208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irxE1M8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgEFRQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:16:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36026 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbgEFRQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588785414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ela94SMUznhXMw7+F5mZ0bXth7xvpX8dxWyN3ynS18=;
        b=irxE1M8OOn2EbNdx/qIB9UlArPa6cJl/+II+37W0k0yORd2GF2ro5ePavhAVFlAuaGsn4j
        VKAxEEoCcI0+6iiztHU1+jf03sm61Pm8a3EbLtUddOFQyrxIQmK3VZeexGzkParNI3FCN4
        CA6/0Cwe3zh5eqOIU2lRAG6ErB26jgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-QB6P7grRMCifQpQU5GheJw-1; Wed, 06 May 2020 13:16:51 -0400
X-MC-Unique: QB6P7grRMCifQpQU5GheJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B1A2461;
        Wed,  6 May 2020 17:16:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3E4145EE13;
        Wed,  6 May 2020 17:16:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  6 May 2020 19:16:48 +0200 (CEST)
Date:   Wed, 6 May 2020 19:16:43 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Guo Ren <guoren@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Security Officers <security@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: ensure that uprobe->offset and ->ref_ctr_offset
 are properly aligned
Message-ID: <20200506171642.GA5678@redhat.com>
References: <CAHk-=whQt69ApMkZF8b2Q2idMDgPpPETZeeOuZg59CrOO4025w@mail.gmail.com>
 <20200428091149.GB19958@linux.vnet.ibm.com>
 <20200428123914.GA27920@redhat.com>
 <20200504164724.GA28697@redhat.com>
 <20200506052955.GA8259@linux.vnet.ibm.com>
 <20200506085141.723673f1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506085141.723673f1@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06, Steven Rostedt wrote:
>
> As this is in the kernel/events/ directory, I'm guessing it should be taken
> through the tip tree?

this would be great, thanks Steven.

Oleg.

