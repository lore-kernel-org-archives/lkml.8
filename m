Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CC1C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9144924692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaY0oTjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgB0TEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:04:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60425 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729170AbgB0TEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582830293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oFQ8gU/ayTn3C6RFyHbjhVTiKOXOw1WdbW6fuZxnr5E=;
        b=SaY0oTjfRZwdscX7LkTVxoHTotsmymB3R3R7OrlvoExjjPKJQMK1IJafrNIqznWJJYhJGp
        LL2UbISzk0fVQbtmsdKEQWPVwcqSRrViM4ZrPwLhnTmO5psPIt+cLAKdhuxGLbsVmVUgPi
        ymiM17jUr5GcEmJShlX8gQiCBO3KmA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-mjDXXEp-N-Ot4lq5j-ss2A-1; Thu, 27 Feb 2020 14:04:47 -0500
X-MC-Unique: mjDXXEp-N-Ot4lq5j-ss2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DC4418A8C85;
        Thu, 27 Feb 2020 19:04:45 +0000 (UTC)
Received: from Liberator.local (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CCD05C651;
        Thu, 27 Feb 2020 19:04:41 +0000 (UTC)
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
To:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>
References: <20200226161404.14136-1-longman@redhat.com>
 <20200226162954.GC24185@bombadil.infradead.org>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <0e5124a2-d730-5c41-38fd-2c78d9be4940@redhat.com>
Date:   Thu, 27 Feb 2020 11:04:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226162954.GC24185@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/20 8:29 AM, Matthew Wilcox wrote:
> On Wed, Feb 26, 2020 at 11:13:53AM -0500, Waiman Long wrote:
>> A new sysctl parameter "dentry-dir-max" is introduced which accepts a
>> value of 0 (default) for no limit or a positive integer 256 and up. Small
>> dentry-dir-max numbers are forbidden to avoid excessive dentry count
>> checking which can impact system performance.
> 
> This is always the wrong approach.  A sysctl is just a way of blaming
> the sysadmin for us not being very good at programming.
> 
> I agree that we need a way to limit the number of negative dentries.
> But that limit needs to be dynamic and depend on how the system is being
> used, not on how some overworked sysadmin has configured it.
> 
> So we need an initial estimate for the number of negative dentries that
> we need for good performance.  Maybe it's 1000.  It doesn't really matter;
> it's going to change dynamically.
> 
> Then we need a metric to let us know whether it needs to be increased.
> Perhaps that's "number of new negative dentries created in the last
> second".  And we need to decide how much to increase it; maybe it's by
> 50% or maybe by 10%.  Perhaps somewhere between 10-100% depending on
> how high the recent rate of negative dentry creation has been.

There are pitfalls to this approach as well.  Consider what libnss
does every time it starts up (via curl in this case)

# cat /proc/sys/fs/dentry-state
3154271	3131421	45	0	2863333	0
# for I in `seq 1 10`; do curl https://sandeen.net/ &>/dev/null; done
# cat /proc/sys/fs/dentry-state
3170738	3147844	45	0	2879882	0

voila, 16k more negative dcache entries, thanks to:

https://github.com/nss-dev/nss/blob/317cb06697d5b953d825e050c1d8c1ee0d647010/lib/softoken/sdb.c#L390

i.e. each time it inits, it will intentionally create up to 10,000 negative
dentries which will never be looked up again.  I /think/ the original intent
of this work was to limit such rogue applications, so scaling with use probably
isn't the way to go.

-Eric

