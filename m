Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE5CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B478A20842
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jGUWW+rr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbgCBTIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:08:07 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:32893 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBTIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:08:07 -0500
Received: by mail-pj1-f66.google.com with SMTP id m7so215937pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 11:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XbS5Oui71TzDSP82zad1HNkPWeQrHZfwLOAk3ttkqPM=;
        b=jGUWW+rrTuCc++AiLH0Jj9vkPATEZ//4C63+YRSjlqzn0c9jqq4hDPQi9tXbitIv1u
         VqLGvPBomCXeewRdCAdzEyMMfvVOASIDci+cn6Mwmiy7QcN2kn9HshsT7n6CqANjidbX
         SjMtuzQjlBNN7ykH6uerE16g6C1o2QAx56ymw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XbS5Oui71TzDSP82zad1HNkPWeQrHZfwLOAk3ttkqPM=;
        b=sJt2DcJHMk2WSLpUd0Hfo4Ooi9Cj+WKbqCeLCQ1/ndNMSeh+1RGoJpP7UMHmphizdd
         9EFSJ8gRlBpUDAE6eFCveNMd4tbSR/A8U8A8cVEblleIi19GK3/zGQ5WseQBe4PJXlUr
         muBCj/cVRG1vb6jcAA4vlPKv2vd/uYXy8Ayv6Bar5O7G198dMBt3Ndhp6IWifdq4Mv1B
         ZEUdFhJsy8a2LkZ1Ge6ozvGQ8vhRKOVtcHa3YCZ/9WPp9JYuZ8kNJ+NqLl1lAjUwdfNz
         O9inm+iFWV7s31bU9kYVhhIIOrTcy7Iko+qVK9rI0YoXMKU9U2GBokT7yDVOCzKaePIu
         T0hQ==
X-Gm-Message-State: ANhLgQ3jZQAVPF0+oxV+GVp1ELxkYtT+/YY++OG49ta4ZYyrHTVcwa9k
        js/nnhRDgeEKl1fEzZI0db5HrQ==
X-Google-Smtp-Source: ADFU+vs45YCE/A4RV+RfdPn7aH+3QF9x3z2I7E6FgPpDlVlxqDee5DDZoCBVOcK9O/y13IEDwk7Adg==
X-Received: by 2002:a17:902:b7c2:: with SMTP id v2mr572385plz.54.1583176084467;
        Mon, 02 Mar 2020 11:08:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r3sm14623739pfq.126.2020.03.02.11.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 11:08:03 -0800 (PST)
Date:   Mon, 2 Mar 2020 11:08:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFC PATCH 09/11] kallsyms: hide layout and expose seed
Message-ID: <202003021107.38017F90@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-10-kristen@linux.intel.com>
 <202002060428.08B14F1@keescook>
 <a915e1eb131551aa766fde4c14de5a3e825af667.camel@linux.intel.com>
 <CAG48ez2SucOZORUhHNxt-9juzqcWjTZRD9E_PhP51LpH1UqeLg@mail.gmail.com>
 <41d7049cb704007b3cd30a3f48198eebb8a31783.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41d7049cb704007b3cd30a3f48198eebb8a31783.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 11:01:56AM -0800, Kristen Carlson Accardi wrote:
> On Thu, 2020-02-06 at 20:27 +0100, Jann Horn wrote:
> > https://codesearch.debian.net/search?q=%2Fproc%2Fkallsyms&literal=1
> 
> I looked through some of these packages as Jann suggested, and it seems
> like there are several that are using /proc/kallsyms to look for
> specific symbol names to determine whether some feature has been
> compiled into the kernel. This practice seems dubious to me, knowing
> that many kernel symbol names can be changed at any time, but
> regardless seems to be fairly common.

Cool, so a sorted censored list is fine for non-root. Would root users
break on a symbol-name-sorted view? (i.e. are two lists needed or can we
stick to one?)

-- 
Kees Cook
