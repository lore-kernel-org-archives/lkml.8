Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBD7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44421207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 20:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjXyudE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgETUmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 16:42:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37167 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727018AbgETUmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590007335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o8obcu4RJyJ5SsFoPKEalBasJOWg/UMge1/Qyw2g7H4=;
        b=YjXyudE9MlSR0s+O6udRASvrie77Yofg97s3sFuVbPmklhIGrhyaZIEwZ9KVYhIgdLsU74
        2sMXhnC5H6lRIQE9e2Mmqp5F5vfeTylP4neFqoq4jIQFQVHYL607YiMt8sCzlnsaIFuIke
        LHE3mFiFfWXSrzG7qzyxi0jtzcE27nU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-BpCPt0jQOxOxfXT_1nXr7Q-1; Wed, 20 May 2020 16:42:14 -0400
X-MC-Unique: BpCPt0jQOxOxfXT_1nXr7Q-1
Received: by mail-ed1-f70.google.com with SMTP id o7so1773547edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 13:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o8obcu4RJyJ5SsFoPKEalBasJOWg/UMge1/Qyw2g7H4=;
        b=JAhQSHI8vyZkECk3Lw8TmhuGWWxhUd3xksocLyqhaPZg6To7RMHqq1l70nDmejajbS
         K/jPmeq5U+z7VNYwebPK35qoZ1olHwsl/L3ynvpoZcDmB0068SRQbas/bOQ69yDKm+tf
         YJzqy5RP6kFva/8TKLeRISt+xssCTlOf+6pALhSMpCaOJo0nAANkyN+yRPqOtTveLXo1
         GJCDWY9Pg7DI3KuLmCNOktR9hhZT7VwFhXQb+jBjXh/b6Ef0hxI0sWjFrUpwcFr/UxUM
         VLZkz9o005iUyZV1MXWGY11R3kKKP7qMZ8wzknIFL90/L1bvS66JTNsyaACu05N+wiaA
         /l6g==
X-Gm-Message-State: AOAM530AqkzEwW0KImKnyavzbkBRb77ytB2LOkK18XPWRtskaZQM2Ita
        f3aoeLJLiq0ZrmdnfGrlT/VDMGrbGLdCsONlCYjkosacLD0KbBcy+zcqHQ3YbM4c3/qvnN/Pgvg
        jpUgi5rzVhhR569VDEZS4RU+y
X-Received: by 2002:a50:ee15:: with SMTP id g21mr4962373eds.170.1590007333148;
        Wed, 20 May 2020 13:42:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwelCdht1h/DJBFh9VXKA7BJoRU8H9J+/uLAg+4Euypi4HeaOVE1BVWG7K28wnyTkiFiv/gg==
X-Received: by 2002:a50:ee15:: with SMTP id g21mr4962360eds.170.1590007332892;
        Wed, 20 May 2020 13:42:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1c48:1dd8:fe63:e3da? ([2001:b07:6468:f312:1c48:1dd8:fe63:e3da])
        by smtp.gmail.com with ESMTPSA id qp13sm2900842ejb.8.2020.05.20.13.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 13:42:12 -0700 (PDT)
Subject: Re: [PATCH 00/24] KVM: nSVM: event fixes and migration support
To:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, Joerg Roedel <jroedel@suse.de>
References: <20200520172145.23284-1-pbonzini@redhat.com>
 <6b8674fa647d3b80125477dc344581ba7adfb931.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cecf6c64-6828-5a3f-642a-11aac4cefa75@redhat.com>
Date:   Wed, 20 May 2020 22:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6b8674fa647d3b80125477dc344581ba7adfb931.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/20 21:24, Maxim Levitsky wrote:
> Patch 24 doesn't apply cleanly on top of kvm/queue, I appplied it manually,
> due to missing KVM_STATE_NESTED_MTF_PENDING bit
> 
> Also patch 22 needes ALIGN_UP which is not on mainline.
> Probably in linux-next?

Just replace it with ALIGN.  (I tested it with memzero_user in
arch/x86/kvm/ for convenience, and the lib/ patch ended up out of sync
with the actual code).

> With these fixes, I don't see #DE exceptions on a nested guest I try to run
> however it still hangs, right around the time it tries to access PS/2 keyboard/mouse.

IIRC you said that the bug appeared with the vintr rework, and then went
from hang to #DE and now back to hang?  And the hang is reported by L2,
not L1?

In order to debug the hang, a good start would be to understand if it
also happens with vgif=0.  This is because with vgif=1 we use VINTR
intercepts even while GIF=0, so the whole thing is a bit more complicated.

Paolo

