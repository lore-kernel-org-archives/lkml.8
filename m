Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C62C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C641820870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588890362;
	bh=QtYWifQxruRicMYlWxBFETeDcMT2YeYKexFYi3DgWKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MfWXyQuWOw5ZKoESTNjcARFpIP29IgAGIBOaeItk+2UzdO8ebDpo8Y/g0WVv4xPHV
	 aDilvOUNDm+p2RfoatxFBbB65gDmvHEf4rB8j5QPkv0FkVBU7O8Fp9MFPK9h0JeGdq
	 yN7/57wqGx75jfcRVVM5youJAQEcjHLQW7s7ZQQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEGW0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 18:26:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35098 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgEGW0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:26:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id f8so2666913plt.2;
        Thu, 07 May 2020 15:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DZd2V6aZzC95wLlSgPEBXlyeRSaAQc/BSqmBsSSCJnY=;
        b=Mn907trl+04MmBXU84WKRAQT1FD7GWoxusIl9dCBVbp/AahOB7DwgnAQ/kpNIPh4OY
         s9ICGmGWRFlrgtjzDWo6CRQnq+IxgHaPJdeMr4+iB78w88SgyfklLk8uQ9Z8KYY4ZP4b
         XfNjUjCayU/bN5L0x2hxqOC6dMNjgZT10UnctORR4Q4kAyOln2mAkKW8tCrg9JHQJlZf
         eaFg2Bx+/4c2eVqrr/7N/YLbvSVlsyZTB2ruuYTvlibqF18vSI4vQJjjCWLQ7EJJTGaO
         bqO58PCHIMfSEdHo3TGGdqqzQ3ar+uOnqnlAvVcU8+18JrkVqJDU4jH2p0USaiaR+ivh
         K7qQ==
X-Gm-Message-State: AGi0PuYEDYBPA05+Z+kZr6A1Lk+Sw1zfO8QqtPA7+WmN7BXOAzawfMHd
        0yjOSRQ2sCbkbWEmSC1+zDU=
X-Google-Smtp-Source: APiQypIPwdzfOMX951uSbn33ONVVuG6n8WfUdh7gFNW66WEA5AQCyAZiEcEcEVoNy/HcIubnSplBmw==
X-Received: by 2002:a17:90a:d3cc:: with SMTP id d12mr2582928pjw.158.1588890360942;
        Thu, 07 May 2020 15:26:00 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h5sm769234pjv.4.2020.05.07.15.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 15:25:59 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 04A1C403EA; Thu,  7 May 2020 22:25:58 +0000 (UTC)
Date:   Thu, 7 May 2020 22:25:58 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Tso Ted <tytso@mit.edu>, Adrian Bunk <bunk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Jeff Mahoney <jeffm@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Jessica Yu <jeyu@suse.de>, Takashi Iwai <tiwai@suse.de>,
        Ann Davis <AnDavis@suse.com>,
        Richard Palethorpe <rpalethorpe@suse.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org
Subject: Re: [PATCH v2] kernel: add panic_on_taint
Message-ID: <20200507222558.GA11244@42.do-not-panic.com>
References: <20200507180631.308441-1-aquini@redhat.com>
 <20200507182257.GX11244@42.do-not-panic.com>
 <20200507184307.GF205881@optiplex-lnx>
 <20200507184705.GG205881@optiplex-lnx>
 <20200507203340.GZ11244@42.do-not-panic.com>
 <20200507220606.GK205881@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507220606.GK205881@optiplex-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 06:06:06PM -0400, Rafael Aquini wrote:
> On Thu, May 07, 2020 at 08:33:40PM +0000, Luis Chamberlain wrote:
> > I *think* that a cmdline route to enable this would likely remove the
> > need for the kernel config for this. But even with Vlastimil's work
> > merged, I think we'd want yet-another value to enable / disable this
> > feature. Do we need yet-another-taint flag to tell us that this feature
> > was enabled?
> >
> 
> I guess it makes sense to get rid of the sysctl interface for
> proc_on_taint, and only keep it as a cmdline option. 

That would be easier to support and k3eps this simple.

> But the real issue seems to be, regardless we go with a cmdline-only option
> or not, the ability of proc_taint() to set any arbitrary taint flag 
> other than just marking the kernel with TAINT_USER. 

I think we would have no other option but to add a new TAINT flag so
that we know that the taint flag was modified by a user. Perhaps just
re-using TAINT_USER when proc_taint() would suffice.

  Luis
