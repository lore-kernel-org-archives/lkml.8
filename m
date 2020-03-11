Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67633C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD6520764
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S72xrfKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbgCKRoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:44:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36431 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbgCKRoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:44:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id g12so1434388plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=95hfOnFS8XcE0SzCSwHywUOSO3ehRo621FiZoRz9T2U=;
        b=S72xrfKyT6ehcjzIlNPRULiD7x0Ry14Ev5yh8+oY7+cEOwLlgoUzbRYHhkyUTRyJY3
         1F6KkDlrXFMvSPXpAgoXaW+KFeOB5zRs/27RpIE3k/lCBcJhTwCvTgd0TNoh5K81SfUx
         bt0J9C43UMfm+SwtHPVMonayJX3loJX1Bot1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=95hfOnFS8XcE0SzCSwHywUOSO3ehRo621FiZoRz9T2U=;
        b=Y4n3sfZR2myVhT3Z/3MY0/kP8w5jHRJjwrTcV0xLgvVaqyaxR/9sdwYujNtos+DEZ4
         Xo1AhcO0XA+8wD5PA+3Cz/sAWvsaDNd7f3NMN5bXvCXgWbUUugQd0InrxgK+8gUzD6UZ
         y1MsI+iKD3Ro3Nh2mqh5GtdzbBOaJkKXUglIXmbJ1uZUp3ujkNiYafkn5H7uXVgTamjh
         EK+oYG00J+AFkrorHjMT7b+rgz0Az1cgTDuZUTEzlXj7/hdCl8ckNiHrBH1sydknm3ZH
         UljV+PoKWHXPWDbpuAztiwdoI4DdRY+yLrfK9ZqLb/s42RkQlezEydjGR9cFDv4tHs0m
         /vbA==
X-Gm-Message-State: ANhLgQ0aW7mOWKwExS/xmFXcxBtM3cUcwfNObBihVyzkHTH6n9kwMETp
        r0kpwOshriQ2GZguWRquK0MJXw==
X-Google-Smtp-Source: ADFU+vt1E7WV6q/CcNOlqwjmSB7ni8eqk0Pkds5Yk5WBpGtM41QjlcCGsbMYxNIMZIokJn1Rpuq08w==
X-Received: by 2002:a17:90a:fa16:: with SMTP id cm22mr4679988pjb.137.1583948651386;
        Wed, 11 Mar 2020 10:44:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d84sm1265231pfd.197.2020.03.11.10.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:44:10 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:44:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     'Christopher Lameter' <cl@linux.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Vitaly Nikolenko <vnik@duasynt.com>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slub: Relocate freelist pointer to middle of object
Message-ID: <202003111039.24B8A0B@keescook>
References: <202003051624.AAAC9AECC@keescook>
 <alpine.DEB.2.21.2003081919290.14266@www.lameter.com>
 <6fbf67b5936a44feaf9ad5b58d39082b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fbf67b5936a44feaf9ad5b58d39082b@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christopher Lameter
> Sent: 08 March 2020 19:21
> 
> On Thu, 5 Mar 2020, Kees Cook wrote:
> 
> > Instead of having the freelist pointer at the very beginning of an
> > allocation (offset 0) or at the very end of an allocation (effectively
> > offset -sizeof(void *) from the next allocation), move it away from
> > the edges of the allocation and into the middle. This provides some
> > protection against small-sized neighboring overflows (or underflows),
> > for which the freelist pointer is commonly the target. (Large or well
> > controlled overwrites are much more likely to attack live object contents,
> > instead of attempting freelist corruption.)
> 
> Sounds good. You could even randomize the position to avoid attacks on via
> the freelist pointer.

That's a good point. "offset" is just calculated once, and for many
slabs, the available space is quite large. I wonder what the best
practice might be for how far from the edge to stay. Hmmm. Maybe simply
carve it into thirds, and randomize the offset within the middle third?

-- 
Kees Cook
