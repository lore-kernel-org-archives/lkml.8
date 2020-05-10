Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A622CC54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 08:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F4920731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 08:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgyM0uEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgEJIy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 04:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgEJIy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 04:54:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC416C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 01:54:55 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id m24so4876861wml.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5Vl2qnoxmz4J1T3BwDEq6p32/lbj7LmoRoectHz7xv4=;
        b=MgyM0uEIM08c5kcwdVasYDB523brr2LQLC5Zs8+pprm3s7w4q9vZbABZYdUsBYeWtC
         pPWdzGNQJn3BPs6EmbPRhTBHiTmG6LIL8pEe75V2NMOn3ei+Qu5yFrIp8BbE8ob8ERk3
         6L4a1EnxqMv40MKsdEd+j2gPb0ey3X4gmSi2uoTxhmQXJyZ8UUn0Aftoettksj88gFPZ
         3xCIpNgPzKqK/mA0k0bhEBpyk56u/L0fmo1KjQkU+WnxWXbSICloNhxXHusGh+xjObRL
         TlqesoEEHg+8yqZip3LYTbE+kLv2Zd0+vOBlC1QNOQXpCO6B0mUq51617Q2Cr5gdbF00
         Au+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5Vl2qnoxmz4J1T3BwDEq6p32/lbj7LmoRoectHz7xv4=;
        b=QOPt2kVOnjYoy4BykFjXo/Zh0He86Vu4EuTU4MmX4oiTMObozwoK4Xfld/eT6ot18N
         uVjp0gRGFVp9CX59Rksh2KoVNHfYF5U4I0r5+m0ovfNER1uBX3kdW00i8UJTkEg1jeLE
         1UoNnSQd3CD9qCcLvmKKRo1Qk+sMJ4BJgitWQ4EQy1PzfEHfBul4RFhbsVQpOPd4xGEw
         AsxGrONoWRb2zp1OAYuFMK64Mxp2fbo6NxN3XxwVkCqAM7ZRLQ6aJM2GChgYvm/8tikx
         o0HMn/9gzdjFfIyqFAW0r9ZlIJSwjmQ6ZvRl4ZUcZCeu2hoEsxg1SP88TVCBW2xeaNsR
         1QUg==
X-Gm-Message-State: AGi0PuZLTIzSVmjnarnTsqmidA1mJSqd6nV1p+zmYcRlzCYzMoRServh
        zsaen4PogHmRWLqJEAu7u50=
X-Google-Smtp-Source: APiQypI9RliZWU4CpeknmxR/rBXOeQUjvri7Mw8qyTEY1m2TgHUteaROcezGOQ27HQeQ4gAfpTs6Vg==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr26245766wme.126.1589100894450;
        Sun, 10 May 2020 01:54:54 -0700 (PDT)
Received: from akira-laptop-2-1.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.gmail.com with ESMTPSA id 17sm20657087wmo.2.2020.05.10.01.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 01:54:53 -0700 (PDT)
Message-ID: <fab87953187dd8b2c9d2bc6f8ea4f1e8042a8ac0.camel@gmail.com>
Subject: Re: [PATCH v5 1/9] w1_therm: adding code comments and code
 reordering
From:   Akira shimahara <akira215corp@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>, greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Date:   Sun, 10 May 2020 10:54:52 +0200
In-Reply-To: <eb73984b-8317-a0e9-90ed-2956d3fbc6b0@infradead.org>
References: <20200509235742.422652-1-akira215corp@gmail.com>
         <eb73984b-8317-a0e9-90ed-2956d3fbc6b0@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 09 mai 2020 à 19:26 -0700, Randy Dunlap a écrit :
> > +
> > +/*----------------------------------Structs-----------------------
> > ----------*/
> > +
> > +/**
> > + * struct w1_therm_family_converter
> > + * \brief Used to bind standard function call
> > + * to device specific function
> > + * it could be routed to NULL if device don't support feature
> > + */
> 
> 
> Hi,
> 
> 
> 
> All of the struct and function documentation comments in all patches
> in
> 
> this patch series should be using kernel-doc notation instead of the
> above
> 
> (whatever it is; I don't know what it is).
> 
> 
> 
> 
> 
> > +struct w1_therm_family_converter {
> > +     u8              broken;
> > +     u16             reserved;
> > +     struct w1_family        *f;
> > +     int             (*convert)(u8 rom[9]);
> > +     int             (*precision)(struct device *device, int val);
> > +     int             (*eeprom)(struct device *device);
> > +};
> > +
> 
> 
> thanks.
> 
> --
> 
> ~Randy

Hi,

Well noted, I will do it and re submit the serie. Thanks for your time.

Akira SHIMAHARA

