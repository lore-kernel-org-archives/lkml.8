Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54733C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C934206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoZIsUgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCSUNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:13:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48492 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725747AbgCSUNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584648822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pz2meSx8kaekzriSFaRshTQDd/5d8cqR1w2EnkHzmmU=;
        b=EoZIsUgzFmxt1C0WYQIon7NNc9+jhNvu8Xv9LGOLNPuCI7brionPplu8POghwonlrxV36X
        eF6yYv5moRcloiOtxT+5mv5d+aFz5DwtUEGLGT5x22DIyVpkeOcvhggZMXRq2fKct/YKHi
        U/Vr+0z1lQvI1RLnh+6RwBz1nQIdyoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-NAifi9mdM5O2JzklWPrenA-1; Thu, 19 Mar 2020 16:13:37 -0400
X-MC-Unique: NAifi9mdM5O2JzklWPrenA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30392801E5C;
        Thu, 19 Mar 2020 20:13:35 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BD1B60BF1;
        Thu, 19 Mar 2020 20:13:31 +0000 (UTC)
Subject: Re: [PATCH v5 19/23] KVM: arm64: GICv4.1: Allow SGIs to switch
 between HW and SW interrupts
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, kvm@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org,
        Robert Richter <rrichter@marvell.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <20200304203330.4967-1-maz@kernel.org>
 <20200304203330.4967-20-maz@kernel.org>
 <8a6cf87a-7eee-5502-3b54-093ea0ab5e2d@redhat.com>
 <877ba4711c6b9456314ea580b9c4718c@kernel.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <9fb8c267-5483-f260-6e37-5e8734b38928@redhat.com>
Date:   Thu, 19 Mar 2020 21:13:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <877ba4711c6b9456314ea580b9c4718c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 3/19/20 8:52 PM, Marc Zyngier wrote:
> The assumption here is that we're coming vgic_v4_configure_vsgis(),
> which starts
> by stopping the whole guest. My guess is that it should be safe enough, but
> maybe you are thinking of something else?
I don't have a specific case in mind. Just preferred asking to make
sure. Usually when touching those fields we take the lock (that's also
the case in vgic_debug_show for instance).

Thanks

Eric

