Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B72C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6250920732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+I4pjf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgBZBNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:13:42 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39419 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730135AbgBZBNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:13:40 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so1468520ioh.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 17:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Md+dR3QAjkgbDHCOD0u7elrQ4FkH1YpiL26CdEGfHpk=;
        b=R+I4pjf2mqXjj+8BCUTibnuDnoALhtisnlvmkpZOTuALmHc7sxQkJkSmlDj9G1kp4F
         5BN4PN1Mkph70DyXdrt6H34L57uHBEbuqveIFJOEdumqQGaX7t7ictKgocS237fQvqEo
         mS1i1JZbRPKsrVo/wv152qvDzlvEDv5Elwub8wVfQX/18NUFIDXkNounJ4Bkwum/W3XS
         bs2l15mYhvWlgK6GvQGKHdJtRx1GIM7bCfqL4z+J8xDLpUr1ejtu/o+fVT5+VcHx4z2c
         /+hr2qxBNVjW3inC/MKwqcMmwv6Tgce3DMfVvk6I/17eliRdypZ+IPVA4fIYctm4/bBO
         +dbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Md+dR3QAjkgbDHCOD0u7elrQ4FkH1YpiL26CdEGfHpk=;
        b=XoC2gYDRw7O1vNn9Sja3IF1xtn0s76HWlCtbeYzxaDOrdE13LJM5DtxSnkb1V0tQKk
         hDBUsFRPGmztThb579EHiixKHVrsAr/VZfyHyU/hgQoTyGvBQ9wU433rrUEPw3xaK1yt
         hbpCxrq6jXWnwvX33Y4Hw61nE/rOKqjCh+YSeIItDmtkEPnRRHfAZUoSOm2hJRqTHgv0
         yItS0JwsDRxYZb2CNpYagPKzX8xNMMmBPO9ptsZcWbTaEtcOMUnU1rMlLYveHhdzxTa6
         sxvsTvI6e6l8vyyvONcNuT7uB2D9ZUORjGD0bqAyxyWzTpfgthIyz1m2KPrHdorauWoE
         NnXw==
X-Gm-Message-State: APjAAAXGCVtO/AHdME9xWEpxeQHB4JqMMK687pEtumd+aDxyqTjFsNms
        WmmGaz0hhaIoEgXi7/eSPdrlYfhuruo=
X-Google-Smtp-Source: APXvYqyziRLA63DqgeyRhiV9j8Pxm2Iva9SkiX6jHMkmIhWdxef0d17W2ImORx3FKCTw289xP0FCYw==
X-Received: by 2002:a05:6638:1a8:: with SMTP id b8mr1405336jaq.34.1582679618849;
        Tue, 25 Feb 2020 17:13:38 -0800 (PST)
Received: from google.com ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id q1sm108128ile.71.2020.02.25.17.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 17:13:38 -0800 (PST)
Date:   Tue, 25 Feb 2020 18:13:35 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mattias Nissler <mnissler@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Raul Rangel <rrangel@google.com>,
        linux-fsdevel@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] Add a "nosymfollow" mount option.
Message-ID: <20200226011335.GA12632@google.com>
References: <20200226010706.9431-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226010706.9431-1-zwisler@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 06:07:06PM -0700, Ross Zwisler wrote:
<>
> Changes since v5 [1]:

And of course this version is v6.  Sorry for the omission.
