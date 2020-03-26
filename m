Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E32EC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E6A20774
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+7GuzXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgCZN4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:56:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56405 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727729AbgCZN4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585230964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=88eUjflRcwmSSWvPRfQg+6bwWoJ2678bQo929jibops=;
        b=L+7GuzXj+9xi1SVBg+NxFkZnx+qFxcmr3rK5+x5urGqzSy6LDC0zMA+lf7i7Rf7suvvBiw
        b+/5PPOYTO2nuCZwky5vMw5Fv7dObhi303utA7pO0jHJBv6xHtjaBiWpxvpBL6UYL7kN3+
        tJStMnaK4wbAUXUvmf2S1XnVSBvK2sQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-AAWCI-RUNIWn_WJ9EQ3guA-1; Thu, 26 Mar 2020 09:56:00 -0400
X-MC-Unique: AAWCI-RUNIWn_WJ9EQ3guA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 840648010FD;
        Thu, 26 Mar 2020 13:55:57 +0000 (UTC)
Received: from localhost (ovpn-12-117.pek2.redhat.com [10.72.12.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 97151CDBC4;
        Thu, 26 Mar 2020 13:55:56 +0000 (UTC)
Date:   Thu, 26 Mar 2020 21:55:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Michel Lespinasse <walken@google.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ying Han <yinghan@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] mmap locking API: convert mmap_sem call sites missed
 by coccinelle
Message-ID: <20200326135553.GM3039@MiWiFi-R3L-srv>
References: <02c6dfa8-0e13-d1d7-e335-ad8f1a3ecb1f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02c6dfa8-0e13-d1d7-e335-ad8f1a3ecb1f@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/20 at 02:41pm, Markus Elfring wrote:
> > Convert the last few remaining mmap_sem rwsem calls to use the new
> > mmap locking API. These were missed by coccinelle for some reason
> 
> I find such a software situation unfortunate.
> Should the transformation approach be clarified any further?

Should be this one:
Documentation/dev-tools/coccinelle.rst

