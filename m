Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F72C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3DA20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbWp2jXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbgGVJBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:01:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40054 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728100AbgGVJBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595408499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MODKfj6PEnGdaynq2BuHvt1PqpJxgvTxzRg0/ny+Tz4=;
        b=DbWp2jXcZgo+H89WwX+dcSUD7E8fPmvI8JaYJ5Q7wPkfpfYuOGlOC5yXUfUCs3HjZZqWee
        7YlGaUzOT8FCsdMftcCHO+27YMBuhf1yrVclgXQUgcB3otYnuFp5V7eNt5Az2vUqLxz3eQ
        LFmOW5TOBDO1YtELgPOYvxHZHKJz9+0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-z3pTMdV8Mhit8do0HU6sDQ-1; Wed, 22 Jul 2020 05:01:37 -0400
X-MC-Unique: z3pTMdV8Mhit8do0HU6sDQ-1
Received: by mail-wm1-f71.google.com with SMTP id l5so852033wml.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MODKfj6PEnGdaynq2BuHvt1PqpJxgvTxzRg0/ny+Tz4=;
        b=pCidq6LYd+LhidWfj9W5tQZKfpkd6lv+lTP0XjxxIlrv/qZmBwHqHOlPZmxL/HoyxW
         hsb+irFCnBv1VKMDnytkjtTGCfMxk6jMNqjlcngm/RLLufG+8b1NkTr4bJr7sbHAcTSz
         Ch+EENxi+qVtzDVlTQWphwNGUd40Y2FB+8DXvF/YR2KkvlNgm0MWEyU8W8e1DbrCZrfl
         kAJIPwO9DsAEyOMPn5KaCVXBBqovoLiTU0nxtISwfUG4f52Po07W5k1vbzK01JyhR8el
         7d6hZySRwwHx9yWm1bRVSqI+cz6nO30Ba1y2WWRXRl+CtLq5GWuRjY6ZrbhJqi6wM7fR
         t48A==
X-Gm-Message-State: AOAM531VHzUaO+xBQo/56XEYfTLbrbtolOghpenyRXjvcq/M12PDWzsH
        ohaLcTSDVhOcdfOR9cY65H2GJ3Erbyod9CJcWEr8dfgX9ITQnkqn4OQcGWP512Ci1IRPrbDsSyp
        FmAUmeuL0kRKF+Qwx9e5n3Arn
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr32620168wrq.56.1595408495913;
        Wed, 22 Jul 2020 02:01:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIN3tzPA5jdW0eMoFjUkNdVR9b4YY5dHx3s7a3dm4qYN4GPi73083gER3O1dnqvdtozPBvjQ==
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr32620152wrq.56.1595408495715;
        Wed, 22 Jul 2020 02:01:35 -0700 (PDT)
Received: from localhost.localdomain ([151.29.94.4])
        by smtp.gmail.com with ESMTPSA id v12sm29607001wrs.2.2020.07.22.02.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 02:01:34 -0700 (PDT)
Date:   Wed, 22 Jul 2020 11:01:32 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
Message-ID: <20200722090132.GB14912@localhost.localdomain>
References: <20200410114720.24838-1-zhe.he@windriver.com>
 <20200703081209.GN9670@localhost.localdomain>
 <cbecaad6-48fc-3c52-d764-747ea91dc3fa@windriver.com>
 <20200706064557.GA26135@localhost.localdomain>
 <20200713132211.GB5564@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713132211.GB5564@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/20 15:22, Juri Lelli wrote:

[...]

> Gentle ping about this issue (mainly addressing relevant maintainers and
> potential reviewers). It's easily reproducible with PREEMPT_RT.

Ping. Any comment at all? :-)

Thanks,

Juri

