Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6BDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8519214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnrFCkM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgAWRgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:36:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35816 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727022AbgAWRgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579801006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D54wJCq+dcoWe+lOlchk/VMBTGpgOIcpCavPiOTlG1Y=;
        b=gnrFCkM0ISO8DmSWmwUpnYxPERc2I4THwxqZxbmifoyV/56vz8kP7FEl0k1d66QCFx/MKS
        Qo7Rzd65QOGQ19onYE6hqY946+P0HmCIhKbQ8v9zVGPNLlEVBQ0JKPW5l5d6kIQ018vyWa
        tj/YjET8iMF7qg/Vr1Nkrj4AfSDY1AE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-d4aV-R_nMuWLziZ8mN2NoA-1; Thu, 23 Jan 2020 12:36:41 -0500
X-MC-Unique: d4aV-R_nMuWLziZ8mN2NoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF6A31005514;
        Thu, 23 Jan 2020 17:36:39 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7762F8644F;
        Thu, 23 Jan 2020 17:36:37 +0000 (UTC)
Subject: Re: [PATCH -next] arm64/spinlock: fix a -Wunused-function warning
To:     Qian Cai <cai@lca.pw>, Will Deacon <will@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, catalin.marinas@arm.com,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200123165614.GA20126@willie-the-truck>
 <48DF011A-3074-422C-BFBA-1A9F2EF4A7BA@lca.pw>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <f95c27b1-a8ca-bac8-e6bb-07ca9e87bcd9@redhat.com>
Date:   Thu, 23 Jan 2020 12:36:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <48DF011A-3074-422C-BFBA-1A9F2EF4A7BA@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/20 12:31 PM, Qian Cai wrote:
>
>> On Jan 23, 2020, at 11:56 AM, Will Deacon <will@kernel.org> wrote:
>>
>> Damn, the whole point of this was to warn in the case that
>> vcpu_is_preempted() does get defined for arm64. Can we force it to evaluate
>> the macro argument instead (e.g. ({ (cpu), false; }) or something)?
> Actually, static inline should be better.
>
> #define vcpu_is_preempted vcpu_is_preempted
> static inline bool vcpu_is_preempted(int cpu)
> {
> 	return false;
> }
>
Yes, that may work.

Cheers,
Longman

