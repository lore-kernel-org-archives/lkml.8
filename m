Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19617C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B262075B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y6x+ktQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgCGIJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 03:09:35 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:46683 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgCGIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 03:09:35 -0500
Received: by mail-pl1-f171.google.com with SMTP id w12so1837121pll.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 00:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Il0BuirtXElX3OhJ8KQ+VVPD82PshE9sC+bGdFWDsGU=;
        b=Y6x+ktQYKlOTGiFoCpzmgJHyWqjxMCmMqSAxY4SB8JzMC5JWisoxpp7cHnfLHFX5OT
         qQIk8bBOtAsU0XfsP37BubttZaRh1tZPPYyBEVOCVfznu+iSOQxvl6ksS5n/GJrr4Hr2
         B87D5TVYJ+RAA2v2G8kT63cJd9bRecv1Ue+6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Il0BuirtXElX3OhJ8KQ+VVPD82PshE9sC+bGdFWDsGU=;
        b=EleXO4seymtIeJoJbeDqrIEnW+fry4/I7fNUq7Hd+GB2e0E4jLFYTh83Y9klTAAtw1
         I3/+tQhREou1d1Gerc5YGztcOlSnVa9bQ6WOCqGtPnr1oX2p06F0KSZ5JS2gucytn/3M
         bRVcyyFRaV07NZ3Gq9dbOnTGrbC/wWJ0SiUikpYw1QH+Tuq0QjQ5viafLPXrBqRylhVm
         lZwNAZ2xn+abHqzbib3j8iN7bB5+0XXienXAE1VGsmoJDHtmwjAmL9qUr5FwHKF3Jl0L
         UBD7RlexDO13Q9b+Q563cz8fb96bDodBfJBJGx74zz175Zf9PkXq4mn1vq53SnBskDas
         EN6w==
X-Gm-Message-State: ANhLgQ10wQMjP2hvAFu3BfrwChTXXCTVml4zAVAeV9r4RQKoj3LFArwL
        z4IxGX8zkAQfUyUlOvPRHwpsXg==
X-Google-Smtp-Source: ADFU+vstyaUZAA30a7Gyv0ev+TGK+vA0QMq+YD9kZGE7d7/4+YCQfrphuGxCCpOOwROkghJ9eGxANg==
X-Received: by 2002:a17:90a:1ae9:: with SMTP id p96mr7809803pjp.123.1583568574186;
        Sat, 07 Mar 2020 00:09:34 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id x9sm7359744pfa.188.2020.03.07.00.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 00:09:33 -0800 (PST)
Date:   Sat, 7 Mar 2020 17:09:32 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 03/11] videobuf2: add V4L2_FLAG_MEMORY_NON_CONSISTENT
 flag
Message-ID: <20200307080932.GF176460@google.com>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
 <20200302041213.27662-4-senozhatsky@chromium.org>
 <40b1cc23-5e28-837b-49d5-e32d9dd3edee@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40b1cc23-5e28-837b-49d5-e32d9dd3edee@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/06 14:58), Hans Verkuil wrote:
> 
> Please fold that in this patch.
> 

Thanks!

	-ss
