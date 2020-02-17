Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9362C34026
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07F6206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzlBnvBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgBQTvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:51:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56562 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727241AbgBQTvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581969109;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=B9s0juc3AflESlDHl9D+g0GD+lvMcnZm6qayBkujW4o=;
        b=BzlBnvBOJ4QDT8O9b/8d5ObdleqjlMxXpq055CKFfpsyuRh4clz/gN1gxa8Iw8N7Zy6rww
        mKpHEE5KaRRPeq7DhHUr72X3giWPHpzgoFtrq1/wdwDhGjWn0ZbFX/mC1ue6IBUyloUQBg
        3d/ORljGUI2UftDFMk/7sqLlm4Dsc0Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-LYFb52XuOPuv_HvuYyT-lw-1; Mon, 17 Feb 2020 14:51:39 -0500
X-MC-Unique: LYFb52XuOPuv_HvuYyT-lw-1
Received: by mail-qt1-f200.google.com with SMTP id k20so11562061qtm.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 11:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=B9s0juc3AflESlDHl9D+g0GD+lvMcnZm6qayBkujW4o=;
        b=cVP9DgORr/Xju4r72Nl3lcBzln8KzvyR0b4vtlrrS5JaMSCJQ34Z9D7DjMSGT4bNqF
         AtIJC8Cu9z5WBcMv2VcZpvlku+exZoghrqODk+8zfemIjFhYq8D4T/qLSUwBvnMPdHXT
         TYl9hyn6NmnHZU7JIYtRy9m9QfFFM+v9RH2mFaMhjTG5efbl/Bd5nQSgzhSEEDZiim4M
         17hxLfDovfveZVRH1IgQKPw3jy+GPlgjKYeM9Tk+jXJElahqMjkn6OaBYQIBI3UK5E72
         VQ8ikYB82sttQChtz+i0pFEw9Yag8TVbpyzRdehIdAsbUIo+v0RYlvHP/UJ6EuEGASkK
         nUeQ==
X-Gm-Message-State: APjAAAVX9Tmvi1DuhUXTzIi5UueEzzKVYx507vSa0o7IDUTuSVtUMFdc
        ssXbCFQ2HYV0UD/3jIOxXEJ2Y9H5bkk3zpv+KolG9V1lU6rDvEJilREdlGDsmVzb0zFCf8HT+Pe
        SdJre8l1NF5a++3Mh+nohBBPz
X-Received: by 2002:ac8:7b29:: with SMTP id l9mr14174344qtu.141.1581969099210;
        Mon, 17 Feb 2020 11:51:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqObS39aCeAmxnIcidfbrehPHzRVkMTV6gjTpXgTb5GckX99ilZ8eP+pSZqDZudFEE4ChYTg==
X-Received: by 2002:ac8:7b29:: with SMTP id l9mr14174335qtu.141.1581969099001;
        Mon, 17 Feb 2020 11:51:39 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id u13sm676899qtg.64.2020.02.17.11.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 11:51:37 -0800 (PST)
Date:   Mon, 17 Feb 2020 12:51:36 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iommu/vt-d: Do deferred attachment in
 iommu_need_mapping()
Message-ID: <20200217195136.g7gfamcmtpow35nk@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-4-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200217193858.26990-4-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Feb 17 20, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>The attachment of deferred devices needs to happen before the check
>whether the device is identity mapped or not. Otherwise the check will
>return wrong results, cause warnings boot failures in kdump kernels, like
>
>	WARNING: CPU: 0 PID: 318 at ../drivers/iommu/intel-iommu.c:592 domain_get_iommu+0x61/0x70
>
>	[...]
>
>	 Call Trace:
>	  __intel_map_single+0x55/0x190
>	  intel_alloc_coherent+0xac/0x110
>	  dmam_alloc_attrs+0x50/0xa0
>	  ahci_port_start+0xfb/0x1f0 [libahci]
>	  ata_host_start.part.39+0x104/0x1e0 [libata]
>
>With the earlier check the kdump boot succeeds and a crashdump is written.
>
>Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

