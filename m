Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0476FC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF33B20791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgIDHVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:21:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46438 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbgIDHVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:21:11 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-xG2rInCnOjaziFdXfQVFhA-1; Fri, 04 Sep 2020 03:21:08 -0400
X-MC-Unique: xG2rInCnOjaziFdXfQVFhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 938BE801AB4;
        Fri,  4 Sep 2020 07:21:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com [10.36.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58BB05D9CC;
        Fri,  4 Sep 2020 07:20:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 33C13204AE; Fri,  4 Sep 2020 09:20:56 +0200 (CEST)
Date:   Fri, 4 Sep 2020 09:20:56 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Tsirkin <mst@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] KVM: x86: KVM_MEM_PCI_HOLE memory
Message-ID: <20200904072056.qy3yse7jarwgunu7@sirius.home.kraxel.org>
References: <20200807141232.402895-1-vkuznets@redhat.com>
 <20200825212526.GC8235@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825212526.GC8235@xz-x1>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> attached.  Though those should be far less than 8000+, and those should also be
> pio rather than mmio.

Well, seabios 1.14 (qemu 5.1) added mmio support (to speed up boot a
little bit, mmio is one and pio is two vmexits).

Depends on q35 obviously, and a few pio accesses remain b/c seabios has
to first setup mmconfig.

take care,
  Gerd

