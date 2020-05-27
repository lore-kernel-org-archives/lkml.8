Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD1FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895272078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590587539;
	bh=P1fXzehRUxYttHKGmyhAdhyhRlmS5Hp/HQQW6zPByp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cc4JCcpMVxsH441KNbpiTQJJmnalr58XcxKUYdBNZSP8wC4uKpNnd5TdivNglpvYV
	 W0YgeRL7RHBZNsvNT3M0rKXSQR6WRmJHIeZQL2UiKPq1FurPsJrYVT34CkRGvf7sIe
	 mQ4dipNV+VLYK/zPfm5EtYEWOqjNEqc8wOp519eM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388916AbgE0NwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388899AbgE0NwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:52:18 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44241C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:52:18 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dh1so11123694qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yCfXCQLnkmmliUl6o46VN/g4F3+m5D5qyYWprcFsdzw=;
        b=ILvc1MCIouRXqf4iMkoTsgwlu7e2DkUvMWMjEiGuqm1VIwOM0WBU6DMMVW9Od645rK
         /pZeylfCuKv6HIpwvfz8wkiIxqofuIV4vkyNmTXa4TuVCj0mUjuytwisQHxAYT9VTyZ2
         FejPrUZdNHX1fz1DbokFY43xQ358a9FOE6/UFU7QeajQcP5c4NK4S7lfpGBgV+tnvMwI
         37Bv7D7l1v1XM8RSMRKx4bJUYmrcbS2LsVeQ9wkbeMGQehTPMpG6olFCP6kjJeWUedgg
         umqBLiHNNsQejZmSjAR96NKgjbDKZSKTkEcbfWpQEogzYiYgG1eCIVa22CY7nyEEeD/l
         KfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yCfXCQLnkmmliUl6o46VN/g4F3+m5D5qyYWprcFsdzw=;
        b=lNNduU6fGEwqFOj6sYZa/DE0SoWKEnPsrn0zA3fWJL3XEjl2IS5aCJaMo7hRSd5jKs
         ngefj3uLOhuEJc3zX+/eIZvU2W9AmGVI04I8oaz5WlZYBCNSVjXQpty5MNNLG/dWCsqG
         0b8rFv1pP3ecTfPn0yMkz7hfPa4IpXuwKIvTJS5dFif/vFE1W7rmifUk9OkXYgy0Mrjf
         HkvY5+XqZY+GDTOAx3ExXt6j8QeO9HY1pkQ6JmOYvkJsffwLwvdMXxadb91sd+AlpFNJ
         7PVbSMFfyIPxooaa8FzvCiJbyRLqyJr49OEGOzy2dBSO5Y7Wj2wQsXkBzEaHkBR6Okc/
         5jSw==
X-Gm-Message-State: AOAM533iKqU3xknHDM0PE+8AC7RL3IPbEmc1CkYwtCsykXfk2AwnCngU
        hAJZW1DD12GO1l6r1OhFmCZqKVfO
X-Google-Smtp-Source: ABdhPJzr/BZ/dF51pigBmbkNJyTIcg4vbPHWZn0hbMeMyd7Ix1aB8FmUHZYfNi6GTwNirRW3pqagGg==
X-Received: by 2002:a0c:fe03:: with SMTP id x3mr24456859qvr.18.1590587537097;
        Wed, 27 May 2020 06:52:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:74a])
        by smtp.gmail.com with ESMTPSA id 5sm2337501qko.14.2020.05.27.06.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 06:52:16 -0700 (PDT)
Date:   Wed, 27 May 2020 09:52:14 -0400
From:   Tejun Heo <tj@kernel.org>
To:     qiang.zhang@windriver.com
Cc:     jiangshanlai@gmail.com, markus.elfring@web.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] workqueue: Remove unnecessary kfree() call in
 rcu_free_wq()
Message-ID: <20200527135214.GI83516@mtj.thefacebook.com>
References: <20200527075715.36849-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527075715.36849-1-qiang.zhang@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 03:57:15PM +0800, qiang.zhang@windriver.com wrote:
> From: Zhang Qiang <qiang.zhang@windriver.com>
> 
> The data structure member "wq->rescuer" was reset to a null pointer
> in one if branch. It was passed to a call of the function "kfree"
> in the callback function "rcu_free_wq" (which was eventually executed).
> The function "kfree" does not perform more meaningful data processing
> for a passed null pointer (besides immediately returning from such a call).
> Thus delete this function call which became unnecessary with the referenced
> software update.
> 
> Fixes: def98c84b6cd ("workqueue: Fix spurious sanity check failures in destroy_workqueue()")
> 
> Suggested-by: Markus Elfring <Markus.Elfring@web.de> 
> Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>

Applied to wq/for-5.8.

Thanks.

-- 
tejun
