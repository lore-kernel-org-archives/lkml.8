Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9FBC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D766A206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 19:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsWuDXKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgBQTy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 14:54:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32021 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729798AbgBQTyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581969294;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=k22V0NI2T+CODElUbt4W6m1o0DIF8IGREqO+FIqkD2A=;
        b=BsWuDXKCihuL6/LYVwnidfuXHPaAPR4h70oX4lu2gKoqMqBJ2rVu5KUsDZyP9Tl5gcX7id
        jl+h3gN5twDfi2WkQ8fEJIkNrvoIHG3JliZR7aPAfZuhuWoUpfSuQHSY7xTifVt738WvUw
        bxA1+f+945VqtAmcrzJ8qe/8/h87NTQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-R-4SOanxPcWGYd4fm1Tm_g-1; Mon, 17 Feb 2020 14:54:52 -0500
X-MC-Unique: R-4SOanxPcWGYd4fm1Tm_g-1
Received: by mail-qv1-f71.google.com with SMTP id e26so10924280qvb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 11:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=k22V0NI2T+CODElUbt4W6m1o0DIF8IGREqO+FIqkD2A=;
        b=nXtX+ELWR4QYkBnfbv4N/NQyg0eGbe24M6cBhXH4qUm5d4Wdqj5hFpEs79gtrw7qw7
         CJFL62dbpyRvnLBD/VIzqkDj79tv+ZjS4ZE2OenXSOASfBdzF12B6hLL071uQ6O95fw9
         ju1OJMItQy9cSzzlVweW76etF+Ut5NRLS7x10PXcpRvGefxEGBmVBwYZJDfrXzxeuL79
         +r4fbUGMwlp50GgtMrlXuJdoc+/Y/9fgC/Pw2R+F2zZi+NCvpDjsJYYUas1uxhmQyWdX
         xI9KFnKtgrpKzV7HXUHvgkw6glEUx0rJyoYzh/fJsKWqejqLrvkLQHmC0j3yltNQV5Sf
         N3gg==
X-Gm-Message-State: APjAAAXQURknxlorUtQwurQi8dTAYbkw4pe5QE26DRaDJ/ZIoVQeDsdU
        gFBDztcYRKI/BnjYrNTcUwR9YcsDyS9V/z+y1ByTRiddzFqh55qmGKJS2b15lrU20K2Jr1FwFl8
        YAIUQbmPqsxLML1b9X8ru/Hxr
X-Received: by 2002:ac8:530c:: with SMTP id t12mr13720560qtn.83.1581969292524;
        Mon, 17 Feb 2020 11:54:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxz6/8kkWYoZceed2fKmMhPAZIXHW8axo8YLZkRnosQXVJIt3ilwzbKaFZnDXltOQklmiye5A==
X-Received: by 2002:ac8:530c:: with SMTP id t12mr13720547qtn.83.1581969292343;
        Mon, 17 Feb 2020 11:54:52 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id f7sm678488qtj.92.2020.02.17.11.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 11:54:51 -0800 (PST)
Date:   Mon, 17 Feb 2020 12:54:50 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iommu/vt-d: Simplify check in identity_mapping()
Message-ID: <20200217195450.hpk5mtxzbhy5p72a@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-6-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200217193858.26990-6-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Feb 17 20, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>The function only has one call-site and there it is never called with
>dummy or deferred devices. Simplify the check in the function to
>account for that.
>
>Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

