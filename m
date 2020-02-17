Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB89C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB14A208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+zAvmD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgBQPa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:30:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32812 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgBQPa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:30:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id m10so155395wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 07:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xLlxKzyyWAgwu5oWmWZ61hqmpwUHLeY8xWAp5SqH8Fk=;
        b=S+zAvmD2yQ1EwqGwVy0jNbBc/JnoNJtkB7V+I0iY30+puKcRQ3ibMXnxTnI79NBIPE
         PLm14M2VSI6EuVv7CGUCMbgYGg9aIm5S7xF4Lk0eegbEUVAsYTCKV9JcR+V+DNmr3cy6
         iwGrFgpx7er8cqaKL7Dt7x7Lhss8M8PtD74WBQV3mV90uZhRfGIesDOTk1PtcEnDZNSp
         zjqAhvujcP5bT+MYRei5SqUF+TopSAO0XMC2CaO08i49zKAcBSiCnfPLGL6wXozD+7hF
         Wp4l4kYz1X4RvhVrO3Im3P5kC7zPp4RNiQV3iODXhVppVxoaxO0VwdWJw1d8wtgM3WSS
         /WiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xLlxKzyyWAgwu5oWmWZ61hqmpwUHLeY8xWAp5SqH8Fk=;
        b=pbX9z2hF/fn0up92xZsp0qwcv+KaLgAo3A7eBw8T0PEZG4pqW1Qnpyvol6naMLEGix
         pdYRaRYXb4KNiGjgMM7R8OgEPJV3bumfOUVozs/mQ1PY0IJBEoVmoAl3lpwd+hqBialw
         4DQUC4GHR2EWAfYpvy9QxmeBl187xQfaabhT3kzDxtc5i08SAvyeYiA/zahCeJr7AaXo
         bNwSKO/8qk8UO9GR99Vdfye9ZyBD/ae9jRpIV6EwrXYWcgGu9o7J6c2TGrfpHbRKLmfT
         SzC8qyQtJco9J2yP6gDCiTZ7Kw013csnzEwbBI8h8SSt0WUPGGg6+B7rR4f5fYYLyEKm
         NS2A==
X-Gm-Message-State: APjAAAUYH81u8+toyDxGyj3YYSUSz+JyDWWQbt/R9JvgdHQH1hNJFim5
        L/vZx6p5XX4BgI9q0eapF3F8LQ==
X-Google-Smtp-Source: APXvYqxFsYONLB2eCep9N5wM8fW7Ek2DFoknrAl5SFMesGmI/IiJ1wKNf+3vSFg32VOkzIHYOamlhg==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr22547282wme.130.1581953427019;
        Mon, 17 Feb 2020 07:30:27 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id y12sm1436973wrw.88.2020.02.17.07.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 07:30:26 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:30:23 +0000
From:   Quentin Perret <qperret@google.com>
To:     Matthias Maennich <maennich@google.com>
Cc:     masahiroy@kernel.org, nico@fluxnic.net,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        kernel-team@android.com, jeyu@kernel.org, hch@infradead.org
Subject: Re: [PATCH v4 1/3] kbuild: allow symbol whitelisting with
 TRIM_UNUSED_KSYMS
Message-ID: <20200217153023.GA71210@google.com>
References: <20200212202140.138092-1-qperret@google.com>
 <20200212202140.138092-2-qperret@google.com>
 <20200217152201.GA48466@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217152201.GA48466@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 Feb 2020 at 15:22:01 (+0000), Matthias Maennich wrote:
> In case the whitelist file can't be found, the error message is
> 
>  cat: path/to/file: file not found
> 
> I wonder whether we can make this error message a bit more specific by
> telling the user that the KSYMS_WHITELIST is missing.

+1, that'd be really useful. I'll check the file existence in v5 (in a
POSIX-compliant way, I promise).

> With the above addressed (and your amend for the absolute path test),
> please feel free to add
> 
> Tested-by: Matthias Maennich <maennich@google.com>
> Reviewed-by: Matthias Maennich <maennich@google.com>

Thanks!
Quentin
