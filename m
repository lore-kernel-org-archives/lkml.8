Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8187C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC05206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EladvbE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbgBNVDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:03:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57531 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbgBNVDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581714232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aaA9LekCmNuBy6+PZz+0QRYJRt8cF6I6ybrh5R8vzNo=;
        b=EladvbE7WnFLQCOaGgXansYhASsp4WPR4ynPGUKIyC7ClKEVjt1C4osHwHR89HHWpa5ZiV
        kCWv4I/8X8QBQXjJ2DZbyQawgT+wBe+N81yG4vio0eUAtUIxLmMD/nt8PBO/rR85gpZZ8g
        Gn1UOt5svj3OrfLH6KR2jOxBjTTjX5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-dd6hp9UGPKSx7KxtkKukFA-1; Fri, 14 Feb 2020 16:03:50 -0500
X-MC-Unique: dd6hp9UGPKSx7KxtkKukFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9773318C43C8;
        Fri, 14 Feb 2020 21:03:48 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4B628AC4D;
        Fri, 14 Feb 2020 21:03:47 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Oliver O'Halloran <oohall@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 0/4] libnvdimm: Cross-arch compatible namespace alignment
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 14 Feb 2020 16:03:47 -0500
In-Reply-To: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
        (Dan Williams's message of "Wed, 12 Feb 2020 16:48:18 -0800")
Message-ID: <x49blq0dgp8.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> ---
>
> Explicit review requests, but any other feedback is of course
> appreciated:
>
> Patch1 needs an ack from ppc arch maintainers, and I'd like a tested-by
> from Aneesh that this still works to solve the ppc issue. Jeff, does
> this look good to you?

OK, I've reviewed everything.  Testing looks good with the change I
mentioned (memremap_compat_align returning PAGE_SIZE).  I made sure a
4k-aligned namespace created under an unpatched kernel would be
accessible under a patched kernel.  I also made sure that manually
setting align would allow for creating of poorly aligned namespaces, and
that those namespaces were then accessible on the unpatched kernel.

Thanks, Dan!

-Jeff

