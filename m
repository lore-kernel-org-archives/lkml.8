Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15A8C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF4520866
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuyPAEXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgHPRnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 13:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgHPRnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 13:43:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317C1C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 10:43:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so12710714wrl.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 10:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nn0Ssx3+c526gox1QvsdRl3BZJs+iVNQgS1FvYlELz4=;
        b=YuyPAEXgZvzHBK677iO7Tvg89GTdZ024gYRGXwq59GXCRP2Q/bWXdEVPft7Uz4qEkA
         /nr3XuTk6ptczo0FpRsJhpBnwXBrurk1ik23l3/Lo7PUo9pHk210E1SBgnr2CdlhzveJ
         CsA1xsqihHq1g+p92q4hLAJ04FZ4TZCIQljemf4LbYv1Lp2/9PJ5HYvilPCSlnJqhRr+
         HPdFAHXG1MDOzP8wK3XrPRW9eV04LwRicZ4VjfAzxLjl6a1fXmAxydbBBgrmEAZdLx0R
         v63YfugikFVfnxusVnmX8rQ+NpgJ76nnbcj3evqUsLRGdrBv+P/+C9nmDm/v0UkH2qxB
         Y0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nn0Ssx3+c526gox1QvsdRl3BZJs+iVNQgS1FvYlELz4=;
        b=Z5qB78A+7JIlPFQV1CulEJbMjPFSHudhTpkKLDeqcrh0LEEZ6rXdIWI7pnaXeEGxEp
         s2lOUAwKfwxmGREQDxedCQYvQAuht48x8M7umYfAZuXm8zq99PDxc038zWGzXVm+1ty4
         Xk40p/VNrw1bbr2iuQwdZ3w203rbtFq8Bg5gHioTE9OS2cjm++XubTve3/dk2FE/z+p+
         RXI3bUMH1/ivCOQzdbBh0KehVHzJgZaV71vEFokrR9nWmYtaynvdxAyZpksU//luNi81
         6pl1NIMPE66+ebkTR2hhOPgAcjC2VAghbTo3ZJ4us5jlmiWnZxxxYvPOgUmphVdrMGUq
         949A==
X-Gm-Message-State: AOAM532OeUOiTY0KHnH2v/+GWSoagVSIFBPnS6boys5La1C20FEAowf/
        tEimaQOgnfZxQxo4hTdDD10=
X-Google-Smtp-Source: ABdhPJxvyqPjh2aOYwOIzUhLE2lT6M/udf3WrdcOACdqp9pQaZlxt1N8eW/LSL2crIqyI/WB7MCKyQ==
X-Received: by 2002:adf:d0c4:: with SMTP id z4mr11608654wrh.245.1597599825799;
        Sun, 16 Aug 2020 10:43:45 -0700 (PDT)
Received: from tsnow ([94.159.146.190])
        by smtp.gmail.com with ESMTPSA id y16sm27330124wrr.83.2020.08.16.10.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 10:43:45 -0700 (PDT)
Date:   Sun, 16 Aug 2020 20:43:40 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Riley Andrews <riandrews@android.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Laura Abbott <labbott@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 3/3] staging: androind: Convert BUG() to WARN()
Message-ID: <20200816174340.GA236914@tsnow>
References: <cover.1597597955.git.tomersamara98@gmail.com>
 <8df6206000524d4a0043a7a1df97b2be2d277995.1597597955.git.tomersamara98@gmail.com>
 <df5e2206-51be-3fc7-ddc2-6f318a8e5a1a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df5e2206-51be-3fc7-ddc2-6f318a8e5a1a@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 10:34:50AM -0700, Randy Dunlap wrote:
> On 8/16/20 10:22 AM, Tomer Samara wrote:
> > replace BUG() with WARN() at ion_sytem_heap.c, this
> > fix the following checkpatch issue:
> > Avoid crashing the kernel - try using WARN_ON &
> > recovery code ratherthan BUG() or BUG_ON().
> > 
> > Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
> > ---
> >  drivers/staging/android/ion/ion_system_heap.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> > index eac0632ab4e8..37065a59ca69 100644
> > --- a/drivers/staging/android/ion/ion_system_heap.c
> > +++ b/drivers/staging/android/ion/ion_system_heap.c
> > @@ -30,7 +30,8 @@ static int order_to_index(unsigned int order)
> >  	for (i = 0; i < NUM_ORDERS; i++)
> >  		if (order == orders[i])
> >  			return i;
> > -	BUG();
> > +
> > +	WARN(1, "%s: Did not found index to order %d", __FUNCTION__, order);
> >  	return -1;
> >  }
> 
> Hi,
> Did you look at what happens when order_to_index() returns -1
> to its callers?
> 
> 
> Also: fix spelling in Subjects: android and BUG/BUG_ON
> 
> -- 
> ~Randy
> 

Hi,
yes I've made a patch for that too but it seems I forgot to
include him in the patch set.
I will send new version for this patch set soon.

Thanks
