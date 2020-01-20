Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790C1C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454C5207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579508640;
	bh=kQKcnfRn7+rmv3JAYoARNARUwQvkrLKnkzN90SxtBM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nJoGki0F48xoJw/Wv0LvO5FpiQk0Xynfesj5QCzM8ZGdPvZnZdcPMP3hTGTYPID0d
	 md2XwbpX5RwoLw1Ia/0xDwhzhR5S6xXknRAw61bmla3HIxD7uO7jiTKGCoji5xczoi
	 pT9hTJbGe7o9m4Fj9v0sJyXX5lRaqRYpllxMt2Fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgATIX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:23:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41638 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATIX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:23:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so28486619wrw.8;
        Mon, 20 Jan 2020 00:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FwrHGyihyj2seEiqaEASGusG9d0JoZrwdg+wq7V434o=;
        b=LiUgkF2C1p0uooV5zn/BjaVSlqLnl6O/A7JsUBGwzA3mwO7raq5Sq4PnQahVJPsY+Y
         BXe04ajQkMmbUpb3xkHolLZxP+umf9bZlswfrku5xbzg5x6T7E5ddpDCFuu4LJ+5L3IY
         VF9dTbDgkm344EiQG0+UEsMa0uoJanLMUQG+ausUk3aYzGR4DQcMBdTOr7ntNr8XnPoD
         5kvYTgWxx+c5LhaAjsQFqvUgskNGy8reohls794DK8AqR6Yx/VISn8PA/bAmL2JHF9eE
         tJUCsu+6ejHaUNHxWqPI0MNB3CjiCNEgpgb7b3m58old+Vl8kTQKYz9Zn4Bt5YhJdTRK
         zm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FwrHGyihyj2seEiqaEASGusG9d0JoZrwdg+wq7V434o=;
        b=lOyN4sMumPlbfipbIcLR7aQeG0liJhW2/EgUA9cKss7d6j1KIgDf0pk4s3Yf56+PGh
         ve5ITyF4OlrXQ5ZiS3+TwbrORPFe5sVOSx1YhqRdehkR1x78IVJEazmzySYV2ZVnSK4x
         4sO85sdCEHT+m73jalC7bkzjbmj+fGvAt1uJR1z/tvRg0zQ5N1zw5NO4x+rXXJAPtBC+
         aOTri2Zvk1zT+uu9oG+XXpXL2PQWI+XoMkz5GM+9ZRKY/NXFnldRtFsEZ1Ptdk5Fp3Ja
         DA1/CCpdjTiRenNcuQOAhg9635g9NafIK8vnPRdlIeakH/ShCTcDktXWpB6cDZQhQySp
         bfew==
X-Gm-Message-State: APjAAAWbTjiOz0N8ZCcyKAvvlHGGNA7c/SAeOhHMZ0oCDUai8htyLXIE
        Ln+BsYg90oFI9ejiIQWJXCs=
X-Google-Smtp-Source: APXvYqxYgWT1xzkU520lqDeeTYOWpBCMR7v9mGF+k55JC48JQrjDpLzgxZt1rGwdCPBWrVIlkRghJQ==
X-Received: by 2002:a5d:4692:: with SMTP id u18mr16973478wrq.206.1579508637052;
        Mon, 20 Jan 2020 00:23:57 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id f16sm46675707wrm.65.2020.01.20.00.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:23:56 -0800 (PST)
Date:   Mon, 20 Jan 2020 09:23:54 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Andres Freund <andres@anarazel.de>,
        Cengiz Can <cengiz@kernel.wtf>, Jann Horn <jannh@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20200120082354.GB26606@gmail.com>
References: <20200116134814.8811-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116134814.8811-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 53f3feeb7bd2d78039b3dc9ab158bad2a5dbe012:
> 
>   Merge tag 'perf-core-for-mingo-5.6-20200106' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2020-01-10 18:49:34 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.6-20200116

>  18 files changed, 97 insertions(+), 16 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
