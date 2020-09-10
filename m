Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514CEC07548
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 13:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3DB20809
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 13:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzGgN564"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbgIJNbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 09:31:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21196 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730821AbgIJN2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599744477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/m+8BzcTQhMcOHlC8kleMb4zFUjUqXj7v07BC3dfEx0=;
        b=DzGgN564wsyfSk9eWic4PI8FLT5q1/IDt782KpTB+aRcM1h6imlJdrs3Q4QRSVKaf9TdRI
        rIRnsKVcn9B+6nHMf07P6w0j4oUAQ0756mTE2lp0vZLhYGOByj8uVvK1uJjbfqu2hKUyq6
        SOJ4/CP1FtIv92q+4sRPVxA8LbRaPEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-GGMbtMqWME-oXJaqIo8ZqA-1; Thu, 10 Sep 2020 09:27:55 -0400
X-MC-Unique: GGMbtMqWME-oXJaqIo8ZqA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B93B425D2;
        Thu, 10 Sep 2020 13:27:54 +0000 (UTC)
Received: from work-vm (ovpn-113-128.ams2.redhat.com [10.36.113.128])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6612F19C59;
        Thu, 10 Sep 2020 13:27:51 +0000 (UTC)
Date:   Thu, 10 Sep 2020 14:27:48 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Steven Price <steven.price@arm.com>,
        Peter Maydell <Peter.Maydell@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        qemu-devel@nongnu.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
Message-ID: <20200910132748.GF2814@work-vm>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
 <5cb1d7ed-54a5-4337-6c3d-2e3e7df89f17@linaro.org>
 <20200910054440.pvnzk7p7riiy45e2@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910054440.pvnzk7p7riiy45e2@kamzik.brq.redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Jones (drjones@redhat.com) wrote:
> On Wed, Sep 09, 2020 at 06:45:33PM -0700, Richard Henderson wrote:
> > On 9/9/20 8:25 AM, Andrew Jones wrote:
> > >>  * Provide a KVM-specific method to extract the tags from guest memory.
> > >>    This might also have benefits in terms of providing an easy way to
> > >>    read bulk tag data from guest memory (since the LDGM instruction
> > >>    isn't available at EL0).
> > > 
> > > Maybe we need a new version of KVM_GET_DIRTY_LOG that also provides
> > > the tags for all addresses of each dirty page.
> > 
> > KVM_GET_DIRTY_LOG just provides one bit per dirty page, no?  Then VMM copies
> > the data out from its local address to guest memory.
> > 
> > There'd be no difference with or without tags, afaik.  It's just about how VMM
> > copies the data, with or without tags.
> 
> Right, as long as it's fast enough to do
> 
>   for_each_dirty_page(page, dirty_log)
>     for (i = 0; i < host-page-size/16; i += 16)
>       append_tag(LDG(page + i))
> 
> to get all the tags for each dirty page. I understood it would be faster
> to use LDGM, but we'd need a new ioctl for that. So I was proposing we
> just piggyback on a new dirty-log ioctl instead.

That feels a bad idea to me; there's a couple of different ways dirty
page checking work; lets keep extracting the tags separate.

Dave

> Thanks,
> drew 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

