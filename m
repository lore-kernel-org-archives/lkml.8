Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC56C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D23206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XalrYwcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgDGMqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:46:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46930 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgDGMqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:46:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id y44so168419wrd.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OMD/WRLziMR1WJFfbGKAOgrQLGevycyvXPwsGYuon6s=;
        b=XalrYwcpREMqevJD3++KPaj/cOH6EaWnDWpbojJbiLmHdPJa1wAgx2mSGMrJo5OoRN
         tTId5C00RgiBxpB/fF7i0bApOZZJ+qrkw1uNnADsZTZUnUsC0MdrFlMSFmrCTxm7l17c
         XooeX36oc9liHERTLw4jNTWea5y+Dd+SKDj1Fioc6VSjq7UFklWGrZ+fhYIeUrJ+EA7f
         7+MRWQ1oYQNpeqESUwA5EqQOvCghV07JaxhWyIW3iVxCL9mY52UxttXQmEwVa12R6se3
         qgvce5TEybNAuIb3VvFMYquY2LcwtWOtDVx1VfO0BXxXv0TCLGWHXMw/1rjIA2sAPFXq
         IhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OMD/WRLziMR1WJFfbGKAOgrQLGevycyvXPwsGYuon6s=;
        b=UoHGzZbY0z6kN+UI468KPCGruzfuGi3DgJw9QEIdI7GhgSMsQnitKvtGaFqCtEIOft
         EDtrHBNy77kwqQa4gXwK3epimp+1M8vjVaiGXMRvLP0Ak8aCADxP9yiDt7Ne5gVw2SyE
         7Z4eRQ9Mo5zawE+5yGcfBwZmXxAfs7R0FJij7VAAPUPl2Dv5lt/h+pHgbzolgh/d4KpG
         NAD198ZCT4fcgcOq5Rx4bLniYnaCATUvNxN5JWFvzx5U7quyG3cm+fGQIqfDj3GmAHRI
         dfs4wb2yn/weKU+nCAEuMc+LLrVTFVXZzyzeyZcthE+Zdp45pgL47BYVvmjx/rfv945W
         c8AA==
X-Gm-Message-State: AGi0PuYcFIi8sj49MddehkRhxzn5qQU8N1Qu17glQ1fohUjpoAv6mqnW
        EQ1Jgl0UxmA8I52dULep7qg=
X-Google-Smtp-Source: APiQypJ3/hkv2myDbosrGmRH2cj0AuLfcE2W1hYk2nUWq6FkQdKq4gVoLLNWPn0JWiFPi9kpg17jWA==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr2635421wrc.412.1586263560349;
        Tue, 07 Apr 2020 05:46:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v9sm20642133wrv.18.2020.04.07.05.45.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Apr 2020 05:45:59 -0700 (PDT)
Date:   Tue, 7 Apr 2020 12:45:58 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com, rientjes@google.com, david@redhat.com
Subject: Re: [Patch v5 0/4] cleanup on do_pages_move()
Message-ID: <20200407124558.obtv2le5rr4zc5ej@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200214003017.25558-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214003017.25558-1-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 08:30:13AM +0800, Wei Yang wrote:
>The logic in do_pages_move() is a little mess for audience to read and has
>some potential error on handling the return value. Especially there are
>three calls on do_move_pages_to_node() and store_status() with almost the
>same form.

Sounds this patch set is not picked up yet.

Any thing else I need to do?

-- 
Wei Yang
Help you, Help me
