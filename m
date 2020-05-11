Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3909C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D6B2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QuMzdF6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgEKWjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 18:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgEKWjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 18:39:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79586C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 15:39:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u35so2228226pgk.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 15:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iAjP/dx+TOMD3h2UkM1NHk9+DSE/HLxGXOk37w+Uu04=;
        b=QuMzdF6PS8DlHrgHS13L45Y9TnYal1cjdG9qFL4fSAMYsADcAWEElruJKaZMbOYFY8
         LLYN/42JZ4pb/bgLL6M2LY+My3cI4oIAEiUGxljboC2qy+VchFpRvHmr0RbSV8NUHYru
         ZE+amPP6HfKJFhKzEmlKRLFeK6aGAM3UVxyiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iAjP/dx+TOMD3h2UkM1NHk9+DSE/HLxGXOk37w+Uu04=;
        b=fbz1pXrlH7SqLcM76vmCPQXpCmEA4VFNc9M4CoxLnH5onvNGrZeZa3cjjkhzT7xsfV
         ac07ESWizaFqVjPid9iLWzJEM87K6m/inOEEG6ZEJaOTw8MP9kVyLn/ymbaA3NAMsMDC
         Yb0mqqaDRW28Ib/h1ioKKWswC6+GGuJSP4wM1+D9k6VMhrBkmfPtXYZ/6WXHNiCHkNkt
         hkQ+zs6vAbcWAKQXWLifiq09GeP92dPVafX61pFLsjesRP0iWI6b5iMrtw2IPQxwtM8A
         js5z+YqKj/hnMEVV9qzkj4aA9mvs5haW2bOI1E6S05MSQ/AwV7Mnxux4VNRor0omRgRq
         Jznw==
X-Gm-Message-State: AGi0PuYp8D4PqYcGxVg4qJpIgNkDWAvXYr05pcNcb2VG21UKMNEySxaH
        FnIdvk5dkDofAD78hqKJSY30Yg==
X-Google-Smtp-Source: APiQypJrZN+k1vOsrote6dfc4R1IK2fAk8lFQlDXHNEbyE2cjka13mhe1A3zpKLQZ+uySGgGBTXm7Q==
X-Received: by 2002:a63:7801:: with SMTP id t1mr15712443pgc.192.1589236755921;
        Mon, 11 May 2020 15:39:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y2sm10207468pfq.16.2020.05.11.15.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 15:39:14 -0700 (PDT)
Date:   Mon, 11 May 2020 15:39:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v7 00/18] pstore: mtd: support crash log to block and mtd
 device
Message-ID: <202005111537.E2DA45A259@keescook>
References: <20200510202436.63222-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510202436.63222-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 01:24:18PM -0700, Kees Cook wrote:
>   pstore/ram: Move dump_oops to end of module_param list
>   pstore/platform: Switch pstore_info::name to const
>   pstore/platform: Move module params after declarations
>   pstore/platform: Use backend name for console registration
>   pstore/ram: Refactor ftrace buffer merging
>   pstore/ftrace: Provide ftrace log merging routine
>   printk: Introduce kmsg_dump_reason_str()

For those following along, I've added these to for-next/pstore, as
they're all prep patches for the rest of this series.

-- 
Kees Cook
