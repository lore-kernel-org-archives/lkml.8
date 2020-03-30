Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4167AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE8F2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IoKCdJlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbgC3Rki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:40:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38785 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgC3Rki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 13:40:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id x7so9000558pgh.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 10:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EIazmoWr1nLxxc8KNs37fnm42F/lDdp4/gYm3JHLHek=;
        b=IoKCdJlIr8dKSUui+FFl2O8BLgUnbJF6UcpsVTBUCUIxnVlSObs8uqbpJtVfo85MHD
         NSMiSHyRzun2Qw2uFSqKhacVvS9T1di6LetUQD1cCrF9rPt/SGxOjvQEku1cIwKpUsK4
         Nyhahu2qk/o5MwyQBOY1XNgL+3twDOfx4D+Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EIazmoWr1nLxxc8KNs37fnm42F/lDdp4/gYm3JHLHek=;
        b=lswpIs17xPJDLmg2RcDf7mW0H08nPgMpIEj4nEhAPSIlrPL5tcGADBPEJYLSIAYw4g
         4AIH2+iyszt6n0tq35w+1Wi+J5L2/5+f9VBJn00uRSB1ndpkju56oDk7X6OzfDPkizVA
         0swu9T5W55RGNb11qBmOIbRWdWkVSCJc6mMiAhCNDXlZcrmmzgZMSjk0KDVfhDE3PPNt
         RbZVf8Wtqu/HcrbQlzb5KA3HBtK+pCY9OB6b213+e/NnXmzdQGo/57DqM5/5JBi9yhBt
         SrsW9U5NHXk5g6zIC03818w0cxtE2CD0jzscVH4s/4JaePQr73zROrKmT3xJ3OE2XFdh
         evDQ==
X-Gm-Message-State: ANhLgQ07Oxyu/EYnXVQuZqfvhunGlZ00Cml2LPN8juFYzSbNolYVCHEP
        FBycct26V5g3EYyJZ5DC1J0W8Q==
X-Google-Smtp-Source: ADFU+vsp6F+mnbmu4oeH1BZE4z851b8UTWueJ6LJmiWqqkcFzAPvDpoG8s71ddjkdVNmXYn/ukbhqw==
X-Received: by 2002:a63:cf:: with SMTP id 198mr14239682pga.447.1585590035454;
        Mon, 30 Mar 2020 10:40:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i2sm10410628pfr.203.2020.03.30.10.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 10:40:34 -0700 (PDT)
Date:   Mon, 30 Mar 2020 10:40:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/3] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <202003301040.E3099A957@keescook>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-2-vbabka@suse.cz>
 <c68b1ed4-51ef-ca65-7128-ff3c8b6b54ee@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c68b1ed4-51ef-ca65-7128-ff3c8b6b54ee@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 06:23:57PM +0200, Vlastimil Babka wrote:
> Boo, all the error prints should terminate with \n
> Will wait for feedback before resend.

eek, yes, good catch. :)

-- 
Kees Cook
