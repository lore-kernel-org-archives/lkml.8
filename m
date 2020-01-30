Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CADC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6D920CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByIPweAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgA3UOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:14:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55344 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727089AbgA3UOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580415258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=It49j9LVTEdfoN2GEBrycA6NOResxAai2wxDK0RMpj4=;
        b=ByIPweATlBxfk4QLbk999ojVIqLOZkkkwvsAeupEgunDiQW+Csz7NohEklpsokmW+OJdc7
        Gx4+QWUlYOVm8t3eRG8S9uT0FE8xTaygBZH+/JFMs94viqNOxP/HwLmrOW7aYq2LWH4T5S
        inIIzKdmji+Fo4A7I9xYfX2VRB5cKpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-wmRWdobNOZq_4MnUvh1Upw-1; Thu, 30 Jan 2020 15:14:16 -0500
X-MC-Unique: wmRWdobNOZq_4MnUvh1Upw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 665E3107B26F;
        Thu, 30 Jan 2020 20:14:14 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A09BB5DA7B;
        Thu, 30 Jan 2020 20:14:11 +0000 (UTC)
Date:   Thu, 30 Jan 2020 15:14:11 -0500
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        ak@linux.intel.com, peterz@infradead.org, pbonzini@redhat.com,
        kan.liang@intel.com, mingo@redhat.com, rkrcmar@redhat.com,
        like.xu@intel.com, jannh@google.com, arei.gonglei@huawei.com,
        jmattson@google.com,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v8 00/14] Guest LBR Enabling
Message-ID: <20200130201411.GF25446@habkost.net>
References: <1565075774-26671-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565075774-26671-1-git-send-email-wei.w.wang@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 03:16:00PM +0800, Wei Wang wrote:
> Last Branch Recording (LBR) is a performance monitor unit (PMU) feature
> on Intel CPUs that captures branch related info. This patch series enables
> this feature to KVM guests.
> 
> Each guest can be configured to expose this LBR feature to the guest via
> userspace setting the enabling param in KVM_CAP_X86_GUEST_LBR (patch 3).

Are QEMU patches for enabling KVM_CAP_X86_GUEST_LBR being planned?

-- 
Eduardo

