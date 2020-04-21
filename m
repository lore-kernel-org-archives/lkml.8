Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B11C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E45206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="faz134qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgDUWDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUWDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:03:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A06C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:03:05 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x3so7254944pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WXkzL4dOrbJQFvSwAu9xq5cucC+v1u0vYRxTZPwycIY=;
        b=faz134qp9HFo4Ei6cS8vm+HKRVAvrPlCNs5BUxgWQGoPpr69XIP76TKD3PVgO3AulV
         RLKSRnXXIt0zJ/M/7onvDQFd6Q8PNOr/7e/y6X/sYFS3dSiFaVvuWohFuNkJw5dcBGbo
         mMUMwkb6dg1xzv1Ppn4CFY3vsuu/V4jSFPBaXKOaPlHk8uYYVwbj8GDocZq9uxIRqoNh
         iBLTpIzsFIjZQ0uKZUezJ6wnRdv7mMYAFapSySu12lqlZWOoJQsnVCdEzZkr/Q+9NK1/
         lpSe33WwkGjL0gRMVd9ngpT0Tnbyz6RJxMNmvSWfRSd+H8TCyv2eukKhaDZE53Tqx0Ky
         zAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WXkzL4dOrbJQFvSwAu9xq5cucC+v1u0vYRxTZPwycIY=;
        b=mJZ1fpW/JBYCv/jWRj4qsB4HlWTm9bFK+/WxVT54Y0f1njj+DNk7i6LakGfTGJ6zKz
         He+uh2ermYkFjGMNI6xP0iYKY+6FXN+/krqw3DzpjPCbX4YnHZ/wXQT0iCFjFh9Y2/6G
         6opwIWe4GrP4vHGkopbzue+PSoGl7Pb1PIvzdGbxHNREFhBAv1R5eNQUSxgDC1ZNMk6T
         /CtOxzSCJ6tRuRuH9h434XTb/TW1xtSEaC8Sv379VqTw+wzcaMQrcfULCmcRUxlY+5dX
         vdWweAn226MoUVGgcchivvqRhAy0Zxk5cgSZaKacWUkA4HOWe82APw5Ienaw8bPNrT5J
         NNYg==
X-Gm-Message-State: AGi0PubRIWnMIBg8ng69IGVimvlTN66D/FMIVP4doyduRWVIMzLhioTP
        SzY1c/DfrHn5YiA3WNym3U+Kkg==
X-Google-Smtp-Source: APiQypJ4BC8yw7C2m1DYZzBfrbDYBdk8gquAtELvbi87GDW40aeMcbmDAOYgYG/sNqXRKgy0vJeCXA==
X-Received: by 2002:a65:611a:: with SMTP id z26mr22635406pgu.341.1587506584593;
        Tue, 21 Apr 2020 15:03:04 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id w186sm3418987pff.83.2020.04.21.15.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 15:03:03 -0700 (PDT)
Date:   Tue, 21 Apr 2020 15:02:58 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] objtool: optimize add_dead_ends for split sections
Message-ID: <20200421220258.GA85573@google.com>
References: <20200421180724.245410-1-samitolvanen@google.com>
 <20200421180724.245410-4-samitolvanen@google.com>
 <20200421201305.66y2u473htzcuhfu@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421201305.66y2u473htzcuhfu@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 03:13:05PM -0500, Josh Poimboeuf wrote:
> Also, the unreachable annotation at the end of a section is really an
> edge case.  I'm sort of wondering if there's a way to accomplish the
> same thing without storing the last_insn.
> 
> For example, I wonder if we could use find_insn() for some bytes at the
> end of the section.  Most of the time I _think_ there will be a two-byte
> UD2 instruction there anyway.  So maybe we could do something like:
> 
> 	for (offset = rela->sym->sec->len - 1;
> 	     offset > rela->sym->sec->len - 10;
> 	     offset --) {
> 
> 	     insn = find_insn(file, rela->sym->sec, offset);
> 	     if (insn)
> 	     	break;
> 	}
> 
> It's kind of ugly, but then we could maybe avoid the need for the
> last_insn thing.

Sure, that looks fine. I tested this and it looks like the performance
is roughly the same. I'll send v2 shortly.

Sami
