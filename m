Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A39C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB8E20656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drvtRa/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgD1XGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726042AbgD1XGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:06:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1754CC03C1AC;
        Tue, 28 Apr 2020 16:06:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h69so61955pgc.8;
        Tue, 28 Apr 2020 16:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yfsu/HSVVo+whNCvC7+Ad36YiKxlRRbH+oE2CArsBNI=;
        b=drvtRa/kVGPe/aGSIjXSD9XyPXWVpkKs8v0NGIJRIeq0cfYpCU2nE9RAh5ODw0FmRB
         xaH1nECe0JgrAtP7wHkgnHewqaSYaN/NYANr71mBUGSIClhZ9RS4Abiq56ewW/9e249U
         x9dehzR5P6PhL4jFEJ9B7en4B/wJHwUk2CNar9pYYQ5QuBKjO4wmzuM5jHdOZj+DWhsi
         CynBJCzvHcg6ODi0v4Y++EmJDyTnmozP4PWhb8fHfYciL4ZuT3MmnMyfW4a0jPxn/+kM
         z1kIQzi7sqVC9wYCHB3oKE8NnFLtp3MjrWsZq37Wn+cGgwGsMxycueJOmxQvyCSTfBhe
         DvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yfsu/HSVVo+whNCvC7+Ad36YiKxlRRbH+oE2CArsBNI=;
        b=YD4xilVW9tuFWOYyT4jXk5jYHQeZ4x2JaIx8DTu4IsTyPZSnbMyMGd7uv4z5240glD
         eknBgZMXaxyFj37vVHcwbxaTh1KAAOuAmHXqVEeWOFtdfya6E4ju/RxCU93VhHyI3rX2
         3OGJKmLeRBD96ClYXG88DzKKxBtMJlBiKEOBJWQkRHMEgMMgyQ6J34oUnUKl1Oup7BaQ
         A/6lGBxSw6MqyGUpNApVoxkNPJEkATQHk/3jz2QripJbnwSvQYl+JolESg5DS9BtWg86
         sqZLqckjT3DO2nCedfwDkW0PcMq+7tBTNyLErHxasuDe1bAcOPdF6zFSxrei1ssZGCCZ
         fhAw==
X-Gm-Message-State: AGi0PuZZqXSL8nWlmDsRpdmLYgRkkJLoNvCfsS1+3GuAAzrn4olRva8h
        T822JQeTOTG0E2XwN3gOzsg9cm/7
X-Google-Smtp-Source: APiQypLOWlhkTwuTmHHzRTzkVYPWGkmTUt5uGv6P0rMwfKPHIy6FzFca7LYYW4VSuMLkyfnl7isIWA==
X-Received: by 2002:a62:e80e:: with SMTP id c14mr31075459pfi.83.1588115170425;
        Tue, 28 Apr 2020 16:06:10 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id f70sm15983495pfa.17.2020.04.28.16.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 16:06:09 -0700 (PDT)
Date:   Tue, 28 Apr 2020 16:06:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 input-current tree
Message-ID: <20200428230607.GW125362@dtor-ws>
References: <20200428182441.3deea12a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428182441.3deea12a@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Apr 28, 2020 at 06:24:41PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   f4dec2d61609 ("Revert "Input: i8042 - add ThinkPad S230u to i8042 nomux list"")
> 
> is missing a Signed-off-by from its author and committer.
> 
> Reverts are commits as well ...

Yes, but they lack creative content IMO. In any case, I do not rewind
for-linus branch, so it will have to stay as it is.

Thanks.

-- 
Dmitry
