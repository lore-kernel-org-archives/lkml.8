Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1E7C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A8C206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNMhJyTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgIDHni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgIDHnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:43:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B5EC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 00:43:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so3919310pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 00:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tQaAklUi4mOHolVXLrurT6V8jWl51s1fx1oUnBoO5Jw=;
        b=bNMhJyTsoVn1gKktUBUxgiXMXLoUoVG4WJERz+LrnRQFWwPg3JjS0tDQIlZJR+RSjF
         Roo8emi2j4ZW2gCmGswCZGlg7atyt9XdJD/n68RuwLxnIeMBUkPhFvsd32ye7MXFdeUD
         STKGEIxy6HzCwU1xvNkntsaqMoSP9ZToLTi/zPMI6sRgNp7xJnMMUiG2iZvlJFSifiV3
         KVUR7DufJU48KbT+p+tnQxPK37ia9MdBudy5LoWlj6dheB4xbwVNvzSJS4GvI8UjrcwA
         T8dFV3nBdz1l4TYPvDn9u4qWdFIcKIV8gqgx7RgnD8xEl06D9orcNbA5X62k5lnZjU5N
         pNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tQaAklUi4mOHolVXLrurT6V8jWl51s1fx1oUnBoO5Jw=;
        b=AG1zh+w7wdRUdgiwmzp589Hwvjsq2qBV4lr2kME2UeyqPne6Iiyr3/5hP1Y4g9vmKg
         v7plrOxAo1gG9RYRq+4TV7MnUWqduNltkulJWdEVdomu5vtLiHT3aM+lWmbcl/p18G8O
         7WjpUC70K3qS4FCZfHAo/6H+rckjX18ZLj/OJ0LxTNIvDTEOUjqkMUnVxTE6/Lc2J8S7
         IqUagpRHb/bndJmN9hIX1/skvBcdNsaZv5J0DT/NV3B1AqWx3t952T2+wuXeaTEvTWMg
         D5CtsULm2cH4T7fFA9wDAJ3dPcgY/5vhBA5pmMLKx/UHTgBG48oa7ectq0ecLcUA9bdI
         Lwow==
X-Gm-Message-State: AOAM533u6htOFdR5muHJI39iDHFUoFBSIml6cqJQnIyUi8G8BpwR10pX
        FAFapMpz0WhB9RrHgwmsuKM=
X-Google-Smtp-Source: ABdhPJy0dpwBb+ewWrTMHGfbTGgK2HDi3d1BTNRXUiZ+npxFGNhc8qLtFmhm+EKDyVc956Eq+vUnTg==
X-Received: by 2002:a63:ca0c:: with SMTP id n12mr3215793pgi.209.1599205416920;
        Fri, 04 Sep 2020 00:43:36 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id b20sm5966248pfb.198.2020.09.04.00.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 00:43:35 -0700 (PDT)
Date:   Fri, 4 Sep 2020 16:43:33 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        threeearcat@gmail.com, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pty: do tty_flip_buffer_push without port->lock in
 pty_write
Message-ID: <20200904074333.GA410@jagdpanzerIV.localdomain>
References: <20200901120157.3412245-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901120157.3412245-1-asavkov@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/01 14:01), Artem Savkov wrote:
[..]
> It looks like the commit was aimed to protect tty_insert_flip_string and
> there is no need for tty_flip_buffer_push to be under this lock.
>
[..]
> @@ -120,10 +120,10 @@ static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
>  		spin_lock_irqsave(&to->port->lock, flags);
>  		/* Stuff the data into the input queue of the other end */
>  		c = tty_insert_flip_string(to->port, buf, c);
> +		spin_unlock_irqrestore(&to->port->lock, flags);
>  		/* And shovel */
>  		if (c)
>  			tty_flip_buffer_push(to->port);
> -		spin_unlock_irqrestore(&to->port->lock, flags);

Performing unprotected

	smp_store_release(&buf->tail->commit, buf->tail->used);

does not look safe to me.


This path can be called concurrently - "pty_write vs console's IRQ handler
(TX/RX)", for instance.

Doing this

	queue_work(system_unbound_wq, &buf->work);

outside of port->lock scope also sounds like possible concurrent data
modification.

I'm not sure I see how this patch is safe.

	-ss
