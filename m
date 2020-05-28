Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D54C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E024207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjwtmTh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgE1GeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:34:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22674 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgE1GeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590647660;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A0TbfU1Wtk9UqNPHb2mnR7GHgRz5NlicH2MG30iIhdQ=;
        b=OjwtmTh0zrTrT55C1ugNY2uw/mCJiqwKZQPEcS9nFMDoY7Uj8LOigV5n9YQzGECOMVXP5Q
        UCVszqXIQFgl5u7w1vyTkSGzLnYxdhO09ZDldXEe0h+d1I4w9SXCeoHmN9ZTgQAafVqfnk
        X6YWrIvsBJSxvpMNQ4Vt8//23QvCE/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-V0gHZIGzPNaVCuaWjLDYHA-1; Thu, 28 May 2020 02:34:16 -0400
X-MC-Unique: V0gHZIGzPNaVCuaWjLDYHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9313E1005510;
        Thu, 28 May 2020 06:34:14 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-130.bne.redhat.com [10.64.54.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 048385C1B0;
        Thu, 28 May 2020 06:34:07 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH RFCv2 3/9] kvm/arm64: Rename kvm_vcpu_get_hsr() to
 kvm_vcpu_get_esr()
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, drjones@redhat.com, eric.auger@redhat.com,
        aarcange@redhat.com, shan.gavin@gmail.com
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-4-gshan@redhat.com>
 <20200526104249.GB1363@C02TD0UTHF1T.local>
 <2e4dd03f-656a-c32b-5e87-ca28583999ef@redhat.com>
 <359dad5546a428ea963781f2728e70bf@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <e71af813-7f72-9d2e-2419-f4e03cf35369@redhat.com>
Date:   Thu, 28 May 2020 16:34:05 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <359dad5546a428ea963781f2728e70bf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/20 5:20 PM, Marc Zyngier wrote:
> On 2020-05-27 03:43, Gavin Shan wrote:
>> Hi Mark,
>>
>> On 5/26/20 8:42 PM, Mark Rutland wrote:
>>> On Fri, May 08, 2020 at 01:29:13PM +1000, Gavin Shan wrote:
>>>> Since kvm/arm32 was removed, this renames kvm_vcpu_get_hsr() to
>>>> kvm_vcpu_get_esr() to it a bit more self-explaining because the
>>>> functions returns ESR instead of HSR on aarch64. This shouldn't
>>>> cause any functional changes.
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>
>>> I think that this would be a nice cleanup on its own, and could be taken
>>> independently of the rest of this series if it were rebased and sent as
>>> a single patch.
>>>
>>
>> Yeah, I'll see how PATCH[3,4,5] can be posted independently
>> as part of the preparatory work, which is suggested by you
>> in another reply.
>>
>> By the way, I assume the cleanup patches are good enough to
>> target 5.8.rc1/rc2 if you agree.
> 
> It's fine to base them on -rc1 or -rc2. They will not be merged
> before 5.9 though.
> 
> Thanks,
> 
>          M.

Sure, Thanks, Marc!

