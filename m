Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9154DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB712078D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="If10uPjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgF3CG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgF3CG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:06:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC70C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:06:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b184so2306554pfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 19:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tKQUz3ss+SkTXPIo7jFWCtq27AsIgeg6pLQv0LW7H5k=;
        b=If10uPjK3MMTzI9xXwJGQ1cOGcfuYSR1WRyeBbR/PUH6HL167ChvfNuykRXPnAT0cq
         KZecDQ1zb2SO+BQwnIZgpK+3kmSVcMkSmTOaZgG0YVSu79JyyH9jSv+r5sG00UsqQhsA
         fSQY7wQNnXymqWXBV+/3TMQ/L/NpZDENPkhBKjsbPvd/3SvfjQA/6y/yf5Wi/uZZWnYR
         mctfTPL0BIozB/gQkBh3pjpFkrHO/lwm4+OdzAKBlnhHurdAMnk0gBPbClEp3ijxw8kM
         FFQMusVF1UPrVKLkzodKeSE7dYo8v/ZnmiB1XQryYgNgD5CeSwikDDfnJ2ju495mKxzw
         COxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tKQUz3ss+SkTXPIo7jFWCtq27AsIgeg6pLQv0LW7H5k=;
        b=c1me/Nfa8jhlEoYOqFvcz6GYM3FtwrWsLsfq8G14O8nX+/Sl79ymCqg4NS80r0M12B
         DTvKaU+kwiYaZsbh1r1xpUSjW87l+gK1b2AZLITicPJ2td63EsZ4q1+NNO4LzOQNpLNA
         VttPZkLZLcxfAyAFIgHRQXDX+boBmC0uCvOMVF+7RMgR+ArZcMnosKhO+fJFUSIVYvzA
         Jb7Ka1+dN7d8F5XdblH8+RVbhMNzZoIyTHJgzUzhOvKZU+dHAFZ5RcrziX69OSbgWS+K
         3dVpJbCbRFx3z4V9N+J8DsXJOlup87dGn9h2OCXa4k0NZXgiG0f2A6hGS8tM5VuixEdK
         UAHg==
X-Gm-Message-State: AOAM533nxAiiSrVU4ba16H616dsRqMtABg6dcZ0SQMYMcpHIRtXe3ySn
        6CB8RlKa6bXuSKpAY9lT+/LORw==
X-Google-Smtp-Source: ABdhPJxMPe/26T/Qx87OxAuBF9dw0hq9HKbcu78S+099W6oaXpno8coYO1yGzLPj8dY4SSuKUW7iUw==
X-Received: by 2002:a65:5a4d:: with SMTP id z13mr10194621pgs.336.1593482816918;
        Mon, 29 Jun 2020 19:06:56 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a8sm818795pfi.29.2020.06.29.19.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 19:06:56 -0700 (PDT)
Date:   Mon, 29 Jun 2020 19:06:55 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     =?UTF-8?B?6IuP6L6J?= <sh_def@163.com>
cc:     Mike Rapoport <rppt@kernel.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re:Re: [PATCH] mm: remove the redundancy code
In-Reply-To: <3f4b9136.1440.17302f60674.Coremail.sh_def@163.com>
Message-ID: <alpine.DEB.2.22.394.2006291905000.1118534@chino.kir.corp.google.com>
References: <20200629173047.GA38128@ubuntu> <alpine.DEB.2.22.394.2006291149040.1030250@chino.kir.corp.google.com> <20200629202429.GG1492837@kernel.org> <3f4b9136.1440.17302f60674.Coremail.sh_def@163.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1482994552-1160537174-1593482816=:1118534"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1482994552-1160537174-1593482816=:1118534
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 8BIT

On Tue, 30 Jun 2020, ку╩т wrote:

> I am sorry that i did not consider the memory hotplug case,
> and i think we should add a new param to distinguish two different cases.
> 

No need, we can simply continue setting zone->zone_start_pfn unless there 
is a bug to be fixed (and, if so, please send a bug report).  Removing it 
would not improve anything and would only increase risk.
--1482994552-1160537174-1593482816=:1118534--
