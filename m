Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F4BC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3809420768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQMcUSiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgCRK5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:57:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44683 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgCRK5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:57:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id w4so11751476lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nV3Qdu0HYWee3j5+6+aGekWI3rUXVXUf4iMVPL1IdEw=;
        b=vQMcUSiu8Ef0t/A+g7adc3drzAiCtfzj33O0acSrVOG2GH/5HUcySiy/OVWguyqDH8
         6q4v6t92onicU3oTLVR4CXmPiztXSa8MgRhdKRrkBmkRBwKelns6VtY0l5Zj66cDOTzZ
         tWV6S3ScsVbJYqgW3yeSzxir4h8mLgggfwYzxGjhHSEw4Oi4uxi2lNWHiiszt6+EMbK7
         cljVksEQPxpT8QkS8aqy5jFCYesMSUO6c1ioO9QziWcEDhjP1MzIS0P+KgDrPZ3YPDe1
         Y1D8pJS8UkGfI4p31s2MqwDM8AQZDLCCcgaGnZ6/pddL86EplPtt9qmLIVfm9BCP0UHW
         2Qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nV3Qdu0HYWee3j5+6+aGekWI3rUXVXUf4iMVPL1IdEw=;
        b=mRiNJyaMCagTY3Y+zEcD0shQPVe5qRBTZBR9ZC6rtpG0GD8n2mDu7uysbFs+nFAB8G
         K3I4Gc8DPGh4u0D8Vu/l0+4WlPlcWYCWlfwiQDerbsgq5iQW9w4c8Fe6AoXen1wZQKJ3
         GOkFPniZ1JpkO7zEorO1XUaZN5iXSH7CKBJnq2PtcnfxU9AShdkTlxkmF2yXszFo6s/G
         lOGBgQJhcpE4V3iFewWgUgj7RwHWLSFlvh6P6gS4FdZLivYjbFwheE+VxRWDMjXbm5/h
         IWBPwgnUoMpSHc+Y74p2pZxkitCIsGBdcvNlLhy7madYzu79naUCZushHCaU7xyMtNk/
         3KEA==
X-Gm-Message-State: ANhLgQ1rA24x00dCprkGwm6DLyX/QdKWz729NQYdW0QySfwFuWUBj2Yo
        lWs82iEZyN1sLd+LhAwSjcA=
X-Google-Smtp-Source: ADFU+vuAMc40DsHrVvUWs8uz714p07itpr22m3meWGZtkyJFaun/GQtn3rU5sYmCyq+9r9bJMr3lxA==
X-Received: by 2002:a2e:b60d:: with SMTP id r13mr2056552ljn.185.1584529069502;
        Wed, 18 Mar 2020 03:57:49 -0700 (PDT)
Received: from uranus.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id t1sm4114152lji.98.2020.03.18.03.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 03:57:48 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id BC321461840; Wed, 18 Mar 2020 13:57:47 +0300 (MSK)
Date:   Wed, 18 Mar 2020 13:57:47 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
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
Message-ID: <20200318105747.GP27301@uranus>
References: <20200317083043.226593-1-areber@redhat.com>
 <20200317083043.226593-2-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317083043.226593-2-areber@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 09:30:41AM +0100, Adrian Reber wrote:
...
> +/*
> + * This structure is used to set the time namespace offset
> + * via /proc as well as via clone3().
> + */
> +struct set_timens_offset {
> +	int			clockid;
> +	struct timespec64	val;
> +};
> +

I'm sorry, I didn't follow this series much so can't comment right now.
Still this structure made me a bit wonder -- the @val seems to be 8 byte
aligned and I guess we have a useless pad between these members. If so
can we swap them? Or it is already part of api?
