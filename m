Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C33C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA90D20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QKfLxKf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgBFMiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 07:38:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34168 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgBFMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:38:55 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so5327838otf.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 04:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0yCsXDZ7Hq3Ej7Od8dbrQEEhSu2aGFReqoIYO2djUlc=;
        b=QKfLxKf+NoFm4DBjWkoWWiW7eX2dRqD3gS03sqW2v3ztdidPcYvxnTJ0QoKe9UqRO+
         o/jdO2CEZgQmKz+y8gJ47hiCcEIM82IGPom5ZNAFWuZ9886t6iz8A8vuo6BPFxwInoJb
         bV6TQsivro3RT8xFE/8oWapetPU7B7vg22Vys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0yCsXDZ7Hq3Ej7Od8dbrQEEhSu2aGFReqoIYO2djUlc=;
        b=E3qopL10aoiosEiKJQepxXvXTFk/aWQ+gae5BcKlVeyfERxLd1TjoX1KMtcdfhtKOX
         AD0yGHFcQolfbURu16XBObNuJnASGRD5Ldis94qGrapvPQr5AWSjDLG4Phdu9SxShxat
         KRi5fPsKLf2RguUNpHhglQkSUh95Mg9i5MXfMZwop28lrYKXQ0dHca6lmSLghYzs5HpK
         tWPGxIyFCNon8cEm5ljwAYxpC1lCEgu3wjGJof8zR5niheM6ycTt5IYiQpczIxsJoGlg
         LFm3Hj9e0VOqv2BP+sm9BD33GSMj+3C7e48FFtC+G8NfpIlCr3Cn7eaidvuybBWeFuQJ
         sXeQ==
X-Gm-Message-State: APjAAAWTTJ0aJKKbWuDRWv0EMWmH8v9zN2/XqXfFpk58tP0TADqXZp8O
        AJdu1SSoAWxcGYgoEz3PgDoWbA==
X-Google-Smtp-Source: APXvYqynAxkaa1Q44AfR1w48j/Y6VPFRGOmR/85OyfO88x0+FLS7Y1TERPYpEugEag+KWDetTLeoOg==
X-Received: by 2002:a05:6830:1251:: with SMTP id s17mr30044739otp.108.1580992735002;
        Thu, 06 Feb 2020 04:38:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e206sm873200oia.24.2020.02.06.04.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 04:38:54 -0800 (PST)
Date:   Thu, 6 Feb 2020 04:38:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 01/11] modpost: Support >64K sections
Message-ID: <202002060438.C2C977F8@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-2-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205223950.1212394-2-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 02:39:40PM -0800, Kristen Carlson Accardi wrote:
> According to the ELF specification, if the value of st_shndx
> contains SH_XINDEX, the actual section header index is too
> large to fit in the st_shndx field and you should use the
> value out of the SHT_SYMTAB_SHNDX section instead. This table
> was already being parsed and saved into symtab_shndx_start, however
> it was not being used, causing segfaults when the number of
> sections is greater than 64K. Check the st_shndx field for
> SHN_XINDEX prior to using.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>

Looking at "readelf" output continues to make me laugh. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
