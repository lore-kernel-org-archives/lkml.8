Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4947BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABAF2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WAZ4doPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389640AbgFXHZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgFXHZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:25:12 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D969C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:25:12 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so701964plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZLkF71JTsTxhhhiydtS3Dg3wcvXwv7lzeN1c+2LHTkY=;
        b=WAZ4doPa04qJ8iercAU2kv0gGs9+d0zRO+9jTotCyRd1mUumDg6pjjtJJbAqaOXV1f
         IzGN3l1C41FxYt2/9Q9RwmWb4Bp5WOXeEyyA5OAvCmhz/RdqRrlORZmZMjpbFRdElhH+
         l9bcuI7JNngNM/rwemvFrHhTFWgmEpdXa3QS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZLkF71JTsTxhhhiydtS3Dg3wcvXwv7lzeN1c+2LHTkY=;
        b=UvY8Bfc3ikwvLhJy/SxehOA+1hnO2wt670v1tFnoaF0dA5LxVvnwVBIrKU4RBQBmL5
         kLA35c8U2LI4CWZ7PyhyOHTcJ7GgBsL4VP0Yc3bPY05T479ED1UukNcKTScttBwDqWLH
         RxNHkCDhxgLOI4oWudGZUKN1FlIYZwdSTq5dWTicHLS38ssfVu98o6x6MW0xOtoIc0nA
         LP0KP5fiKX91b9PPCznSs0oZc04rOkqLnne9OUpuXe/HbpUvLv95MrWdT+YkBtzaZqkc
         ZijEfjdHRfPJBVEeJgwzD7PEG3Mrycv2+VwrBN0REigIrwozE3hvGPL0pgAh2p6qvDza
         eW5w==
X-Gm-Message-State: AOAM5332RhOPikJPOyQZooPXn2n3HGw1dYLYzi8yRjojKj+YBouARVRY
        SDdSobiShr29CC0hjXJMbMKsOA==
X-Google-Smtp-Source: ABdhPJyI1eeUVqQVvX6PwmU1zR/wkoa+/6wYGM6Zr5x61cPl17IX/K26RULodS2LBOkVqvoXWv1Thg==
X-Received: by 2002:a17:90a:356a:: with SMTP id q97mr12932118pjb.213.1592983511481;
        Wed, 24 Jun 2020 00:25:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e12sm19999633pfj.137.2020.06.24.00.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 00:25:10 -0700 (PDT)
Date:   Wed, 24 Jun 2020 00:25:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v3 09/10] kallsyms: Hide layout
Message-ID: <202006240022.E5FB4E08F3@keescook>
References: <20200623172327.5701-1-kristen@linux.intel.com>
 <20200623172327.5701-10-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623172327.5701-10-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:23:26AM -0700, Kristen Carlson Accardi wrote:
> +static int kallsyms_open(struct inode *inode, struct file *file)
> +{
> +	int ret;
> +	struct list_head *list;
> +
> +	list = __seq_open_private(file, &kallsyms_sorted_op, sizeof(*list));
> +	if (!list)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(list);
> +
> +	ret = kallsyms_on_each_symbol(get_all_symbol_name, list);
> +	if (ret != 0)
> +		return ret;
> +
> +	list_sort(NULL, list, kallsyms_list_cmp);
> +
> +	return 0;
> +}

Oh, wait, one thing! I think this feedback to v2 got missed:
https://lore.kernel.org/lkml/202005211441.F63205B7@keescook/

This bug still exists, and has the same solution.

-- 
Kees Cook
