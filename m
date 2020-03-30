Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F79C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8B720716
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1+bh/LW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgC3Nmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:42:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36968 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgC3Nmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:42:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id j19so3155678wmi.2;
        Mon, 30 Mar 2020 06:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+4dtqpZ9E/y+Y2Xp7JjUzAS5gfte9TfEmTWLiGOPgKw=;
        b=E1+bh/LWhrzjVhduFXMI2gFY9kcTEVMbO91wXz4zHbXOHLoagnHrn4VIRUbfTf5LAY
         y5Ptr96MjvyaYpyw/++AwonBrKS5/uy53eg0RcuWiHaY9+Gsf/8uueM39YlOGcMDdNcg
         N4rtWeuMhYDgoNfp2+HtHoyf+891JZZO+ovabQVhoF1IkTyYAz5tjK8V9CokFu9IFoEG
         juwhY6pIt5fclKGaLlF9mZz+FJDIJo6PPF7F6dtuFq07PbsPcTleAl9MX/QuGh9nuHi4
         3nRDOgvm6wN6BlED/wKS0l7I50QFIEx4P0PTDg/oVThEwBPxlqU2UorjtyCvW95Twg9U
         vt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+4dtqpZ9E/y+Y2Xp7JjUzAS5gfte9TfEmTWLiGOPgKw=;
        b=ukbG+q0qxatRIBHoexKeD1dDELaJFNHlr15HYj4KndZaHRqRs42e75jBR6Zuwbkywb
         BMsyhtBVkp5yHdWMmyIF5ir/4+jES+lrKdTz0Kp1gp9EXePShLKJPYSwmSnQsrW9gzJr
         /IbJvQbCM7yBuverxxGQpMTbaIfhUzeK4XU4ELnYHI29hHzbEwSwv/OSttLOsisD9sYq
         Wq8LqfgypBiQembm/6fkwt6iY8NtjPRrAfnrWG9iz6gzlX0Dqi379rAUFbeYnqGlb9Eq
         u2tc6RE2sBwSHRXfI+M5Y6LPTr7oMubDv7v9klrJ+Ss9awMmSrqFQWZlOQXA6MobJR/K
         Dk2w==
X-Gm-Message-State: ANhLgQ2GCXKto+FTZ1HQpimqBI0Ad3UWe7S1PzRcB990c8c5RvvwFP6n
        2JBNsK56xdof3CVglDn1ibM=
X-Google-Smtp-Source: ADFU+vtPO9ITAfnWp23rut5FwstAuP7n2/LQ+EyO1woR1b4thPW8IRUNOiIPVaMsuSz41RpqQbv2DA==
X-Received: by 2002:a1c:4e0d:: with SMTP id g13mr7695203wmh.156.1585575764591;
        Mon, 30 Mar 2020 06:42:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a186sm20920344wmh.33.2020.03.30.06.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 06:42:43 -0700 (PDT)
Date:   Mon, 30 Mar 2020 13:42:42 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] XArray: fix comment on Zero/Retry entry
Message-ID: <20200330134242.prxgqezb2gsadinp@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-2-richard.weiyang@gmail.com>
 <20200330124613.GX22483@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330124613.GX22483@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 05:46:13AM -0700, Matthew Wilcox wrote:
>On Mon, Mar 30, 2020 at 12:36:35PM +0000, Wei Yang wrote:
>> Correct the comment according to definition.
>
>You should work off linux-next; it's already fixed in commit
>24a448b165253b6f2ab1e0bcdba9a733007681d6

Oh, thanks

-- 
Wei Yang
Help you, Help me
