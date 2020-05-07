Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FD5C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C743B216FD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ9XyzPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgEGT3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726761AbgEGT3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:29:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADF1C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 12:29:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z1so3495380pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 12:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UZiFmRSwooukbARffriwuLenCobEPu6OrZKDTN6rOMI=;
        b=LQ9XyzPRFI4yJ75kyCibj4LbWvp1W1qDaHBodoOlAqLzN7au7G8hm16e2+9JReICIG
         HULDgeVQc0SHrcMSw+3uLHKOiNyuWFeFWClQ2JnwoAZSdklVLqkEdXxBTHOfP+AR6Lg3
         KfYvftw299yDV4A1/mY9eZgDVAWBJA7Q7okNoMOh1cj6HL/VHljbTn5tfUEvGj1U6PHv
         0u8kj5AgcGAeDywS+5GYg/uty2M2S/NikwNnycxUImdEs3vKuPak9nm8mPB/c2aJKuqT
         XEJ58pqwAcaRpTyb5Yn39/DmWn9Qmo4ljwhAU63AnfKQCI7TkvuyvK2GasHQHCaU71GZ
         X5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UZiFmRSwooukbARffriwuLenCobEPu6OrZKDTN6rOMI=;
        b=hxs3jZG5scR/Luk37FWKeJUl9RKiyLXLFXz5C22YZzLP6anfHHbrawQMkDaE9IVcJ5
         fqt+xrL6mmf/HjMZ+uTjSlYUJzVkgBEICKb+Z2RtVJZfwVNudAfNDV1rYljTXSp0SftE
         5VM0uFXqvIs96uJ1EX7EJAFNM2vFUNL7CXh1x1Dsq6VoMLd3yMH5JlSFsHNrKDUdONe8
         d/JVcpORf0mHg0DTKIy5CA5imUOcWdpzR9qsKT6OutldJ68YzARE5McLWAcC03OTPuHE
         Bvo1V9PpNUJJIbZyyvJi4c2zDW2Vn4ba825eBx6wDDFdKVwY9Zjo8i8lvDa53+6Zdfdt
         Kl7Q==
X-Gm-Message-State: AGi0PubbqrnHmS1uxX4QsbeLF85vHgK5GiOFWsisgvrYGiKI1FITzFG+
        r1H3TcGbvUv1+Qj2skRcxR4=
X-Google-Smtp-Source: APiQypJwuGsxsy5gPrNHxW1kn/8GAvaP1KOCkZnHKUKOelU+lAHGNOFiwX/RRY94wLD3NjEngIqwEg==
X-Received: by 2002:aa7:9535:: with SMTP id c21mr15115063pfp.39.1588879775893;
        Thu, 07 May 2020 12:29:35 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id d126sm5762076pfc.81.2020.05.07.12.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 12:29:35 -0700 (PDT)
Date:   Thu, 7 May 2020 12:29:33 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ChenTao <chentao107@huawei.com>
Cc:     kstewart@linuxfoundation.org, tglx@linutronix.de,
        gregkh@linuxfoundation.org, allison@lohutok.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input/misc/drv260x: Remove a useless comparison
Message-ID: <20200507192933.GK89269@dtor-ws>
References: <20200507051617.212434-1-chentao107@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507051617.212434-1-chentao107@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 07, 2020 at 01:16:17PM +0800, ChenTao wrote:
> Fix the following warning:
> 
> 'mode' and 'library' are u32, they are never be negative,
> DRV260X_LRA_MODE and DRV260X_LIB_EMPTY are 0x00, the comparison
> is always false.


The fact that the symbolic names resolve to 0 is just a happenstance. We
should not be writing code based on concrete values in this case. I
wish we could tell the compiler to ignore this kind of cases, where we
want to test a range of values, and do not care about concrete numeric
bounds of said range.

> 
> drivers/input/misc/drv260x.c:478:20: warning:
> comparison of unsigned expression < 0 is always false [-Wtype-limits]
>   if (haptics->mode < DRV260X_LRA_MODE ||
> drivers/input/misc/drv260x.c:490:23: warning:
> comparison of unsigned expression < 0 is always false [-Wtype-limits]
>   if (haptics->library < DRV260X_LIB_EMPTY ||

Are we planning on enabling this warning in kernel by default?

Thanks.

-- 
Dmitry
