Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12753C34026
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 20:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDC1206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 20:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atoDUkNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgBQUEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 15:04:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49227 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727241AbgBQUEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 15:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581969840;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=gNniWaKO6cLGO+dIQOvLhhRagXQZ/USr9hJlmkNpWOY=;
        b=atoDUkNLNlePqzJX44hBsXBMiIb+efihDv3VrNuqmDuf3f3dlwGjZY+Gh/FiA520SM83hG
        WtNQYSNM6LxTOUV9Mvad6YAWWEfdScg6A1AqqqFv6fVr0S/MJ/KagqAeoMdN2RaWFKnAQR
        EqhuNR5gV8LGkGt3ZUByIb4JW3BNawM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-4sIZbrXpM0OhyACdxXwMIQ-1; Mon, 17 Feb 2020 14:50:31 -0500
X-MC-Unique: 4sIZbrXpM0OhyACdxXwMIQ-1
Received: by mail-qv1-f69.google.com with SMTP id z39so10921985qve.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 11:50:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=gNniWaKO6cLGO+dIQOvLhhRagXQZ/USr9hJlmkNpWOY=;
        b=d3ldBzNiOT7mr3hNLPKhIxFHhW0q0Wnnuqq0YEZfCizQt0INPGdszquU0Sg3ukcaO4
         BUBMwHDVoo1qlpR+vOAch9eDtKmNsVWGPiNCHmfq1PUHWr+vulNPZAEB4xggzkFIIDqB
         mXEq+gTAtSB1qzwJpglwHCtqmmF8F2jQ58KeA8Wgt6vOEvMN095K5OQBnfNwZjhPut0j
         ufk59xirwafOhO3DvMZ985tUFxVrKr6xP4/YVbM6ooDcyYAEdRdDUYsfs60dLOO4QEJj
         4J/rfTmVNLus3M4lsNui0yX6s8NjRf3R/QLRewQ5toWv3pxNdA4t38i99gi0sKIqx/4L
         LuFg==
X-Gm-Message-State: APjAAAVEb4ekRo7tdYpzyoVrpPu/hKf7Xtu+Eb500QevoRjumTAt0MY0
        3ZqedwkdlPyZW62GkRkWpZ7sMQG0+MVW5iJDYXELzI8LM0ECZHuohJT4rX2IInzvRqWFVUy0t9b
        Ah5JrPo8cz6e9y0kaO1SLEkS6
X-Received: by 2002:a05:620a:1279:: with SMTP id b25mr14322634qkl.385.1581969010470;
        Mon, 17 Feb 2020 11:50:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEz2fW3GrBa7Qc1v+rXsbwKMDxOkGqyFWXWzs6sQ1ePE7ymxQJi4Brq0/lHG4v1VDI2Vn48Q==
X-Received: by 2002:a05:620a:1279:: with SMTP id b25mr14322617qkl.385.1581969010237;
        Mon, 17 Feb 2020 11:50:10 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id a72sm731107qkc.121.2020.02.17.11.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 11:50:09 -0800 (PST)
Date:   Mon, 17 Feb 2020 12:50:08 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iommu/vt-d: Add attach_deferred() helper
Message-ID: <20200217195008.kxl6n6ev2jchzcxc@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-2-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200217193858.26990-2-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Feb 17 20, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>Implement a helper function to check whether a device's attach process
>is deferred.
>
>Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

