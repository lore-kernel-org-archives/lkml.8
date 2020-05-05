Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399F4C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5CC20735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+jlWyYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgEEMhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728268AbgEEMg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:36:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C740FC061A0F;
        Tue,  5 May 2020 05:36:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v63so815222pfb.10;
        Tue, 05 May 2020 05:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1FVwCTdzUus+BeJwL418UcPLHNV4GTDcBxgUZvnFZFs=;
        b=Z+jlWyYicYxxVCvfexXcKtvUh+MhjDcMy9/ZwcidXROpTSxWxcNd0rA2cj1zVxC+A7
         AAig6m0k2gnoheiDeBWprjDxkL/h3A3zpmMopT+yRpVVNs7y4rPVFYe2ymXd3o7sjZCS
         0mvkPgYuHQIhbEpxstCmv45V9yK5cfhnfS2V+QewmP2RqFum+QtfI90DCaqJ1BMbL2xP
         yvZvq6tmSaZx8P/5k7qSX/b5Xi4G7bu+SnZrMfen79BagSANQlxPBrNrB6luunFSqJCb
         lrl/A4xhK3icZrRGRHQljWhkXtegn4zS2evbdEzlrXTVDhQXQl1vnq4G3mebj6pRVsFh
         kIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1FVwCTdzUus+BeJwL418UcPLHNV4GTDcBxgUZvnFZFs=;
        b=XYagLqCBYUkfufYNj8QyoZBEu10QXTfsGpxx+iFvgsi6aZgzkDTvu1kGSnE6nMC+z1
         OOsJp5b9Kn8K6rIa+/mMrT8U2HZR76/NbYrWNy0qjf1SzHnoDtnddRECrJz94vcwLNr/
         BDZelckSk0G9PNNVtJJ0mjDAbnG50wjDBYrW+8yaw6Y+pSie8SdTBDV3hUVzARgNwY+C
         Wdc/md4oXmD47naAwawBlGa2Eh3WvhCWIh4EgvPQwdmEX1TnO9OhyfYRsVDlh0I0LUBg
         WmBigxw1DqWDanisVOWN9VJaUPUiJmUN5RFInw0GAocKlRBRTeIagp5eoppQ59943SVn
         vp3A==
X-Gm-Message-State: AGi0PuZKFBPyRnlSostQkUaIm7e9Bd5raicS9MChbLUM8jvBhb+wsvcl
        gdi2YpX5Y2ZjKcnS87RnNV8=
X-Google-Smtp-Source: APiQypIf6NjtOfOf1wYGAAOPq3vm+cU/I+FTDflCs1rOtjr+REQjV0K6QvWZm+a/P+UHf4mkhbEmug==
X-Received: by 2002:a62:844c:: with SMTP id k73mr2876122pfd.235.1588682219284;
        Tue, 05 May 2020 05:36:59 -0700 (PDT)
Received: from localhost (146.85.30.125.dy.iij4u.or.jp. [125.30.85.146])
        by smtp.gmail.com with ESMTPSA id 6sm1475400pgw.47.2020.05.05.05.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 05:36:58 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 5 May 2020 21:36:54 +0900
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/3] allow ramoops to collect all kmesg_dump events
Message-ID: <20200505123654.GA509@jagdpanzerIV.localdomain>
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
 <202005041112.F3C8117F67@keescook>
 <CA+CK2bBDzbXdH23aDxqGzMoxPppNcVmitrYJ00tJqympMBVJOg@mail.gmail.com>
 <202005041211.040A1C65C8@keescook>
 <CA+CK2bAJgKR+=Tby91gU-ZKy29Juv_oJinCTFAWRaKiiro2vkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAJgKR+=Tby91gU-ZKy29Juv_oJinCTFAWRaKiiro2vkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/04 15:17), Pavel Tatashin wrote:
> AFAIK, there is no way to have different log levels for
> different consoles.

There was a patch set from facebook several years ago to make
loglevels per-console, but it didn't land. Perhaps we need to
refresh it.

	-ss
