Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76865C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4967D206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkWj+dpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgAUQWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:22:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44251 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728916AbgAUQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579623774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSrmHU/c0jtGaJj8vyueDcKzMK7TX1vX4zLRbw0Rf50=;
        b=dkWj+dpnZyHXhGQxGGGZopQgnaNNOlSB6z5N8CcWlOXRylyfpTjAd1J4/4m1NHpgP/iEPV
        BUP2UmU9LHs7voaynPlcmyMiGNcGzXYwMeB+GdTlRq5sd60ymDD0iXqnm4s5EbpIirbiPw
        Dv4NIKVcS8BL8w3FxjejxMaV2WNHnkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-yFgfKiUDMuuhG_keWw5skA-1; Tue, 21 Jan 2020 11:22:49 -0500
X-MC-Unique: yFgfKiUDMuuhG_keWw5skA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6C5F9263E;
        Tue, 21 Jan 2020 16:22:47 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E9F28BE19;
        Tue, 21 Jan 2020 16:22:44 +0000 (UTC)
Subject: Re: [PATCH RFC] x86/speculation: Clarify Spectre-v2 mitigation when
 STIBP/IBPB features are unsupported
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20200121160257.302999-1-vkuznets@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <20c1c0f2-046e-eb77-d655-75f62ebafcb2@redhat.com>
Date:   Tue, 21 Jan 2020 11:22:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200121160257.302999-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/20 11:02 AM, Vitaly Kuznetsov wrote:
> When STIBP/IBPB features are not supported (no microcode update,
> AWS/Azure/... instances deliberately hiding SPEC_CTRL for performance
> reasons,...) /sys/devices/system/cpu/vulnerabilities/spectre_v2 looks like
>
>   Mitigation: Full generic retpoline, STIBP: disabled, RSB filling
>
> and this looks imperfect. In particular, STIBP is 'disabled' and 'IBPB'
> is not mentioned while both features are just not supported. Also, for
> STIBP the 'disabled' state (SPECTRE_V2_USER_NONE) can represent both
> the absence of hardware support and deliberate user's choice
> (spectre_v2_user=off)
>
> Make the following adjustments:
> - Output 'unsupported' for both STIBP/IBPB when there's no support in
>   hardware.
> - Output 'unneeded' for STIBP when SMT is disabled/missing (and this
>   switch_to_cond_stibp is off).

I support outputting "unsupported" when the microcode doesn't support
it. However, I am not sure if "unneeded" is really necessary or not.
STIBP is not needed when SMT is disabled or when Enhanced IBRS is
available and used. Your patch handles the first case, but not the
second. I think it may be easier to just leave it out in case it is not
needed.

Cheers,
Longman

