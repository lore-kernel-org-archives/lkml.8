Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3683FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB4A206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5aLZDzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHKVqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKVqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:46:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07133C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:46:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t6so107408pjr.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ekEmY1/ax+L0gbL+grpGSGz9Q9IPbEokzoRjtsOxC1U=;
        b=i5aLZDzI1JL4lb6HPqx8WlSa8C3dyiMON9IxEKkfdzKyX6Os6yQyAUR23IJqWf4Vdb
         4IcWkrGq99RdvEDChPbSJk+gs09bd8XXuG37lllChucpF03voHQJZRWrbNL8IMQpZsr9
         Z7rWA8UDIjlKl6dvW7XvCzj865A6Ut2BeBHJWdOMemcfprHDi2bhgW85TY9qeD54/+xh
         AG4WqTPxUzZAe1txrRklwcZAEng16ZCQZAtWy73VSaXLUsZxbt1qih1cUVjp+QzkYl8Y
         fNVP1i1vug7EGn5lg7HZ3HNZP4CiQ+tnHxYrRY2jawn8bdASYGbfy6rEmDqt0i10Xn/K
         W/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ekEmY1/ax+L0gbL+grpGSGz9Q9IPbEokzoRjtsOxC1U=;
        b=NcSRZLzo9VPO/adxdgR1rL8ukd2fb0K7/aWETV7kY3JTug4WGZfphWMnZmwMiOXMd4
         MtXAmzl7MGaIwVR+9p9sAV9yXucBMMImKrHcDSWqNtKOpxsLdEadgPs3rh8aSib9CGo2
         AgjnXCQnHD3A/VssnWs20m+XuYItdbrG4fqENFfQnVJ7m2+rCt7JvNH9IAo7pepQnjrd
         2MpD3m8AIm7/76JOzZ7ERJuRQbUYUlv+P6+4aPgrzoUa3s/ny6GsS0WcgYHoxsosaaLr
         Fip/JvW+ozFdJMNWED2zk81E+wkeboPerTFqhKGJiX3klFf+QjhJUGIX6C0GwBcK99vD
         /uPQ==
X-Gm-Message-State: AOAM530RxTCNyUc5WfXHy1bg3W5e/4x6K1SQ6NPvHDHum4995CT/gOe+
        WnlA/0rMjiNCTWbnmcKlpv2qxg==
X-Google-Smtp-Source: ABdhPJzOj+r0U6pHD/1nLCE5XH2G6juiTmwPB2fXh5kdWIxO6qV+5d6jN3/qvFyqNknLxLde9i7WAQ==
X-Received: by 2002:a17:902:c40f:: with SMTP id k15mr2700290plk.330.1597182370358;
        Tue, 11 Aug 2020 14:46:10 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id q83sm51671pfc.31.2020.08.11.14.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:46:09 -0700 (PDT)
Date:   Tue, 11 Aug 2020 14:46:09 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Baoquan He <bhe@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, sonnyrao@chromium.org, yuzhao@google.com
Subject: Re: [PATCH] Revert "mm/vmstat.c: do not show lowmem reserve protection
 information of empty zone"
In-Reply-To: <20200811075412.12872-1-bhe@redhat.com>
Message-ID: <alpine.DEB.2.23.453.2008111442301.3428139@chino.kir.corp.google.com>
References: <20200811075412.12872-1-bhe@redhat.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020, Baoquan He wrote:

> This reverts commit 26e7deadaae1755faf1f6d1a68988c4b8348df59.
> 
> Sonny reported that one of their tests started failing on the latest
> kernel on their Chrome OS platform. The root cause is that the above
> commit removed the protection line of empty zone, while the parser used
> in the test relies on the protection line to mark the end of each zone.
> 
> Let's revert it to avoid breaking userspace testing or applications.
> 

Acked-by: David Rientjes <rientjes@google.com>

No objection since I noted userspace parsing as a potential risk in 
https://marc.info/?l=linux-mm&m=158507790824995 but I didn't catch this 
earlier patch which could have led to the same thing.
