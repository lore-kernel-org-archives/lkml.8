Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEB7C34026
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503302067D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQoySoW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgBQTvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:51:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23084 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728728AbgBQTvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581969063;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=k0Chcwf/bsLQkQ/EVoH3LvBOp4tQlHkngFIxzFLsbIQ=;
        b=YQoySoW65LO3VFHWCZz7XzSN+iaLqyYArgOllSX1Dv/sa+MgRYBywN4wv8uHk8UTx+2I1K
        hv3GXaUAEqfAYik4VZ1Ps+J/jR0BVbaGqcu9op7QyKpdfG3PPqLc7H8VRe/0JA/bR+h9ao
        C8+i96MBMm80Zkp0RBxlSwIEFKC/gzE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-FFbIbn0BN42_5iV6NTbrYw-1; Mon, 17 Feb 2020 14:51:01 -0500
X-MC-Unique: FFbIbn0BN42_5iV6NTbrYw-1
Received: by mail-qv1-f71.google.com with SMTP id l1so10915424qvu.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 11:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=k0Chcwf/bsLQkQ/EVoH3LvBOp4tQlHkngFIxzFLsbIQ=;
        b=j7MaQfcppj2YdLiE3eOJQm17LlqBprgV+m8HasG5qyqj3aqXfTQRvqJmZYKYIQb/jC
         8AZUi1fLOS4u+XYeRb5ANFi03bi3NYoIRJ+b5A0keWNnexzcE4n5L9y4XvOD2WTN+J27
         hmsJuSlnmTn3RAb00J3Ig4eh5mpTaBQ2+T9RY2Iexj2QGTe9dgUF3ZC1eUj7/tleeokS
         6irtUoLeChEpmlPVstZNWSQwAg6+hrvDzOCAnjaGRqRaUmFbKPXwioB55fCJ744LJWS0
         NA2OXnV8iE5mcYp77QAukBw/9ViiuYY0djMJEsvAfMXt8TGAkOwkgDxPKM/YSuavsSl6
         UZoQ==
X-Gm-Message-State: APjAAAWAsFpPVKhUE4BjsAMFhIOwkz0zqRaa7VYGPtFyfgAkfij+XLM/
        +ZAygonfYSS2YBzuhZaWxa0gOYXdfrXCcXlCyMl0s+hVNUrvYcOcLXaSPbSXMXOe5aSVQktg8NK
        cgxhcMkCHFu38qHr+THsotAsO
X-Received: by 2002:ac8:78c:: with SMTP id l12mr14422062qth.187.1581969061343;
        Mon, 17 Feb 2020 11:51:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8naZM+WMKHD78gxMUMOBP7WY6Lu7S+z2iYJK0VTmyeX2Ylddr5klNyTj63j8jue71ybf8qA==
X-Received: by 2002:ac8:78c:: with SMTP id l12mr14422053qth.187.1581969061109;
        Mon, 17 Feb 2020 11:51:01 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id d2sm741039qko.110.2020.02.17.11.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 11:51:00 -0800 (PST)
Date:   Mon, 17 Feb 2020 12:50:59 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu/vt-d: Move deferred device attachment into
 helper function
Message-ID: <20200217195059.bcvht2m252msrnt5@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200217193858.26990-3-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Feb 17 20, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>Move the code that does the deferred device attachment into a separate
>helper function.
>
>Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

