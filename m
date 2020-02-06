Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F11C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F121217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YDPSl97I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgBFMhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 07:37:42 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41610 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbgBFMhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:37:42 -0500
Received: by mail-ot1-f65.google.com with SMTP id r27so5297402otc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 04:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6fXR/mbSdG/GuSMMWg/QMGok/jnDT6wVXIjTyBjsSus=;
        b=YDPSl97I6ie5WoTko+sLjNuIbuKRJ0lnQHSRwMr5Y6HtI9GRn2CyTqHW9t0F/mCZTb
         PrqWx1eIhx1UOYMGHk1pWUX0UhRN1FQd6pUSajEMJoSkwJGyfF4hMsofqz5ytpoefHyN
         DN8hb4Rw0W7U6VO5nOyU0MyBMSfHWGyFgvovg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6fXR/mbSdG/GuSMMWg/QMGok/jnDT6wVXIjTyBjsSus=;
        b=LiZER6tppcrbFOzQtSP95IWHmIrhpRiXq1vmsXs8ZqI+M2RaNR+XlP+IbxnEltnMs2
         vyCoecaJFB7bAM3ZhZrrkufEMgKuQbSkbazgOvEw9JNnME3Fh+aY3wel8Ma7M4ihR8F1
         xp7XbvzY2RrgGwDC37VhAu+ppugW274lcg4jdj1SoVntUO6I552upu0L1GWUrK5tcrhh
         rYkbgH2VxPyLUGc/Ej4D1qrwuS0SyzxdfNT9miju6Kv9r/1lvhIiP9hxkiBp0KRlG6fy
         kTz9547KhECSoNMFK7es2CU2E+eRus3KS+NxkXNxhUqfD1qdaSWNmGIxenvxX162i5Ld
         tEhw==
X-Gm-Message-State: APjAAAUPOocJaaSiekQUXKK1HSvYFShwuz2yzhQqyWwo189Rj0Or8777
        D20ljzGlFYL5vb29f3oavhfekNhqiWQ=
X-Google-Smtp-Source: APXvYqxakL0/UPBmResyRSGCzxIsFRYduCjh/RPlXP67bb//K0x4goyhxhEXAJoeeeHituBlbyGvKQ==
X-Received: by 2002:a9d:1928:: with SMTP id j40mr30813778ota.68.1580992661363;
        Thu, 06 Feb 2020 04:37:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a14sm1061768otr.54.2020.02.06.04.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 04:37:40 -0800 (PST)
Date:   Thu, 6 Feb 2020 04:37:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 07/11] x86/tools: Adding relative relocs for
 randomized functions
Message-ID: <202002060435.CF7BFB723@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-8-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205223950.1212394-8-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 02:39:46PM -0800, Kristen Carlson Accardi wrote:
> If we are randomizing function sections, we are going to need
> to recalculate relative offsets for relocs that are either in
> the randomized sections, or refer to the randomized sections.
> Add code to detect whether a reloc satisifies these cases, and if
> so, add them to the appropriate reloc list.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>

Looks good to me. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
