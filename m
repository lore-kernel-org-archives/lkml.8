Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D5DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003B22074B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eBf8JGQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgFDVdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgFDVdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:33:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB97C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 14:33:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 64so3853510pfg.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 14:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Ed2x1xHYGNA/npaN4uNgJCVcnkg59P4yDxYvAmxsgc=;
        b=eBf8JGQp8z5Zkl06WtNZJt+kjhVJvpEquXEeMrtjJRtCB406/IkjEMrsOw8Jqp27Pr
         pgrpSnWmIjRUD9fxQNaCzzsZ0sO6oNOhA0aUWhKS3S5KLaEX9h7sX89gfNI8maEZIEig
         CF+j2uM101uoXlWa5v64shfCSfxZR7oBG5Bss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Ed2x1xHYGNA/npaN4uNgJCVcnkg59P4yDxYvAmxsgc=;
        b=ezq+vzMriItCcEOvbtJVpB3SfRrwZfJ/4yWPwy/jPVx+BVe8XFxOsjJAjJS0ua1CcT
         HEZxji6ahy3xXpmA8DV7Klq7X1TkGOTsLrUA0s0u6ESvZYwdFOY3vFiwG558g8nCpejA
         Q3mxenuqpcMTHF/PHJIwJ/NDXAGF7/aqhILxvauB2ypTNOrcr8vDrg96cjJlRkEWMNpv
         a/93ZVm3X6cW3IRJ4NmaAXZshVSWW4We2RsKl+I3sUJP/znpJRV4Sw/UH6FxYLRQ/RYU
         /aPmiP+5WzjZszBeU8+Uvhm1Lvm0S4nm6H8E6tjJwxsMuki8H3bmH4keefncK2OVXWbs
         0baQ==
X-Gm-Message-State: AOAM533/YJ/8mBu9FBATNbJOt/i1eyTfd29aOh5LSTYdoOi1IyB734hC
        LADT0wk5wK0dVLfdVe2o+jclyg==
X-Google-Smtp-Source: ABdhPJzYyn+9V8IgbiR5Z+D6gjBVLB39apZrs8Opn5/9tWvaFnUjZxtkyjmQ0YKk03cpCr13crHfKg==
X-Received: by 2002:a63:7407:: with SMTP id p7mr6539543pgc.268.1591306428981;
        Thu, 04 Jun 2020 14:33:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x190sm4815464pgb.79.2020.06.04.14.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 14:33:48 -0700 (PDT)
Date:   Thu, 4 Jun 2020 14:33:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] docs: deprecated.rst: Add note to the use of
 struct_size() helper
Message-ID: <202006041433.7065E1A7@keescook>
References: <20200604172138.GA21820@embeddedor>
 <202006041047.9B3E8FB951@keescook>
 <20200604182123.GD10051@embeddedor>
 <202006041322.35912ABB@keescook>
 <20200604211903.GF10051@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604211903.GF10051@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 04:19:03PM -0500, Gustavo A. R. Silva wrote:
> On Thu, Jun 04, 2020 at 01:25:26PM -0700, Kees Cook wrote:
> > On Thu, Jun 04, 2020 at 01:21:23PM -0500, Gustavo A. R. Silva wrote:
> > > Yeah. My reasoning for is that it will take a while --at least one 
> > > development cycle more-- to completely get rid of all the 0/1-arrays.
> > 
> > Right -- but we need a place to point people when we tell them "please
> > don't use 0-byte and 1-byte arrays", and the deprecated.rst is the place
> > for that.
> > 
> > Having it in deprecated.rst once they're all gone only serves to explain
> > why various compiler flags are enabled, etc. But while they're being
> > removed, it serves as a single place to document the issue (as in, much
> > of the flex-array patch commit log "boilerplate" can actually be
> > repeated in deprecated.rst.
> > 
> > > But I think we can add this note while I continue working on the flexible-array
> > > conversions. Once that work is complete, I can go back and update the
> > > documentation. :)
> > > 
> > > What do you think?
> > 
> > I think we need to document it at the beginning of the work (and I
> > should have asked for this earlier). So let's just add a new section on
> > dynamic array usage, etc. It can include a note about struct_size() as
> > an example for why 1-byte arrays are so weird. :)
> > 
> 
> Got ya. :)
> 
> One last thing... I was thinking on adding such section (dynamic array
> usage) to coding-style.rst, explaining how to use struct_size() and
> transform the different open-coded versions we currently have in the
> kernel, e.g. I have seen people use offsetof() --and sometimes open-coded
> versions of sizeof_field()-- and its open-coded version to do arithmetic
> in allocator arguments.

Yeah, that sounds good to me!

-Kees

> 
> Thanks
> --
> Gustavo
> 

-- 
Kees Cook
