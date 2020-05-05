Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C8AC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F72D20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVkOhUUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgEEVGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 17:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgEEVGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 17:06:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F521C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 14:06:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x4so160207wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 14:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Qnfn5++D/Wi4xtbIl/4IruN2YNTAZrZK9CzFRQ9QTjU=;
        b=pVkOhUUpZl/ylOnPBt4LlGVgVwb0GYh/TlgReV29LSw0tYq3UkoYiaD5oDRpVd5Grn
         dZENeyNjhfieWF6xBSdCf1/hMPgd0jaUJ1J8Zz/h4BOXwzOpCC/n/jcLv8LqsgPFaNg3
         Zkd2oKP2zm3hypk1z2v+duXSlF1YxAMs2HVIy8CW7YFEvgD6YGE8aSIEthItw5hnLrQr
         ppEOcai8UxPVmDbJavakvJOEuePx5GOgLjePzF9I+0SadeVvGOFLiW6OMmTVewxT/TO2
         twJYEVJjQh12Pv6ojX3E+o0JiB1eZXNUhOOYDkyc8jVdZicKA+rmgGoqLoxPvTsXOs12
         9T8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Qnfn5++D/Wi4xtbIl/4IruN2YNTAZrZK9CzFRQ9QTjU=;
        b=kwNTUCMH0QhDcL2Ru7SjIeviMARYVWUPky0yU8V6lVtoieWBz3aNF6x+yYi9i6KdVi
         atY+Xrj4m76Q3aruhE5/JGkRl2uxxG7+GZOdrAGzTOpbucH9IW0NPo/TVjJyJ/uj0PNe
         7ra81AqXR1O5gPX1BgdWzkKAJnsVBSTozqbP5huHybGLMS66M18qfyY+GBwe05XDyotJ
         JdS2msHFcpuPf06Do0xajPbL/AYNNuqBQYorL9P/56xf8lphCs+STzGEjEOI5QkEgGOA
         b9Qpl5ta116eZ+rKvcvkMJ9rCqHzDPoj7qHUpFx7kGCWw08zSdE9Vs8kuXeIOewYQ11e
         PpuQ==
X-Gm-Message-State: AGi0PuYujlpktlW32c7BxeZFoNC7bKJCH7W6+MVEji5UcM7Y5xzOMFg2
        Rbgi7s42sLnN/b6bOBK18QAKbqcH
X-Google-Smtp-Source: APiQypLIYv42tr5CEP671CQQ0JDwNTnEgzVxY0a4IenB2lsqPKZMpTIQ20g5MT2d6pmie9bpsPX94w==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr538177wma.138.1588712794462;
        Tue, 05 May 2020 14:06:34 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id h1sm5938910wme.42.2020.05.05.14.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 14:06:33 -0700 (PDT)
Message-ID: <868327e3af1d7ba2e2adfe7209f77a25a1cd1226.camel@gmail.com>
Subject: Re: [PATCH v4 2/9] w1_therm: fix reset_select_slave at beginning of
 search process
From:   Akira shimahara <akira215corp@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Date:   Tue, 05 May 2020 23:06:32 +0200
In-Reply-To: <20200505144900.GE838641@kroah.com>
References: <20200429225943.199249-1-akira215corp@gmail.com>
         <20200505144900.GE838641@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 05 mai 2020 à 16:49 +0200, Greg KH a écrit :
> >   /*------------------------Hardware Functions---------------------
> > -----*/
> >   
> > +/* Safe version of reser_select_slave - avoid using the one in
> > w_io.c */
> > +static int reset_select_slave(struct w1_slave *sl)
> > +{
> > +     u8 match[9] = { W1_MATCH_ROM, };
> > +     u64 rn = le64_to_cpu(*((u64 *)&sl->reg_num));
> > +
> > +     if (w1_reset_bus(sl->master))
> > +             return -ENODEV;
> > +
> > +     memcpy(&match[1], &rn, 8);
> > +     w1_write_block(sl->master, match, 9);
> > +
> > +     return 0;
> > +}
> 
> 
> If you put this higher up in the .c file, no function definition is
> 
> needed in the .h file at all, right?
> 
> 
> 
> thanks,
> 
> 
> 
> greg k-h

Yes, everything could be put in the .c file, but I think we will loose
clarity.
Please, let me know what you prefer.

Thanks

Akira Shimahara

