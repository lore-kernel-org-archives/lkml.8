Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61B1C47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93117207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="q6Caj39q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgD3UIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgD3UIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:08:06 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E804C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 13:08:06 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id k81so4430930qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 13:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ok16EsO/ISAsEJIxQSbChy5pO1QqgpEPtp1JMK5qicY=;
        b=q6Caj39qklQ+cMsmLSSD8BCgquSyU51XfuP2wwrqiVW6b36fQcsg0ufYNBYoggqogy
         YwZ+GVhOioys/L4NHy20h7Dr1yqFyImrq0+d5ifynClSfFHra+UosMjEMZ6C1nNcVbEb
         nyAMYCbrZv2nEjrYhZzYCuPmAW2kNMvpQXZp2UmKoJRWRdmWwsCdAplNQS3reKCocxz8
         q8jknBR33fIvnEqQRSOPlTAF7t18vMbHMRsgBfKOcz8AViAsn7YJlVk2EGX3Ouurzezd
         mwr7QLY5OHN1MmTIs4pSRDlozgTyBbt1BL2J4W4Mbo8COXC5TT1R5fjSX3FNsgaSayMz
         w2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Ok16EsO/ISAsEJIxQSbChy5pO1QqgpEPtp1JMK5qicY=;
        b=ihpqiwQXVBb6lXCkSdY9dl8US394485HcsWTLsOjgTLEzMjm3LJSskWBqxDwG+px0F
         oXfCsliawYtzmWT3aGBmYjoOGDlv8LeR3T99eJPZVOJmY5nHmrUrRU+Y8Jj6oG0cTJmT
         tWr61oY30F8mCA2GGBWCxa81o1i43mFCaKMckqmhFswJ25nxZ5i/IUULQPORJ599rgoL
         uncWaUE4vqKF78+sLMSj4dZpnQw9R7hNOfPajDCp+NpbrSi1m4jLJiMzb/t+PzZXpZY9
         m+uE3SdjE6N+05CNW2i4DuJBTDLy6klky5GQGYFYR4YHNq1iK1u1a4WGLSN62+zRpid7
         MHxw==
X-Gm-Message-State: AGi0PuYVIcErlRCLzUjCFhO6al4IbPQHalu0ZteCqQJ1WDm+mu9e0GEp
        QjFNm34GFso+5yK2xmYYH+6zUA==
X-Google-Smtp-Source: APiQypIYsFkIRlq5IN9jj4U8w9Kol8rc9/N9rWY/GS/z5sFI9as51Gma038GxqW1OegRDrgR4FfTFw==
X-Received: by 2002:a05:620a:16cf:: with SMTP id a15mr241173qkn.156.1588277285654;
        Thu, 30 Apr 2020 13:08:05 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id b11sm638844qti.50.2020.04.30.13.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 13:08:04 -0700 (PDT)
Message-ID: <8e52829575f430721113c646f07f9dca280a025b.camel@massaru.org>
Subject: Re: [PATCH] docs: filesystems: fix `make htmldocs` warning
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, hubcap@omnibond.com,
        martin@omnibond.com, devel@lists.orangefs.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Thu, 30 Apr 2020 17:08:01 -0300
In-Reply-To: <20200430140412.7d4c692d@lwn.net>
References: <20200430190737.80950-1-vitor@massaru.org>
         <20200430134704.236c612b@lwn.net>
         <07d33cf9937c89519bafc9210a98dab42579e681.camel@massaru.org>
         <20200430140412.7d4c692d@lwn.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-30 at 14:04 -0600, Jonathan Corbet wrote:
> On Thu, 30 Apr 2020 16:57:24 -0300
> Vitor Massaru Iha <vitor@massaru.org> wrote:
> 
> > Sorry about that. I searched but I didn't find the documentation
> > tree.
> > Could you point me to the git url?
> 
> The MAINTAINERS file is always the place to look for such things:
> 
> > T:	git git://git.lwn.net/linux.git docs-next
> 
> jon

Thanks Jon!

