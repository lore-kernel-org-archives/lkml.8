Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE1CC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260BA2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+mpGriI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbgIAQjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:39:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27012 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731184AbgIAQjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598978353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6+Siw16/5zZv5latdr2RuSbzR6sWfZeXRN2Pb2vqAJA=;
        b=g+mpGriIyPlZEhMHTzYB3MwC0SKHzvdvrCMOlT795SVu38h7xNwAWnoFgNTIyzQlEdEifO
        AP6zrhsD7YF/XbMFgO+DF6WKmMBS720cSJlQbQelj5ZBdK9OQ+HLrRi6IrzUB2eijJVN0m
        UZwXY1sO/057I0NRGzS705vtq4czwJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-zHY5MrSXP42TFBfcxnlUZg-1; Tue, 01 Sep 2020 12:39:09 -0400
X-MC-Unique: zHY5MrSXP42TFBfcxnlUZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78DDD801AE6;
        Tue,  1 Sep 2020 16:39:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.114])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9975C5C1A3;
        Tue,  1 Sep 2020 16:39:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  1 Sep 2020 18:39:08 +0200 (CEST)
Date:   Tue, 1 Sep 2020 18:39:05 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, axboe@kernel.dk,
        ebiederm@xmission.com, madhuparnabhowmik10@gmail.com,
        gustavoars@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: clean up codestyle
Message-ID: <20200901163904.GC4386@redhat.com>
References: <20200901115800.7916-1-linmiaohe@huawei.com>
 <20200901122047.7hzztrssvr72wb2d@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901122047.7hzztrssvr72wb2d@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01, Christian Brauner wrote:
>
> On Tue, Sep 01, 2020 at 07:58:00AM -0400, Miaohe Lin wrote:
> > No functional change intended.
>
> Hey Miaohe,
>
> Thank you for the patch.
> I'm sure this is well-intended but afaict the whole file has more or
> less a consistent style already where e.g. sig-1 without spaces seems to
> be preferred. The same for the casts where most places use a single
> space.
>
> Now, I know CodingStyle.rst is on your side at least when it comes to
> the first point:
>
> Use one space around (on each side of) most binary and ternary operators,
> such as any of these::
>
> 	=  +  -  <  >  *  /  %  |  &  ^  <=  >=  ==  !=  ?  :
>
> but then you'd need to change each place in kernel/signal.c where that
> is currently not the case.

Or simply leave this code alone ;)

To be honest I do not like the very idea of enforce-coding-style patches,
coding style is very personal and even this trivial (but imho pointless)
change can complicate the backporting of some bugfix. I hit this problem
quite often.

Oleg.

