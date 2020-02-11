Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACDAC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 05:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F303E2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 05:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMH574uU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgBKFok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 00:44:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45747 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBKFoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 00:44:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id g3so9553604wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 21:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VF1bXPK5oEmTt3ZiFcaHZFV+yxaXGNeTcRvRNXdxka0=;
        b=KMH574uU0/our/bWIDk7tjF0CUOpdqEXUyxAO0039Q/ScMEEx/kWVTsxYYA62OIBMJ
         D16sPI+yXivoWONcUrA3xZdL1rUTPPpeYcz3nbmI9zgy/a73ecyPFyXmZCLaAdcXYB69
         i3a0KOmy8IF5CZWW3RTO97fleUVR86S00gILgYTZX8Tf5owMYqqc1uN/yKx5RdUKC0Fe
         sb9V24tq0qXoUhCWeN/C7meMGS5QYDDdZEvzasbVecYNr5jCa7daRa85QkGFi7cxwFSv
         6NmstJd1m3eGbo0YNpZRAAtB8eQtI/59xiKQRLGkXIJKl+7MqDuqQ3uCwYQzRC6W5vIK
         o3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VF1bXPK5oEmTt3ZiFcaHZFV+yxaXGNeTcRvRNXdxka0=;
        b=BOjNxIFANlX2Y30Bpfw1hOuTu0/BZLLIG2f7g8pQun3UPnyq9leNxXq9cNpr/pa31N
         41y1aOn1uM2r3pqcWzC4vk3TEIA1+6oHOShXtspo332zzKyDBmw9SfO5OJ2ACQdl+W6Q
         OLw3+GSUy+6HTxVueWozm8ZZbqYVfH2mgxHGjPQRZ1C/eOtd7UkSUTvGVz8TZ2Zg5dEL
         RvK/6tSz0+any+YckGGAqoCkYQDlVRttzGjt5DVEHvcUyTsB3jWoWepfkr4f0UhzL7k2
         uIpFflIALpQ9sYtXKufsYxUc1N07sas15beWyLJrrCK6vmrXd7KMtUqmgA5H2lF9LAbJ
         L+yg==
X-Gm-Message-State: APjAAAXFEiBdK8QrcZNQCtsnasNXWOchFrYtCbXbV0SWrx5a6vrHsVNX
        +MoEivcX9OMpcr+RxkXuCRcmvw==
X-Google-Smtp-Source: APXvYqwAHVf5Ta/OFH/ILekJE7pefp/yafQSgOec2ohu/cK71immVVEQjkV4APbEK3wz/hDLs6Eegw==
X-Received: by 2002:adf:cd11:: with SMTP id w17mr6669549wrm.66.1581399877026;
        Mon, 10 Feb 2020 21:44:37 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id h10sm2283730wml.18.2020.02.10.21.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 21:44:36 -0800 (PST)
Date:   Tue, 11 Feb 2020 05:44:33 +0000
From:   Quentin Perret <qperret@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jessica Yu <jeyu@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 1/3] kbuild: allow symbol whitelisting with
 TRIM_UNUSED_KSYMS
Message-ID: <20200211054433.GB72419@google.com>
References: <20200207180755.100561-1-qperret@google.com>
 <20200207180755.100561-2-qperret@google.com>
 <CAK7LNASMeXjxaj2Hbh420bxBZqVUoa87PtBuu38+fB6aZgJTXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASMeXjxaj2Hbh420bxBZqVUoa87PtBuu38+fB6aZgJTXg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 Feb 2020 at 06:05:02 (+0100), Masahiro Yamada wrote:
> On Fri, Feb 7, 2020 at 7:08 PM Quentin Perret <qperret@google.com> wrote:
> > diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
> > index a904bf1f5e67..58335eee4b38 100755
> > --- a/scripts/adjust_autoksyms.sh
> > +++ b/scripts/adjust_autoksyms.sh
> > @@ -38,6 +38,10 @@ esac
> >  # We need access to CONFIG_ symbols
> >  . include/config/auto.conf
> >
> > +# The symbol whitelist, relative to the source tree
> > +eval ksym_wl="${CONFIG_UNUSED_KSYMS_WHITELIST:-/dev/null}"
> 
> What is this 'eval' needed for?
> 
> This worked for me without it.

Right, it is there to expand the path in cases where the user sets the
option to "~/my_whitelist" for instance. That could most certainly use a
comment, though.

Thanks,
Quentin
