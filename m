Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5AFC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706832467F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBkuE/Mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgB0ISU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:18:20 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35622 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgB0IST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:18:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so833397plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 00:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EQ1OArC9+PGVIVOYRg8p8lLBdRwgZHTkLw1vIlbJ3/c=;
        b=EBkuE/MzV9jeWo3BcnvBklKy1SVFhdjVFLZ9nC8MjOX+0BfPYIttRW3e48QX4KseFF
         UYQqlRf86Wx2na4TwM2913bSy79PlmAU5xAvvjqLFz3KWFbZGU6bxZVbrLDe8j663TgI
         WruaIVEupFRLM7DJFcQ/75kLKKyMpbPEYVYljFyOxQyPSdDNeKahXsZAbdN7DWxsb8JH
         ZyR17k7AiV2brDSl50Zug3jF3rrFxAqTl3iRu3+KPUrrhSEnb2IBcwRGg0RLVVob/373
         d/H/9jFuVUL4z+bj3nsTQr/izWdAmN1ACFZ+t/BLO4JwnOA0PsLiNpCShGCyaUpE69zL
         T7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EQ1OArC9+PGVIVOYRg8p8lLBdRwgZHTkLw1vIlbJ3/c=;
        b=U5r2+FOC2rCFQ8X83e0Z344BWxkRl9QnD1wWmfN4BcJDPDtbrHtxz8tRJtdJJsH+iM
         1cCLCEIbBgR2so/AhhIU920IChL1HFZcD/e7lRB3oGUOFw+lN3W/vudjjsBDI1RHvZoR
         lO1tooifKKkq6CmjIGalnOPe7RHEMKexEC2CXoTJ2S2+etuowRXy5XX+wWX1kGVgetSV
         Q0dhAtBVZI6O34GsRMa5WeNP5sbw4WbGwroFjBHAZ5iQb9mErNcJBjajKkquLMHNT7P0
         sMxWPRQes3FtKBQb8M/BfvI2l2JOgfMn5w6kcFBszlVYT4E+k874wMQ9tHxuLY54E9gi
         4Z4Q==
X-Gm-Message-State: APjAAAXjjwIT3DHwR4ZOQPglmUSfcD3SIJwMAkd5+dXnCn8f86W0L2Qp
        yQA5Cww9Uln1ylo4Ylr5rxsAw2ay
X-Google-Smtp-Source: APXvYqw+tW9ZM0fvPS6MtEVuy53rlIDMRPTv9RKgxrkcFfTDBsUT4Z+HAXHs3lZIqca8FWuV2KF3sg==
X-Received: by 2002:a17:902:6b07:: with SMTP id o7mr3359727plk.141.1582791497517;
        Thu, 27 Feb 2020 00:18:17 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id q25sm5945945pfg.41.2020.02.27.00.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 00:18:16 -0800 (PST)
Date:   Thu, 27 Feb 2020 17:18:14 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] drivers/block/zram/zram_drv.c: avoid needless checks in
 backing_dev_store() failure path
Message-ID: <20200227081814.GI122464@google.com>
References: <20200227081219.13144-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227081219.13144-1-zbestahu@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/27 16:12), Yue Hu wrote:
> 
> There are null pointer checks in out block if backing_dev_store() fails.
> That is needless, we can avoid them by setting different jumping label.
> 

Dunno. Numerous error-out labels to jump to (instead of a single one)
don't really look like an improvement to me.

	-ss
