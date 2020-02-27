Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6719C4BA37
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A28F24679
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgLqNPkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgB0CnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 21:43:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60985 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728094AbgB0CnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 21:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582771385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jIzd+MZl1AvxRGDWe7UFrELxx/1RAKgj7dqtWoVC2q8=;
        b=BgLqNPkvYkA1ftIBextYCzPG+5Gx6Rh9f1+uMANZW6+exqZaf1E+PkwDgpPStyxLvekA69
        DgqJBYALfEpNcnan0JIOXrPbrHdhDEMJKzb0zGviUN3b2kWViS2MrjjSbqYwmEP5vpP/JZ
        Zf5KaNjIvCpT6i0RJGkULqMoRXO9/c8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-OiqDfqPvP-WvbDkjQd8jmA-1; Wed, 26 Feb 2020 21:43:01 -0500
X-MC-Unique: OiqDfqPvP-WvbDkjQd8jmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A6751005512;
        Thu, 27 Feb 2020 02:43:00 +0000 (UTC)
Received: from localhost (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 665A660BE1;
        Thu, 27 Feb 2020 02:42:56 +0000 (UTC)
Date:   Thu, 27 Feb 2020 10:42:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        dyoung@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH 09/11] kallsyms: hide layout and expose seed
Message-ID: <20200227024253.GA5707@MiWiFi-R3L-srv>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-10-kristen@linux.intel.com>
 <202002060428.08B14F1@keescook>
 <a915e1eb131551aa766fde4c14de5a3e825af667.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a915e1eb131551aa766fde4c14de5a3e825af667.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/20 at 09:51am, Kristen Carlson Accardi wrote:
> On Thu, 2020-02-06 at 04:32 -0800, Kees Cook wrote:

> > In the past, making kallsyms entirely unreadable seemed to break
> > weird
> > stuff in userspace. How about having an alternative view that just
> > contains a alphanumeric sort of the symbol names (and they will
> > continue
> > to have zeroed addresses for unprivileged users)?
> > 
> > Or perhaps we wait to hear about this causing a problem, and deal
> > with
> > it then? :)
> > 
> 
> Yeah - I don't know what people want here. Clearly, we can't leave
> kallsyms the way it is. Removing it entirely is a pretty fast way to
> figure out how people use it though :).

Kexec-tools and makedumpfile are the users of /proc/kallsyms currently. 
We use kallsyms to get page_offset_base and _stext.

