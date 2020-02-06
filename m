Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED1EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B98217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TQ3RFnoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgBFMjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 07:39:46 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42596 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgBFMjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:39:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id j132so4401596oih.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 04:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6jPO1T6lQYmXuz/rFgYHrB+x12nlG09wpWY9E0p2rSA=;
        b=TQ3RFnoZKH3ZBv79/bbk5oudQBaraIuvDJKWhIJyFoOHL7MyM3+HGsuy+LmNLyqiA2
         ztAbkuqDdXJjGOIIhGdS3NZksNBPvIxNlp5MK6aPSl+kIA5KyURvm8VAKmNwOAF++5bt
         XLVcwDF+XfS+7sNSFhRkuPEpYItkmNHN3UQrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6jPO1T6lQYmXuz/rFgYHrB+x12nlG09wpWY9E0p2rSA=;
        b=IbuF7QtkGtdrLA7II9zAHNlBOU+5AKKZifb2n1EOqwApwPcnwbrAb9dEqqpVV/VuMY
         nO59O9K8PgPYTyxQDVet/0fFpBoveLEZPltl4Eiql9kNrUDSiPffUQmCKLfJ7GyqA9d6
         qRURuA0UO+rZF6jGbvpG0c1Z4ZRCkF9CuDplOwYrFXXifqVooqtIm3jyWIhM3zuKK6qf
         Jm7o4F37rVl4oB2N2PZocq9bS6/4bT9y5IIBWnXE1l40TTgfAe5EVIG6CWWziGMtikqR
         A4hd8Ths8z62K/8Zi44ws1OOA9+QxNHNoJ7046s5ublAbGlKgNgkIUAiWd4MdVr75MCc
         BvJg==
X-Gm-Message-State: APjAAAUDitBWuKsk7dyElJoh9MFgyVmj/EiP2ZlVBm/1EzsTkQuhXSEj
        9XgeqMbT9IY55kRvJxP2GX8Ghg==
X-Google-Smtp-Source: APXvYqyYBNyrz5dJrLJgiE7fGukQlyrxAicKgMaKFnp3VSjEQvph59mI9TJQKtb23axx9NlPf3j0EA==
X-Received: by 2002:aca:3857:: with SMTP id f84mr6389157oia.150.1580992785571;
        Thu, 06 Feb 2020 04:39:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n64sm1065880otn.35.2020.02.06.04.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 04:39:44 -0800 (PST)
Date:   Thu, 6 Feb 2020 04:39:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 02/11] x86: tools/relocs: Support >64K section headers
Message-ID: <202002060438.D30727DA@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-3-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205223950.1212394-3-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 02:39:41PM -0800, Kristen Carlson Accardi wrote:
> While it is already supported to find the total number of section
> headers if we exceed 64K sections, we need to support the
> extended symbol table to get section header indexes for symbols
> when there are > 64K sections. Parse the elf file to read
> the extended symbol table info, and then replace all direct references
> to st_shndx with calls to sym_index(), which will determine whether
> we can read the value directly or whether we need to pull it out of
> the extended table.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>

Looks good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
