Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401E3C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A0B2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPW0uolj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgCRL2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:28:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43371 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRL2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:28:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id n20so16683404lfl.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 04:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cLYM/R1h5w+GOcuz5jjEq4Hd85OEJopjKNWmXG+H+90=;
        b=qPW0uolji+yS7Bzq20Ze8HcuQ19IaLRQF0ojLqmOLWKSWylxMy17nOqu8GwWza0NjL
         p1p5AuLsCF3m7sMDHnKMQPLrm79vzb2G3ZbMjPOkizmDHN5W0Fd1NgVuTvDU9PxyyKtV
         Zw7sV8Y6EwV3n7skiV350VrhR1oNJAaAdCtOFQ+nT7IhJXVrOEgloLW9EP5Autfa0Ux9
         S4zLKzuLPDOx4VXbYUa/Vopp/g4QraHUchE9/29SmKJ5ho5mjGY3gV3qEf/HcPhbiTpg
         qL/AOVrjsSQrNxhpvj652VTTY2B72nu3TJVFKR7fMiE76WGPciCV4y7bdXPCIzcQETbT
         9asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cLYM/R1h5w+GOcuz5jjEq4Hd85OEJopjKNWmXG+H+90=;
        b=oYkUijVzOYAfLxtZjxMrYBdpOiYQx1hpSSKlJ1d1mLxGcI6EtqPJGo6EfmmGzpuASd
         NuvMFnax755Rgspj1HdpluEP/SAxluz+M3R3eiU5QyH1+gJYsL0taYE2qauB4BrPuy7B
         3Gp28UtC3EEzUWC7by5q2RlHd1ufeI2FBea4IPT3XmkrXvL+FpW4IaWiWgvBalH6VU0T
         cD1iRE4ZoMAWstHKl9ue4ArH7wqwwwplhw/xz6sefZQYlxaI66/JZvo5aviKrm+KVY/v
         5GcsoziBQHRrURqbULiJFHRymwx91fbsFGv/HV1sdrTzbA+vD24qqRpkzvqjWLvQVIuf
         z4xA==
X-Gm-Message-State: ANhLgQ213OgZdQtomkTpX8x2yO2YoM42Ae3ZVtQ8xDS1NOIWTst2qAaj
        MlCX1v+9CqXXap1hA/+m/yw=
X-Google-Smtp-Source: ADFU+vstEvMOMKalLvAvCKwrSIizTk63jrV6hhjdTL0mGBT0dhx+rr6l/6OfnnlJNMmBDmqOjYNotg==
X-Received: by 2002:a19:6e0f:: with SMTP id j15mr2648989lfc.76.1584530896236;
        Wed, 18 Mar 2020 04:28:16 -0700 (PDT)
Received: from uranus.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id f8sm4379449lfc.10.2020.03.18.04.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 04:28:14 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 87C14461840; Wed, 18 Mar 2020 14:28:14 +0300 (MSK)
Date:   Wed, 18 Mar 2020 14:28:14 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/4] ns: prepare time namespace for clone3()
Message-ID: <20200318112814.GQ27301@uranus>
References: <20200317083043.226593-1-areber@redhat.com>
 <20200317083043.226593-2-areber@redhat.com>
 <20200318105747.GP27301@uranus>
 <20200318111726.u2r3ghymexyng5nn@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318111726.u2r3ghymexyng5nn@wittgenstein>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 12:17:26PM +0100, Christian Brauner wrote:
> On Wed, Mar 18, 2020 at 01:57:47PM +0300, Cyrill Gorcunov wrote:
> > On Tue, Mar 17, 2020 at 09:30:41AM +0100, Adrian Reber wrote:
> > ...
> > > +/*
> > > + * This structure is used to set the time namespace offset
> > > + * via /proc as well as via clone3().
> > > + */
> > > +struct set_timens_offset {
> > > +	int			clockid;
> > > +	struct timespec64	val;
> > > +};
> > > +
> > 
> > I'm sorry, I didn't follow this series much so can't comment right now.
> > Still this structure made me a bit wonder -- the @val seems to be 8 byte
> > aligned and I guess we have a useless pad between these members. If so
> > can we swap them? Or it is already part of api?
> 
> It's not part of the api yet. We're still arguing about how and what we
> want to pass down.

I see, thanks for info! So I think we could swap the members.
