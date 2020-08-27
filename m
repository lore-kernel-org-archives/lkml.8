Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FE3C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E1C20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jjWnq371"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgH0UZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgH0UZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 16:25:22 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDC7C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:25:21 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id f12so6004230ils.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EcPugKinUDkl45gw2/TofizT3GOM5FJb2tHu0+XZtfc=;
        b=jjWnq371SBtqP44eYzksxx+Ez1Vqdmotak6/NGGCW240lnyg+AY6wdXUaHmqTCHcls
         7Ufv5ivFPyKcBG/qcjXE8J2XyPUv8+pUeFqujz3ZqhipT/ZFKK6N0FoWo5OELlZgnCMq
         ltWz5TcKuEyAZnQ+DalgXB5fJkK/tScz1iOpDNYkQlDwE6WELNDH1sJylvOeepxLI8d2
         czEGUJ9xpdplUyX+w4fJM0Qcw9EfPBwZ02Yi5cuTXjYrKonuUWTN+QPRDqlzkAv6sWcv
         ZiI9u/RibB7o6CqSHA4CmRCSZkWSJLra8LmWsHpJbrQkYEdUSvOIWQ9ObG0bVRRlR8mA
         Oz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EcPugKinUDkl45gw2/TofizT3GOM5FJb2tHu0+XZtfc=;
        b=AX4T7dBzx1vOX/8k2x+jvs/YjRdXbVB4FzkU/04v3AiKTzI2fsYF7zfKIlMG7EKAAU
         9IEcYqAVGUjHVMUHLjzR/y3V9l8QC5z9WovfPYGFhukZnM7YTcO+bzc5PnS9zgzqhxw0
         jMEjGz5zgz5SUgerw4MRxOpIXspDz6kUKUgl95F+1QehkEdWbzrlvIvTMYJBDMEjMz7v
         UA0kgofV0yZuqcJtvXNuuZCp4Q4MEotdlmn/50qlFAJNDYVzXyBBQze9h56uxa7RGK2T
         lo8F2TWYV+sOKvgRcYjNmL396U/krjT9n8dNY3e42eZuQ9oWBL4GfgGG78HxLvYjsvcx
         y2lw==
X-Gm-Message-State: AOAM530hrlcFkAmIQje4vKXQq2QDwU72kPeQqv3ZtHGndWKR//qsDG88
        ZVItf11prKEb+75W8XHrIlESLuFWCY+d2FKA
X-Google-Smtp-Source: ABdhPJypVWkjZUjt8Sj+LCVvbBEGUX7d4meeBdN/kwOzHSsOqrAhQv8bjR5/peeV6piVllYGZxandQ==
X-Received: by 2002:a92:dc03:: with SMTP id t3mr17495932iln.59.1598559920719;
        Thu, 27 Aug 2020 13:25:20 -0700 (PDT)
Received: from google.com ([2601:285:8380:9270::f2a2])
        by smtp.gmail.com with ESMTPSA id c24sm1662935iom.46.2020.08.27.13.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 13:25:19 -0700 (PDT)
Date:   Thu, 27 Aug 2020 14:25:17 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ross Zwisler <zwisler@chromium.org>, linux-kernel@vger.kernel.org,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v9 1/2] Add a "nosymfollow" mount option.
Message-ID: <20200827202517.GA484488@google.com>
References: <20200827170947.429611-1-zwisler@google.com>
 <20200827200801.GB1236603@ZenIV.linux.org.uk>
 <20200827201015.GC1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827201015.GC1236603@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 09:10:15PM +0100, Al Viro wrote:
> On Thu, Aug 27, 2020 at 09:08:01PM +0100, Al Viro wrote:

> > AFAICS, it applies clean to -rc1; what was the rebase about?

Oh, sorry if that was confusing, I just wanted to make sure that it still
applied cleanly to the latest -rc so that you didn't hit a merge conflict.

Yes, these patches apply cleanly to both -rc1 and -rc2.

> Applied (to -rc1) and pushed

Many thanks!
