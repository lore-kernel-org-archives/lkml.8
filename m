Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C6AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 447EF2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O05Q0HMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgE0DQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:16:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53518 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgE0DQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590549364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/U30jq60+l+qSoKQaysERZKm3+QDoP2KNzgEBqE3b8=;
        b=O05Q0HMdncPqAo5ZQD7XVR5LYJr8MYBVSPLZ/JMexyBNpYUqwBbrAroywGyzA3aXeHzRBC
        +JtWXIZ0/0c2jdSxWzYDAmVHU+XWif/bkE9YDhFe9VeQ/IkqTxmmZ5hAdpYx0c1s05s7dH
        BYlDlKdJ821gqFNlt0nwUh+kqVry8Qk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-kriTgT6fMYigScKrfzBEzQ-1; Tue, 26 May 2020 23:16:01 -0400
X-MC-Unique: kriTgT6fMYigScKrfzBEzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5331F835B42;
        Wed, 27 May 2020 03:16:00 +0000 (UTC)
Received: from [10.72.12.206] (ovpn-12-206.pek2.redhat.com [10.72.12.206])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C941F5C1B0;
        Wed, 27 May 2020 03:15:53 +0000 (UTC)
Subject: Re: [PATCH] kexec: Do not verify the signature without the lockdown
 or mandatory signature
To:     Jiri Bohac <jbohac@suse.cz>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, jmorris@namei.org, mjg59@google.com,
        dyoung@redhat.com, bhe@redhat.com
References: <20200525052351.24134-1-lijiang@redhat.com>
 <20200526135935.ffkfulsjf7xrep63@dwarf.suse.cz>
From:   lijiang <lijiang@redhat.com>
Message-ID: <07a65a70-3764-f62f-705c-049b8d409316@redhat.com>
Date:   Wed, 27 May 2020 11:15:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200526135935.ffkfulsjf7xrep63@dwarf.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020年05月26日 21:59, Jiri Bohac 写道:
> On Mon, May 25, 2020 at 01:23:51PM +0800, Lianbo Jiang wrote:
>> So, here, let's simplify the logic to improve code readability. If the
>> KEXEC_SIG_FORCE enabled or kexec lockdown enabled, signature verification
>> is mandated. Otherwise, we lift the bar for any kernel image.
> 
> I agree completely; in fact that was my intention when
> introducing the code, but I got overruled about the return codes:
> https://lore.kernel.org/lkml/20180119125425.l72meyyc2qtrriwe@dwarf.suse.cz/
> 
> I like this simplification very much, except this part:
> 
>> +	if (ret) {
>> +		pr_debug("kernel signature verification failed (%d).\n", ret);
> 
> ...
> 
>> -		pr_notice("kernel signature verification failed (%d).\n", ret);
> 
> I think the log level should stay at most PR_NOTICE when the
> verification failure results in rejecting the kernel. Perhaps
> even lower.
> 

Thank you for the comment, Jiri Bohac.

I like the idea of staying at most PR_NOTICE, but the pr_notice() will output
some messages that kernel could want to ignore, such as the case you mentioned
below.

> In case verification is not enforced and the failure is
> ignored, KERN_DEBUG seems reasonable.
> 

Yes, good understanding. It seems that the pr_debug() is still a good option here?
Any other thoughts?

Thanks.
Lianbo


> Regards,
> 

