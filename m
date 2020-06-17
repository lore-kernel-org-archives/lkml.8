Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54132C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EEA720776
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GZ/SbfKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgFQDsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFQDsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:48:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51698C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:48:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id h185so476948pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=epbODcoERc3hFGFakjGWOwHdqNCRuVQUeyHnJOTXzPA=;
        b=GZ/SbfKWHWqn93rskoU6iDqEmLuYD7wcXDs8qwGTLGz0InjAQfp4P2V5awYwLho1jJ
         wC/08oqamfwjeNhd791dSoxFwH+ONmytEBH5GYz7h2ba75LrnGrPs4Ra+hnFdbfpOd4d
         w709Sr9Y6IKe+BJHN9VnsankSpY3FVZLbMhLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=epbODcoERc3hFGFakjGWOwHdqNCRuVQUeyHnJOTXzPA=;
        b=F83AI7RnIdhHl5nzL/KP7PpPm26mTrqokAXMJbVWds36w5/iUDbvwdcnQ62WoQxBXb
         4IK+JEz6GKcKMI7ao6cUYKzwyWuvC15gGVtCr1/ov3TFocGhXNrromphgJ50M2wWpvUM
         IrUTw5rFpVkOEksB4pPRGkss9AdE59d/PdDWIKSmNb5vTOZmEUgxXpkEAS9NPFp7+0dz
         cobOXnwDITb62ixbBoJqf5vWaJhX/trKRc8BgYbeFJiM+Ah6SPhQLpNGVSp0W1KqNkoq
         uc+0mUalTPTT89iH5Skz/yc/P5AktBhIM+G+1dqN+jjUv0ggp1H0kQOaB7cc+jh+OkdP
         uAvw==
X-Gm-Message-State: AOAM531Jr9/EefgmB5fKYL9gA+8nUrHCKKYceL4RdcoNuwNi+DCN4P93
        NJ9oe25cXT8qwb1H9Hr8BQKIpw==
X-Google-Smtp-Source: ABdhPJxmlUZEnvgX0cxFedDt0HshokXCuNrNFj74FsnomMnbTWi9IBi/MKUweyDhci1oMDGtN1PQew==
X-Received: by 2002:a62:8c15:: with SMTP id m21mr4746304pfd.182.1592365730767;
        Tue, 16 Jun 2020 20:48:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p12sm18798935pfq.69.2020.06.16.20.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 20:48:49 -0700 (PDT)
Date:   Tue, 16 Jun 2020 20:48:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] overflow.h: Add flex_array_size() helper
Message-ID: <202006162048.A22F1C14@keescook>
References: <20200609012233.GA3371@embeddedor>
 <202006101427.68A436C@keescook>
 <fd198a2b-9a79-b7b7-3cee-5856cffc88af@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd198a2b-9a79-b7b7-3cee-5856cffc88af@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 03:48:51PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 6/10/20 16:38, Kees Cook wrote:
> 
> >> -#define struct_size(p, member, n)					\
> >> -	__ab_c_size(n,							\
> >> +#define struct_size(p, member, count)					\
> >> +	__ab_c_size(count,							\
> >>  		    sizeof(*(p)->member) + __must_be_array((p)->member),\
> >>  		    sizeof(*(p)))
> > 
> > I like the "count" change -- "n" can be seen as either count or bytes,
> > so I like this being distinctly "count".
> > 
> 
> Yep. :)
> 
> >>  
> >> +/**
> >> + * flex_array_size() - Calculate size, in bytes, of a flexible array member
> >> + * within an enclosing structure. Read on for more details.
> >> + *
> >> + * @p: Pointer to the structure.
> >> + * @member: Name of the flexible array member.
> >> + * @count: Number of elements in the array.
> >> + *
> >> + * Calculates size, in bytes, of a flexible array @member of @count elements
> >> + * within structure @p.
> >> + *
> >> + * Return: number of bytes needed or SIZE_MAX on overflow.
> >> + */
> >> +#define flex_array_size(p, member, count)					\
> >> +	array_size(count,							\
> >> +		    sizeof(*(p)->member) + __must_be_array((p)->member))
> >> +
> >>  #endif /* __LINUX_OVERFLOW_H */
> > 
> > I like it! You mentioned off-list that maybe this could be named
> > sizeof_flex_array() (like sizeof_field(), etc), and that does seem
> > attractive. As you also mentioned, it begs the question of renaming
> > struct_size() to sizeof_struct().
> > 
> > Looking back through the thread[1], it seems the name came from Linus[2],
> > and was more related to the existing array_size() helper.
> > 
> > So, how about this, as a convention we can use to make a choice:
> > 
> > For things that are strictly constant in size, we can use sizeof_*. For
> > things that have a dynamic component, we'll use *_size(). So, this patch
> > is correct as-is.
> > 
> 
> I like the idea. I haven't thought it in terms of dynamic and constant size,
> but it sounds sensible.
> 
> > Acked-by: Kees Cook <keescook@chromium.org>
> > 
> > (I wonder who's tree this should go via?)
> > 
> 
> Yours? :)

Done; I'll see if Linus will take this for -rc2 so you'll be able to use
it for v5.9 patches...

Thanks!

-- 
Kees Cook
