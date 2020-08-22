Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC3DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0265D20738
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RF17qP3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgHVJe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHVJe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 05:34:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB9DC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 02:34:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o4so4496wrn.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 02:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5asITRPbZ4NXMNWi/OhKvzA0M2sqXcJbRzcSLzCCfjk=;
        b=RF17qP3GY8mp7qU0/TPPiqpCST8KS4prrK/lnpCGl6+Tp3j5/bA5JgROyRABPnwXTd
         Oo+TbHkdQy83KrZ4Y7LqWegqk66PTOuh8jomsBsFJYJARM3zSbPsv8pnmk1m6XvkorpQ
         wEzTTFL0p8vUOXyuFUIrPZWe2FQ0WPz8hCNR7yZzE3UKUWXP0cLeDTyXuOc4xsf8TCMT
         vNGUQqlWeZl8Nwro6KJibKQt2GfoWZ6HRgMpOMNVoIScfot/maT3Wf4e7mIcl3RkJ5Ro
         84kSHTQMP3QkB+mPskMUlmhj3eyQ/0gYvPIeCnzxqfcB/2CQ8XyUbgvYXJw4omgbYRPn
         skKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5asITRPbZ4NXMNWi/OhKvzA0M2sqXcJbRzcSLzCCfjk=;
        b=FFtuFkMfDkGfp2rRX4+0wqxP/GJkWKp8S05q5+cORqeGSiAvShez2uXHGes2g455O9
         EVKaWady0MsQLZCR4rY8l3Y45JhDw6qpKXvIKMejhS0SEeD0y8vS9ksibkq2nnpdqDN1
         p9Z0/8lQtc3Bbz+5mu53O1lqFg3DH4ibrM20fFPMoFCB5RVlB2p4kSgaOpDXLdrWXniX
         apahKeI2qXiWERgxOmKOWviVS44vNOuiswr9DIY4tfkUBEgpDu2sZjMCkv7qIGn5w8sn
         Taq60cfgAxMarpL9S2hU9HpmmF1v4S0gEL2ZixBpu7+FBe5NShT7B35XcFLLdedwuwU2
         PjJA==
X-Gm-Message-State: AOAM5320BcLgbDs2yNQ+ILRI1M8PGZcVhCGMoZUcdpoVwEojak142Pfr
        Zc3njhDNb+eHMo5fCkctnm8=
X-Google-Smtp-Source: ABdhPJxuFiH+UmReuhcyyAyGrbWmKlWBl59GiciDXztDjxRwUb3dqBB2To4CpBLSVy8/FdsKID2EOA==
X-Received: by 2002:a5d:6505:: with SMTP id x5mr6242528wru.336.1598088866260;
        Sat, 22 Aug 2020 02:34:26 -0700 (PDT)
Received: from tsnow ([176.231.38.53])
        by smtp.gmail.com with ESMTPSA id j2sm9662473wrp.46.2020.08.22.02.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 02:34:25 -0700 (PDT)
Date:   Sat, 22 Aug 2020 12:34:21 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Riley Andrews <riandrews@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] staging: android: Remove BUG from
 ion_system_heap.c
Message-ID: <20200822093421.GA6631@tsnow>
References: <cover.1598023523.git.tomersamara98@gmail.com>
 <a39407f84031eaeed5e65a7aab515a079edf5fcc.1598023524.git.tomersamara98@gmail.com>
 <3eba90dc-128f-49da-41a6-81494653d535@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eba90dc-128f-49da-41a6-81494653d535@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:25:26AM -0700, Randy Dunlap wrote:
> On 8/21/20 8:28 AM, Tomer Samara wrote:
> > Remove BUG() from ion_sytem_heap.c
> > 
> > this fix the following checkpatch issue:
> > Avoid crashing the kernel - try using WARN_ON &
> > recovery code ratherthan BUG() or BUG_ON().
> > 
> > Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
> > ---
> >  drivers/staging/android/ion/ion_system_heap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> > index eac0632ab4e8..00d6154aec34 100644
> > --- a/drivers/staging/android/ion/ion_system_heap.c
> > +++ b/drivers/staging/android/ion/ion_system_heap.c
> > @@ -30,7 +30,7 @@ static int order_to_index(unsigned int order)
> >  	for (i = 0; i < NUM_ORDERS; i++)
> >  		if (order == orders[i])
> >  			return i;
> > -	BUG();
> > +	/* This is impossible. */
> >  	return -1;
> >  }
> 
> Hi,
> Please explain why this is impossible.
> 
> If some caller calls order_to_index(5), it will return -1, yes?
> 
> -- 
> ~Randy
> 

As Dan Carpenter says here https://lkml.kernel.org/lkml/cover.1597865771.git.tomersamara98@gmail.com/T/#mc790b91029565b1bb0cb87997b39007d9edb6e04.
After looking at callers we see that order_to_index called from 2 functions:
- alloc_buffer_page called from alloc_largest_available which 
  loop over all legit order nubmers
  ( Flow:
   alloc_largest_available-->alloc_buffer_page-->order_to_index
  )

- free_buffer_page takes the order using compound_order, which return 0 or
  the order number for the page, this function has 2 callers too,
  ion_system_heap_allocate (which called it in case of failure at sg_alloc_table,
  thus calling from this flow will no casue error) and ion_system_heap_free
  (which will be called on every sg table in the buffer that allocated good,
  meaning from this flow also error will not be created).
  ( Flows:
   ion_system_heap_free     --> free_buffer_page --> order_to_index
   ion_system_heap_allocate --> free_buffer_page --> order_to_index
  )

Of course if some user will use this function with wrong order number he will be able to get this -1.
So should I remove this comment and resotre the error checks?
Btw, this is the same reason that I dropped the error check at ion_page_pool_shrink, so should I restore here also?

Thanks,
	Tomer Samara

