Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95047C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6475B20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580477845;
	bh=KqKKJ7/yhRZmAEh2+ibnaTqsXl65EgR8PZ9zxyx3Enk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T5gAYBxRe6esZ1TQwEZlZ5+zXpCJWpfWfcDHoSUHTaeTAbcLx9smhjNP7VFUmdgak
	 rYVPeEcId07fYKEtqDeSYuEcTz3He5oWkZU68/p59pM8ujqYblPl94hGlL2mVtsZfl
	 5aRrVgMFEXIIebb6rIF93PkqQqyo+QR24kXKCYCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgAaNhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:37:24 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46314 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgAaNhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:37:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id x14so7060817ljd.13;
        Fri, 31 Jan 2020 05:37:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/KmFerTMrLQTt2owFkJV50/D5+cJT9X+Wd/6C7uz3Ec=;
        b=bRRmAK9ZfpdBVFKcUBnoQye4cfhiPjwR2BAEEKodDRqQTcSnzTPUXknMU/p+W9zLAd
         COXUIhRrDhWgLaUv8VmZG8lR3gqzh9AWP+zzQwlanFEAwce3EDYN/YwyEbiwLOXNG2YC
         JLGdQ5e/qVux4iQewc1kZA78j+EEZm1ayOHubAkcPPrbJLOOB+8kMeE4zvyV2rEY5sl0
         fuW678gvn0nJCI+Ykl0K04gw3+ANpa5aCwwzN924sGuCYFZxFTm4hykTwDRKUB7D17WS
         umFyDt5kOcl9CHTXBxBE3H6QVIfjZNyAeeVs7L2KXoxmTxjWXZuyzMQGsxB1qi86h72h
         D5PQ==
X-Gm-Message-State: APjAAAV+eH/e3mSz+PSBVT1L1EScYrphSbJe6ksoqn5BHz50Q6speELd
        XRFfSJAeN2FvQzaLstd3RWI=
X-Google-Smtp-Source: APXvYqxOCliooekvLeL52WUPxjK2FtRWB9QFwu7qunXvZLWFKp1TSq8LfW0dNc9qdr/aRPTNJkM+NA==
X-Received: by 2002:a2e:3609:: with SMTP id d9mr6069080lja.188.1580477842351;
        Fri, 31 Jan 2020 05:37:22 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id h19sm4736692ljl.57.2020.01.31.05.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 05:37:21 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ixWUA-0005cm-DW; Fri, 31 Jan 2020 14:37:26 +0100
Date:   Fri, 31 Jan 2020 14:37:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hillf Danton <hdanton@sina.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        ingrassia@epigenesys.com, LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] usb: core: urb: change a dev_WARN() to dev_err() for
 syzbot
Message-ID: <20200131133726.GE10381@localhost>
References: <00000000000095e1d8059d4675ac@google.com>
 <20200131090510.7112-1-hdanton@sina.com>
 <20200131101644.GE11068@kadam>
 <CACT4Y+YmUBUzZQNrHZtCV-LDxvmgoJtaoPYYP9OgRpAa59qF-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YmUBUzZQNrHZtCV-LDxvmgoJtaoPYYP9OgRpAa59qF-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 12:19:39PM +0100, Dmitry Vyukov wrote:
 
> I see lots of people also mention panic_on_warn in the context of
> these reports. panic_on_warn here is only a red herring. It really
> does not change anything. We could remove it, but still report
> WARNINGs. But syzkaller also reports some things that don't panic
> anyway. This is really about the criteria for kernel bug vs non-bug
> (something that needs to be reported or not).

Mentioning panic_on_warn is relevant to determine whether a fix needs to
be backported or not. Some of the bugs in question are mostly benign in
the sense that they are unlikely to crash your machine, but we'd still
want them in in stable due to panic_on_warn and automatic testing.

Johan
