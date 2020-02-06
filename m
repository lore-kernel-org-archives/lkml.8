Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE34C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 02:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8060320720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 02:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8eLMk9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBFC64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 21:58:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37575 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727558AbgBFC64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 21:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580957935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUikXJihSelGv3US13DwD7EM94hbrK9xMRarpaRh2Mg=;
        b=V8eLMk9eBjEL4/UzDSr+RJYNYHZyMNHOydu35t/x67AoNlaV5g6iZ7AoVhTm9VQzT1et2P
        lyblF/+XW6wVAmOLD/Q0yQBIiHOGyywDBKIYnJLPgniTbMjVdcBywa9i6Qco/Cs1WdMO5/
        SDMezf0MADMSQB2HffkqUl2TQFwq1gc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-HZki0O0INhaJeqV3CdPS5g-1; Wed, 05 Feb 2020 21:58:51 -0500
X-MC-Unique: HZki0O0INhaJeqV3CdPS5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCA6D800D54;
        Thu,  6 Feb 2020 02:58:49 +0000 (UTC)
Received: from localhost (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67CC0790C8;
        Thu,  6 Feb 2020 02:58:46 +0000 (UTC)
Date:   Thu, 6 Feb 2020 10:58:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mhocko@kernel.org, david@redhat.com,
        bsingharora@gmail.com
Subject: Re: [PATCH v3] mm/hotplug: Only respect mem= parameter during boot
 stage
Message-ID: <20200206025843.GL8965@MiWiFi-R3L-srv>
References: <20200204050643.20925-1-bhe@redhat.com>
 <1356631d-30b6-e967-9874-6c48c25304cf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1356631d-30b6-e967-9874-6c48c25304cf@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/20 at 08:53am, J=FCrgen Gro=DF wrote:
> On 04.02.20 06:06, Baoquan He wrote:
> > In commit 357b4da50a62 ("x86: respect memory size limiting via mem=3D
> > parameter") a global varialbe max_mem_size is added to store
> > the value parsed from 'mem=3D ', then checked when memory region is
> > added. This truly stops those DIMMs from being added into system memo=
ry
> > during boot-time.
> >=20
> > However, it also limits the later memory hotplug functionality. Any
> > DIMM can't be hotplugged any more if its region is beyond the
> > max_mem_size. We will get errors like:
> >=20
> > [  216.387164] acpi PNP0C80:02: add_memory failed
> > [  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
> > [  216.392187] acpi PNP0C80:02: Enumeration failure
> >=20
> > This will cause issue in a known use case where 'mem=3D' is added to
> > the hypervisor. The memory that lies after 'mem=3D' boundary will be
> > assigned to KVM guests. After commit 357b4da50a62 merged, memory
> > can't be extended dynamically if system memory on hypervisor is not
> > sufficient.
> >=20
> > So fix it by also checking if it's during boot-time restricting to ad=
d
> > memory. Otherwise, skip the restriction.
> >=20
> > And also add this use case to document of 'mem=3D' kernel parameter.
> >=20
> > Fixes: 357b4da50a62 ("x86: respect memory size limiting via mem=3D pa=
rameter")
> > Signed-off-by: Baoquan He <bhe@redhat.com>
>=20
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks, Juergen. Seems I should add more details to explain this. Will
post v4 with your 'Reviewed-by'.

