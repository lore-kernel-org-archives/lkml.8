Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714DDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B11D2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="QLBgRrCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391164AbgAXSDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:03:34 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35238 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391132AbgAXSDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:03:33 -0500
Received: by mail-pj1-f67.google.com with SMTP id q39so176304pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KYYV9rcdEb+nT+n76T9IL2Mvjnz++gVjwO67Ed6lDIA=;
        b=QLBgRrCRV3Qrx7BRCpYBc1z6C+go7OJtBBMTk2vteQruNfk+Jb4+PlqJWk6jwdNFO9
         Vw2yUcc/MCqfZTQ7O6Iqm/RGOxZOBFCNJ6kCB7uJEIIlLDpt/qm2YX1+QHI0GYc6jiTu
         +qzBhavepYUedI7ys2+YwQW/Bl+IVfsxJR0cnDnVJ9ED/qsqfOra6kyi8LhDIYt4kxy7
         5Xj2aDsQ4WI17egTXDEFzF/O4IuypL8PFT07s029KMwqFmjLcdgGszHc7iny2Ynu33ot
         cLpN+/Ki10iyRJlbelw5tEM189ZIgkpyZlt5eCKwGw+flz72N+3qAgZ0fIZpiTfHgC+G
         DToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KYYV9rcdEb+nT+n76T9IL2Mvjnz++gVjwO67Ed6lDIA=;
        b=Fi/9neNZYzd4a7Mmm8G5pXKWE8D4vFkOxNDH7hdqZYm7AEWTjLpIcYckVpSigLi3OR
         UWeac2/qaBPLLQYj0i+ZXrloHc3o3nEli6fBqELQyYEkpArH4F+1xhZIQQL6+cuZYxR0
         mQR1pQ54LQSszeQIi2OvuIGpMHikv9DvWsMnoOVzaLwreXa4bA7ufVJE77c0Un7DqsVn
         piBZnqw93ZU6AVJ28RZD61vooKulnvJoDl6l+IEdG3MLi/eZvpbMUovDuUB52nXhOOEC
         nGQIowbLc/HcYQ4cp7+HztEKHs3rK8CFMjdaMqVpmMzUOuT7dhVGsLiQT5dEws/GDdTH
         AaOQ==
X-Gm-Message-State: APjAAAUcx+O3yF7a5Gsmb0ua9thZeoMsTx0462F7VfvBcQpb2hAjVyCb
        x+/z7PbNdTEVs5sXXlmH1uGkaQ==
X-Google-Smtp-Source: APXvYqxzwjaX46e/1fUSjuFqRje3gg6dT16MaHtJeX4pLiTiDcr2YsyJMPFPS/RCb7fTnNGkezX5Jw==
X-Received: by 2002:a17:90a:2763:: with SMTP id o90mr459921pje.110.1579889012413;
        Fri, 24 Jan 2020 10:03:32 -0800 (PST)
Received: from cisco ([69.162.16.18])
        by smtp.gmail.com with ESMTPSA id v15sm7022881pju.15.2020.01.24.10.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 10:03:31 -0800 (PST)
Date:   Fri, 24 Jan 2020 10:03:32 -0800
From:   Tycho Andersen <tycho@tycho.ws>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, christian.brauner@ubuntu.com
Subject: Re: [PATCH 3/4] seccomp: Add SECCOMP_USER_NOTIF_FLAG_PIDFD to get
 pidfd on listener trap
Message-ID: <20200124180332.GA4151@cisco>
References: <20200124091743.3357-1-sargun@sargun.me>
 <20200124091743.3357-4-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124091743.3357-4-sargun@sargun.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 01:17:42AM -0800, Sargun Dhillon wrote:
> Currently, this just opens the group leader of the thread that triggere
> the event, as pidfds (currently) are limited to group leaders.

I don't love the semantics of this; when they're not limited to thread
group leaders any more, we won't be able to change this. Is that work
far off?

Tycho
