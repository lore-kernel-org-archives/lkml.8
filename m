Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAF9C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED53120722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589207066;
	bh=eUY+V9avHkw35scki8sAx9ovC9hnXTHSF0meB9Ak5is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NNW7rVXvXJIHyjxM1gM7fsDeozEFf8bsIjono8TTODFDJk/b2+/T6F6GrMBgoTYOe
	 Epve/M3fUfKy2ZRvw2UkcgYaXhZHjX0zwtttLhF9/UWMX0byCKuKwPLP+UmLsR9Vff
	 UGViqgvFYuIUR+FAfPDma6gKzbJFOQNccWGj9axk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgEKOYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728090AbgEKOYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:24:24 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A035C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:24:24 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f13so9271053qkh.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=twjRjT2Wvsa2Tj+eD74MQswCgBJyV7ZtvVkgi+TE9UQ=;
        b=fpGx6N7DNhBxVLwQyeexrEdltZQN2DZv7wmEZzAqZUZRDiMPEF0mBtb8C5H8zuTvAF
         mAYVknYYg/i7DAe675ObdafxuTG4o0i62Tj571zqSqlpBHaSqpNhBTxJW7dPrNULDNx/
         aUMbGmSbUeH/J0OGoqOEIrJ7/bjjsIigzIZgXEX9IAFOCI5cznCfAMEElagLJ9+4Aeq6
         0oTKJy4Yrq9hDtiRftAfnnkNZojLl7t1c3XJMQLou4luSavi/oqxWFDbAI2+CeD85GuA
         2tHduSbB0tqE+QaXgUtuESM3ZfpGMwMkWq+S14ggQhaqWQ5f3N+Rh0hM+GzSGQcwsxtJ
         hAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=twjRjT2Wvsa2Tj+eD74MQswCgBJyV7ZtvVkgi+TE9UQ=;
        b=CV7b0CBUALgSNOYP7Lp/Rh8AMsF0yMOmQNL/qk/bD0wKIjqqRT3lNIWayClPuJcHk+
         QcaSfG61vd6bJTK1MTUjXgHcg0LkXLChuHT8fiSHcuRpdu+pzRxN9Ks+ksSYjeUlixtH
         Pkz9+Eyvksc+IXmNt9Q4gcXo5cjkjwajQ9DvPJVXB0xQN0MH3nCRepQPdSK+HOxHUF03
         I04GicEmof/gbUcZWGRhLc7FsPzrrwDaU95tCPd/KKOKgXLmhGJtxAfCCRqhp1dnGfYs
         XXDhhOO987inPdHayNjaMkNrAdLxHRfcVXnCP7uTlF2urTE7bUJGdWExGhXE3ApDhUXP
         9bYQ==
X-Gm-Message-State: AGi0PuZTXh2FvIPdATSz8u9rK8Y3KM2TtbY4SlqJj6tUpG6luWgwHNmf
        PX2iK0iyNV00kFINbp1mydc=
X-Google-Smtp-Source: APiQypI0WWPgA6ZJzn5oadeRVnpu4qnGgdwyRN5ER+xZcazf4xXRXFT+S6lwV3DabqutxGbMJDmPlw==
X-Received: by 2002:a37:65cd:: with SMTP id z196mr8886195qkb.473.1589207063461;
        Mon, 11 May 2020 07:24:23 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id a190sm4025692qkc.118.2020.05.11.07.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 07:24:22 -0700 (PDT)
Date:   Mon, 11 May 2020 10:24:18 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, wangle6@huawei.com
Subject: Re: [PATCH] trace: Remove duplicate semicolons at the end of line
Message-ID: <20200511142418.GB16815@mtj.duckdns.org>
References: <1589196062-84310-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589196062-84310-1-git-send-email-nixiaoming@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 07:21:02PM +0800, Xiaoming Ni wrote:
> Remove duplicate semicolons at the end of line in
> include/trace/events/iocost.h
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

iocost changes normally goes through the block tree. Can you please resend
with Jens Axboe <axboe@kernel.dk> and linux-block@vger.kernel.org added to
the cc list?

Thanks.

-- 
tejun
