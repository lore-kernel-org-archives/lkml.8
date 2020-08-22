Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557EAC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 02:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352AE20732
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 02:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfmTUga1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHVCww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 22:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgHVCwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 22:52:50 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA716C061573;
        Fri, 21 Aug 2020 19:52:49 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g26so3121256qka.3;
        Fri, 21 Aug 2020 19:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kyLJM4FctGqEJCm/I2loZSNxyXzpdIJPpLQ4djhV+lk=;
        b=HfmTUga1AoWFZUbQqWrEPstih7PtA53ZWumfWpHFB91fKdKZhG3NFPdkyWKLEyLUUw
         hy+TYdx9u+PSe4fsD96jHgmpdHfyoTNXfSKttlyDvGT47+iU9R712wjfpvlK24uKwZRU
         fqk0RHmhyHpd9amA9XeZET5XKwHKeUFtkOFCzCKakM+cIcB+9n4nEkT5hFh/c9VWqWnm
         Uf6A2RgdGb1Ocz73cgSyCZg/4ZGk7YwKbBaI73mc4jxaibeh9xq9LxJpyaSHQrKEnf9a
         c7VkS34FcntozOzvFr5n0nYSBzUShsVuf8U5rzGwVRwQyYhaC3WEUvqUIl/C/S6+S/DI
         viLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kyLJM4FctGqEJCm/I2loZSNxyXzpdIJPpLQ4djhV+lk=;
        b=SazfU6yq7THGefmoGerhRrY9P5FFOVL05fgL36skwjjH2HqVPAVUF8Motu3r1cXUdZ
         H50LS0bq+BZ+WbVstivFLJNsmIEkfPt/rMdRX0wfJYuYi6eldMYe1xa+/qLAVOa7sIJr
         0LyYfENo8qj8zpebaQedNbElmhbH26unw8MoYROtbdxoieOzhntbkWHs60RJqXtRM+ZQ
         YB0vnFo94MddyHWw+1WS2IR5zKZeTiXEjY+m0hDAB577EHWDRGC4CvEYQmYfkXaPxTFQ
         I6aUvMYjZ66AOBREHHsNNq46mksx0R8DWyrU9PtnpazauVYQbL3tB4S2hUz+duTH/oT+
         Tuow==
X-Gm-Message-State: AOAM530MwX5Vmf/BJfvSX2nVv8KliBHcXLMvMcp867fjIubpj5kEETLP
        3XWdtmYG/BLNLkzP7CcHC70=
X-Google-Smtp-Source: ABdhPJyZrxoFgMhPcWPhe8oeEY9eGq7iObG0P48MLzPL4OEFDzSPafgXDRvajhmdZwFnXrFij17bow==
X-Received: by 2002:a37:cc5:: with SMTP id 188mr5244082qkm.195.1598064769125;
        Fri, 21 Aug 2020 19:52:49 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s4sm4011079qtn.34.2020.08.21.19.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 19:52:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id CEF6427C0054;
        Fri, 21 Aug 2020 22:52:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 21 Aug 2020 22:52:46 -0400
X-ME-Sender: <xms:fYhAX6t4IH6I8d4eh7FXTwCgjE2lJVvLq_Tna0Ii4K9yXBKzivvjjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddufedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpegsohhquhhn
    rdhfvghnghesghhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeduvdfguedtueehgf
    fghfelgfegveeuleeigfdvgfegueekheelleeuieeiudekudenucfkphephedvrdduheeh
    rdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledv
    geehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtoh
    hmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:fYhAX_ce169f3drFsCCc80-akIh3ZDL2K2045bgbE01M2w2yFnkYDQ>
    <xmx:fYhAX1xxftnUMXL-2vHQntlZe3L6WtjBUh4_EQEM72GQ2IZ7LI7BDA>
    <xmx:fYhAX1NYYsJYG5ZztxAUyTHF7029nwKpmJU1_RiHHajfp_bLoPeaJA>
    <xmx:fohAX-bhcCHEvPGNhXus17niZrEhPIpByV2rcL47k0rj5g9eRoPQCQ>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7DE69328005E;
        Fri, 21 Aug 2020 22:52:45 -0400 (EDT)
Date:   Sat, 22 Aug 2020 10:52:44 +0800
From:   boqun.feng@gmail.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>
Subject: Re: [RFC v7 14/19] lockdep: Take read/write status in consideration
 when generate chainkey
Message-ID: <20200822025244.GC79404@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
 <20200807074238.1632519-15-boqun.feng@gmail.com>
 <20200821174132.GR3982@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821174132.GR3982@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 07:41:32PM +0200, Peter Zijlstra wrote:
> 
> So far so good, excellent work.
> 
> On Fri, Aug 07, 2020 at 03:42:33PM +0800, Boqun Feng wrote:
> > @@ -371,6 +371,21 @@ static struct hlist_head classhash_table[CLASSHASH_SIZE];
> >  
> >  static struct hlist_head chainhash_table[CHAINHASH_SIZE];
> >  
> > +/*
> > + * the id of held_lock
> > + */
> > +static inline u16 hlock_id(struct held_lock *hlock)
> > +{
> > +	BUILD_BUG_ON(MAX_LOCKDEP_KEYS_BITS + 2 > 16);
> > +
> > +	return (hlock->class_idx | (hlock->read << MAX_LOCKDEP_KEYS_BITS));
> > +}
> > +
> > +static inline unsigned int chain_hlock_class_idx(u16 hlock_id)
> > +{
> > +	return hlock_id & MAX_LOCKDEP_KEYS;
> 
> But did that want to be:
> 
> 	return hlock_id & (MAX_LOCKDEP_KEYS-1);
> 

Right, clearly I'm missing the fact we have change the definition of 
MAX_LOCKDEP_KEYS at commit 01bb6f0af992 ("locking/lockdep: Change the
range of class_idx in held_lock struct").

Thanks for catching this!

Regards,
Boqun

> ?
> 
> > +}
