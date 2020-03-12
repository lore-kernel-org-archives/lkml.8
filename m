Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095CDC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB27A2072F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584037641;
	bh=LQdfO10Srv2HjxNEEjAd8rd2rM0p91Oi3fz+bEvZqos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FIvAL6qmird+m1iUDTiQsv9j8zvHy7LMeLtQOpWhfJW8SEnouWaMVW6C5sHd4gvJz
	 SNMw2q8a1YcRgNJKMxLYcLa2m+ar5N5jIcrRlIcbhzlDQuesm12O/eTwaLCjaFQSSV
	 iteKMMQVi+8iVgtrSEqVddTt5ezSaLRqb1pq4lZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgCLS1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:27:20 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43721 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgCLS1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:27:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id x1so3065872qkx.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JuxJ7Z8xDChrzzCB7zGTi4ix30Z2gSprxe8mqlOflC4=;
        b=qEixyka206vrRdeAV/u+7hfIPOtZxqQvwSbHupJXY9nmsBSrzOl45ME2lgszt1VrSc
         fFT/JSNGoJB45Qwc5TVok8llXqbHzLRD8gczEsxdEQ9x1pQ9bWTpg5KFdSR8XLjJkDsT
         pZy6ftB92RX8A2DG3h7cKtAaElNxcx0WdZotTjWeitv/rNS9vkj0v6sgJx8GlIkMqVLX
         v94A8xVhZ1RcnCSbZDhT0hIrGKrK4/xSMvajPNmRWjuaf+YKarlrWzhdWptSqcROK47g
         Mon4ELYq+q7X4TmVftIAFL1+1n9sdTXZGIIXunmlVd198rU09cPgFEzYuLE10+eabWw8
         A9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JuxJ7Z8xDChrzzCB7zGTi4ix30Z2gSprxe8mqlOflC4=;
        b=pVnvHqJZfRkA2i3e0kbqOv1AAdm2NGvJKmUV6t3PPlq31wnYD6Yf0s/qPK44mDmfd1
         0kYI4rP37+lgOpPogNEDTg9wOEjJE2ZEbDiy3qJ+OTq3BisdD+vwZtU2nx70gb50hHro
         agMVoywxBa7XuhybH25VqiyB5yVQhhuOx4ZnDF6ZvmpvKoJlb06t2+HmgKCSEbufgwHa
         rG5oKAIt6LkP01etSQ32aj/F+Ks4HKTOJVdFSva7s+q5TYKB0WDT1jjNSUZ21l3k2YLt
         KhNv37v2gsIEqsbmoFEtk7sK7GFFlv2tMw4FIVF8jm+l6chELRuzlshgB8Q2BMJJ3Oop
         eMqQ==
X-Gm-Message-State: ANhLgQ3guZyn1lhTGaueClzgmBz/n4yuvmdGWux9wUpbEsNvm3KjAEao
        neFfDgVktTOeHl9OlDMYSYM9UqoCu1A=
X-Google-Smtp-Source: ADFU+vvrjFjR/+N/Dt77AaCC43mx5oawY6Xl9Tx9TPCavfi7WQa97pDbwsLnjm1F/qG/Yv+YHfkQEQ==
X-Received: by 2002:a05:620a:228f:: with SMTP id o15mr9199167qkh.197.1584037639272;
        Thu, 12 Mar 2020 11:27:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::fec8])
        by smtp.gmail.com with ESMTPSA id x9sm13920350qtk.7.2020.03.12.11.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 11:27:18 -0700 (PDT)
Date:   Thu, 12 Mar 2020 14:27:17 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: Mark up unlocked access to wq->first_flusher
Message-ID: <20200312182717.GF79873@mtj.duckdns.org>
References: <20200310162319.10138-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310162319.10138-1-chris@chris-wilson.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 04:23:19PM +0000, Chris Wilson wrote:
> [ 7329.671518] BUG: KCSAN: data-race in flush_workqueue / flush_workqueue
> [ 7329.671549]
> [ 7329.671572] write to 0xffff8881f65fb250 of 8 bytes by task 37173 on cpu 2:
> [ 7329.671607]  flush_workqueue+0x3bc/0x9b0 (kernel/workqueue.c:2844)
> [ 7329.672527]
> [ 7329.672540] read to 0xffff8881f65fb250 of 8 bytes by task 37175 on cpu 0:
> [ 7329.672571]  flush_workqueue+0x28d/0x9b0 (kernel/workqueue.c:2835)
> 
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>

Applied to wq/for-5.7.

Thanks.

-- 
tejun
