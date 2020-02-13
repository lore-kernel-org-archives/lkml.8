Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE3AC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 19:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640FD217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 19:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4Fkoj09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgBMTQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 14:16:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25271 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727720AbgBMTQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581621373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3SQ+LK7N11bGZ8q1OPiZl9texnQsy+HSMYBO5njmoYo=;
        b=N4Fkoj09VKw5WjwIbst8XMsYyw8kQqWy/YbHe0/6sluPgRC/o7PGDSoZP2nWrdq3H8jsaa
        gKokiLuUoNlHNuDAlmtT3RveT4+PyutmESO/MYVak69+yl/9aMvY9774WsAZs/uEYTdVEI
        LTr5SBmAiLLkOpc/cjmrtnJ0H1hVfGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-XG0hJnjHPBS9gjBI-CDJyA-1; Thu, 13 Feb 2020 14:16:04 -0500
X-MC-Unique: XG0hJnjHPBS9gjBI-CDJyA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FB91107ACCC;
        Thu, 13 Feb 2020 19:16:02 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C5D35C100;
        Thu, 13 Feb 2020 19:16:01 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/4] libnvdimm/namespace: Enforce memremap_compat_align()
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
        <158155490897.3343782.14216276134794923581.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 13 Feb 2020 14:16:00 -0500
In-Reply-To: <158155490897.3343782.14216276134794923581.stgit@dwillia2-desk3.amr.corp.intel.com>
        (Dan Williams's message of "Wed, 12 Feb 2020 16:48:29 -0800")
Message-ID: <x49o8u25mdr.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> The pmem driver on PowerPC crashes with the following signature when
> instantiating misaligned namespaces that map their capacity via
> memremap_pages().
>
>     BUG: Unable to handle kernel data access at 0xc001000406000000
>     Faulting instruction address: 0xc000000000090790
>     NIP [c000000000090790] arch_add_memory+0xc0/0x130
>     LR [c000000000090744] arch_add_memory+0x74/0x130
>     Call Trace:
>      arch_add_memory+0x74/0x130 (unreliable)
>      memremap_pages+0x74c/0xa30
>      devm_memremap_pages+0x3c/0xa0
>      pmem_attach_disk+0x188/0x770
>      nvdimm_bus_probe+0xd8/0x470
>
> With the assumption that only memremap_pages() has alignment
> constraints, enforce memremap_compat_align() for
> pmem_should_map_pages(), nd_pfn, or nd_dax cases.
>
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Link: https://lore.kernel.org/r/158041477336.3889308.4581652885008605170.stgit@dwillia2-desk3.amr.corp.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

