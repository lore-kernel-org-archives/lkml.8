Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8B0C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26F72187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/0O19ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgAOK4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:56:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44890 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgAOK4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579085778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZyaR/7/9S+/6ABEGQloytJgYAXgFxNor2r6ruyS7t4A=;
        b=W/0O19ia5aOmOLF76OKbvgoj29KRBc/VyNl9znnV8rz3D3WPo/yzFZyBl6J2rkmmutI1zo
        6bMjLPPZzWFe9te6u6sREAJZMH6/t6qJGRMO14sCu4seZLFStQTgXj61/Uq7z6gpKh6VLP
        ps3STBco3IZFW0yDTwJzXQZV51eUbTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-fb4UWU8QN-CefzjtnH-Fcg-1; Wed, 15 Jan 2020 05:56:15 -0500
X-MC-Unique: fb4UWU8QN-CefzjtnH-Fcg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3B27107ACC4;
        Wed, 15 Jan 2020 10:56:13 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C51D160BE0;
        Wed, 15 Jan 2020 10:56:07 +0000 (UTC)
Date:   Wed, 15 Jan 2020 11:56:05 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     alex.williamson@redhat.com, kwankhede@nvidia.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kevin.tian@intel.com, joro@8bytes.org, peterx@redhat.com,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH v4 04/12] vfio_pci: make common functions be extern
Message-ID: <20200115115605.2014c01f.cohuck@redhat.com>
In-Reply-To: <1578398509-26453-5-git-send-email-yi.l.liu@intel.com>
References: <1578398509-26453-1-git-send-email-yi.l.liu@intel.com>
        <1578398509-26453-5-git-send-email-yi.l.liu@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jan 2020 20:01:41 +0800
Liu Yi L <yi.l.liu@intel.com> wrote:

> This patch makes the common functions (module agnostic functions) in
> vfio_pci.c to be extern. So that such functions could be moved to a
> common source file.
> 
> *) vfio_pci_set_vga_decode
> *) vfio_pci_probe_power_state
> *) vfio_pci_set_power_state
> *) vfio_pci_enable
> *) vfio_pci_disable
> *) vfio_pci_refresh_config
> *) vfio_pci_register_dev_region
> *) vfio_pci_ioctl
> *) vfio_pci_read
> *) vfio_pci_write
> *) vfio_pci_mmap
> *) vfio_pci_request
> *) vfio_pci_err_handlers
> *) vfio_pci_reflck_attach
> *) vfio_pci_reflck_put
> *) vfio_pci_fill_ids

I find it a bit hard to understand what "module agnostic functions" are
supposed to be. The functions you want to move seem to be some "basic"
functions that can be shared between normal vfio-pci and
vfio-mdev-pci... maybe talk about "functions that provide basic vfio
functionality for pci devices" and also mention the mdev part?

[My rationale behind complaining about the commit messages is that if I
look at this change in a year from now, I want to be able to know why
and to what end that change was made.]

> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci.c         | 30 +++++++++++++-----------------
>  drivers/vfio/pci/vfio_pci_private.h | 15 +++++++++++++++
>  2 files changed, 28 insertions(+), 17 deletions(-)

