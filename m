Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF4EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0AF520738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qqk3qs7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgFCPko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:40:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28911 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbgFCPkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591198842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdlXkqSUFoXM0JnYdCV2CEI4PZdSQVjXKjFpcdUfIWs=;
        b=Qqk3qs7BZhWLBMo61gAf8GIIb9Bgp1wDHMtrc8OksaHgBSGdzzy0spop1zdx7s0PT5p3ay
        JhtnncbcgaAEklQJFMZUlpv+NFDeXUIKrw8mri50dveTqcLO2DtYtWx1qT7a7EHx9/futX
        zlP/TGt9B1k+UdVi3EEreXmX5ljI2Xw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-yX-bTHDGOjC7JJ41CWA9cw-1; Wed, 03 Jun 2020 11:40:24 -0400
X-MC-Unique: yX-bTHDGOjC7JJ41CWA9cw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CD091097F02;
        Wed,  3 Jun 2020 15:39:40 +0000 (UTC)
Received: from llong.remote.csb (ovpn-115-1.rdu2.redhat.com [10.10.115.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1935D10013D5;
        Wed,  3 Jun 2020 15:39:39 +0000 (UTC)
Subject: Re: [PATCH] x86/speculation: Check whether speculation is force
 disabled
To:     "Tada, Kenta (Sony)" <Kenta.Tada@sony.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TYXPR01MB150318D484EE220452A5085AF5880@TYXPR01MB1503.jpnprd01.prod.outlook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d0356d0a-83dd-f3ae-c0ba-82089976c014@redhat.com>
Date:   Wed, 3 Jun 2020 11:39:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <TYXPR01MB150318D484EE220452A5085AF5880@TYXPR01MB1503.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/20 3:12 AM, Tada, Kenta (Sony) wrote:
> Once PR_SPEC_FORCE_DISABLE is set, users cannot set PR_SPEC_ENABLE.
> This commit checks whether PR_SPEC_FORCE_DISABLE was previously set.
>
> Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> ---
>   arch/x86/kernel/cpu/bugs.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index ed54b3b21c39..678ace157035 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1173,6 +1173,9 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
>   		if (spectre_v2_user == SPECTRE_V2_USER_STRICT ||
>   		    spectre_v2_user == SPECTRE_V2_USER_STRICT_PREFERRED)
>   			return -EPERM;
> +		/* If speculation is force disabled, enable is not allowed */
> +		if (task_spec_ib_force_disable(task))
> +			return -EPERM;
>   		task_clear_spec_ib_disable(task);
>   		task_update_spec_tif(task);
>   		break;

There is a comment up a few lines about this:

                 /*
                  * Indirect branch speculation is always allowed when
                  * mitigation is force disabled.
                  */
It conflicts with your new code. We can have an argument on whether IB 
should follow how SSB is being handled. Before that is settled,

Nacked-by: Waiman Long <longman@redhat.com>

