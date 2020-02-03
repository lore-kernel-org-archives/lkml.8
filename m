Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4915DC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1845A2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0ZbVzFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgBCS1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:27:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32849 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727124AbgBCS1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580754438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ScQAELNsrhFhctu+0tG8n84o4vjKl6zh78J/ARkQSJ4=;
        b=L0ZbVzFHGo/ihcvLl9vN2fGAt/2y1bR+jeGs7ulQotVVGty3sVkPFecmenZ5dXPvM3/Npo
        1jTejyoNm6y3oyLzqoWxSUT+MVINvWbHVBzi+o0qtnLKgjz4lxdw3BVVCABXeuZpWbk5u3
        AlCb/dTnEnEE1szyvgA/wdGLILix3Pw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-3Fq-OHPgNXirtzdTnknZfQ-1; Mon, 03 Feb 2020 13:27:14 -0500
X-MC-Unique: 3Fq-OHPgNXirtzdTnknZfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99696A0CC4;
        Mon,  3 Feb 2020 18:27:12 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 509F719C7F;
        Mon,  3 Feb 2020 18:27:09 +0000 (UTC)
Date:   Mon, 3 Feb 2020 11:27:08 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 3/3] iommu/uapi: Add helper function for size lookup
Message-ID: <20200203112708.14174ce2@w520.home>
In-Reply-To: <20200131155125.53475a72@jacob-builder>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1580277724-66994-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200129144046.3f91e4c1@w520.home>
        <20200129151951.2e354e37@w520.home>
        <20200131155125.53475a72@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 15:51:25 -0800
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> Hi Alex,
> Sorry I missed this part in the previous reply. Comments below.
> 
> On Wed, 29 Jan 2020 15:19:51 -0700
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > Also, is the 12-bytes of padding in struct iommu_gpasid_bind_data
> > excessive with this new versioning scheme?  Per rule #2 I'm not sure
> > if we're allowed to repurpose those padding bytes,  
> We can still use the padding bytes as long as there is a new flag bit
> to indicate the validity of the new filed within the padding.
> I should have made it clear in rule #2 when mentioning the flags bits.
> Should define what extension constitutes.
> How about this?
> "
>  * 2. Data structures are open to extension but closed to modification.
>  *    Extension should leverage the padding bytes first where a new
>  *    flag bit is required to indicate the validity of each new member.
>  *    The above rule for padding bytes also applies to adding new union
>  *    members.
>  *    After padding bytes are exhausted, new fields must be added at the
>  *    end of each data structure with 64bit alignment. Flag bits can be
>  *    added without size change but existing ones cannot be altered.
>  *
> "
> So if we add new field by doing re-purpose of padding bytes, size
> lookup result will remain the same. New code would recognize the new
> flag, old code stays the same.
> 
> VFIO layer checks for UAPI compatibility and size to copy, version
> sanity check and flag usage are done in the IOMMU code.
> 
> > but if we add
> > fields to the end of the structure as the scheme suggests, we're
> > stuck with not being able to expand the union for new fields.  
> Good point, it does sound contradictory. I hope the rewritten rule #2
> address that.
> Adding data after the union should be extremely rare. Do you see any
> issues with the example below?
>  
>  offsetofend() can still find the right size.
> e.g.
> V1
> struct iommu_gpasid_bind_data {
> 	__u32 version;
> #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> 	__u32 format;
> #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> 	__u64 flags;
> 	__u64 gpgd;
> 	__u64 hpasid;
> 	__u64 gpasid;
> 	__u32 addr_width;
> 	__u8  padding[12];
> 	/* Vendor specific data */
> 	union {
> 		struct iommu_gpasid_bind_data_vtd vtd;
> 	};
> };
> 
> const static int
> iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = { /*
> IOMMU_UAPI_BIND_GPASID */ {offsetofend(struct iommu_gpasid_bind_data,
> vtd)}, ...
> };
> 
> V2, Add new_member at the end (forget padding for now).
> struct iommu_gpasid_bind_data {
> 	__u32 version;
> #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> 	__u32 format;
> #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> #define IOMMU_NEW_MEMBER_VAL	(1 << 1) /* new member added */
> 	__u64 flags;
> 	__u64 gpgd;
> 	__u64 hpasid;
> 	__u64 gpasid;
> 	__u32 addr_width;
> 	__u8  padding[12];
> 	/* Vendor specific data */
> 	union {
> 		struct iommu_gpasid_bind_data_vtd vtd;
> 	};
> 	__u64 new_member;
> };
> const static int
> iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = { /*
> IOMMU_UAPI_BIND_GPASID */ 
> 	{offsetofend(struct iommu_gpasid_bind_data,
> 	vtd), offsetofend(struct iommu_gpasid_bind_data,new_member)},
> 
> };
> 
> V3, Add smmu to the union,larger than vtd
> 
> struct iommu_gpasid_bind_data {
> 	__u32 version;
> #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> #define IOMMU_PASID_FORMAT_INTEL_SMMU	2
> 	__u32 format;
> #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> #define IOMMU_NEW_MEMBER_VAL	(1 << 1) /* new member added */
> #define IOMMU_SVA_SMMU_SUPP	(1 << 2) /* SMMU data supported */
> 	__u64 flags;
> 	__u64 gpgd;
> 	__u64 hpasid;
> 	__u64 gpasid;
> 	__u32 addr_width;
> 	__u8  padding[12];
> 	/* Vendor specific data */
> 	union {
> 		struct iommu_gpasid_bind_data_vtd vtd;
> 		struct iommu_gpasid_bind_data_smmu smmu;
> 	};
> 	__u64 new_member;
> };
> const static int
> iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = {
> 	/* IOMMU_UAPI_BIND_GPASID */
> 	{offsetofend(struct iommu_gpasid_bind_data,vtd),
> 	offsetofend(struct iommu_gpasid_bind_data, new_member),
> 	offsetofend(struct iommu_gpasid_bind_data, new_member)},
> ...
> };
> 

How are you not breaking rule #3, "Versions are backward compatible"
with this?  If the kernel is at version 3 and userspace is at version 2
then new_member exists at different offsets of the structure.  The
kernels iommu_uapi_data_size for V2 changed between version 2 and 3.
Thanks,

Alex

