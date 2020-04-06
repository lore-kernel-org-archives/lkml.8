Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96248C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60591206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vy3ZrVa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgDFXUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:20:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41812 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgDFXUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 19:20:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id a24so8367555pfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 16:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Zy9jOR3FEHibqt+rwh6SfI22BV7Ing5bU84+BN00rNw=;
        b=Vy3ZrVa/Ni/8KnrxqiUwWfKPPhdXuDRGfUImo5iYAADPRayaJ+EUfF37ttrOwVRcWP
         bWT3PuAEHyYlL7rT0ylAoFAmthfWjqZjby+RPm88xojLHEy2Ih2ong0+3AOVmz1/s4Kn
         NGe6JAqA9FnKdPJnDMNWXHSVzW+UFJGofnJqMqiXNIkuKTnaNK/Zf0FjB+Db5P82JVNd
         qOP6n6cb5yVnUlnNjBg+ZklcqkDUWXxwXZwBPsLQp2zETZPewlXOjDTnDzGwbjsIaomN
         pgOh96a/mMXIX5tcHKxyenKzvWKRXYg4gHRXJRm8Flz9q7colzH3b+7kImcTXlJE+Dl2
         KXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Zy9jOR3FEHibqt+rwh6SfI22BV7Ing5bU84+BN00rNw=;
        b=FFuf3KSCRZlqqRaUslwMw/YfO1pft0gg/zqb59tNw+0iGjfZ5Y9OWPByRitsl/1DUW
         2cPFxlS4xylx9LSQQfZX/NBfqMqDkbAbefl3H0D548YGd016Y/owme44Jgd9eKXwzT/9
         Ud6ZB0U03T9QLkQNu+XZ5+w5weP7QS35VefrvPSa05QlEDHbfG8Fyki6e/FUNmZTQapo
         yU2hxJqDBxwrnxAtmqbQ36H+orkYoVx6jYZLKOGIAH4k3zeh+pwvSyoa6HjsJTVbifp6
         RaISzE2OiI0Ncao5hbgz+rdJoeGX5DS6ERu53zF3Xedc5lZh6x3uXbPL9IKIpK6Cxs1b
         EZcw==
X-Gm-Message-State: AGi0PuZRoE08ZM7jlX1q3ke3Hh0lu9XlhtdbFSYuxzGuP/aOMO72SSNW
        SMBu1hLVfOA4WhXLdt1NKGsScQ==
X-Google-Smtp-Source: APiQypLsaTUFaOPT9CXZo9RFi5Ei4O5u7vftOcbwlI7jEvEVk+ydbIpJPPLduNdR9tBuA3ImrEDjDA==
X-Received: by 2002:a62:520a:: with SMTP id g10mr1757591pfb.271.1586215213567;
        Mon, 06 Apr 2020 16:20:13 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c190sm12367290pfa.66.2020.04.06.16.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 16:20:12 -0700 (PDT)
Date:   Mon, 6 Apr 2020 16:20:12 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     David Howells <dhowells@redhat.com>
cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data
 objects
In-Reply-To: <6504.1586159053@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.21.2004061618580.45667@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2004052119530.243304@chino.kir.corp.google.com> <20200406023700.1367-1-longman@redhat.com> <6504.1586159053@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020, David Howells wrote:

> David Rientjes <rientjes@google.com> wrote:
> 
> > > +static inline void kvfree_sensitive(const void *addr, size_t len)
> > > +{
> > > +	if (addr) {
> > 
> > Shouldn't this be if (unlikely(ZERO_OR_NULL_PTR(addr))?
> 
> You've reversed the logic - it needs a '!' there.
> 

Ah lol, yeah.  Probably just better to do

	if (unlikely(ZERO_OR_NULL_PTR(addr)))
		return;

but I agree that mm.h is likely not the right spot.
