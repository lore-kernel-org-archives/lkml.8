Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AE4C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4A92469C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qsxn4Hk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgB0QCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:02:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41142 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgB0QCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:02:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id t14so1316037plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 08:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9WYvJWXMZ+rcEfofeSJpHlDz/l6UP/pgxaBPI0bVL+I=;
        b=Qsxn4Hk1uahykr+QWbXHItx2AejCBY1osUAbIGB78L1sCo7B6Il4l6DND0mh7bGD0P
         VEphLT6LKCT7GeIYw8JhWS4IdRBHN9OjLD6OTWcRutDRZdUgwuaqV/hwpz3zxaBidUgO
         ggRjZ0IGbj3DcO3j9UNLtGA9Bagw1dMPj4wqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9WYvJWXMZ+rcEfofeSJpHlDz/l6UP/pgxaBPI0bVL+I=;
        b=LslSGSHdpyydQ1EtqJh6TYL7HhL98mQtD9yGeSZFzl9AsPQWpqRsVj6ycwso1HMBeu
         NHD6ZHgJZU0S0EgDgNN1R0ueVhJdiwnspH7/Rjdj/EKBIRMfr+AeouKaPKy8QGTnyj3n
         80ems3oj91BZI/kDlNkLN6j9czSnv6xf8N1lWh7o91Bo4LCqMiHExK1NoGNqNt9hr8t/
         tGY+UqQTlaGYEjJepTUSWPrnGVFjTAbHcGWNi5VhxQTYQVnRdOSN4w2zHt8G2W9EWvHo
         ama6ljrR7zRLR7pC05rCEgYvjlUfdYkhGFhyKYZHJeMttMkZRpLZfVBcbFztcxKPcUl5
         MYYw==
X-Gm-Message-State: APjAAAWFKaH4Hjgv5fdeGhhT4OuvnDx3xJBFOvYZtkklURooyO68nQxq
        U3THs7GHpmCOEx0OgAVzBJdqWw==
X-Google-Smtp-Source: APXvYqwuoISNzfA3MpWinuXHZq6onkj6FotCRgoAwXWcPcaWOvayXN9eZRYUoFiSP4YFJQB9lCtKzA==
X-Received: by 2002:a17:902:265:: with SMTP id 92mr402833plc.292.1582819359541;
        Thu, 27 Feb 2020 08:02:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 5sm7682612pfx.163.2020.02.27.08.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 08:02:38 -0800 (PST)
Date:   Thu, 27 Feb 2020 08:02:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        dyoung@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, arjan@linux.intel.com,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH 09/11] kallsyms: hide layout and expose seed
Message-ID: <202002270802.1CA8B32AC@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-10-kristen@linux.intel.com>
 <202002060428.08B14F1@keescook>
 <a915e1eb131551aa766fde4c14de5a3e825af667.camel@linux.intel.com>
 <20200227024253.GA5707@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227024253.GA5707@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 10:42:53AM +0800, Baoquan He wrote:
> On 02/06/20 at 09:51am, Kristen Carlson Accardi wrote:
> > On Thu, 2020-02-06 at 04:32 -0800, Kees Cook wrote:
> 
> > > In the past, making kallsyms entirely unreadable seemed to break
> > > weird
> > > stuff in userspace. How about having an alternative view that just
> > > contains a alphanumeric sort of the symbol names (and they will
> > > continue
> > > to have zeroed addresses for unprivileged users)?
> > > 
> > > Or perhaps we wait to hear about this causing a problem, and deal
> > > with
> > > it then? :)
> > > 
> > 
> > Yeah - I don't know what people want here. Clearly, we can't leave
> > kallsyms the way it is. Removing it entirely is a pretty fast way to
> > figure out how people use it though :).
> 
> Kexec-tools and makedumpfile are the users of /proc/kallsyms currently. 
> We use kallsyms to get page_offset_base and _stext.

AIUI, those run as root so they'd be able to consume the uncensored
output.

-- 
Kees Cook
