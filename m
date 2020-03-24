Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB19FC54FCF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE852076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgCXTkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:40:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55021 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCXTkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:40:42 -0400
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1jGpPj-00063D-Vj
        for linux-kernel@vger.kernel.org; Tue, 24 Mar 2020 19:40:40 +0000
Received: by mail-lf1-f69.google.com with SMTP id l7so6194536lfk.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 12:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/2JobbXs1W8yxYMJ6+lq0xhIU5CU+OqYIQOVd5RVlA=;
        b=pIktQ4RNrN/3HvjX6aAl9JATSJ/rlMgLKW6iZxhToAoxItBto+kdmz6wK/hX1aU4yd
         Mx2UmMU2gtiFrGFFNANeCU3/cBzdkWuMbqV/qcO57F7sIBXBBR7Fnka+mPC0KJyn+fIp
         q7KgsdCFw38kjo1UkvW/6c1fxuQp+OMPyKxzMTsGFiDa7RaF0/b+8H+/YB6jf5WmKRND
         4SbDj3JxljuS1o7ddFFJf0bEidTWlzUP4PLy0TvxbPUmUVLKmwFKr+AaHhtGalB+5jzi
         BJjnS8H6c5pQrd/tikYULzurfyXAuBOr5m/mrCJtJG2Mg0qIu7G9yhWwhR9MP9e93jWz
         TcTg==
X-Gm-Message-State: ANhLgQ0tTlIBZfcs9/OLlrMFoD9mVtjb4l4xdaQNT9auR43jF4Gb9b05
        iMsTO2coHHpEGJhN1jWUidN8AJtYq0faI+Oak0PEdkOzJyGOc4n2hOFgfTho1YI/DurhCpyJqoi
        Wt8EJviTOvFkQ2h71RsI0QaaW0CuQ+CV7V/zd/rRMCr1VMewHhMspIykugA==
X-Received: by 2002:a2e:85c6:: with SMTP id h6mr11097004ljj.218.1585078839452;
        Tue, 24 Mar 2020 12:40:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt0WbprPyjvyjWMRUlAK3041SLktIQRQSflKpi1eNe5RAyLTHHdxh7A+f14ugm+cM4/wPJn748paxHlMg1chqs=
X-Received: by 2002:a2e:85c6:: with SMTP id h6mr11096987ljj.218.1585078839248;
 Tue, 24 Mar 2020 12:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200323223035.29891-1-gpiccoli@canonical.com> <202003241137.A90B14A@keescook>
In-Reply-To: <202003241137.A90B14A@keescook>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Tue, 24 Mar 2020 16:40:02 -0300
Message-ID: <CAHD1Q_wYtuWPtDQ6xVQZ8AGbnVYhh8bYzrhnr=-OYokHEPhQZg@mail.gmail.com>
Subject: Re: [PATCH V2] panic: Add sysctl/cmdline to dump all CPUs backtraces
 on oops event
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mcgrof@kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Kees! I'll respin a V3 without the kernel param, now that we
plan to have "soon" a way to set sysctl parameters from the
command-line.

Cheers,


Guilherme
