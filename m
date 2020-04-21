Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE48C55183
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34E3206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jo5FKBn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDUUUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgDUUUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:20:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB933C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:20:07 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r14so7133552pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1iFjbz8Jw8ibbB0XT4DmNFkXZwjx8auTEGChMa/iuHI=;
        b=Jo5FKBn/tL3wInA9uRKBGO7/qcNeByYqd8aj+ZPI/jZnMwO1Ri4RCYwLxdiGWOnWJ3
         81+z6pM3SfjUTSGiebWv9b7mvD649MBsCCeJ26rAJo5DjBTBnvMGpAfY4npst/Yftt21
         9kGTDYZwCWo1/4kTiXkLqGu3aXauoDgiW89TVNYvLUVIRo1n2Nqh9h9Z5tM6pFwT5BWP
         QX3tqAyg7qicEhQpZxenUWUwJBY/JR3+2b7UIikaOLPfH14abE2Ebbbea5nSdTwwUd4n
         KrFT87ffoi48QT2cdh9fxZ3+4QS7KyFk4Zaffibqp9fTrUsLw2K8P1ROKNMR/WaUQ8LU
         ii4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1iFjbz8Jw8ibbB0XT4DmNFkXZwjx8auTEGChMa/iuHI=;
        b=r9fJl4K0TWvV2UIHUcymWs4/vLjpfUG3k6ttEqFJ/HzX9uz+M7AnRorfE56oyrPmHV
         gqLlQFsr2q2sCW8lqiQu9NM6L6AibjDO/WxxCKGSDpgHA9OPSLeHlWQtY87OHqD+DV5y
         RTzzHO8UVuvFPI+vm11AELiuwyBwy9T/qNzd6Hg8ZnzknDN554M1B1ycWyi2qXSSGOzD
         /2T0akVNi+3cFlrrI5Zf1zZnNXfojEC8Nfq7Y/Uys7F/Bral6iusnpU3gx3vVZbDjBYs
         1cqtlLV8k7RGqf0LyxC+aqAiPA2kFWN1ZTyKvTz8jwjrtwQjKEbDZfPtJfcG5PIBFNx3
         aWng==
X-Gm-Message-State: AGi0PuauxKmT4rpbIhcLIGo12ZYfnLP+p01Ib8xE+y2sUZDBVGdjHDIU
        FN5CFotynXfc4LDPr1YGjV5NtA==
X-Google-Smtp-Source: APiQypJ88+z5exqmvb480JeRvdSbXBkxyS0uUX9BssPV8KA+/lvJw1UIgbmAqaln7qpJNY0B022HHw==
X-Received: by 2002:a63:49:: with SMTP id 70mr6495452pga.275.1587500406869;
        Tue, 21 Apr 2020 13:20:06 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id i9sm3211391pfk.199.2020.04.21.13.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 13:20:06 -0700 (PDT)
Date:   Tue, 21 Apr 2020 13:20:01 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] objtool: optimize insn_hash for split sections
Message-ID: <20200421202001.GA90686@google.com>
References: <20200421180724.245410-1-samitolvanen@google.com>
 <20200421180724.245410-3-samitolvanen@google.com>
 <20200421194749.GX20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421194749.GX20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 09:47:49PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 21, 2020 at 11:07:23AM -0700, Sami Tolvanen wrote:
> > When running objtool on vmlinux.o compiled with -ffunction-sections,
> > we end up with a ton of collisions in the insn_hash table as each
> > function is in its own section. This results in a runtime of minutes
> > instead of seconds. Use both section index and offset as the key to
> > avoid this, similarly to rela_hash.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> 
> I already have this queued:
> 
>   https://lkml.kernel.org/r/20200416115119.227240432@infradead.org
> 
> which looks very similar.

Great, that works for me. Thanks for the link!

Sami
