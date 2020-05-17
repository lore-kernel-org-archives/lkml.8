Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BB5C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 02:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C91206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 02:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OXjpn524"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgEQCnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 22:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgEQCnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 22:43:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7204BC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 19:43:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t11so2992205pgg.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 19:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PQbWte+9OK/nLNDqarqOgSaVb57KOMwmsLKM5RcSivI=;
        b=OXjpn524jciuJ+MwLJD3qHyQSe9O545X8knfqGRrCTEgEAjzU4X6X0hTZVT3BfEM39
         05iAL3cXXMJGy3YcDCA2cR3ijkbTE2liaGnyLYKEByCq/LgHYhWN7sn5LvBTeM5QqSgI
         Z0ytD2W2896oRxw+DUyIf2wnt5lmGCIvqyOiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PQbWte+9OK/nLNDqarqOgSaVb57KOMwmsLKM5RcSivI=;
        b=C9Bpj7A5/WKpepkPCVg35uVmvFO+n5syhadmciJBS0OYWYaLg2PlxNspdapoEINTT3
         yMeuIFRxWf8p3Y9uxBJHK9RKdUsb3JVKVoSt7W6PNlLEejueLHWlMRjpUxFVMx0T3Wg1
         pVJWPRAkXJ8eU5E0w5QUU5rTZJBtLRHLwB2NXQZZRNMVoJM6pYJQT1u+Yo+m2JGXodTB
         Ge5pk7itLYr2mK11ptoH7JrbUgX0RW6oAQcgxFLXOplJq1EDCOKzpJg+jQM4obnUsBVS
         B3IiSMN96b6N4OnJsdb/2yJh/ipKoZrw6aWGrKBYhG1dtAVU1JbzTvNR2MFsI2NoHHOe
         UJug==
X-Gm-Message-State: AOAM533/MnVahU10hYkh1tJVg0nsOe5eNGykg64ALqd28DlfCWkdkBoS
        YOn17zHeKaSSq2gKY32wQdl7JA==
X-Google-Smtp-Source: ABdhPJy1RXvKH0mAU9GGmLdbQPD2jWqMfq66q4h3kKvUeq/f7u9fSAD7Wp2pGagWZRyz92SSaiHZlg==
X-Received: by 2002:aa7:9093:: with SMTP id i19mr10541447pfa.152.1589683398054;
        Sat, 16 May 2020 19:43:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p62sm5223387pfb.93.2020.05.16.19.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:43:16 -0700 (PDT)
Date:   Sat, 16 May 2020 19:43:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        peterz@infradead.org, mingo@kernel.org, patrick.bellasi@arm.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        Jisheng.Zhang@synaptics.com, bigeasy@linutronix.de,
        pmladek@suse.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangle6@huawei.com
Subject: Re: [PATCH v2 3/4] hung_task: Move hung_task sysctl interface to
 hung_task.c
Message-ID: <202005161942.682497BF@keescook>
References: <1589619315-65827-1-git-send-email-nixiaoming@huawei.com>
 <1589619315-65827-4-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589619315-65827-4-git-send-email-nixiaoming@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 04:55:14PM +0800, Xiaoming Ni wrote:
> +/*
> + * This is needed for proc_doulongvec_minmax of sysctl_hung_task_timeout_secs
> + * and hung_task_check_interval_secs
> + */
> +static unsigned long hung_task_timeout_max = (LONG_MAX / HZ);

Please make this const. With that done, yes, looks great!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
