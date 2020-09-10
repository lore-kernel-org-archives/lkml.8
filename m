Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C885C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC21C21D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e3QOW6li"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgIJTv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgIJTvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:51:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF66C061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:51:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d6so5307637pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+cHRkT8sNFeWTbynGyxN3PPYP8ykbg0LglvItAS32tg=;
        b=e3QOW6liZzQXG+Kv2AcwAesvbHXZXtz83QCDVvrluTaPKCOoFGrEp8/WJIbrbwBrvn
         h4scUnJ51PfrgEOp3GFTHmUzxVSBoQuw0WKCBUKih20chmEnh1bNIhopi9J3wcIWomN9
         rieGPxZXAOcUJ9GBL/9QNZzYnFo7NmUnIfdY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+cHRkT8sNFeWTbynGyxN3PPYP8ykbg0LglvItAS32tg=;
        b=Oat6S2TeIaeSodslPA250dK37HS+4DiJy5p7VHntytLRjp+TZGDEJoGPllUNeosMUO
         ILGJ6abYNszT94D6r4w3f3uKsLFKa06rSsy3E5BGS+p2ZVdpCZQOGhj8czxeImbW6ZZN
         Xrd0Qse4mvFrMquD0HULXnmMreTDiKtaxjnq1qkmtV29nkRMNRP4OG1xxgKznaccV4Eg
         muFQP/fMhlQ5i+CR7l8hdMHTMTtHl57nEwc+J3K7dcQVFz/iWeH4g2g1w0cCHu3NBBxL
         GLuWQi2kGZlKAAWk9DvPec4Hmw+OXmTxtAt3ro9Za4abspBsYhS6oX+iIdWABrsumPry
         K13A==
X-Gm-Message-State: AOAM532S4xrQAAvUT7N4CZHWi/N5A3JGzXQ3qHE2TkkvvmqvAAIe7Bd1
        dp7LvNYmymJkRdfDxmiSoIVoMQ==
X-Google-Smtp-Source: ABdhPJy3Vb6fYslObxnLlySxaRWzrc6tYBUQWTnl/9XhUVGIeStG6vd//sipTl6dmBxBI1gqfF58iQ==
X-Received: by 2002:aa7:9730:0:b029:13e:d13d:a091 with SMTP id k16-20020aa797300000b029013ed13da091mr7054551pfg.40.1599767470434;
        Thu, 10 Sep 2020 12:51:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l1sm6732890pfc.164.2020.09.10.12.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 12:51:09 -0700 (PDT)
Date:   Thu, 10 Sep 2020 12:51:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>, julia.lawall@inria.fr
Subject: Re: [PATCH] checkpatch: Warn on self-assignments
Message-ID: <202009101250.FBB416D@keescook>
References: <20200811210127.11889-1-efremov@linux.com>
 <20200901094812.428896-1-efremov@linux.com>
 <afc2cffdd315d3e4394af149278df9e8af7f49f4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc2cffdd315d3e4394af149278df9e8af7f49f4.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 10:58:29AM -0700, Joe Perches wrote:
> The uninitialized_var() macro was removed recently via
> commit 63a0895d960a ("compiler: Remove uninitialized_var() macro")
> as it's not a particularly useful warning and its use can
> "paper over real bugs".
> 
> Add a checkpatch test to warn on self-assignments as a means
> to avoid compiler warnings and as a back-door mechanism to
> reproduce the old uninitialized_var macro behavior.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

I like it! :)

Can you add a section to code style and include a link in the checkpatch
warning to it? (Feel free to just reuse the text removed from
deprecated.rst)

-- 
Kees Cook
