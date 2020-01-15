Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E669DC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6E7222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKo/hsUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgAOKng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:43:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33227 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729585AbgAOKng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579085014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bbj9Kc2TqKCL3zhoK+YIraED9e1tRV86n2nohBIEClM=;
        b=jKo/hsUZCQD0i9cGC1cVn62KJUCIvLtBEw+HPKy8wHEMkUQr0JqZet4NhxGKqx71RT4NQU
        BVNPjuwKI7/KylK8ixEvcbDjetb0IN5+txRLnur4BeXBo0FSNAysGgDPYINUZmlFMPILK4
        hibLTT9uQA94ECQwSaT18eZjnKzIyzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-Jd9zGg8yM7il1o2fxgw4fw-1; Wed, 15 Jan 2020 05:43:33 -0500
X-MC-Unique: Jd9zGg8yM7il1o2fxgw4fw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C319D1097D01;
        Wed, 15 Jan 2020 10:43:31 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1EDC80617;
        Wed, 15 Jan 2020 10:43:24 +0000 (UTC)
Date:   Wed, 15 Jan 2020 11:43:22 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     alex.williamson@redhat.com, kwankhede@nvidia.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kevin.tian@intel.com, joro@8bytes.org, peterx@redhat.com,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH v4 02/12] vfio_pci: move
 vfio_pci_is_vga/vfio_vga_disabled to header file
Message-ID: <20200115114322.31644ede.cohuck@redhat.com>
In-Reply-To: <1578398509-26453-3-git-send-email-yi.l.liu@intel.com>
References: <1578398509-26453-1-git-send-email-yi.l.liu@intel.com>
        <1578398509-26453-3-git-send-email-yi.l.liu@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jan 2020 20:01:39 +0800
Liu Yi L <yi.l.liu@intel.com> wrote:

> This patch moves two inline functions to vfio_pci_private.h for further
> sharing across source files. Also avoids below compiling error in further
> code split.
>=20
> "error: inlining failed in call to always_inline =E2=80=98vfio_pci_is_vga=
=E2=80=99:
> function body not available".

"We want to use these functions from other files, so move them to a
header" seems to be justification enough; why mention the compilation
error?

>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci.c         | 14 --------------
>  drivers/vfio/pci/vfio_pci_private.h | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 14 deletions(-)

