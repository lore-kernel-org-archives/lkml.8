Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5CBC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 512C220735
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q44kjiia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgEKNJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgEKNJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:09:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F44C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:09:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j5so10896484wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dvv6tJzVeSp90KNaJF9Iza45Xb9aV8/SHy0QZUnd5+U=;
        b=q44kjiiaaYaBbDkBcrfJCt7AWGhDC8EznfPHDU4j48RSdJmdY9PpTBBunwUCdjbUOR
         AzVWkWagGb/SMOCOMruhWmrtrfWmHVo9/iMRA/VkX/c1SJhRIm1EbY1g0sCxps4ybA3x
         NUselnnn4UfbaxQdcCcoq1bofN9xIOb0tcW3kBLrKAxmwa/geFItZ0kAfd8LVaEsIhgj
         Cvxy9v2Gz9loj8C6GUlIWCe7SrbCkskcqFR9JtBntGjKu/N8LAhvLZBm4vhP1/D7njQg
         mVpISTXAMNnC+DmGBotieInbAh/at6M5GpBVcVloauw1vp9BRc8m5V9P2z26G4IQcX+w
         Kniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dvv6tJzVeSp90KNaJF9Iza45Xb9aV8/SHy0QZUnd5+U=;
        b=ha3ERoZynce40lVIRR0Ucgt9JPO9xGzxeSlAqDU8l3pNnFA/7/0y6WiIGmoK8IVCXv
         r3BJLXZ/JhNkzeZqQf/A7Au2A6jllrTc+8gSFlVmV/ni0L/skOska0QE58KUBMNi9bMQ
         QTqhR3f4ep2cclQYi60jjXLS7GYMaNsOsczVNTzeOCaeBxY65dNGPWWMZVWkmmVcibhi
         QDJz6CS32pa3vNca7eysSTLCv1+eSIoOGYXnZhjOQlStGwyF0fvLYsAC7Q3ZNAUOAO+f
         ccQ1Jmv8gC/TQ4+jWr3wZlYvGznTdVjhGst0kUgyq0KdyCEqMbDgo5O5u5EsxCjHJ+JA
         cKIA==
X-Gm-Message-State: AGi0PubCGjofmeydYuyst5ZQswi3UcY0kkvqdaty+FiWaqwnHLrJbO5M
        sktPERJSNxc73LM5IEfIyYDPXm1n5Ubmew==
X-Google-Smtp-Source: APiQypJZ02WbEw5weH5Ix8Han9Dgv/v1PknkgFFgnmn2QEm8/t3C94crXZ+rubgdhhXDGPF2IADvdA==
X-Received: by 2002:a5d:66c9:: with SMTP id k9mr16929992wrw.307.1589202541411;
        Mon, 11 May 2020 06:09:01 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f123sm13589695wmf.44.2020.05.11.06.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:09:00 -0700 (PDT)
Date:   Mon, 11 May 2020 14:08:59 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     jason.wessel@windriver.com, dianders@chromium.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdb: Return true in kgdb_nmi_poll_knock()
Message-ID: <20200511130859.hfbxuc2y54ih4kjf@holly.lan>
References: <20200507110649.37426-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507110649.37426-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:06:49PM +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> include/linux/kgdb.h:301:54-55: WARNING: return of 0/1 in function
> 'kgdb_nmi_poll_knock' with return type bool
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied, thanks.


> ---
>  include/linux/kgdb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index b072aeb1fd78..042828aeb73d 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -298,7 +298,7 @@ extern bool kgdb_nmi_poll_knock(void);
>  #else
>  static inline int kgdb_register_nmi_console(void) { return 0; }
>  static inline int kgdb_unregister_nmi_console(void) { return 0; }
> -static inline bool kgdb_nmi_poll_knock(void) { return 1; }
> +static inline bool kgdb_nmi_poll_knock(void) { return true; }
>  #endif
>  
>  extern int kgdb_register_io_module(struct kgdb_io *local_kgdb_io_ops);
> -- 
> 2.21.1
> 
