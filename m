Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D8FC2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174D620772
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BAoU/QSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgCZHVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:21:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34983 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgCZHVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:21:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id g6so1816625plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nFKrUEgeFa7EbhKVQYAD2wP/31kNz1QwptTeG1sEwow=;
        b=BAoU/QShY6ywU3pTWp1V9cChIjzV8h5Z2dICalBhYAji0uRIBMWN+0ukKItBUNd6Xs
         wrjaYp9RpQG3zUspc+8FvPKincpU6/Ue05WbJvfgDbkfUqECTXqNLnKKBbSPk0gb6y9C
         FQ2g6g6XgCa+cXCJ6Sp5AxnFS7G5GwjNl+4Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nFKrUEgeFa7EbhKVQYAD2wP/31kNz1QwptTeG1sEwow=;
        b=eTUMN6F1HKobX+VGaKPFC/sfd+H73p8I5beKO9a/9Ev0CXCIH+PHcL5TOEEw2Px8vO
         Y/B8pndvhzdqGytPiw29yl0DW9dmOP6BiQH+zszssHUgmJx5NpMiNJHfAs1UD6GRQb3t
         nPiaVaPydHhF2odm4w5WKbAlEdzoTvgnFqR3EGIbc4tbCz4buIRm+nPgb9C7MPUku186
         W9Aj2O8ah4uvjyhwHYa8x/7lvtEuU3e1ZmN7XWHSJZqd/0cbKlBT1wJQ3N+2MHYqNSmc
         eJRxL2hdV0Roj5YSOikLc28Epwtxy/hcMjc2v8I8M94I/7BzKwDcpX393KCObr1xcCD5
         ZROA==
X-Gm-Message-State: ANhLgQ0aw1+9y6ZUAMDBrJD2ZeTJtn8RcjHR7S8VgHRw7FWlEcVRIkU5
        atZCmDggHlLiw4oVX6rMWxblmQ==
X-Google-Smtp-Source: ADFU+vsRXQ2gRszQo8R/li9R/yQ8ZllZsAs3VyIOYY8ZCPe+z6YoAiBt8mcHHzlQCiWmcataarR3/w==
X-Received: by 2002:a17:902:b692:: with SMTP id c18mr7014861pls.7.1585207292475;
        Thu, 26 Mar 2020 00:21:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r4sm922290pgp.53.2020.03.26.00.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 00:21:31 -0700 (PDT)
Date:   Thu, 26 Mar 2020 00:21:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
Subject: Re: [RFC v2 1/2] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <202003260018.81648AA67@keescook>
References: <20200325120345.12946-1-vbabka@suse.cz>
 <874kuc5b5z.fsf@x220.int.ebiederm.org>
 <20200326065829.GC27965@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326065829.GC27965@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 07:58:29AM +0100, Michal Hocko wrote:
> On Wed 25-03-20 17:20:40, Eric W. Biederman wrote:
> > Vlastimil Babka <vbabka@suse.cz> writes:
> [...]
> > > +	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1))
> > > +		return 0;
> > 
> > Is there any way we can use a slash separated path.  I know
> > in practice there are not any sysctl names that don't have
> > a '.' in them but why should we artifically limit ourselves?
> 
> Because this is the normal userspace interface? Why should it be any
> different from calling sysctl?

Right. The common method from userspace is dot-separated (which I agree
is weird, but it's been like this for ages: see manpages sysctl(8) and
sysctl.conf(5) for the details and examples). While "/" is accepted by
sysctl, the files shipped in /etc/sysctl.d/ are all using "."  separators.

-- 
Kees Cook
