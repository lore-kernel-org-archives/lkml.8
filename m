Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66752C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3D6207D8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6XekqW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgFDQKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:10:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56181 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726026AbgFDQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591287015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33vpNUuNxkjZ5GKzhxiKkwTKxAN4HEyu5dck6AfGsBY=;
        b=K6XekqW2idyxNWKPNEOY6DW3oWVstLvBOUoU0cjUUNwGEUI09ATqAYpiF07yPuxzVODOoO
        HDfk3/K/l8k1Lc/C2zO+KzWURz/0FHdxlABJQuJKyrlgU3cLAa/jCp7Jo9Po4+M3espBOY
        NY1nox4B61cJ3xY5NJcdkP27Dvrs7dE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-WQEv_epHNqCn79N2sJoHSQ-1; Thu, 04 Jun 2020 12:10:11 -0400
X-MC-Unique: WQEv_epHNqCn79N2sJoHSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00158835B48;
        Thu,  4 Jun 2020 16:10:10 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-167.rdu2.redhat.com [10.10.117.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A41445C557;
        Thu,  4 Jun 2020 16:10:08 +0000 (UTC)
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
 <d0356d0a-83dd-f3ae-c0ba-82089976c014@redhat.com>
 <TYXPR01MB1503D6F73C6356DED5D2C849F5890@TYXPR01MB1503.jpnprd01.prod.outlook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b7242c5d-f667-1cdb-19ff-8f7ee06b9e7d@redhat.com>
Date:   Thu, 4 Jun 2020 12:10:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <TYXPR01MB1503D6F73C6356DED5D2C849F5890@TYXPR01MB1503.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/20 3:29 AM, Tada, Kenta (Sony) wrote:
>> It conflicts with your new code. We can have an argument on whether IB should follow how SSB is being handled. Before that is settled,
> Thank you for the information.
> It conflicts but I think users who read the below document get confused.
> Documentation/userspace-api/spec_ctrl.rst.
>
> Especially, seccomp users must know the difference of this implicit specification
> because both IB and SSB are force disabled simultaneously when seccomp is enabled
> without SECCOMP_FILTER_FLAG_SPEC_ALLOW on x86.

What I am saying is that you have to make the argument why your patch is 
the right way to do thing and also make sure that the comment is 
consistent. Your current patch doesn't do that.

Cheers,
Longman

