Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D7AC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B54224649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmxcQ55O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgBNUTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:19:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24432 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729633AbgBNUTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581711558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zUUGrdP4j1cXvm1eFGmQNpbG1sQHN9lpbJso5oFN/oI=;
        b=DmxcQ55OmQP2HCjIZhCBScsv8nSesXpllsPfdxNYOG33tZsBl5OpS6xS9km+maWttzDFE8
        DyNLT/MvBRgkOLOV6oxYY1Kha9GdhGi0y/cB0dbiq5ekrGQohnwCOmVlZAf42cjWdmsQkP
        LPyfI8oI5bzDZUi9v4oQrf+XNanEK5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-BGeSogtHN2ixrrdRK5EOyg-1; Fri, 14 Feb 2020 15:19:10 -0500
X-MC-Unique: BGeSogtHN2ixrrdRK5EOyg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28490108592A;
        Fri, 14 Feb 2020 20:19:09 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 687605C1D8;
        Fri, 14 Feb 2020 20:19:08 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 4/4] libnvdimm/region: Introduce an 'align' attribute
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
        <158155491952.3343782.4541070487858304628.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 14 Feb 2020 15:19:07 -0500
In-Reply-To: <158155491952.3343782.4541070487858304628.stgit@dwillia2-desk3.amr.corp.intel.com>
        (Dan Williams's message of "Wed, 12 Feb 2020 16:48:39 -0800")
Message-ID: <x495zg8exc4.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> The align attribute applies an alignment constraint for namespace
> creation in a region. Whereas the 'align' attribute of a namespace
> applied alignment padding via an info block, the 'align' attribute
> applies alignment constraints to the free space allocation.
>
> The default for 'align' is the maximum known memremap_compat_align()
> across all archs (16MiB from PowerPC at time of writing) multiplied by
> the number of interleave ways if there is blk-aliasing. The minimum is
> PAGE_SIZE and allows for the creation of cross-arch incompatible
> namespaces, just as previous kernels allowed, but the expectation is
> cross-arch and mode-independent compatibility by default.
>
> The regression risk with this change is limited to cases that were
> dependent on the ability to create unaligned namespaces, *and* for some
> reason are unable to opt-out of aligned namespaces by writing to
> 'regionX/align'. If such a scenario arises the default can be flipped
> from opt-out to opt-in of compat-aligned namespace creation, but that is
> a last resort. The kernel will otherwise continue to support existing
> defined misaligned namespaces.
>
> Unfortunately this change needs to touch several parts of the
> implementation at once:
>
> - region/available_size: expand busy extents to current align
> - region/max_available_extent: expand busy extents to current align
> - namespace/size: trim free space to current align
>
> ...to keep the free space accounting conforming to the dynamic align
> setting.
>
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Reported-by: Jeff Moyer <jmoyer@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Link: https://lore.kernel.org/r/158041478371.3889308.14542630147672668068.stgit@dwillia2-desk3.amr.corp.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

This looks good to me.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

